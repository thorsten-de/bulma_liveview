defmodule Bulma.Hero do
  use Phoenix.Component
  import Bulma.Helpers

  @properties [inner_block: [], color: nil, size: nil, fullheight: false, head: [], foot: []]
  @excludes Keyword.keys(@properties)
  def hero(assigns) do
    assigns =
      assigns
      |> assign_defaults(@properties)
      |> assign_class([:hero, is(:color), is(:size), is(:fullheight)])
      |> set_attributes_from_assigns(exclude: @excludes)

    ~H"""
      <section {@attributes}>
        <.if_slot {assigns} name={:head}>
          <div class="hero-head">
            <%= render_slot(@head) %>
          </div>
        </.if_slot>
        <div class="hero-body">
          <%= render_slot(@inner_block) %>
        </div>
         <.if_slot {assigns} name={:foot}>
          <div class="hero-foot">
            <%= render_slot(@foot) %>
          </div>
        </.if_slot>
      </section>
    """
  end
end
