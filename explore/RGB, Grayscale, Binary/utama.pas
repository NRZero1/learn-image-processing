unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs, ComCtrls;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    ButtonInvers: TButton;
    ButtonBinary: TButton;
    ButtonSave: TButton;
    ButtonGray: TButton;
    ButtonBlue: TButton;
    ButtonGreen: TButton;
    ButtonRed: TButton;
    ButtonColor: TButton;
    ButtonLoadImage: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    TrackBar1: TTrackBar;
    procedure ButtonBinaryClick(Sender: TObject);
    procedure ButtonBlueClick(Sender: TObject);
    procedure ButtonColorClick(Sender: TObject);
    procedure ButtonGrayClick(Sender: TObject);
    procedure ButtonGreenClick(Sender: TObject);
    procedure ButtonInversClick(Sender: TObject);
    procedure ButtonLoadImageClick(Sender: TObject);
    procedure ButtonRedClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

{ TFormUtama }
uses
  windows;

var
  bitmapR, bitmapG, bitmapB : array[0..1000, 0..1000] of byte;

procedure TFormUtama.ButtonLoadImageClick(Sender: TObject);
var
  x, y : integer;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);

    for y := 0 to Image1.Height-1 do
    begin
      for x := 0 to Image1.Width-1 do
      begin
        bitmapR[x,y] := GetRValue(Image1.Canvas.Pixels[x,y]);
        bitmapG[x,y] := GetGValue(Image1.Canvas.Pixels[x,y]);
        bitmapB[x,y] := GetBValue(Image1.Canvas.Pixels[x,y]);
      end;
    end;
  end;

end;

procedure TFormUtama.ButtonRedClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      Image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], 0, 0);
    end;
  end;
end;

procedure TFormUtama.ButtonSaveClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
  end;
end;

procedure TFormUtama.TrackBar1Change(Sender: TObject);
var
  x, y, newR, newG, newB : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      newR := bitmapR[x,y] + TrackBar1.Position;
      newG := bitmapG[x,y] + TrackBar1.Position;
      newB := bitmapB[x,y] + TrackBar1.Position;
      if newR > 255 then
      begin
        newR := 255;
      end;
      if newG > 255 then
      begin
        newG := 255;
      end;
      if newB > 255 then
      begin
        newB := 255;
      end;
      if newR < 0 then
      begin
        newR := 0;
      end;
      if newG < 0 then
      begin
        newG := 0;
      end;
      if newB < 0 then
      begin
        newB := 0;
      end;
      Image1.Canvas.Pixels[x,y] := RGB(newR, newG, newB);
    end;
  end;
end;

procedure TFormUtama.ButtonColorClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      Image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
    end;
  end;
end;

procedure TFormUtama.ButtonGrayClick(Sender: TObject);
var
  x, y, gray : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
      Image1.Canvas.Pixels[x,y] := RGB(gray, gray, gray);
    end;
  end;
end;

procedure TFormUtama.ButtonBlueClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      Image1.Canvas.Pixels[x,y] := RGB(0, 0, bitmapB[x,y]);
    end;
  end;
end;

procedure TFormUtama.ButtonBinaryClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      if ((bitmapR[x,y] >= 0) and (bitmapR[x,y] <= 127)) or
         ((bitmapG[x,y] >= 0) and (bitmapG[x,y] <= 127)) or
         ((bitmapR[x,y] >= 0) and (bitmapR[x,y] <= 127)) then
       begin
         Image1.Canvas.Pixels[x,y] := RGB(0, 0, 0);
       end
      else
      begin
        Image1.Canvas.Pixels[x,y] := RGB(255, 255, 255);
      end;
    end;
  end;
end;

procedure TFormUtama.ButtonGreenClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      Image1.Canvas.Pixels[x,y] := RGB(0, bitmapG[x,y], 0);
    end;
  end;
end;

procedure TFormUtama.ButtonInversClick(Sender: TObject);
var
  x, y : integer;
begin
  for y := 0 to Image1.Height-1 do
  begin
    for x := 0 to Image1.Width-1 do
    begin
      Image1.Canvas.Pixels[x,y] := RGB(255-bitmapR[x,y], 255-bitmapG[x,y], 255-bitmapB[x,y]);
    end;
  end;
end;

end.

