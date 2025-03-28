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