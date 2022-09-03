defmodule Bulma.FontIcon do
  @moduledoc """
  Simple component that uses an icon font to display icons. You have to include
  the icon font to your application. Default configuration is configured to use
  FontAwesome, as Bulma also assumes. You can configure bulma_liveview to use
  prefixes for other icon fonts (that use the same naming scheme) as so:
  ```
  # Bootstrap Icons:
  config :bulma_liveview, :icon_font_prefix, :bi

  # Line Awesome:
  config :bulma_liveview, :icon_font_prefix, :la
  ```
  """
  use Phoenix.Component
  import Bulma.Helpers

  @font_prefix Application.get_env(:bulma_liveview, :icon_font_prefix, "fa")

  defp prefix_text(text), do: "#{@font_prefix}-#{text}"

  defp prefix(what), do: {what, &prefix_text/1}

  @properties [set: @font_prefix, icon: nil]
  def icon(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([
        prefix(:name),
        prefix(:size),
        # when a set like "brands" is given, construct fa-brands
        set: &prefix_text/1
      ])

    ~H"""
      <i class={@class}></i>
    """
  end
end
