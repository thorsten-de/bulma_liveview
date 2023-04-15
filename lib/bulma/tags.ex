defmodule Bulma.Tags do
  @moduledoc """
  Bulma Tag element to use tag labels:
  https://bulma.io/documentation/elements/tag/
  """
  use Phoenix.Component
  import Bulma.Helpers
  import Bulma.Label, only: [label: 1]

  # style is used to generate "is-rounded" style or "is-delete" special tags by
  # defining style="rounded" or style="delete"
  attr :size, :any
  attr :color, :any
  attr :style, :any
  attr :class, :any

  # Attributes given to label component
  attr :icon, :string
  attr :icon_set, :string
  attr :label, :string

  slot :inner_block

  def tag(assigns) do
    assigns =
      assigns
      |> assign_class([
      "tag",
      is(:size),
      is(:color),
      is(:style)
    ])
    |> set_attributes_from_assigns(
     exclude: [:class, :size, :color, :style]
    )

    ~H"""
    <span class={@class}>
      <%= if has_slot?(@inner_block) do %>
        <%= render_slot(@inner_block) %>
      <% else %>
        <.label {@attributes} />
      <% end %>
    </span>
    """
  end

  attr :has_addons, :boolean, default: :false
  attr :class, :any
  slot :inner_block


  def tags(assigns) do
    assigns = assigns
    |> assign_class(["tags", are(:size), add_if(:has_addons, class: "has-addons")])

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
