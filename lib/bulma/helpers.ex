defmodule Bulma.Helpers do
  use Phoenix.Component

  def assign_defaults(assigns, definitions \\ []) do
    definitions
    |> Enum.reduce(assigns, &init/2)
  end

  defp init({key, fun}, assigns) when is_function(fun, 0), do: assigns |> assign_new(key, fun)
  defp init({key, value}, assigns), do: init({key, fn -> value end}, assigns)

  def is(what),
    do:
      {what,
       fn
         true ->
           "is-#{what}"

         false ->
           nil

         list when is_list(list) ->
           Enum.map_join(list, " ", &"is-#{&1}")

         other ->
           "is-#{other}"
       end}

  def has(what),
    do:
      {what,
       fn
         true ->
           "has-#{what}"

         false ->
           nil

         list when is_list(list) ->
           Enum.map_join(list, " ", &"has-#{what}-#{&1}")

         other ->
           "has-#{what}-#{other}"
       end}

  def value_of(what), do: {what, & &1}

  def assign_class(assigns, classes \\ []) do
    classes =
      case assigns[:class] do
        list when is_list(list) -> list ++ classes
        element -> [assigns[:class] | classes]
      end

    class_string =
      classes
      |> Enum.reduce([], &filter_class(&1, &2, assigns))
      |> Enum.reject(&is_nil/1)
      |> Enum.reverse()
      |> Enum.join(" ")

    assigns
    |> assign(:class, class_string)
  end

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

  def set_attributes_from_assigns(assigns, exclude \\ []) do
    assigns
    |> assign(:attributes, assigns_to_attributes(assigns, exclude))
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

  def if_slot(assigns) do
    case assigns[assigns.name] |> IO.inspect() do
      [_ | _] -> ~H[<%= render_slot(@inner_block) %>]
      _ -> ~H[]
    end
  end

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
end
