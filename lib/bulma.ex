defmodule Bulma do
  use Phoenix.Component
  import Bulma.{Helpers}

  @properties [inner_block: [], width: nil, text: nil]
  @exclude Keyword.keys(@properties)
  def container(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([:container, is(:width), has(:text)])
      |> set_attributes_from_assigns(exclude: @exclude)

    ~H"""
      <div {@attributes}>
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  def box(assigns) do
    assigns =
      assigns
      |> assign_defaults(inner_block: [])
      |> assign_class(["box"])

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def content(assigns) do
    assigns =
      assigns
      |> assign_defaults(inner_block: [])
      |> assign_class(["content", is(:size)])

    ~H"""
    <div class={@class}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def section(assigns) do
    assigns = assigns |> assign_defaults(inner_block: [])

    ~H"""
    <section class="section">
      <%= render_slot(@inner_block) %>
    </section>
    """
  end

  defmacro __using__(_whatever) do
    quote do
      alias Bulma.Tags
      alias Bulma.Form
      alias Bulma.Button
      alias Bulma.Dropdown
      import Bulma, only: [container: 1, section: 1, box: 1, content: 1]
      import Bulma.{Columns, Title, FontIcon, Label}
      import Button, only: [button: 1]
      import Bulma.Media, only: [media: 1]
      import Form, only: [field: 1, inputs: 1]
      import Bulma.Table, only: [table: 1]
      import Bulma.Card, only: [card: 1]
      import Bulma.Hero, only: [hero: 1]
      import Dropdown, only: [dropdown: 1]
      import Bulma.Level, only: [level: 1]
    end
  end
end
