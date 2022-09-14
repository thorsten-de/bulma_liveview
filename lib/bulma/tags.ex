defmodule Bulma.Tags do
  @moduledoc """
  Bulma Tag element to use tag labels:
  https://bulma.io/documentation/elements/tag/
  """
  use Phoenix.Component
  import Bulma.Helpers

  # style is used to generate "is-rounded" style or "is-delete" special tags by
  # defining style="rounded" or style="delete"
  @properties [
    size: nil,
    color: nil,
    label: nil,
    style: nil
  ]
  @exclude Keyword.keys(@properties)

  defp prepare_tag_assigns(assigns) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([
      :tag,
      is(:size),
      is(:color),
      is(:style)
    ])
    |> set_attributes_from_assigns(@exclude)
  end

  def tag(assigns) do
    assigns =
      assigns
      |> prepare_tag_assigns()

    ~H"""
    <span {@attributes}>
      <.label_or_slot {assigns} />
    </span>
    """
  end

  @properties [
    has_addons: false,
    inner_block: []
  ]
  @exclude Keyword.keys(@properties)
  def tags(assigns) do
    assigns
    |> assign_defaults(@properties)
    |> assign_class([
      :tags,
      add_if(:has_addons, class: "has-addons")
    ])
    |> set_attributes_from_assigns(@exclude)
    |> render_div_with_slot()
  end
end
