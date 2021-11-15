defmodule Bulma.Navbar do
  use Phoenix.Component
  import Bulma.Helpers

  @properties [inner_block: [], color: nil, transparent: false, fixed: nil]
  @excludes Keyword.keys(@properties)
  def navbar(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([:navbar, is(:color), is(:transparent), is(:fixed)])
      |> set_attributes_from_assigns(@excludes)

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
      <div id={@id} class="navbar-menu">
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
      <a class="navbar-burger" aria-label="menu" aria-expanded="false"
        data-target={@data_target}>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    """
  end

  def item(%{href: _href} = assigns) do
    ~H"""
      <a href={@href} class="navbar-item">
        <.label_or_slot {assigns} />
      </a>
    """
  end

  def item(assigns) do
    ~H"""
      <div class="navbar-item">
        <.label_or_slot {assigns} />
      </div>
    """
  end

  def divider(assigns) do
    ~H"""
      <hr class="navbar-divider">
    """
  end
end
