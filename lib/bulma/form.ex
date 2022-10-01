defmodule Bulma.Form do
  @moduledoc """
  Generic form controls for Bulma. Inputs are delegated to the corresponding
  Phoenix.HTML.Form helper, so the 'type' property must be the name of the
  Phoenix.HTML.Form.*_input/3 functions. Invoked by MFA when atom is provided
  """
  use Phoenix.Component
  import Bulma.Helpers
  import Bulma.Label, only: [label: 1]
  alias Phoenix.HTML.Form, as: PhxForm

  def control(assigns) do
    assigns =
      assigns
      |> assign_defaults(inner_block: [], icon: [])
      |> assign_icons()
      |> assign_class(:class, [
        "control",
        has(:icons),
        is(:loading),
        add_if(:"is-expanded")
      ])

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
      <%= for icon <- @icon do %>
        <.label {icon} />
      <% end %>
    </div>
    """
  end

  def field(%{input: :select} = assigns) do
    field_attributes =
      assigns
      |> assigns_to_attributes(
        _exclude = [
          :input,
          :input_class,
          :options,
          :color,
          :size
        ]
      )

    assigns =
      assigns
      |> assign_defaults(label: nil, form: nil, name: nil, icon: [])
      |> assign_options()
      |> assign_class(:select_class, ["select", is(:color), is(:size), is(:loading), is(:style)])
      |> assign_class(:class, [is(:state)])
      |> set_attributes_from_assigns(
        exclude: [:select_class, :form, :name, :label, :options, :icon]
      )
      |> assign(field_attributes: field_attributes)

    ~H"""
      <.field {@field_attributes}>
        <div class={@select_class}>
          <%= PhxForm.select(@form, @name, @options, @attributes) %>
        </div>
      </.field>
    """
  end

  def field(%{input: input} = assigns) when not is_nil(input) do
    field_attributes =
      assigns
      |> assigns_to_attributes(
        _exclude = [
          :input,
          :input_class
        ]
      )

    assigns =
      assigns
      |> assign_class(:class, ["input", is(:size), is(:style), is(:state)])
      |> set_attributes_from_assigns(
        exclude: [
          :input,
          :field_class,
          :label_class,
          :form,
          :label,
          :name,
          :type,
          :icon,
          :size,
          :style,
          :state,
          :"is-expanded"
        ]
      )
      |> assign(field_attributes: field_attributes)

    ~H"""
    <.field {@field_attributes}>
      <%= case assigns[:input] do
          function_name when is_atom(function_name) -> apply(PhxForm, function_name, [@form, @name, @attributes])
          f when is_function(f, 3) -> f.(@form, @name, @attributes)
          _ -> []
        end %>

      <%= if assigns[:inner_block], do: render_slot(@inner_block), else: [] %>
    </.field>
    """
  end

  def field(assigns) do
    assigns = prepare_field_assigns(assigns)

    ~H"""
    <div class={@field_class}>
      <%= if @label do %>
        <%= PhxForm.label(@form, @name, @label, class: @label_class) %>
      <% end %>
      <.control {@attributes}>
          <%= render_slot(@inner_block) %>
      </.control>
    </div>
    """
  end

  def inputs(assigns) do
    ~H"""
    <%= for inputs <- PhxForm.inputs_for(@form, @field) do %>
      <%= PhxForm.hidden_inputs_for(inputs) %>
      <%= render_slot(@inner_block, inputs) %>
    <% end %>
    """
  end

  defp prepare_field_assigns(assigns) do
    assigns
    |> assign_defaults(label: nil, form: nil, name: nil, icon: [], inner_block: [])
    |> assign_class(:field_class, ["field"])
    |> assign_class(:label_class, ["label"])
    |> set_attributes_from_assigns(
      exclude: [
        :field_class,
        :label_class,
        :form,
        :label,
        :name
      ]
    )
  end

  defp assign_icons(assigns) do
    icons =
      assigns.icon
      |> Enum.map(& &1.align)
      |> Enum.uniq()

    assigns
    |> assign(:icons, icons)
  end

  defp assign_options(assigns),
    do:
      update(
        assigns,
        :options,
        &Enum.map(
          &1,
          fn
            {key, label} when is_atom(:key) -> {label, key}
            text when is_binary(text) -> text
          end
        )
      )
end
