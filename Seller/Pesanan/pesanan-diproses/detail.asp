<!--#include file="../../../connections/pigoConn.asp"--> 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../")

    end if

    id = request.queryString("trID")

    set pesanan_cmd = server.createObject("ADODB.COMMAND")
	pesanan_cmd.activeConnection = MM_PIGO_String

    pesanan_cmd.commandText = "Select * From MKT_T_Pesanan_H where  ps_trID = '"& id &"' "
    'response.write pesanan_cmd.commandText
    set pesanan = pesanan_cmd.execute

    set seller_cmd = server.createObject("ADODB.COMMAND")
	seller_cmd.activeConnection = MM_PIGO_String

	seller_cmd.commandText = "SELECT MKT_M_Seller.slName,   MKT_M_Seller.sl_custID, MKT_M_Alamat.almID, MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec,  MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custEmail,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.trBiayaOngkir, MKT_T_Transaksi_D1.trAsuransi,MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_H.trJenisPembayaran,  MKT_T_Transaksi_D1.tr_strID FROM MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID RIGHT OUTER JOIN MKT_M_Seller ON MKT_M_Customer.custID = MKT_M_Seller.sl_custID ON MKT_T_Transaksi_D1.tr_slID = MKT_M_Seller.sl_custID RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID LEFT OUTER JOIN MKT_T_Transaksi_D1A ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_D1A.trD1A WHERE MKT_T_Transaksi_H.trID = '"& id &"' AND MKT_T_Transaksi_D1.tr_slID = '"& request.Cookies("custID") &"' GROUP BY MKT_M_Seller.slName, MKT_M_Seller.sl_custID, MKT_M_Alamat.almID,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota,  MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima,MKT_M_Alamat.almKec,  MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custEmail,  MKT_T_Transaksi_H.trID, MKT_T_Transaksi_D1.trPengiriman, MKT_T_Transaksi_H.trTglTransaksi, MKT_T_StatusTransaksi.strID, MKT_T_StatusTransaksi.strName, MKT_T_Transaksi_D1.trBiayaOngkir,  MKT_T_Transaksi_D1.trD1catatan, MKT_T_Transaksi_D1.trAsuransi, MKT_T_Transaksi_D1.trBAsuransi, MKT_T_Transaksi_D1.trPacking, MKT_T_Transaksi_D1.trBPacking, MKT_T_Transaksi_H.trJenisPembayaran,  MKT_T_Transaksi_D1.tr_strID"
    'response.write seller_cmd.commandText
    set seller = seller_cmd.execute

    set buyer_cmd = server.createObject("ADODB.COMMAND")
	buyer_cmd.activeConnection = MM_PIGO_String

    set produk_cmd = server.createObject("ADODB.COMMAND")
	produk_cmd.activeConnection = MM_PIGO_String

    set API_cmd = server.createObject("ADODB.COMMAND")
	API_cmd.activeConnection = MM_PIGO_String
    API_cmd.commandText = " SELECT * FROM GLB_M_API_Int where APIName = 'DBS' "
    'response.write API_cmd.commandText
    set API = API_cmd.execute
%>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="../../../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../fontawesome/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="../pesanan-baru/detail.css">

    <script src="../../../js/jquery-3.6.0.min.js"></script>

    <title>Otopigo</title>
    <script>
        function uk(){
            let p = Number(document.getElementById('panjang').value);
            let l = Number(document.getElementById('lebar').value);
            let t = Number(document.getElementById('tinggi').value);
            let ukr = (p*l*t);
            document.getElementById('pdukuran').value = ukr;
        }
    
    </script>

</head>
<body onload="return uk()" >

