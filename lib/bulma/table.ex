defmodule Bulma.Table do
  @moduledoc """

  """
  use Phoenix.Component
  import Bulma.Helpers
  import Bulma.Label, only: [label: 1]

  attr :data, :list,  default: [], doc: "The data that is used to generate rows"
  attr :style, :string, default: nil
  attr :fullwidth, :boolean, default: false
  slot :column, doc: "Columns with header label" do
    attr :field, :atom, doc: "Columns data field"
    attr :header, :string, doc: "Column header label"
    attr :icon, :string, doc: "Column header icon"
  end
  slot :header, doc: "If not given, no headers are shown. Can be used to define a template for a column header"
  slot :footer, doc: "If not given, no footer row is shown. Can be used to define a template for a column footer"
  slot :column_header, doc: "Columns with row label" do
    attr :field, :atom, doc: "data field for row header"
  end


  def table(assigns) do
    assigns =
      assigns
     # |> assign_defaults(@properties)
      |> assign_class(["table", is(:style), is(:fullwidth)])
      #|> set_attributes_from_assigns(exclude: Keyword.keys(@properties))

    ~H"""
    <table class={@class}>
      <thead :if={has_slot?(@header)}>
        <tr :for={header <- @header}>
          <th :for={col <- @column_header ++ @column}>
            <%= if header[:inner_block] do %>
              <%= render_slot(header, col) %>
            <% else %>
              <.label label={col[:header] || col[:field]} {col} />
            <% end %>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr :for={{item, row_idx} <- Enum.with_index(@data, 1)}>
          <th :for={col <- @column_header}>
            <%= if col[:inner_block] do %>
              <%= render_slot(col, %{item: item, idx: row_idx, field: Map.get(item, col[:field])}) %>
            <% else %>
              <.label label={Map.get(item, col[:field], row_idx)} />
            <% end %>
          </th>
          <td :for={col <- @column}>
            <%= if col[:inner_block] do %>
              <%= render_slot(col, %{item: item, idx: row_idx, field: Map.get(item, col[:field])}) %>
            <% else %>
              <.label label={Map.get(item, col.field)} />
            <% end %>
          </td>
        </tr>
      </tbody>
      <tfoot :if={has_slot?(@footer)}>
        <tr :for={footer <- @footer}>
          <th :for={col <- @column_header ++ @column} >
            <%= if footer[:inner_block] do %>
              <%= render_slot(footer, col) %>
            <% else %>
              <.label label={col[:header] || col[:field]} {col} />
            <% end %>
          </th>
        </tr>
      </tfoot>
    </table>
    """
  end
end
