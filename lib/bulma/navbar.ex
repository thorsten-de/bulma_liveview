defmodule Bulma.Navbar do
  use Phoenix.Component
  import Bulma.Helpers

  alias Phoenix.LiveView.JS

  @properties [inner_block: [], color: nil, transparent: false, fixed: nil]
  @excludes Keyword.keys(@properties)
  def navbar(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([:navbar, is(:color), is(:transparent), is(:fixed)])
      |> set_attributes_from_assigns(exclude: @excludes)

    ~H"""
      <nav {@attributes}>
        <%= render_slot(@inner_block) %>
      </nav>
    """
  end

  def brand(assigns) do
    ~H"""
      <div class="navbar-brand">
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  def menu(assigns) do
    ~H"""
      <div id={@id} class="navbar-menu" phx-click-away={JS.remove_class("is-active", to: "##{@id}")} >
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  def bar_start(assigns) do
    ~H"""
      <div class="navbar-start">
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  def bar_end(assigns) do
    ~H"""
      <div class="navbar-end">
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  def burger(assigns) do
    ~H"""
      <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" phx-click={JS.add_class("is-active", to: @target)} >
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    """
  end

  def item(%{patch: _destination} = assigns) do
    assigns = prepare_item_assigns(assigns)

    ~H"""
      <%= live_patch to: @patch, class: @class do %>
        <.label_or_slot {@attributes}   />
      <% end %>
    """
  end

  def item(%{href: _href} = assigns) do
    link_attributes =
      assigns
      |> assigns_to_attributes([:href])

    assigns =
      assigns
      |> prepare_item_assigns()
      |> assign(link_attributes: link_attributes)

    ~H"""
      <%= Phoenix.HTML.Link.link Keyword.merge(@link_attributes, to: @href, class: @class) do %>
        <.label_or_slot {@attributes} />
      <% end %>
    """
  end

  def item(assigns) do
    assigns = prepare_item_assigns(assigns)

    ~H"""
      <div class={@class}>
        <.label_or_slot {@attributes} />
      </div>
    """
  end

  defp prepare_item_assigns(assigns) do
    assigns
    |> assign_class(["navbar-item"])
    |> set_attributes_from_assigns(
      include: [:inner_block],
      exclude: [:class, :href]
    )
  end

  def dropdown(assigns) do
    assigns =
      assigns
      |> assign_defaults(inner_block: [], label: "")
      |> assign_class(["has-dropdown", is(:hoverable), is(:active)])

    ~H"""
    <.item class={@class}>
      <a class="navbar-link">
        <%= @label %>
      </a>

      <div class="navbar-dropdown">
        <%= render_slot(@inner_block) %>
      </div>
    </.item>
    """
  end

  def divider(assigns) do
    ~H"""
      <hr class="navbar-divider">
    """
  end
end
