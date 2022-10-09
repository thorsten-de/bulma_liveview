defmodule Bulma.Button do
  use Phoenix.Component
  import Bulma.Helpers

  @properties [
    size: nil,
    color: nil,
    text: nil,
    state: nil,
    style: nil,
    class: nil,
    fullwidth: false,
    click: nil,
    target: nil
  ]

  @exclude Keyword.keys(@properties)

  defp prepare_button_assigns(assigns) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([
      :button,
      is(:size),
      is(:color),
      is(:state),
      is(:style),
      has(:text),
      is(:fullwidth)
    ])
    |> set_attributes_from_assigns(exclude: @exclude)
    |> assign_bindings(:bindings, [:click, :target])
  end

  def button(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <button class={@class} {@bindings}><.label_or_slot {@attributes} /></button>
    """
  end

  def submit(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <input type="submit" class={@class} {@attributes}/>
    """
  end

  def reset(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <input type="reset" class={@class} {@attributes}/>
    """
  end
end
