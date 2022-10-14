defmodule Bulma.Dropdown do
  use Phoenix.Component
  import Bulma.Helpers
  alias Phoenix.LiveView.JS

  def dropdown(%{items: items} = assigns) do
    assigns =
      assigns
      |> set_attributes_from_assigns(exclude: [:items], include: [:trigger])

    ~H"""
    <.dropdown {@attributes}>
      <%= for item <- items do %>
        <%= case item do %>
        <% "-" -> %>
          <.divider />
        <% item -> %>
          <%= render_slot(@inner_block, item) %>
        <% end %>
      <% end %>
    </.dropdown>
    """
  end

  def dropdown(assigns) do
    assigns =
      assigns
      |> assign_defaults(inner_block: [], trigger: [])
      |> assign_class(["dropdown", is(:active), is(:hoverable)])
      |> assign(dropdown_menu_id: "dropdown-menu--#{assigns[:id]}")

    ~H"""
    <div id={"dropdown--#{assigns[:id]}"} class={@class} >
      <div class="dropdown-trigger" aria-haspopup="true" aria-controls={@dropdown_menu_id}  phx-click={JS.add_class("is-active",  to: "#dropdown--#{assigns[:id]}")} phx-click-away={JS.remove_class("is-active",  to: "#dropdown--#{assigns[:id]}")}>
          <%= render_slot(@trigger) %>
      </div>
      <div class="dropdown-menu" id={@dropdown_menu_id} role="menu">
        <div class="dropdown-content">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  def item(assigns) do
    assigns =
      assigns
      |> assign_class(["dropdown-item", is(:active)])
      |> set_attributes_from_assigns(exclude: [:class, :click, :target, :active])
      |> assign_bindings(:bindings, [:click, :target])
      |> assign_values()

    ~H"""
    <div class={@class} {@bindings} {@phx_values}>
      <.label_or_slot {@attributes} />
    </div>
    """
  end

  def divider(assigns) do
    ~H"""
    <hr class="dropdown-divider">
    """
  end
end
