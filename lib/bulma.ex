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
      import Bulma.{Columns, Title, FontIcon, Label}
      import Bulma.Button, only: [button: 1]
      import Bulma, only: [container: 1, section: 1]
      import Bulma.Media, only: [media: 1]
      import Bulma.Form, only: [field: 1, inputs: 1]
      import Bulma.Table, only: [table: 1]
      alias Bulma.Tags
      alias Bulma.Form
      alias Bulma.Button
    end
  end
end
