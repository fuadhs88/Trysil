(*

  Trysil
  Copyright © David Lastrucci
  All rights reserved

  Trysil - Operation ORM (World War II)
  http://codenames.info/operation/orm/

*)
unit Orders.Model;

interface

uses
  System.Classes,
  System.SysUtils,
  
  Trysil.Types,
  Trysil.Attributes,
  Trysil.Generics.Collections,
  Trysil.Lazy;

type

{ TCustomer }

  [TTable('Customers')]
  [TSequence('CustomersID')]
  [TRelation('Orders', 'CustomerID', False)]
  TCustomer = class
  strict protected
    [TPrimaryKey]
    [TColumn('ID')]
    FID: TTPrimaryKey;

    [TColumn('CompanyName')]
    FCompanyName: String;

    [TColumn('Address')]
    FAddress: String;

    [TColumn('City')]
    FCity: String;

    [TColumn('Region')]
    FRegion: String;

    [TColumn('PostalCode')]
    FPostalCode: String;

    [TColumn('Country')]
    FCountry: String;

    [TColumn('Email')]
    FEmail: String;

    [TVersionColumn]
    [TColumn('VersionID')]
    FVersionID: TTVersion;
  public
    function ToString(): String; override;

    property ID: TTPrimaryKey read FID;
    property CompanyName: String read FCompanyName write FCompanyName;
    property Address: String read FAddress write FAddress;
    property City: String read FCity write FCity;
    property Region: String read FRegion write FRegion;
    property PostalCode: String read FPostalCode write FPostalCode;
    property Country: String read FCountry write FCountry;
    property Email: String read FEmail write FEmail;
  end;

{ TBrand }

  [TTable('Brands')]
  [TSequence('BrandsID')]
  [TRelation('Products', 'BrandID', False)]
  TBrand = class
  strict protected
    [TPrimaryKey]
    [TColumn('ID')]
    FID: TTPrimaryKey;

    [TColumn('Description')]
    FDescription: String;

    [TVersionColumn]
    [TColumn('VersionID')]
    FVersionID: TTVersion;
  public
    function ToString(): String; override;

    property ID: TTPrimaryKey read FID;
    property Description: String read FDescription write FDescription;
  end;

{ TProduct }

  [TTable('Products')]
  [TSequence('ProductsID')]
  [TRelation('OrderDetails', 'ProductID', False)]
  TProduct = class
  strict protected
    [TPrimaryKey]
    [TColumn('ID')]
    FID: TTPrimaryKey;

    [TColumn('BrandID')]
    FBrand: TTLazy<TBrand>;

    [TColumn('Description')]
    FDescription: String;

    [TColumn('Price')]
    FPrice: Double;

    [TVersionColumn]
    [TColumn('VersionID')]
    FVersionID: TTVersion;

    function GetBrand: TBrand;
    procedure SetBrand(const AValue: TBrand);
  public
    function ToString(): String; override;

    property ID: TTPrimaryKey read FID;
    property Brand: TBrand read GetBrand write SetBrand;
    property Description: String read FDescription write FDescription;
    property Price: Double read FPrice write FPrice;
  end;

{ TOrderDetail }

  [TTable('OrderDetails')]
  [TSequence('OrderDetailsID')]
  TOrderDetail = class
  strict protected
    [TPrimaryKey]
    [TColumn('ID')]
    FID: TTPrimaryKey;

    [TColumn('OrderID')]
    FOrderID: TTPrimaryKey;

    [TColumn('ProductID')]
    FProduct: TTLazy<TProduct>;

    [TColumn('Description')]
    FDescription: String;

    [TColumn('Quantity')]
    FQuantity: Double;

    [TColumn('Price')]
    FPrice: Double;

    [TColumn('Produced')]
    FProduced: TTNullable<TDateTime>;

    [TColumn('Delivered')]
    FDelivered: TTNullable<TDateTime>;

    [TColumn('Cashed')]
    FCashed: TTNullable<TDateTime>;

    [TVersionColumn]
    [TColumn('VersionID')]
    FVersionID: TTVersion;

    function GetProduct: TProduct;
    procedure SetProduct(const AValue: TProduct);
    function GetAmount: Double;
  public
    function ToString(): String; override;

    property ID: TTPrimaryKey read FID;
    property OrderID: TTPrimaryKey read FOrderID write FOrderID;
    property Product: TProduct read GetProduct write SetProduct;
    property Description: String read FDescription write FDescription;
    property Quantity: Double read FQuantity write FQuantity;
    property Price: Double read FPrice write FPrice;
    property Amount: Double read GetAmount;
    property Produced: TTNullable<TDateTime> read FProduced write FProduced;
    property Delivered: TTNullable<TDateTime> read FDelivered write FDelivered;
    property Cashed: TTNullable<TDateTime> read FCashed write FCashed;
  end;

