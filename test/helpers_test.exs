defmodule FlagIconsHelpersTest do
  use ExUnit.Case, async: true
  doctest FlagIcons.Helpers

  alias FlagIcons.Helpers

  describe "get_country_name_by_code/1" do
    test "it should return the country name for the given code" do
      assert Helpers.get_country_name_by_code!("gb") == "United Kingdom"
      assert Helpers.get_country_name_by_code!("gb_eng") == "England"
      assert Helpers.get_country_name_by_code!("gb-eng") == "England"
      assert Helpers.get_country_name_by_code!(:gb_eng) == "England"
      assert Helpers.get_country_name_by_code!("pt") == "Portugal"
      assert Helpers.get_country_name_by_code!("prt") == "Portugal"
      assert Helpers.get_country_name_by_code!(:pt) == "Portugal"
      assert Helpers.get_country_name_by_code!(:prt) == "Portugal"
      assert Helpers.get_country_name_by_code!("eu") == "European Union"
      assert Helpers.get_country_name_by_code!(:eu) == "European Union"
    end

    test "it should raise if the code is not found" do
      assert_raise KeyError, fn -> Helpers.get_country_name_by_code!("XPT") end
    end

    test "empty string should return nil" do
      assert Helpers.get_country_name_by_code!("") == nil
    end

    test "nil should return nil" do
      assert Helpers.get_country_name_by_code!(nil) == nil
    end
  end
end
