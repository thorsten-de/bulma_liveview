defmodule Bulma.Title do
  use Phoenix.Component
  import Bulma.Helpers

  def title(assigns) do
    assigns
    |> prepare_title(:title)
    |> render_div_with_slot_or_label()
  end

  def subtitle(assigns) do
    assigns
    |> prepare_title(:subtitle)
    |> render_div_with_slot_or_label()
  end

  @properties [inner_content: [], label: nil, size: nil, spaced: nil]
  @exclude Keyword.keys(@properties)

  def prepare_title(assigns, main_class) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([main_class, is(:size), is(:spaced)])
    |> set_attributes_from_assigns(@exclude)
  end
end
