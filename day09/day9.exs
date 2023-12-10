defmodule Day9 do
  def readFile() do
    case File.read("input.txt") do
      {:ok, content} ->
        content
        |> String.split(~r/\r\n/, trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))
        |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)

      {:error, err} ->
        IO.puts("is wrong: #{err}")
    end
  end

  defp diffs(nums) do
    nums
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&(List.last(&1) - hd(&1)))
  end

  defp nextNum(nums) do
    if Enum.all?(nums, &(&1 == 0)) do
      0
    else
      diffs(nums)
      |> nextNum()
      |> Kernel.+(List.last(nums))
    end
  end

  def part1(input) do
    input
    |> Enum.map(&nextNum(&1))
    |> Enum.sum()
  end

  defp prevNum(nums) do
    if Enum.all?(nums, &(&1 == 0)) do
      0
    else
      diffs(nums)
      hd(nums) - prevNum(differences)
    end
  end

  def part2(input) do
    input
    |> Enum.map(&prevNum(&1))
    |> Enum.sum()
  end
end

fileContent = Day9.readFile()
IO.inspect(Day9.part1(fileContent))
IO.inspect(Day9.part2(fileContent))
