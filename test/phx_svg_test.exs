defmodule PhxSvgTest do
  use ExUnit.Case, async: true

  import Mix.Tasks.PhxSvg.Build, only: [run: 1]
  import Phoenix.LiveViewTest

  setup_all do
    output_path = Path.join(["test/support", "test_mod.ex"])

    args = [
      "--mod-name=SvgTest",
      "--svg-path=test/support/*.svg",
      "--output-path=#{output_path}"
    ]

    _ = run(args)

    [mod_and_docs] =
      modules =
      output_path
      |> Code.compile_file()
      |> Enum.map(fn {mod, bytecode} -> {mod, fetch_docs(bytecode)} end)

    on_exit(fn ->
      Enum.each(modules, fn {mod, _} ->
        :code.delete(mod)
        :code.purge(mod)
      end)
    end)

    {:ok, mod: mod_and_docs}
  end

  setup do
    {:ok, assigns: %{__changed__: nil}}
  end

  test "default", %{mod: {mod, _}} do
    assert render_component(&mod.elixir_plain/1, %{}) =~
             ~s|<svg viewbox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">|
  end

  test "with class", %{mod: {mod, _}} do
    class = "w-2"

    assert render_component(&mod.elixir_plain/1, %{class: class}) =~
             ~s|<svg class="w-2" viewbox="0 0 128 128" xmlns="http://www.w3.org/2000/svg">|
  end

  test "should have docs", %{mod: {_mod, docs}} do
    assert {:docs_v1, _, :elixir, _, %{"en" => en}, _, _} = docs
    assert en != ""
  end

  defp fetch_docs(bytecode) do
    docs_chunk = 'Docs'
    assert {:ok, {_module, [{^docs_chunk, bin}]}} = :beam_lib.chunks(bytecode, [docs_chunk])
    :erlang.binary_to_term(bin)
  end
end
