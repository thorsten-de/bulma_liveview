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
      |> set_attributes_from_assigns(@exclude)

    ~H"""
      <div {@attributes}>
        <%= render_slot(@inner_block) %>
      </div>
    """
  end

  defmacro __using__(_whatever) do
    quote do
      import Bulma.{Columns, Title, FontIcon, Label}
      import Bulma.Button, only: [button: 1]
      import Bulma, only: [container: 1]
      import Bulma.Media, only: [media: 1]
      alias Bulma.Tags
    end
  end
end
