defmodule Bulma.AwesomeIcon do
  @moduledoc """
  Simple component to make use of LineAwesome Icons.
  from bulma_liveview
  """
  use Phoenix.Component
  import Bulma.Helpers

  @awesome_prefix Application.get_env(:bulma_liveview, :awesome_prefix, "fa")

  defp prefix(what), do: {what, &"#{@awesome_prefix}-#{&1}"}

  @properties [set: @awesome_prefix, icon: nil]
  def icon(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([
        prefix(:name),
        prefix(:size),
        set: & &1
      ])

    ~H"""
      <i class={@class}></i>
    """
  end
end
