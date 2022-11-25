defmodule Bulma.Level do
  @moduledoc """
  A multi-purpose horizontal level, which contains other elements. See https://bulma.io/documentation/layout/level/
  """
  use Phoenix.Component
  import Bulma.Helpers

  @doc """
  Define an horizontal level
  """
  slot :left, default: [], doc: "Elements on the left side of this level"
  slot :right, default: [], doc: "Elements on the left side of this level"
  slot :center, default: [], doc: "Elements in the center of this level"
  attr :class, :any
  attr :style, :any, doc: "Customize level style, e.g. by setting mobile for is-mobile"

  def level(assigns) do
    assigns = assigns
    |> assign_class(["level", is(:style)])

    ~H"""
    <div class={@class}>
      <div :if={has_slot?(@left)} class="level-left">
        <.item :for={item <- @left} {item}>
          <%= render_slot(item) %>
        </.item>
      </div>
      <.item :for={item <- @center} >
        <%= render_slot(item) %>
      </.item>
      <%= render_slot(@inner_block) %>
        <div :if={has_slot?(@right)} class="level-right">
        <.item :for={item <- @right}>
          <%= render_slot(item) %>
        </.item>
      </div>
    </div>
  """
  end

  @doc """
  A level item, where you can insert almost anything you want
  """
  slot :inner_block, default: []
  attr :class, :any
  attr :text, :any, doc: "sets has-text-VALUE to this level-item to define text alignment"

  def item(assigns) do
    assigns = assigns
    |> assign_class(["level-item", has(:text)])

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
