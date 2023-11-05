defmodule Mix.Tasks.FlagIcons.Update do
  @moduledoc false
  @shortdoc false

  @vsn "6.12.0"

  use Mix.Task
  require Logger

  def vsn, do: @vsn

  def svgs_path, do: Path.join("assets", "svgs")

  @impl true
  def run(_args) do
    version = @vsn
    tmp_dir = Path.join(System.tmp_dir!(), "flag-icons")
    svgs_dir = Path.join([tmp_dir, "flag-icons-#{version}", "flags"])

    File.rm_rf!(tmp_dir)
    File.mkdir_p!(tmp_dir)

    url = "https://github.com/lipis/flag-icons/archive/refs/tags/v#{version}.zip"
    archive = fetch_body!(url)

    case unpack_archive(".zip", archive, tmp_dir) do
      :ok -> copy_svgs(svgs_dir)
      other -> raise "couldn't unpack archive: #{inspect(other)}"
    end
  end

  defp copy_svgs(svgs_dir) do
    Logger.debug("Copying flag-icons from #{svgs_dir}")

    for format <- File.ls!(svgs_dir) do
      case format do
        "1x1" -> copy_svg_files(Path.join([svgs_dir, format]), "squared")
        "4x3" -> copy_svg_files(Path.join([svgs_dir, format]), "regular")
      end
    end
  end

  defp copy_svg_files(src_dir, format) do
    dest_dir = Path.join(svgs_path(), format)
    File.rm_rf!(dest_dir)
    File.mkdir_p!(dest_dir)
    File.cp_r!(src_dir, dest_dir)
  end

  defp fetch_body!(url) do
    Logger.debug("Downloading flag-icons from #{url}")

    Application.ensure_all_started(:flag_icons)

    case Req.get(url, raw: true) do
      {:ok, %Req.Response{status: 200, body: body}} ->
        body

      {:error, reason} ->
        raise "Failed to fetch #{url}: #{inspect(reason)}"
    end
  end

  defp unpack_archive(".zip", zip, cwd) do
    with {:ok, _} <- :zip.unzip(zip, cwd: to_charlist(cwd)), do: :ok
  end

  defp unpack_archive(_, tar, cwd) do
    :erl_tar.extract({:binary, tar}, [:compressed, cwd: to_charlist(cwd)])
  end
end
