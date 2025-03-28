program RandomNumberGenerator;
uses crt;

type
  TIntArray = array of Integer;

procedure GenerateRandomNumbers(var arr: TIntArray; minVal, maxVal, count: Integer);
var
  i: Integer;
begin
  SetLength(arr, count);
  Randomize;
  for i := 0 to count - 1 do
    arr[i] := Random(maxVal - minVal + 1) + minVal;
end;

procedure PrintArray(arr: TIntArray);
var
  i: Integer;
begin
  for i := Low(arr) to High(arr) do
    Write(arr[i], ' ');
  Writeln;
end;
