defmodule Day04 do
  def validate(line, valid) do
    required_fields = [
      "byr",
      "iyr",
      "eyr",
      "hgt",
      "hcl",
      "ecl",
      "pid"
    ]

    has_required =
      Enum.reduce(
        required_fields,
        true,
        &(Enum.member?(String.split(line, [":", " "]), &1) and &2)
      )

    line_valid =
      line
      |> String.split([" "], trim: true)
      |> Enum.reduce(true, &(validate(&1) and &2))

    case has_required and line_valid do
      true -> valid + 1
      false -> valid
    end
  end

  def validate(field) do
    [param, value] =
      field
      |> String.split(":")

    validate_value(param, value)
  end

  # byr (Birth Year) - four digits; at least 1920 and at most 2002.
  # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  # hgt (Height) - a number followed by either cm or in:
  #     If cm, the number must be at least 150 and at most 193.
  #     If in, the number must be at least 59 and at most 76.
  # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  # pid (Passport ID) - a nine-digit number, including leading zeroes.
  # cid (Country ID) - ignored, missing or not.
  def validate_value("byr", value),
    do: String.to_integer(value) >= 1920 and String.to_integer(value) <= 2002

  def validate_value("iyr", value),
    do: String.to_integer(value) >= 2010 and String.to_integer(value) <= 2020

  def validate_value("eyr", value),
    do: String.to_integer(value) >= 2020 and String.to_integer(value) <= 2030

  def validate_value("hgt", value) do
    case String.split_at(value, -2) do
      {value, "cm"} -> String.to_integer(value) >= 150 and String.to_integer(value) <= 193
      {value, "in"} -> String.to_integer(value) >= 59 and String.to_integer(value) <= 76
      _ -> false
    end
  end

  def validate_value("hcl", value), do: String.match?(value, ~r/#[0-9a-f]{6}/)
  def validate_value("pid", value), do: String.match?(value, ~r/[0-9]{9}/)

  def validate_value("ecl", value),
    do: Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value)

  def validate_value(_, _), do: true
end

_lines =
  File.read!("input")
  |> String.trim()
  |> String.split("\n\n")
  |> Enum.map(&String.replace(&1, "\n", " "))
  |> Enum.reduce(0, &Day04.validate/2)
  |> IO.inspect()
