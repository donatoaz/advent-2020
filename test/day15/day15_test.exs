defmodule Aoc2020test.Day15 do
  use ExUnit.Case
  doctest Aoc2020.Day15.Part1

  describe "Part 1" do
    Enum.each(
      [
        {"0,3,6", 436},
        {"1,3,2", 1},
        {"2,1,3", 10},
        {"1,2,3", 27},
        {"2,3,1", 78},
        {"3,2,1", 438},
        {"3,1,2", 1836}
      ],
      fn {input, expected} ->
        @input input
        @expected expected

        test "#{@input} works with result #{@expected}" do
          assert Aoc2020.Day15.Part1.run(@input, 2020) == @expected
        end
      end
    )

    test "it works for provided input" do
      assert Aoc2020.Day15.Part1.run("2,20,0,4,1,17", 2020) == 758
    end
  end

  describe "Part 2" do
    Enum.each(
      [
        {"0,3,6", 175_594},
        {"1,3,2", 2578},
        {"2,1,3", 3_544_142},
        {"1,2,3", 261_214},
        {"2,3,1", 6_895_259},
        {"3,2,1", 18},
        {"3,1,2", 362}
      ],
      fn {input, expected} ->
        @input input
        @expected expected

        # this suite takes 4min to run, so I am skipping it
        @tag :skip
        test "#{@input} works with result #{@expected}" do
          assert Aoc2020.Day15.Part1.run(@input, 30_000_000) == @expected
        end
      end
    )

    test "it works for provided input" do
      assert Aoc2020.Day15.Part1.run("2,20,0,4,1,17", 30_000_000) == 814
    end
  end
end
