defmodule Bulma.Footer do
  use Phoenix.Component
  import Bulma.Helpers

  @properties [inner_block: [], text: nil]
  @exclude Keyword.keys(@properties)
  def footer(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([:footer, has(:text)])
      |> set_attributes_from_assigns(exclude: @exclude)

    ~H"""
      <footer {@attributes}>
        <%= render_slot(@inner_block) %>
      </footer>
    """
  end
end
