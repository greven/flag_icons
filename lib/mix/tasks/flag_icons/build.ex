defmodule Mix.Tasks.FlagIcons.Build do
  @moduledoc false
  @shortdoc false

  use Mix.Task

  @source_file "priv/flag_icons.exs"
  @target_file "lib/flag_icons.ex"

  @impl true
  def run(_args) do
    vsn = Mix.Tasks.FlagIcons.Update.vsn()
    svgs_path = Mix.Tasks.FlagIcons.Update.svgs_path()

    regular = Path.wildcard(Path.join(svgs_path, "regular/**/*.svg"))
    squared = Path.wildcard(Path.join(svgs_path, "squared/**/*.svg"))

    flags =
      (regular ++ squared)
      |> Enum.group_by(&flag_code(&1), &File.read!(&1))
      |> Enum.map(fn {code, svgs} -> {function_name(code), %{code: code, svgs: svgs}} end)

    Mix.Generator.copy_template(@source_file, @target_file, [vsn: vsn, flags: flags], force: true)
    Mix.Task.run("format")
  end

  # We need to add a suffix to the function name to avoid conflicts with kernel functions
  defp function_name(code), do: "#{code}_flag"

  defp flag_code(file) do
    file
    |> Path.basename()
    |> Path.rootname()
    |> String.split("-")
    |> Enum.join("_")
  end
end
