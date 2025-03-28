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

procedure TestGenerateRandomNumbers(minVal, maxVal, count: Integer);
var
  arr: TIntArray;
  i: Integer;
  passed: Boolean;
begin
  GenerateRandomNumbers(arr, minVal, maxVal, count);
  Writeln('Generated array:');
  PrintArray(arr);

  passed := True;

  if (Length(arr) <> count) then
  begin
    passed := False;
    Writeln('Generated array length not equal to count');
  end;

  for i := 0 to High(arr) do
    if (arr[i] < minVal) or (arr[i] > maxVal) then
    begin
      passed := False;
      Writeln('One of the array elements not in the range');
      Break; 
    end;

  if passed then
    Writeln('Test: PASSED')
  else
    Writeln('Test: FAILED');
end;

begin
  Writeln('Running tests...');
  TestGenerateRandomNumbers(1, 10, 20);
  TestGenerateRandomNumbers(1, 100, 10);
  TestGenerateRandomNumbers(1, 10, 0);
  TestGenerateRandomNumbers(1, 10, 1);
  TestGenerateRandomNumbers(1, 1, 100);
  Writeln('Tests completed.');
  Readln;
end.
