defmodule Bulma.Tabs do
  use Phoenix.Component
  import Bulma.Helpers
  import Bulma.Label, only: [label: 1]

  @properties [
    align: nil,
    size: nil,
    boxed: nil,
    toggle: nil,
    "toggle-rounded": nil,
    fullwidth: nil,
    tab: []
  ]
  @exclude Keyword.keys(@properties)

  defp prepare_tabs_assigns(assigns) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([
      :tabs,
      is(:size),
      is(:align),
      is(:toggle),
      is(:"toggle-rounded"),
      is(:fullwidth)
    ])
    |> set_attributes_from_assigns(@exclude)
  end

  def tabs(assigns) do
    assigns = prepare_tabs_assigns(assigns)

    ~H"""
      <div {@attributes}>
        <ul>
          <%= for tab <- @tab do %>
            <.tab {tab} />
          <% end %>
        </ul>
      </div>
      <div class="tabs-content">
        <%= for tab <- @tab do %>
        <div>
          <%= render_slot(tab) %>
        </div>
        <% end %>
      </div>
    """
  end

  @tab_properties [
    label: "",
    icon: nil,
    disabled: false,
    visible: true,
    active: false
  ]

  defp prepare_tab_assigns(assigns) do
    assigns
    |> assign_defaults(@tab_properties)
  end

  def tab(assigns) do
    assigns =
      prepare_tab_assigns(assigns)
      |> assign_class(["tab", is(:active)])

    ~H"""
      <li class={@class}>
        <a href="#tabtest"><.label icon={@icon} label={@label}/></a>
      </li>
    """
  end
end
