﻿<%@ Page Title="" Language="C#" MasterPageFile="~/filippo_admin_page/admin_master.Master" AutoEventWireup="true" CodeBehind="a_gallery.aspx.cs" Inherits="photography.filippo_admin_page.a_gallery" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="Stylesheet" type="text/css" href="css/a_gallery.css" />  
    <script type="text/javascript">
        $(function () {
            if (!('multiple' in document.createElement('input'))) {
                var add_btn = $("<a href='#'>Add more photos</a>").insertAfter("#ContentPlaceHolder1_upload_lbl");
                var upload_pnl = $('<input type="file" runat="server"/>');
                var upload_holder = $("#fileinput_placeholder");
                add_btn.on("click", function () {
                    upload_holder.append(upload_pnl.clone());
                });
            }
        });
    </script>      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="whole_wrapper">
        <div id="insert_wrapper">
                <fieldset class="fieldset_format">
                    <legend>Insert new image:</legend>
                    <ul>
                        <li>
                            <asp:Label AssociatedControlID="title_txt" runat="server" ID="title_lbl">Title:</asp:Label>
                            <asp:TextBox ID="title_txt" runat="server" placeholder="Image title"></asp:TextBox>
                        </li>
                        <li>
                            <asp:Label AssociatedControlID="desc_txt" runat="server" ID="desc_lbl">Description:</asp:Label>
                            <asp:TextBox ID="desc_txt" runat="server" class="textarea_format" placeholder="Image description" TextMode="MultiLine"></asp:TextBox>
                        </li>
                        <li>
                            <asp:Label AssociatedControlID="cat_txt" runat="server" ID="cat_lbl">Category:</asp:Label>
                            <asp:TextBox ID="cat_txt" runat="server" placeholder="Enter new category"></asp:TextBox>
                            <span>or</span>
                            <asp:DropDownList ID="cat_ddl" runat="server" DataSourceID="SqlDataSource2" 
                                DataTextField="img_cat" DataValueField="img_cat"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:DBCS %>" 
                                ProviderName="<%$ ConnectionStrings:DBCS.ProviderName %>" 
                                SelectCommand="SELECT * FROM dbo.Select_gallery_names_FN()"></asp:SqlDataSource>                            
                        </li>
                        <li>
                            <asp:Label ID="upload_lbl" runat="server">Select Image(s) (MAX total = 10MB per upload) :</asp:Label>
                            <div id="fileinput_placeholder">
                                <input type="file" multiple="true" runat="server"/>
                            </div>
                        </li>
                        <li>
                            <asp:Button class="clear_btn buttons_positioner" runat="server" Text="Clear" CausesValidation="False" 
                            UseSubmitBehavior="False" onclientclick="reset_all(); return false;" />
                            <asp:Button class="submit_btn" runat="server" Text="Upload" id="submit_btn" onclick="submit_Click"/>                        
                        </li>
                    </ul>
                <asp:Label ID="msg_lbl" Visible="false" runat="server"></asp:Label>                
                </fieldset>
            </div>
            <div id="grid_wrapper">
                <asp:LinkButton Text="Delete selected photos" ID="DeleteBtn" OnClick="DeleteBtn_Click" OnClientClick="return confirm('Delete Selected Photos?');" class="delete_btn" runat="server" />
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                    AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" 
                    DataKeyNames="img_id" DataSourceID="SqlDataSource1" ForeColor="Black" 
                    GridLines="Vertical" PageSize="5" CssClass="mGrid">
                    <AlternatingRowStyle BackColor="#CCCCCC" />
                    <Columns>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:CheckBox ID="deleteCheck" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="img_id" Visible="false" />
                        <asp:BoundField DataField="img_title" HeaderText="Title" 
                            SortExpression="img_title" />
                        <asp:BoundField DataField="img_desc" HeaderText="Description" 
                            SortExpression="img_desc" />
                        <asp:BoundField DataField="img_cat" HeaderText="Category" 
                            SortExpression="img_cat" ReadOnly="True" />
                        <asp:BoundField DataField="img_date" HeaderText="Added in" 
                            SortExpression="img_date" ReadOnly="True">
                        <ControlStyle Width="200px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" 
                                    ImageUrl='<%# DataBinder.Eval(Container.DataItem, "img_path") %>'/>
                            </ItemTemplate>
                            <ControlStyle Height="100px" Width="150px" />
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#808080" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#383838" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConflictDetection="CompareAllValues" 
                    ConnectionString="<%$ ConnectionStrings:DBCS %>" 
                    OldValuesParameterFormatString="original_{0}" 
                    ProviderName="<%$ ConnectionStrings:DBCS.ProviderName %>" 
                    SelectCommand="SELECT * FROM dbo.Select_gallery_all_FN()">                        
                </asp:SqlDataSource>
                <asp:Label ID="grid_msg_lbl" runat="server"></asp:Label>
            </div>
    </div>    
</asp:Content>
