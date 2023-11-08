defmodule FlagIcons do
@moduledoc """
Phoenix Component of country flags in SVG (downloaded from the
NPM package [https://github.com/lipis/flag-icons](flag-icons) (v<%= @vsn %>).
The generated components are pre-compiled.

## Usage

To call a flag icon, use the `FlagIcons` component and either an ISO 3166-1 alpha-2 or
other non-country code (for non-country flags) as a string or an atom as the component name.

```heex
<FlagIcons.us_flag />
<FlagIcons.fr_flag />
<FlagIcons.eu_flag />
```

The flags images are available in two different formats, regular (`4x3`) and squared (`1x1`).
By default the `FlagIcon` component will use the regular format, but it can be changed by
by passing the `squared` attribute to use the `1x1` format.

```heex
<FlagIcons.us_flag />
<FlagIcons.us_flag squared />
```

There are some included styles to use with the icons which are optional (all  `false` by default):
- `border` - adds a 1px border around the flag to enhance the visibility on light backgrounds.
- `rounded` - rounds the corners of the flag.
- `shadow` - adds a subtle drop shadow to the back of the flag.
- `circle` - rounds the corners of the flag to make it a circle.
- `overlay` - adds a overlay effect. Values can be `false`, `linear`, `diagonal` or `radial`.

```heex
<FlagIcons.us_flag rounded border shadow />
<FlagIcons.pt_flag rounded border overlay={:diagonal} />
```

You can also pass arbitrary HTML attributes to the components:
```heex
<FlagIcons.us_flag class="rounded" />
<FlagIcons.fr_flag squared />
```

To call a flag icon dynamically, use the `FlagIcons.flag/1` function and the country iso code
(ISO 3166-1 alpha-2 or alpha-3) as attribute (either as a string or as an atom).

```heex
<FlagIcons.flag code="us" />
<FlagIcons.flag code={:usa} />
```
"""

  use Phoenix.Component

  @doc false
  attr :code, :any, required: true, doc: "the flag code either an ISO 3166-1 alpha-2 or other non-country code as a string or an atom"
  attr :regular, :boolean, default: true, doc: "use the regular flag format (4x3)"
  attr :squared, :boolean, default: false, doc: "use the squared flag format (1x1)"
  attr :border, :boolean, default: false, doc: "adds a 1px border around the flag to enhance the visibility on light backgrounds"
  attr :rounded, :boolean, default: false, doc: "rounds the corners of the flag"
  attr :shadow, :boolean, default: false, doc: "adds a subtle drop shadow to the back of the flag"
  attr :circle, :boolean, default: false, doc: "rounds the corners of the flag to make it a circle"
  attr :overlay, :atom, values: [false, :linear, :diagonal, :radial], default: false, doc: "adds a overlay effect. Values can be
  `false`, `linear`, `diagonal` or `radial`"
  attr :class, :any, default: "", doc: "extra CSS classes"
  attr :rest, :global, doc: "the arbitrary HTML attributes for the svg container"

  def flag(assigns) do
    apply(FlagIcons, String.to_existing_atom("#{assigns.code}_flag"), [assigns])
  end

  defp svg(assigns) do
    case assigns do
      %{squared: false} -> ~H"<.svg_flag {@rest}><%%= {:safe, @svgs[:regular]} %></.svg_flag>"
      %{squared: true} -> ~H"<.svg_flag {@rest}><%%= {:safe, @svgs[:squared]} %></.svg_flag>"
    end
  end

  attr :class, :any, default: ""
  attr :rest, :global, default: %{"aria-hidden": "true"}
  slot :inner_block, required: true

  defp svg_flag(assigns) do
    ~H"""
    <div class={@class} {@rest}>
      <%%= render_slot(@inner_block) %>
    </div>
    """
  end

  <%= for flag <- @flags, {func, %{code: code, svgs: [regular, squared]}} = flag do %>
  @doc """
  Renders the `<%= FlagIcons.Helpers.get_country_name_by_code!(code) %>` flag icon.
  """

  attr :regular, :boolean, default: true, doc: "use the regular flag format (4x3)"
  attr :squared, :boolean, default: false, doc: "use the squared flag format (1x1)"
  attr :border, :boolean, default: false, doc: "adds a 1px border around the flag to enhance the visibility on light backgrounds"
  attr :rounded, :boolean, default: false, doc: "rounds the corners of the flag"
  attr :shadow, :boolean, default: false, doc: "adds a subtle drop shadow to the back of the flag"
  attr :circle, :boolean, default: false, doc: "rounds the corners of the flag to make it a circle"
  attr :overlay, :atom, values: [false, :linear, :diagonal, :radial], default: false, doc: "adds a overlay effect. Values can be
  `false`, `linear`, `diagonal` or `radial`"
  attr :class, :any, default: "", doc: "extra CSS classes"
  attr :rest, :global, doc: "the arbitrary HTML attributes for the svg container"

  def <%= func %>(assigns) do
    svg(assign(assigns, svgs: %{regular: ~S|<%= regular %>|, squared: ~S|<%= squared %>|}))
  end
  <% end %>
end
