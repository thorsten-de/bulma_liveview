defmodule Bulma.Helpers do
  use Phoenix.Component

  import Phoenix.Component

  def assign_defaults(assigns, definitions \\ []) do
    definitions
    |> Enum.reduce(assigns, &init/2)
  end

  defp init({key, fun}, assigns) when is_function(fun, 0), do: assigns |> assign_new(key, fun)
  defp init({key, value}, assigns), do: init({key, fn -> value end}, assigns)

  def value_of(what), do: {what, & &1}

  def add_if(what, opts \\ []) do
    to_value_class = opts[:value_class] || (&to_string/1)
    to_class = fn value -> "#{opts[:prefix]}#{opts[:class] || to_value_class.(value)}" end

    {what,
     fn
       false ->
         nil

       true ->
         to_class.(what)

       list when is_list(list) ->
         Enum.map_join(list, " ", to_class)

       other ->
         to_class.(other)
     end}
  end

  def is(what), do: add_if(what, prefix: "is-")
  def are(what), do: add_if(what, prefix: "are-")

  def has(what), do: add_if(what, prefix: "has-", value_class: &"#{what}-#{&1}")

  def assign_class(assigns, to \\ :class, classes) do
    classes =
      case assigns[to] do
        nil -> classes
        list when is_list(list) -> list ++ classes
        element -> [element | classes]
      end

    class_string =
      classes
      |> Enum.reduce([], &filter_class(&1, &2, assigns))
      |> Enum.reject(&is_empty/1)
      |> Enum.reverse()
      |> Enum.join(" ")

    assigns
    |> assign(to, class_string)
  end

  def assign_bindings(assigns, name, types) do
    bindings =
      types
      |> Enum.reduce([], fn type, acc ->
        case assigns[type] do
          nil ->
            acc

          value ->
            [{"phx-#{type}", value} | acc]
        end
      end)

    assigns
    |> assign(name, bindings)
  end

  defp is_empty(nil), do: true
  defp is_empty([]), do: true
  defp is_empty(""), do: true
  defp is_empty(_), do: false

  defp filter_class(nil, acc, _), do: acc
  defp filter_class(item, acc, _assigns) when is_binary(item) or is_atom(item), do: [item | acc]
  defp filter_class({_item, nil}, acc, _assigns), do: acc
  defp filter_class({_item, false}, acc, _assigns), do: acc

  defp filter_class({item, f}, acc, assigns) when is_function(f, 0),
    do: filter_class({item, f.()}, acc, assigns)

  defp filter_class({key, f}, acc, assigns) when is_atom(key) and is_function(f, 1) do
    case assigns[key] do
      nil -> acc
      value -> [f.(value) | acc]
    end
  end

  defp filter_class({item, _}, acc, _assigns), do: [item | acc]
  defp filter_class(_item, acc, _assigns), do: acc

  def assign_values(assigns) do
    phx_values =
      assigns
      |> Access.get(:values, [])
      |> Enum.reduce(%{}, fn {key, value}, acc ->
        Map.put(acc, "phx-value-#{key}", value)
      end)

    assigns
    |> assign(:phx_values, phx_values)
  end

  def set_attributes_from_assigns(assigns, opts \\ []) do
    exclude = opts[:exclude] || []
    include = opts[:include] || []

    attributes =
      assigns
      |> assigns_to_attributes(exclude)

    attributes =
      include
      |> Enum.reduce(attributes, fn item, attribs ->
        case assigns[item] do
          nil -> attribs
          value -> Keyword.put(attribs, item, value)
        end
      end)

    assigns
    |> assign(:attributes, attributes)
  end

  # label_or_slot uses a given label property to label the component

  # if no label is given, inner_block is rendered, if there is any
  def label_or_slot(%{inner_block: _has_block} = assigns) do
    ~H"""
    <%= render_slot(@inner_block) %>
    """
  end

  def label_or_slot(assigns) do
    ~H"""
    <Bulma.Label.label {assigns} />
    """
  end

  # no label and no inner blocks, so render nothing

  def has_default_slot(assigns) do
    assigns
    |> assign(
      :__default_slot_content__,
      assigns[:inner_block]
    )
  end

  def default_slot(%{__default_slot_content__: nil} = assigns) do
    ~H"""
    <%= render_slot(@inner_block) %>
    """
  end

  def default_slot(assigns) do
    ~H"""
    <%= render_slot(@__default_slot_content__) %>
    """
  end

  def has_inner_block?(%{inner_block: nil}), do: false

  def has_inner_block?(_what), do: true

  def if_slot(assigns) do
    case assigns[assigns.name] do
      [_ | _] -> ~H[<%= render_slot(@inner_block) %>]
      _ -> ~H[]
    end
  end

  @spec render_div_with_slot_or_label(any) :: Phoenix.LiveView.Rendered.t()
  def render_div_with_slot_or_label(assigns) do
    ~H"""
    <div {@attributes}><.label_or_slot {assigns} /></div>
    """
  end

  def render_div_with_slot(assigns) do
    ~H"""
    <div {@attributes}><%= render_slot(@inner_block) %></div>
    """
  end

  def has_slot?([]), do: false
  def has_slot?([_slot|_]), do: true
  def has_slot?(_other), do: false
end
