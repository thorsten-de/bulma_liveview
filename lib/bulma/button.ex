defmodule Bulma.Button do
  use Phoenix.Component
  import Bulma.Helpers

  @properties [
    size: nil,
    color: nil,
    text: nil,
    label: nil,
    state: nil,
    style: nil,
    fullwidth: false
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
  end

  def button(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <button {@attributes}><.label_or_slot {assigns}/></button>
    """
  end

  def submit(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <input type="submit" {@attributes}/>
    """
  end

  def reset(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <input type="reset" {@attributes}/>
    """
  end

  def link(assigns) do
    assigns = prepare_button_assigns(assigns)

    ~H"""
      <a {@attributes}><.label_or_slot {assigns}/></a>
    """
  end
end
