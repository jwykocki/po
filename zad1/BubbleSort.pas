program BubbleSort;

uses crt;

type
  TIntArray = array of Integer;

procedure BubbleSort(var arr: TIntArray);
var
  i, j, temp: Integer;
  swapped: Boolean;
begin
  for i := High(arr) downto Low(arr) do
  begin
    swapped := False;
    for j := Low(arr) to i - 1 do
    begin
      if arr[j] > arr[j + 1] then
      begin
        temp := arr[j];
        arr[j] := arr[j + 1];
        arr[j + 1] := temp;
        swapped := True;
      end;
    end;
    if not swapped then Break;
  end;
end;

procedure PrintArray(arr: TIntArray);
var
  i: Integer;
begin
  for i := Low(arr) to High(arr) do
    Write(arr[i], ' ');
  Writeln;
end;

function AssertArrayEqualsExpected(arr, expectedArr: TIntArray): Boolean;
var
  i: Integer;
begin
  for i := Low(arr) to High(arr) do
    if arr[i] <> expectedArr[i] then
      Exit(False);
  Exit(True);
end;

procedure TestBubbleSort(var arr, expectedArr: TIntArray);
begin
  Writeln('--- TEST START ---');
  Writeln('Array before sort: ');
  PrintArray(arr);
  BubbleSort(arr);
  Writeln('Array after sort: ');
  PrintArray(arr);
  Writeln('Expected array: ');
  PrintArray(expectedArr);

  if AssertArrayEqualsExpected(arr, expectedArr) then
    Writeln('Test: PASSED')
  else
    Writeln('Test: FAILED');

  Writeln('--- TEST END ---');
end;

var
  arr1, expectedArr1: TIntArray;
  arr2, expectedArr2: TIntArray;
  arr3, expectedArr3: TIntArray;
  arr4, expectedArr4: TIntArray;
  arr5, expectedArr5: TIntArray;

begin
  ClrScr;

  arr1 := Concat([4, 3, 1, 2]);
  expectedArr1 := Concat([1, 2, 3, 4]);

  arr2 := Concat([]);
  expectedArr2 := Concat([]);

  arr3 := Concat([1]);
  expectedArr3 := Concat([1]);

  arr4 := Concat([1, 2, 3, 4]);
  expectedArr4 := Concat([1, 2, 3, 4]);

  arr5 := Concat([1, 1, 1, 1]);
  expectedArr5 := Concat([1, 1, 1, 1]);

  TestBubbleSort(arr1, expectedArr1);
  TestBubbleSort(arr2, expectedArr2);
  TestBubbleSort(arr3, expectedArr3);
  TestBubbleSort(arr4, expectedArr4);
  TestBubbleSort(arr5, expectedArr5);

  Readln;
end.
