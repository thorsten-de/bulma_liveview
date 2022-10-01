defmodule Bulma.Table do
  use Phoenix.Component

  import Bulma.Helpers
  import Bulma.Label, only: [label: 1]

  @properties [
    data: [],
    column: [],
    footer: [],
    header: [],
    column_header: []
  ]
  def table(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class(["table", is(:style), is(:fullwidth)])
      |> set_attributes_from_assigns(exclude: Keyword.keys(@properties))

    ~H"""
    <table {@attributes}>
      <thead>
        <%= for header <- @header do %>
          <tr>
            <%= for col <- @column_header ++ @column do %>
              <th>
                <%= if header[:inner_block] do %>
                  <%= render_slot(header, col) %>
                <% else %>
                  <.label label={col[:header] || col[:field]} {col} />
                <% end %>
              </th>
            <% end %>
          </tr>
        <% end %>
      </thead>
      <tbody>
        <%= for {item, row_idx} <- Enum.with_index(@data, 1) do %>
          <tr>
            <%= for col <- @column_header do %>

              <th>
                <%= if col[:inner_block] do %>
                  <%= render_slot(col, %{item: item, idx: row_idx, field: Map.get(item, col[:field])}) %>
                <% else %>
                  <.label label={Map.get(item, col[:field], row_idx)} />
                <% end %>
              </th>
            <% end %>
            <%= for col <- @column do %>
            <td>
              <%= if col[:inner_block] do %>
                <%= render_slot(col, %{item: item, idx: row_idx, field: Map.get(item, col[:field])}) %>
              <% else %>
                <.label label={Map.get(item, col.field)} />
              <% end %>
            </td>
            <% end %>
          </tr>
        <% end %>
      </tbody>
      <tfoot>
      <%= for footer <- @footer do %>
        <tr>
          <%= for col <- @column_header ++ @column do %>
            <th>
            <%= if footer[:inner_block] do %>
              <%= render_slot(footer, col) %>
             <% else %>
                <.label label={col[:header] || col[:field]} {col} />
              <% end %>
            </th>
          <% end %>
        </tr>
      <% end %>
      </tfoot>
    </table>
    """
  end
end
