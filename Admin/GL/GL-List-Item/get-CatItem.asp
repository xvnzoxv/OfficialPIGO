<!--#include file="../../../Connections/pigoConn.asp" -->
<%
    Cat_Tipe = request.queryString("Item_CatTipe")
    Cat_Tipee = request.queryString("Item_CatTipee")

    if Cat_Tipe = "" then 

    set GL_M_CategoryItem_PIGO_cmd = server.createObject("ADODB.COMMAND")
        GL_M_CategoryItem_PIGO_cmd.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_PIGO_cmd.commandText = "SELECT Cat_ID, Cat_Name FROM GL_M_CategoryItem_PIGO WHERE Cat_Tipe = '"& Cat_Tipee &"'"
    'response.Write GL_M_CategoryItem_PIGO_cmd.commandText
    set CatItem = GL_M_CategoryItem_PIGO_cmd.execute

    else

    set GL_M_CategoryItem_PIGO_cmd = server.createObject("ADODB.COMMAND")
        GL_M_CategoryItem_PIGO_cmd.activeConnection = MM_PIGO_String
        GL_M_CategoryItem_PIGO_cmd.commandText = "SELECT Cat_ID, Cat_Name FROM GL_M_CategoryItem_PIGO WHERE Cat_Tipe = '"& Cat_Tipe &"'"
    'response.Write GL_M_CategoryItem_PIGO_cmd.commandText
    set CatItem = GL_M_CategoryItem_PIGO_cmd.execute
    
    end if 

%>
<span class="cont-text"> Sub Kategori </span><br>
    <select required class=" mb-2 cont-form" name="Item_Cat_ID" id="Item_Cat_ID" aria-label="Default select example">
    <option value="">Pilih</option>
    <% do while not CatItem.eof %>
    <option value="<%=CatItem("Cat_ID")%>"> <%=CatItem("Cat_ID")%> - <%=CatItem("Cat_Name")%> </option>
    <% CatItem.movenext
    loop %>
    </select>