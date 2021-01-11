age = IO.get("What is your age? ")

{age, _} = Integer.parser(age)

message =
  if age < 18 do
    "You can't vote yet"
  else
    "You can vote!"
  end

IO.puts(message)
