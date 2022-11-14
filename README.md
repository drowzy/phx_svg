# PhxSvg

Precompile SVGS to functions. Packaged as a `Phoenix Component`

## Usage

```sh
mix phx_svg.build --mod-name=MySvgs --svg-path="path/to/svgs/**/*.svg" --output-path="./lib/my_app_web/components/svgs.ex"
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `phx_svg` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:phx_svg, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/phx_svg>.

