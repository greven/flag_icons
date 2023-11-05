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

    flags = Enum.group_by(regular ++ squared, &function_name(&1), &File.read!(&1))

    Mix.Generator.copy_template(@source_file, @target_file, %{vsn: vsn, flags: flags}, force: true)

    # Mix.Task.run("format")
  end

  # We need to add a suffix to the function name to avoid conflicts with kernel functions
  defp function_name(file) do
    code = file |> file_name() |> flag_code()
    "#{code}_flag"
  end

  defp file_name(file) do
    file
    |> Path.basename()
    |> Path.rootname()
  end

  defp flag_code(code) do
    code
    |> String.split("-")
    |> Enum.join("_")
  end
end
