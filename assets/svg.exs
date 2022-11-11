defmodule <%= @mod_name %> do
  @moduledoc """
  Provides precompiled svgs for <%= @mod_name %>.

  ## Usage

  Function names are based on the svg filename, for example:
  <% f_name = Enum.random(@svgs) |> elem(0) %>

  ```heex
    <<%= @mod_name%>.<%= f_name %> />
  ```

  You can also pass arbitrary HTML attributes to the components:
   ```heex
  <<%= @mod_name%>.<%= f_name %> class="w-2 h-2" />
  ```
  """

  use Phoenix.Component

  attr :rest, :global
  # slot :inner_block, required: true
  defp svg(assigns) do
    assigns = assign(assigns, :computed_rest, Map.merge(assigns.rest, Enum.into(assigns.svg_attrs, %{})))
    ~H"""
    <svg {@computed_rest}>
      <%%= {:safe, @paths[:default]} %>
    </svg>"
    """
  end


  <%= for svg <- @svgs, {func, [{"svg", svg_attrs, els}]} = svg do %>
  @doc """
  Renders the `<%= func %>` icon.
  By default, it maintains the svg attributes from loaded from file
  attributes can be provided for alternative styles.

  You may also pass arbitrary HTML attributes to be applied to the svg tag.

  ## Examples

  ```heex
  <<%= @mod_name %>.<%= func %> />
  <<%= @mod_name %>.<%= func %> class="w-4 h-4" />
  ```
  """

  attr :rest, :global, doc: "the arbitrary HTML attributes for the svg container", include: ~w(fill stroke stroke-width)

  def <%= func %>(assigns) do
    svg(assign(assigns, svg_attrs: <%= inspect(svg_attrs, limit: :infinity) %>, paths: %{default: ~S|<%= Floki.raw_html(els) %>|}))
  end
  <% end %>
end