<!--Breadcrumb-->
    <div class="container mt-3">
        <div class="navigasi" >
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb ">
                    <li class="breadcrumb-item"><a href="../index.asp" >Seller Home</a></li>
                    <li class="breadcrumb-item"><a href="index.asp" >Pesanan Toko</a></li>
                    <li class="breadcrumb-item"><a href="#" >Rincian Pesanan</a></li>
                </ol>
            </nav>
        </div>
    </div> 

    <hr size="10px" color="#ececec">

    <form class="pesananbaru" action="P-pesanandiproses.asp" method="POST">
        <div class="container mt-2 mb-2 detail-pesananbaru">
            <div class="row">
                <div class="col-6">
                <span class="text-detailjudul"> Data Transaksi </span>
                    <div class="row mt-1">
                        <div class="col-12">
                            <span class="text-detail"> Pesanan ID  : <input class="text-center inp-detailpesanan" type="text" name="nopesanan" id="nopesanan" value="<%=pesanan("psID")%>"> </span>
                        </div>
                    </div>
                    <div class="row mt-1">
                        <div class="col-12">
                            <span class="text-detail"> Kode Transaksi  : <input class="text-center inp-detailpesanan" type="text" name="notransaksi" id="notransaksi" value="<%=seller("trID")%>"> / <input class="text-center inp-detailpesanan" type="text" name="tglpesanan" id="tglpesanan" value="<%=Cdate(seller("trTglTransaksi"))%>">  [ <%=seller("strName")%> ]</span><br>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <span class="text-detailjudul"> Data Seller </span>
                    <div class="row mt-1">
                        <div class="col-4">
                            <span class="text-detail"> <%=seller("slname")%></span><br>
                            <span class="text-detail"> <%=seller("almPhonePenerima")%></span><br>
                        </div>
                        <!--alamatpengirim-->
                        <div class="col-8">
                            <span class="text-detail"> <%=seller("almlengkap")%></span><br>
                            <span class="text-detail"> <%=seller("almKel")%>,<%=seller("almKec")%>,<%=seller("almKota")%></span><br>
                            <span class="text-detail"> <%=seller("almProvinsi")%>,<%=seller("almkdpos")%></span><br>
                            <input class="text-center inp-detailpesanan" type="hidden" name="alamatpengirim" id="alamatpengirim" value="<%=seller("almID")%>">
                            <input class="text-center inp-detailpesanan" type="hidden" name="sellerid" id="sellerid" value="<%=seller("sl_custID")%>">
                            
                        </div>
                        <!--alamatpengirim-->
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <span class="text-detail"> Detail Pengiriman  </span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-4">
                    <div class="row">
                        <div class="col-5">
                            <span class="text-detail"> Jenis Pembayaran  </span><br>
                            <span class="text-detail"> Jenis Pengiriman  </span><br>
                            <span class="text-detail"> Ongkos Kirim  </span><br>
                            <span class="text-detail"> Catatan Pesanan  </span><br>
                        </div>
                        <div class="col-1">
                            <span class="text-detail"> :  </span><br>
                            <span class="text-detail"> :  </span><br>
                            <span class="text-detail"> :  </span><br>
                            <span class="text-detail"> :  </span><br>
                        </div>
                        <div class="col-6">
                            <span class="text-detail"> <%=seller("trJenisPembayaran")%>  </span><br>
                            <span class="text-detail"> <%=seller("trPengiriman")%>  </span><br>
                            <span class="text-detail"> <%=seller("trBiayaOngkir")%>  </span><br>
                            <span class="text-detail"> <%=seller("trD1Catatan")%><input class="text-center inp-detailpesanan" type="hidden" name="catatan" id="catatan" value="<%=seller("trD1Catatan")%>"></span><br>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <div class="row">
                        <div class="col-3">
                            <span class="text-detail"> Asuransi  </span><br>
                            <span class="text-detail"> Packing  </span>
                        </div>
                        <div class="col-1">
                            <span class="text-detail"> :  </span><br>
                            <span class="text-detail"> :  </span>
                        </div>
                        <div class="col-8">
                            <span class="text-detail"> <%=seller("trAsuransi")%>  </span><br>
                            <span class="text-detail"> <%=seller("trPacking")%>  </span><br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            buyer_cmd.commandText = "SELECT MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.tr_custID, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almID,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong,  MKT_M_Alamat.alm_custID, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custEmail FROM MKT_T_Transaksi_H LEFT OUTER JOIN MKT_M_Alamat RIGHT OUTER JOIN MKT_M_Customer ON MKT_M_Alamat.alm_custID = MKT_M_Customer.custID ON MKT_T_Transaksi_H.tr_custID = MKT_M_Customer.custID LEFT OUTER JOIN MKT_T_Transaksi_D1A RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_Transaksi_D1A.trD1A = LEFT(MKT_T_Transaksi_D1.trD1, 12) ON MKT_T_Transaksi_H.trID = LEFT(MKT_T_Transaksi_D1.trD1, 12) LEFT OUTER JOIN MKT_T_Transaksi_D2 ON MKT_T_Transaksi_H.trID = MKT_T_Transaksi_D2.trD2 Where MKT_T_Transaksi_D1.tr_slID = '"& seller("sl_custID") &"' and MKT_T_Transaksi_H.trID = '"& seller("trID") &"' and MKT_T_Transaksi_D1.tr_strID = '01' GROUP BY MKT_M_Customer.custID, MKT_M_Customer.custNama, MKT_T_Transaksi_H.trID, MKT_T_Transaksi_H.tr_custID, MKT_M_Alamat.almNamaPenerima, MKT_M_Alamat.almPhonePenerima, MKT_M_Alamat.almID,  MKT_M_Alamat.almProvinsi, MKT_M_Alamat.almKota, MKT_M_Alamat.almKec, MKT_M_Alamat.almKel, MKT_M_Alamat.almKdpos, MKT_M_Alamat.almLengkap, MKT_M_Alamat.almLatt, MKT_M_Alamat.almLong,  MKT_M_Alamat.alm_custID, MKT_M_Customer.custPhone1, MKT_M_Customer.custPhone2, MKT_M_Customer.custEmail"
            'response.write buyer_cmd.commandText
            set buyer = buyer_cmd.execute
        %>
        <div class="container mt-2 mb-2 detail-pesananbaru">
            <div class="row">
                <div class="col-12">
                <span class="text-detailjudul"> Data Customer </span>
                    <div class="row mt-2">
                        <div class="col-12">
                            <span class="text-detail"> Customer  : <%=buyer("custNama")%> [ <%=buyer("custEmail")%> ]  </span>
                            <input class="text-center inp-detailpesanan" type="hidden" name="custid" id="custid" value="<%=buyer("custID")%>">
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row mt-2">
                <div class="col-12">
                    <span class="text-detail"> Rician Detail Produk Yang Di Pesan  </span>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-12">
                    <table class="table table-bordered table-condensed" style="font-size:12px font-weight:500">
                        <thead>
                            <tr class="text-center">
                                <th> ID Produk </th>
                                <th> Nama Produk </th>
                                <th> SKU </th>
                                <th> Berat (Gram) </th>
                                <th> Ukuran (CM) </th>
                                <th> Nilai Volume </th>
                                <th> Jumlah </th>
                                <th> Harga </th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                produk_cmd.commandText = "SELECT MKT_M_Produk.pdID, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang, MKT_M_Produk.pdLebar, MKT_M_Produk.pdTinggi,  MKT_M_Produk.pdVolume, MKT_M_Produk.pdSku FROM MKT_M_Produk RIGHT OUTER JOIN MKT_T_Transaksi_D1A ON MKT_M_Produk.pdID = MKT_T_Transaksi_D1A.tr_pdID RIGHT OUTER JOIN MKT_T_StatusTransaksi RIGHT OUTER JOIN MKT_T_Transaksi_D1 ON MKT_T_StatusTransaksi.strID = MKT_T_Transaksi_D1.tr_strID ON MKT_M_Produk.pd_custID = MKT_T_Transaksi_D1.tr_slID AND LEFT(MKT_T_Transaksi_D1A.trD1A, 12)  = LEFT(MKT_T_Transaksi_D1.trD1, 12) RIGHT OUTER JOIN MKT_T_Transaksi_H ON LEFT(MKT_T_Transaksi_D1.trD1, 12) = MKT_T_Transaksi_H.trID  Where MKT_T_Transaksi_D1.tr_slID = '"& seller("sl_custID") &"' and MKT_T_Transaksi_H.tr_custID = '"& buyer("custID") &"' and MKT_T_Transaksi_D1.tr_strID = '01' GROUP BY MKT_M_Produk.pdID, MKT_M_Produk.pdNama, MKT_T_Transaksi_D1A.tr_pdHarga, MKT_T_Transaksi_D1A.tr_pdQty, MKT_M_Produk.pdBerat, MKT_M_Produk.pdPanjang, MKT_M_Produk.pdLebar, MKT_M_Produk.pdTinggi,  MKT_M_Produk.pdVolume, MKT_M_Produk.pdSku"
                                'response.write produk_cmd.commandText
                                set produk = produk_cmd.execute
                            %>
                            <% do while not produk.eof %>
                            <tr>
                                <td class="text-center"> <%=produk("pdID")%> </td>
                                <td class="text-center"> <%=produk("pdNama")%> </td>
                                <td class="text-center"> <%=produk("pdSku")%> </td>
                                <td class="text-center"> <%=produk("pdberat")%> </td>
                                <td class="text-center"> <%=produk("pdID")%> </td>
                                <td class="text-center"> <%=produk("pdvolume")%> </td>
                                <td class="text-center"> <%=produk("tr_pdQty")%> </td>
                                <td class="text-center"> <%=produk("tr_pdHarga")%> </td>
                            </tr>
                            <%produk.movenext
                            loop%>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row align-items-center mt-2">
                <div class="col-12">
                <span class="text-detailjudul"> Konfirmasi Pesanan </span>
                    <div class="row mt-2">
                        <div class="col-2">
                            <select required class="text-detail"  name="statustransaksi" id="statustransaksi">
                                <option value=""> Pilih Konfirmasi </option>
                                <option value="02"> Pesanan Siap Dikirim </option>
                            </select>
                        </div>
                        <div class="col-2">
                            <span class="text-detail"> Pesanan Telah Sesuai ? </span><br>
                            <input class="text-detail" required type="radio" id="konfirmasips" name="konfirmasips" value="Y">
                                <label class="text-detail" for="konfirmasips">Ya</label><br>
                            <input class="text-detail" required type="radio" id="konfirmasips" name="konfirmasips" value="N">
                                <label class="text-detail" for="konfirmasips">Tidak</label><br>
                        </div>
                        <div class="col-2">
                            <input type="submit" name="" id="" Value="Proses Pesanan">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>



  
    
<!-- Body -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
    <script>

        function Timer(duration, display)   
            {
                var timer = duration, hours, minutes, seconds;
                setInterval(function () {
                    hours = parseInt((timer /3600)%24, 10)
                    minutes = parseInt((timer / 60)%60, 10)
                    seconds = parseInt(timer % 60, 10);

                            hours = hours < 10 ? "0" + hours : hours;
                    minutes = minutes < 10 ? "0" + minutes : minutes;
                    seconds = seconds < 10 ? "0" + seconds : seconds;

                    display.text(hours +":"+minutes + ":" + seconds);

                            --timer;
                }, 1000);
            }

            jQuery(function ($) 
            {
                var twentyFourHours = 24 * 60 * 60;
                var display = $('#remainingTime');
                Timer(twentyFourHours, display);
        });

    </script>
</body>
<!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>
</html>
s