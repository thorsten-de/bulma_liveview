# Bulma LiveView component library

This component library provides some simple [LiveView](https://hexdocs.pm/phoenix_live_view) components based on [Bulma](https://bulma.io/), a modern CSS framework. Bulma is CSS only, so there are no issues to integrate some required JS with LiveView.

> [!WARNING]
> This is _bulma_liveview_ compatible with LiveView 0.17, and I haven't used it for a long time.

## Installation

There is no published `bulma_liveview`-Package on [Hex](https://hex.pm) yet. You can use it inside your Phoenix application by adding `bulma_liveview` via github to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
     {:bulma_liveview, github: "thorsten-de/bulma_liveview"}
  ]
end
```

This library does not contain any assets from Bulma itself. Your application has to include the Bulma css assets as needed, for example using the [bulma hex package](https://hexdocs.pm/bulma).

## Icons

The `label` component is designed to support icons by specifing the `icon` attribute with the desired icon class. As there are many icon fonts available, it is up to your application to contribute the assets to show the icons. By default, it is assumed that [Font Awesome](https://fontawesome.com/) is used and css classes are generated accordingly:

- The given `icon` is prefixed with `fa`, so `icon="plus"` results in the css class `fa-plus`.
- The _style_ can be given by the `set` attribute on an `icon` component or the  `icon_set` on a `label` component. It defaults to `regular`, so the css class `fa-regular` is added to the  component.

Both defaults can be overridden in your appliction's configuration:

```elixir
  config :bulma_liveview, :icon_font_prefix, "fa"
  cnfIig :bulma_liveview, :icon_font_set, "solid"
```

## History

In the early days of LiveView, there was the [Surface](https://github.com/surface-ui/surface) component library by Marlus Saraiva and [surface_bulma](https://github.com/surface-ui/surface_bulma) on top of it, providing some basic components. I used this to build a LiveView frontend with some custom components.

The Surface project lead to the new `HEEx` template engine and the introduction of _function components_ in LiveView 0.16. My demands for a component model are supported now, so I switched _from Surface to a pure LiveView_ implementation for Bulma components.
