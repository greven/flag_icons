defmodule FlagIconsTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  setup do
    Mix.Task.run("FlagIcons.build")
    {:ok, assigns: %{__changed__: nil}}
  end

  # test "flag/1" do
  #   render_component(&FlagIcons.flag/1, %{code: "pt", class: ""})
  #   |> dbg()
  # end

  describe "render flag icons using default assigns" do
    test "pt_flag/1" do
      assert render_component(&FlagIcons.pt_flag/1) =~
               ~s|<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink="http://www.w3.org/1999/xlink" id="flag-icons-pt" viewBox="0 0 640 480">|
    end

    test "fr_flag/1" do
      assert render_component(&FlagIcons.fr_flag/1) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" id="flag-icons-fr" viewBox="0 0 640 480">|
    end
  end

  describe "render squared flag icons" do
    test "pt_flag/1" do
      assert render_component(&FlagIcons.pt_flag/1, squared: true) =~
               ~s|<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink="http://www.w3.org/1999/xlink" id="flag-icons-pt" viewBox="0 0 512 512">|
    end

    test "fr_flag/1" do
      assert render_component(&FlagIcons.fr_flag/1) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" id="flag-icons-fr" viewBox="0 0 512 512">|
    end
  end
end
