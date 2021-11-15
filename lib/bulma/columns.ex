defmodule Bulma.Columns do
  use Phoenix.Component
  import Bulma.Helpers

  @properties [inner_content: [], target: nil]
  @exclude Keyword.keys(@properties)
  def columns(assigns) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([:columns, is(:target)])
    |> set_attributes_from_assigns(@exclude)
    |> render_div_with_slot()
  end

  @properties [inner_content: [], width: nil]
  @exclude Keyword.keys(@properties)
  def column(assigns) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([:column, is(:width)])
    |> set_attributes_from_assigns(@exclude)
    |> render_div_with_slot()
  end
end
