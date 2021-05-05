(*

  Trysil
  Copyright � David Lastrucci
  All rights reserved

  Trysil - Operation ORM (World War II)
  http://codenames.info/operation/orm/

*)
unit Trysil.Data.SqlSyntax.FirebirdSQL;

interface

uses
  System.Classes,
  System.SysUtils,

  Trysil.Data.SqlSyntax;

type

{ TTDataFirebirdSQLSequenceSyntax }

  TTDataFirebirdSQLSequenceSyntax = class(TTDataSequenceSyntax)
  strict protected
    function GetSequenceSyntax: String; override;
  end;

{ TTDataFirebirdSQLSelectSyntax }

  TTDataFirebirdSQLSelectSyntax = class(TTDataSelectSyntax)
  strict protected
    function GetFilterTopSyntax: String; override;
  end;

{ TTDataFirebirdSQLSyntaxClasses }

  TTDataFirebirdSQLSyntaxClasses = class(TTDataSyntaxClasses)
  public
    function Sequence: TTDataSequenceSyntaxClass; override;
    function SelectCount: TTDataSelectCountSyntaxClass; override;
    function Select: TTDataSelectSyntaxClass; override;
    function Metadata: TTDataMetadataSyntaxClass; override;
    function Insert: TTDataCommandSyntaxClass; override;
    function Update: TTDataCommandSyntaxClass; override;
    function Delete: TTDataCommandSyntaxClass; override;
  end;

implementation

{ TTDataFirebirdSQLSequenceSyntax }

function TTDataFirebirdSQLSequenceSyntax.GetSequenceSyntax: String;
begin
  result :=
    Format('SELECT GEN_ID(%s, 1) ID FROM RDB$DATABASE', [FSequenceName]);
end;

{ TTDataFirebirdSQLSelectSyntax }

function TTDataFirebirdSQLSelectSyntax.GetFilterTopSyntax: String;
begin
  result := Format('FIRST %d', [FFilter.Top.MaxRecord]);
end;

{ TTDataFirebirdSQLSyntaxClasses }

function TTDataFirebirdSQLSyntaxClasses.Sequence: TTDataSequenceSyntaxClass;
begin
  result := TTDataFirebirdSQLSequenceSyntax;
end;

function TTDataFirebirdSQLSyntaxClasses.SelectCount:
  TTDataSelectCountSyntaxClass;
begin
  result := TTDataSelectCountSyntax;
end;

function TTDataFirebirdSQLSyntaxClasses.Select: TTDataSelectSyntaxClass;
begin
  result := TTDataFirebirdSQLSelectSyntax;
end;

function TTDataFirebirdSQLSyntaxClasses.Metadata: TTDataMetadataSyntaxClass;
begin
  result := TTDataMetadataSyntax;
end;

function TTDataFirebirdSQLSyntaxClasses.Insert: TTDataCommandSyntaxClass;
begin
  result := TTDataInsertSyntax;
end;

function TTDataFirebirdSQLSyntaxClasses.Update: TTDataCommandSyntaxClass;
begin
  result := TTDataUpdateSyntax;
end;

function TTDataFirebirdSQLSyntaxClasses.Delete: TTDataCommandSyntaxClass;
begin
  result := TTDataDeleteSyntax;
end;

end.
