report 50103 OrderNotice
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'App/03_Report/Layout/OrderNoticeReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            PrintOnlyIfDetail = true;
            column(Bill_to_Name; "Bill-to Name")
            {
                Caption = 'Bill to name';
            }
            column(External_Document_No_; "External Document No.")
            {

            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {

            }
            column(Order_Date; "Order Date")
            {

            }
            column(Shipment_Date; "Shipment Date")
            {

            }
            column(HeaderNo; "No.")
            {

            }
            column(LineCount; gLineCount)
            {

            }
            column(GroupCount; gGroupCount)
            {

            }
            column(Create_User_ID; "Create User ID")
            {

            }
            column(UserName; gUserName)
            {

            }
            column(TotalPage; gTotalPageNumber)
            {

            }
            column(CurrencyCode; "Currency Code")
            {

            }
            column(LCYCode; gLCYCode)
            {

            }
            column(QuoteNo; "Quote No.")
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(SalesPerson; gSalesPerson)
            {

            }
            column(ShipmentMethod; gShipMethod)
            {

            }
            column(TextCustomer; TextCustomer)
            {

            }
            column(TextCurrency; TextCurrency)
            {

            }
            column(TextCustomerNo; TextCustomerNo)
            {

            }
            column(TextCustomerPO; TextCustomerPO)
            {

            }
            column(TextIndustryDesc; TextIndustryDesc)
            {

            }
            column(TextOrderDate; TextOrderDate)
            {

            }
            column(TextOrderNo; TextOrderNo)
            {

            }
            column(TextQouteNo; TextQouteNo)
            {

            }
            column(TextSalesPerson; TextSalesPerson)
            {

            }
            column(TextSalesRegion; TextSalesRegion)
            {

            }
            column(TextShipDate; TextShipDate)
            {

            }
            column(TextShipMethod; TextShipMethod)
            {

            }
            column(TextTitle; TextTitle)
            {

            }
            column(TextCustItemNo; TextCustItemNo)
            {

            }
            column(TextCustItemName; TextCustItemName)
            {

            }
            column(TextItemName; TextItemName)
            {

            }
            column(TextSpec; TextSpec)
            {

            }
            column(TextQuantity; TextQuantity)
            {

            }
            column(TextUOM; TextUOM)
            {

            }
            column(TextUnitPrice; TextUnitPrice)
            {

            }
            column(TextPack; TextPack)
            {

            }
            column(TextBox; TextBox)
            {

            }
            column(TextItemNo; TextItemNo)
            {

            }
            column(TextManager; TextManager)
            {

            }
            column(TextPurchaser; TextPurchaser)
            {

            }
            column(TextCreater; TextCreater)
            {

            }
            column(TextTotal; TextTotal)
            {

            }
            column(TextPrintDate; TextPrintDate)
            {

            }
            column(TextPrintTime; TextPrintTime)
            {

            }
            column(TextPageNumber; TextPageNumber)
            {

            }
            dataitem("Sales line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");

                column(LineNo; "Line No.")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(UOM; "Unit of Measure")
                {

                }
                column(UnitPrice; "Unit Price")
                {

                }
                column(ItemNo; "No.")
                {

                }


                dataitem(Items; Item)
                {
                    DataItemLinkReference = "Sales Line";
                    DataItemLink = "No." = field("No.");
                    column(Pack; Pack)
                    {

                    }
                    column(Box; Box)
                    {

                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if ((gLineCount MOD 3) = 0) and (gLineCount <> 0) then begin
                        //gGroupCount += 1; 
                    end;
                    gLineCount += 1;
                end;

            }
            dataitem(Comments; "Sales Comment Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "No." = field("No.");
                column(CommentLine_No_; "Line No.")
                {

                }
                column(Comment; Comment)
                {

                }
            }
            trigger OnAfterGetRecord()
            var

                TempPageCount: Integer;
                TempUOM: Text[10];
            begin
                Clear(gUsername);
                Clear(gLCYCode);
                Clear(gSalesPerson);
                Clear(gShipMethod);
                gLineCount := 0;
                gGroupCount := 0;
                gTotalPageNumber := 0;

                gRecUser.Reset();
                gRecUser.SetRange("User Name", "Create User ID");
                if gRecUser.FindSet() then
                    gUserName := gRecUser."Full Name";

                gRecLine.Reset();
                gRecLine.SetRange("Document No.", "No.");
                if gRecLine.FindSet() then begin
                    TempPageCount := gRecLine.Count;
                    gTotalPageNumber := Round(TempPageCount / 3, 1, '>') - 1; //Calculate which page the total line should show, index start with 0.
                end;                                                          //3 lines a group, page break on each group.

                gRecLCYCode.Reset();
                if gRecLCYCode.Get() then
                    gLCYCode := gRecLCYCode."LCY Code";

                gRecSalesPerson.Reset();
                if gRecSalesPerson.Get("Sales Header"."Salesperson Code") then
                    gSalesPerson := gRecSalesPerson.Name;

                gRecShipMethod.Reset();
                if gRecShipMethod.Get("Sales Header"."Shipment Method Code") then
                    gShipMethod := gRecShipMethod.Description;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }

    }
    var
        gLineCount: Integer;
        gGroupCount: Integer;
        gRecUser: Record User;
        gUserName: Text[30];
        gTotalPageNumber: Integer;
        gRecLine: Record "Sales Line";
        gRecLCYCode: Record "General Ledger Setup";
        gLCYCode: Code[3];
        gRecSalesPerson: Record "Salesperson/Purchaser";
        gSalesPerson: Text[30];
        gRecShipMethod: Record "Shipment Method";
        gShipMethod: Text[35];
        TextCustomer: TextConst CHT = '客戶名稱: ', ENU = 'Customer: ', CHS = '客户名称: ';
        TextCustomerPO: TextConst CHT = '客戶 PO#: ', ENU = 'Cusotmer PO#: ', CHS = '客户 PO#: ';
        TextSalesRegion: TextConst CHT = '銷售區域: ', ENU = 'Sales Region: ', CHS = '销售区域: ';
        TextCustomerNo: TextConst CHT = '客戶編號: ', ENU = 'Customer NO. : ', CHS = '客户编号: ';
        TextQouteNo: TextConst CHT = '交期查詢單號: ', ENU = 'Qoute NO. : ', CHS = '交期查询单号: ';
        TextCurrency: TextConst CHT = '幣別代碼: ', ENU = 'Currency Code: ', CHS = '币别代码: ';
        TextOrderDate: TextConst CHT = '訂單日期: ', ENU = 'Order Date: ', CHS = '订单日期: ';
        TextShipDate: TextConst CHT = '交貨日期: ', ENU = 'Shipment Date: ', CHS = '交货日期: ';
        TextSalesPerson: TextConst CHT = '業務員: ', ENU = 'Salesperson/Purchaser: ', CHS = '业务员: ';
        TextOrderNo: TextConst CHT = '訂單編號: ', ENU = 'Sales Header NO. : ', CHS = '订单编号: ';
        TextIndustryDesc: TextConst CHT = '行業說明: ', ENU = 'Industry Description: ', CHS = '行业说明: ';
        TextShipMethod: TextConst CHT = '發貨方式: ', ENU = 'Shipment Method: ', CHS = '发货方式: ';
        TextTitle: TextConst CHT = '貿易部訂貨通知單', ENU = 'Trade Department Order Notice', CHS = '贸易部订货通知单';
        TextCustItemNo: TextConst CHT = '客戶品號', ENU = 'Customer Item NO. ', CHS = '客户品号';
        TextCustItemName: TextConst CHT = '客戶品名', ENU = 'Customer Item Name', CHS = '客户品名';
        TextItemName: TextConst CHT = '公司品名', ENU = 'Item Name', CHS = '公司品名';
        TextSpec: TextConst CHT = '規格', ENU = 'Spec', CHS = '规格';
        TextQuantity: TextConst CHT = '數量', ENU = 'Quantity', CHS = '数量';
        TextUOM: TextConst CHT = '單位', ENU = 'Unit of Measure', CHS = '单位';
        TextUnitPrice: TextConst CHT = '單價', ENU = 'Unit Price', CHS = '单价';
        TextPack: TextConst CHT = '包裝', ENU = 'Pack', CHS = '包装';
        TextBox: TextConst CHT = '箱裝', ENU = 'Box', CHS = '箱装';
        TextItemNo: TextConst CHT = '公司品號', ENU = 'Item NO. ', CHS = '公司品号';
        TextManager: TextConst CHT = '主管: ', ENU = 'Mnager:　', CHS = '主管: ';
        TextPurchaser: TextConst CHT = '業務: ', ENU = 'Purchaser: ', CHS = '业务: ';
        TextCreater: TextConst CHT = '製單: ', ENU = 'Creater: ', CHS = '制单: ';
        TextTotal: TextConst CHT = '總計', ENU = 'Total', CHS = '总计';
        TextPrintDate: TextConst CHT = '印表日期: ', ENU = 'Print Date: ', CHS = '印表日期: ';
        TextPrintTime: TextConst CHT = '印表時間: ', ENU = 'Print Time: ', CHS = '印表时间: ';
        TextPageNumber: TextConst CHT = '印表頁次: ', ENU = 'Page Number: ', CHS = '印表页次: ';
}