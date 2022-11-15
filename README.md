# Phx.Svg

Precompile SVGS to functions. Packaged as a `Phoenix Component`

## Options

* `svg_path` - Wildcard path to svgs ex `./path/to/**/.svg`
* `mod_name` - Module name to use for generated files defaults to: `SVG`
* `output_path` - Output path defautl: `lib/icons.ex`

## Usage

```sh
mix phx_svg.build \
--mod-name=MySvgs \ 
--svg-path="path/to/svgs/**/*.svg" \
--output-path="./lib/my_app_web/components/svgs.ex"
```

In a `HEEX` template:

```elixir
def render(assigns) do
  ~H"""
  <div>
    <Svgs.name_of_svg />
    <Svgs.name_of_svg class="w-2 h-2" />
  </div>
  """
end
```

## Installation

The package can be installed by adding `phx_svg` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phx_svg, "~> 0.1.0", only: [:dev], runtime: false}
  ]
end
```
