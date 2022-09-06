defmodule Bulma.Media do
  use Phoenix.Component
  import Bulma.Helpers

  @moduledoc """
  Bulma Media Object
  https://bulma.io/documentation/layout/media-object/
  """

  @properties inner_block: [], left: nil, right: nil
  @exclude Keyword.keys(@properties)
  @doc """
  Media object that uses the default slot to present the main media-content and named slots
  `:left` and `:right` for showing additional content in the left/right part.
  """
  def media(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([:media])
      |> set_attributes_from_assigns(@exclude)

    ~H"""
    <article {@attributes}>
      <%= if @left do %>
        <figure class="media-left">
          <%= render_slot(@left) %>
        </figure>
      <% end %>
      <div class="media-content">
        <%= render_slot(@inner_block) %>
      </div>
      <%= if @right do %>
        <div class="media-right">
          <%= render_slot(@right) %>
        </div>
      <% end %>
    </article>
    """
  end
end
