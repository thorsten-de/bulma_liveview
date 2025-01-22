defmodule Bulma.Label do
  use Phoenix.Component
  import Bulma.Helpers
  alias Bulma.FontIcon

  @default_icon_set Application.compile_env(:bulma_liveview, :icon_font_set, "solid")

  def label(%{icon: icon, label: text} = assigns)
      when not (is_nil(icon) or is_nil(text)) do
    assigns =
      assigns
      |> assign_defaults(icon_font_size: nil, icon_set: @default_icon_set)
      |> assign_class(["icon", is(:icon_size)])
      |> set_attributes_from_assigns(
        exclude: [:icon_font_size, :icon, :icon_set, :icon_size, :class]
      )

    ~H"""
      <span class="icon-text">
        <span class={@class}>
         <FontIcon.icon name={@icon} set={@icon_set} size={@icon_font_size}/>
        </span>
        <span><.label {@attributes} /></span>
      </span>
    """
  end

  def label(%{icon: icon} = assigns) when not is_nil(icon) do
    assigns =
      assigns
      |> assign_defaults(icon_set: @default_icon_set, icon_font_size: nil)
      |> assign_class(["icon", is(:icon_size), is(:align)])

    ~H"""
    <span class={@class}>
      <FontIcon.icon name={@icon} set={@icon_set} size={@icon_font_size}/>
    </span>
    """
  end

  def label(%{label: text, abbr: abbr} = assigns)
      when not is_nil(text) and not is_nil(abbr) do
    ~H"""
    <abbr title={@label}><%= @abbr %></abbr>
    """
  end

  # label_or_slot uses a given label property to label the component
  def label(%{label: text} = assigns)
      when not is_nil(text) do
    ~H"""
    <%= @label %>
    """
  end

  def label(assigns),
    do: ~H"""
    """
end
