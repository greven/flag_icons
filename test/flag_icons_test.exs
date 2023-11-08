defmodule FlagIconsTest do
  use ExUnit.Case, async: true

  import Phoenix.LiveViewTest

  setup do
    Mix.Task.run("FlagIcons.build")
    {:ok, assigns: %{__changed__: nil}}
  end

  describe "render flag icons using default assigns" do
    test "flag/1" do
      assert render_component(&FlagIcons.flag/1, %{code: "pt", class: ""}) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 640 480">|
    end

    test "pt_flag/1" do
      assert render_component(&FlagIcons.pt_flag/1) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 640 480">|

      assert render_component(&FlagIcons.pt_flag/1) =~
               ~s|<path fill="#060" d="M0 0h256v480H0z" />|
    end

    test "fr_flag/1" do
      assert render_component(&FlagIcons.fr_flag/1) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 480">|

      assert render_component(&FlagIcons.fr_flag/1) =~
               ~s|<path fill="#000091" d="M0 0h213.3v480H0z" />|
    end
  end

  describe "render squared flag icons" do
    test "pt_flag/1" do
      assert render_component(&FlagIcons.pt_flag/1, squared: true) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 512 512">|

      assert render_component(&FlagIcons.pt_flag/1, squared: true) =~
               ~s|<path fill="red" d="M204.8 0H512v512H204.7z" />|
    end

    test "fr_flag/1" do
      assert render_component(&FlagIcons.fr_flag/1, squared: true) =~
               ~s|<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">|

      assert render_component(&FlagIcons.fr_flag/1, squared: true) =~
               ~s|<path fill="#fff" d="M0 0h512v512H0z" />|
    end
  end
end