{ TOrder }

  [TTable('Orders')]
  [TSequence('OrdersID')]
  [TRelation('OrderDetails', 'OrderID', True)]
  TOrder = class
  strict protected
    [TPrimaryKey]
    [TColumn('ID')]
    FID: TTPrimaryKey;

    [TColumn('OrderDate')]
    FOrderDate: TDateTime;

    [TColumn('CustomerID')]
    FCustomer: TTLazy<TCustomer>;

    [TColumn('Cached')]
    FCached: Boolean;

    [TVersionColumn]
    [TColumn('VersionID')]
    FVersionID: TTVersion;

    [TDetailColumn('ID', 'OrderID')]
    FDetail: TTLazyList<TOrderDetail>;

    function GetCustomer: TCustomer;
    procedure SetCustomer(const AValue: TCustomer);
    function GetDetail: TTList<TOrderDetail>;
  public
    property ID: TTPrimaryKey read FID;
    property OrderDate: TDateTime read FOrderDate write FOrderDate;
    property Customer: TCustomer read GetCustomer write SetCustomer;
    property Cached: Boolean read FCached write FCached;

    property Detail: TTList<TOrderDetail> read GetDetail;
  end;

{ TOrderView }

  TOrderView = class
  strict protected
    [TPrimaryKey]
    [TColumn('ID')]
    FID: TTPrimaryKey;

    [TColumn('OrderDate')]
    FOrderDate: TDateTime;

    [TColumn('CustomerID')]
    FCustomer: TTLazy<TCustomer>;

    [TColumn('ProductID')]
    FProduct: TTLazy<TProduct>;

    [TColumn('Description')]
    FDescription: String;

    [TColumn('Quantity')]
    FQuantity: Double;

    [TColumn('Price')]
    FPrice: Double;

    function GetCustomer: TCustomer;
    function GetProduct: TProduct;
    function GetAmount: Double;
  public
    property ID: TTPrimaryKey read FID;
    property OrderDate: TDateTime read FOrderDate;
    property Customer: TCustomer read GetCustomer;
    property Product: TProduct read GetProduct;
    property Description: String read FDescription;
    property Quantity: Double read FQuantity;
    property Price: Double read FPrice;
    property Amount: Double read GetAmount;
  end;

{ TProductsToBeProduced }

  [TTable('ProductsToBeProduced')]
  TProductsToBeProduced = class(TOrderView);

{ TProductsToBeDelivered }

  [TTable('ProductsToBeDelivered')]
  TProductsToBeDelivered = class(TOrderView);

{ TProductsToBeCashed }

  [TTable('ProductsToBeCashed')]
  TProductsToBeCashed = class(TOrderView);

implementation

{ TCustomer }

function TCustomer.ToString: String;
begin
  result := FCompanyName;
end;

{ TBrand }

function TBrand.ToString: String;
begin
  result := FDescription;
end;

{ TProduct }

function TProduct.ToString: String;
begin
  result := FDescription;
end;

function TProduct.GetBrand: TBrand;
begin
  result := FBrand.Entity;
end;

procedure TProduct.SetBrand(const AValue: TBrand);
begin
  FBrand.Entity := AValue;
end;

{ TOrderDetail }

function TOrderDetail.ToString: String;
begin
  result := FDescription;
end;

function TOrderDetail.GetProduct: TProduct;
begin
  result := FProduct.Entity;
end;

procedure TOrderDetail.SetProduct(const AValue: TProduct);
begin
  FProduct.Entity := AValue;
  FDescription := FProduct.Entity.Description;
  FPrice := FProduct.Entity.Price;
end;

function TOrderDetail.GetAmount: Double;
begin
  result := FQuantity * FPrice;
end;

{ TOrder }

function TOrder.GetCustomer: TCustomer;
begin
  result := FCustomer.Entity;
end;

procedure TOrder.SetCustomer(const AValue: TCustomer);
begin
  FCustomer.Entity := AValue;
end;

function TOrder.GetDetail: TTList<TOrderDetail>;
begin
  result := FDetail.List;
end;

{ TOrderView }

function TOrderView.GetCustomer: TCustomer;
begin
  result := FCustomer.Entity;
end;

function TOrderView.GetProduct: TProduct;
begin
  result := FProduct.Entity;
end;

function TOrderView.GetAmount: Double;
begin
  result := FQuantity * FPrice;
end;

end.