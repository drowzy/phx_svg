defmodule Mix.Tasks.PhxSvg.Build do
  @moduledoc """
  Generate `Phoenix.Component` from `.svg` files.

  Each filename matched by `svg_path` is included as a `Phoenix.Component`.
  Packaged in a module named `mod_name`.

  ## Required options

  * `svg_path` - Wildcard path to svgs ex `./path/to/**/.svg`
  * `mod_name` - Module name to use for generated files defaults to: `Svgs`
  * `output_path` - Output path defautl: `lib/svgs.ex`

  ## Example

  ```
  mix phx_svg.build --mod-name=Svgs --svg-path="path/to/svgs/**/*.svg" --output-path="./lib/svgs.ex"
  ```

  In a `HEEX` template:

  ```elixir
  <Svgs.name_of_svg />
  <Svgs.name_of_svg class="w-2 h-2" />
  ```
  """

  @shortdoc "Generate a `Phoenix.Component` with svg functions"

  use Mix.Task

  @target_file "lib/svgs.ex"
  @default_mod_name "Svgs"

  @switches [
    svg_path: :string,
    output_path: :string,
    mod_name: :string
  ]

  def run(args) do
    {opts, []} = OptionParser.parse!(args, strict: @switches)

    unless opts[:svg_path] do
      Mix.raise("No svg path specified")
    end

    mod_name = opts[:mod_name] || @default_mod_name

    output_path =
      opts
      |> Keyword.get(:output_path, @target_file)
      |> Path.expand()

    svg_files = Path.wildcard(Path.expand(opts[:svg_path]))

    svgs =
      for file <- svg_files do
        elements =
          file
          |> File.read!()
          |> Floki.parse_document!()
          |> Enum.reject(&ignore/1)

        {function_name(file), elements}
      end

    priv_dir =
      :phx_svg
      |> :code.priv_dir()
      |> to_string()

    Mix.Generator.copy_template(
      Path.join([priv_dir, "templates/svg.exs"]),
      output_path,
      %{svgs: svgs, mod_name: mod_name},
      force: true
    )

    Mix.Task.run("format", [output_path])
  end

  defp ignore({:pi, _, _}), do: true
  defp ignore({:comment, _}), do: true
  defp ignore(_), do: false

  defp function_name(file) do
    file |> Path.basename() |> Path.rootname() |> String.split("-") |> Enum.join("_")
  end
end
