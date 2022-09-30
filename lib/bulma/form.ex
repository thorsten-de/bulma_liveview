defmodule Bulma.Form do
  @moduledoc """
  Generic form controls for Bulma. Inputs are delegated to the corresponding
  Phoenix.HTML.Form helper, so the 'type' property must be the name of the
  Phoenix.HTML.Form.*_input/3 functions. Invoked by MFA when atom is provided
  """
  use Phoenix.Component
  import Bulma.Helpers

  import Bulma.Label, only: [label: 1]

  def(field(assigns)) do
    assigns = prepare_field_assigns(assigns)

    ~H"""
    <div class={@field_class}>
      <%= if @label do %>
        <label class={@label_class}><%= @label %></label>
      <% end %>
      <div class={@control_class}>
        <%= case assigns[:type] do
          nil -> []
          function_name when is_atom(function_name) -> apply(Phoenix.HTML.Form, function_name, [@form, @name, Keyword.merge(@attributes, class: @input_class)])
          f when is_function(f, 3) -> f.(@form, @name, Keyword.merge(@attributes, class: @input_class))
          _ -> []
        end %>
        <%= for icon <- @icon do %>
          <.label {icon} />
        <% end %>
        <%= if assigns[:inner_block] do %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
    </div>
    """
  end

  defp prepare_field_assigns(assigns) do
    assigns
    |> assign_defaults(label: nil, form: nil, name: nil, icon: [])
    |> assign_icons()
    |> assign_class(:control_class, ["control", has(:icons), add_if(:"is-expanded")])
    |> assign_class(:input_class, ["input"])
    |> assign_class(:field_class, ["field"])
    |> assign_class(:label_class, ["label"])
    |> set_attributes_from_assigns(
      exclude: [
        :input_class,
        :field_class,
        :label_class,
        :control_class,
        :form,
        :label,
        :name,
        :type,
        :icons,
        :icon,
        :"is-expanded"
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
end
