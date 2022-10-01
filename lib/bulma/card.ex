defmodule Bulma.Card do
  @moduledoc """
  Bulma card component
  """
  use Phoenix.Component
  import Bulma.Helpers
  import Bulma.Label, only: [label: 1]

  @properties [
    inner_block: [],
    header: [],
    footer: [],
    image: []
  ]

  def card(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class(["card"])

    ~H"""
    <div class={@class}>
      <%= for header <- @header do %>
        <header class="card-header">
          <p class="card-header-title">
            <.label {header} />
          </p>
          <%= if has_inner_block?(header), do: render_slot(header) %>
        </header>
      <% end %>
      <%= for image <- @image, has_inner_block?(image) do %>
        <div class="card-image">
          <%= render_slot(image) %>
        </div>
      <% end %>
      <div class="card-content">
        <%= render_slot(@inner_block) %>
      </div>
      <%= for footer <- @footer, has_inner_block?(footer) do %>
        <footer class="card-footer">
          <%= render_slot(footer) %>
        </footer>
      <% end %>
    </div>
    """
  end
end
