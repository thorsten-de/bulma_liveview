defmodule Bulma.Label do
  use Phoenix.Component
  import Bulma.Helpers

  @awesome_prefix Application.get_env(:bulma_liveview, :awesome_prefix, "fa")

  def label(%{icon: icon, label: text} = assigns)
      when not (is_nil(icon) or is_nil(text)) do
    assigns =
      assigns
      |> assign_defaults(icon_size: nil, icon_set: @awesome_prefix)

    ~H"""
      <span class="icon-text">
        <span class="icon">
         <Bulma.AwesomeIcon.icon name={@icon} size={@icon_size} set={@icon_set}/>
        </span>
        <span><%= @label %></span>
      </span>
    """
  end

  def label(%{icon: icon} = assigns) when not is_nil(icon) do
    assigns =
      assigns
      |> assign_defaults(icon_size: nil, icon_set: @awesome_prefix)

    ~H"""
      <span class="icon">
        <Bulma.AwesomeIcon.icon name={@icon} size={@icon_size} set={@icon_set}/>
      </span>
    """
  end

  # label_or_slot uses a given label property to label the component
  def label(%{label: text} = assigns)
      when is_binary(text) do
    ~H"""
      <%= @label %>
    """
  end

  def label(assigns),
    do: ~H"""
    """
end
