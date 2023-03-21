<!--#include file="../../../connections/pigoConn.asp"--> 
 
<%
    if request.Cookies("custEmail")="" then

    response.redirect("../../../")

    end if

    pdID = request.queryString("pdID")

	dim upproduk
			
	set upproduk_cmd = server.createObject("ADODB.COMMAND")
	upproduk_cmd.activeConnection = MM_PIGO_String

	upproduk_cmd.commandText = "SELECT MKT_M_PIGO_Produk.pdID,MKT_M_PIGO_Produk.pdHarga As Harga, MKT_M_PIGO_Produk.pdImage, MKT_M_PIGO_Produk.pdNama,MKT_M_Kategori.catID, MKT_M_Kategori.catName, MKT_M_Merk.mrID,MKT_M_Merk.mrNama, MKT_M_PIGO_Produk.pdKondisi, MKT_M_PIGO_Produk.pdTypeProduk, MKT_M_PIGO_Produk.pdTypePart, MKT_M_PIGO_Produk.pdStokAwal, MKT_M_PIGO_Produk.pdPartNumber,MKT_M_PIGO_Produk.pdBerat, MKT_M_PIGO_Produk.pdPanjang, MKT_M_PIGO_Produk.pdLebar, MKT_M_PIGO_Produk.pdTinggi, MKT_M_PIGO_Produk.pdVolume FROM MKT_T_MaterialReceipt_D1 RIGHT OUTER JOIN  MKT_T_MaterialReceipt_H LEFT OUTER JOIN MKT_T_MaterialReceipt_D2 ON MKT_T_MaterialReceipt_H.mmID = MKT_T_MaterialReceipt_D2.mmID_D2 ON MKT_T_MaterialReceipt_D1.mmID_D1 = MKT_T_MaterialReceipt_H.mmID RIGHT OUTER JOIN MKT_M_Kategori RIGHT OUTER JOIN  MKT_M_Merk RIGHT OUTER JOIN MKT_M_PIGO_Produk ON MKT_M_Merk.mrID = MKT_M_PIGO_Produk.pd_mrID ON MKT_M_Kategori.catID = MKT_M_PIGO_Produk.pd_catID ON MKT_T_MaterialReceipt_D2.mm_pdID = MKT_M_PIGO_Produk.pdID Where MKT_M_PIGO_Produk.pdID = '"& pdID &"' " 
    'response.write upproduk_cmd.commandText
	set upproduk = upproduk_cmd.execute

	dim kategori
			
	set kategori_cmd = server.createObject("ADODB.COMMAND")
	kategori_cmd.activeConnection = MM_PIGO_String
			
	kategori_cmd.commandText = "SELECT [catID] ,[catName] ,[catAktifYN] FROM [PIGO].[dbo].[MKT_M_Kategori] where catAktifYN = 'Y'" 
	set kategori = kategori_cmd.execute
    
	dim sub1
			
	set sub1_cmd = server.createObject("ADODB.COMMAND")
	sub1_cmd.activeConnection = MM_PIGO_String
			
	sub1_cmd.commandText = "SELECT [scat1ID] ,[scat1Name] ,[scat1AktifYN] FROM [PIGO].[dbo].[MKT_T_SubKategori1] where scat1AktifYN = 'Y'" 
	set sub1 = sub1_cmd.execute
			


	dim merk

    set merk_cmd = server.createObject("ADODB.COMMAND")
	merk_cmd.activeConnection = MM_PIGO_String
			
	merk_cmd.commandText = "SELECT [mrID] ,[mrNama] ,[mrAktifYN] FROM [PIGO].[dbo].[MKT_M_Merk] where mrAktifYN = 'Y'" 
	set merk = merk_cmd.execute

	dim Alamat

    set Alamat_cmd = server.createObject("ADODB.COMMAND")
	Alamat_cmd.activeConnection = MM_PIGO_String
			
	Alamat_cmd.commandText = "SELECT * From MKT_M_Alamat where alm_custID = '"&request.cookies("custID")&"' and almJenis = 'Alamat Toko' " 
	set Alamat = Alamat_cmd.execute
%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/css/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/Produk/produk.css">
        <link rel="stylesheet" type="text/css" href="<%=base_url%>/fontawesome/css/all.min.css">
        <script src="<%=base_url%>/js/jquery-3.6.0.min.js"></script>

        <title>PIGO</title>
        
    <script>

        const loadFile1 = function(event) {
            const output1 = document.getElementById('output1');
                output1.src = URL.createObjectURL(event.target.files[0]);
                output1.onload = function() {
                URL.revokeObjectURL(output1.src)
            }
        }

        const loadFile2 = function(event) {
            const output2 = document.getElementById('output2');
                output2.src = URL.createObjectURL(event.target.files[0]);
                output2.onload = function() {
                URL.revokeObjectURL(output2.src)
            }
        };

        const loadFile3 = function(event) {
            const output3 = document.getElementById('output3');
                output3.src = URL.createObjectURL(event.target.files[0]);
                output3.onload = function() {
                URL.revokeObjectURL(output3.src)
            }
        };

        const loadFile4 = function(event) {
            const output4 = document.getElementById('output4');
                output4.src = URL.createObjectURL(event.target.files[0]);
                output4.onload = function() {
                URL.revokeObjectURL(output4.src)
            }
        };

        // const loadFile5 = function(event) {
        //     const output5 = document.getElementById('output5');
        //         output5.src = URL.createObjectURL(event.target.files[0]);
        //         output5.onload = function() {
        //         URL.revokeObjectURL(output5.src)
        //     }
        // };

        const loadFile6 = function(event) {
            const output6 = document.getElementById('output6');
                output6.src = URL.createObjectURL(event.target.files[0]);
                output6.onload = function() {
                URL.revokeObjectURL(output6.src)
            }
        };

        function simpan(){
            let sim= document.getElementsByClassName("sim");

            document.getElementById("lanjut").style.display = "block";
        }
        
        function variasipr(){
            let variasi = document.getElementsByClassName("variasi");

            document.getElementById("variasi").style.display = "block";
        }

        function nilaivolume(){
            var panjang = Number(document.getElementById("panjang").value);
            var lebar = Number(document.getElementById("lebar").value);
            var tinggi = Number(document.getElementById("tinggi").value);
            var volume = 0;
            var nilaivolume = parseInt(panjang*lebar*tinggi);
            volume = nilaivolume;
            document.getElementById("totVol").value = volume;
        };
        document.addEventListener("DOMContentLoaded", function(event) {
            nilaivolume();
        });
        
        function harga() {
            var hargabeli = Number(document.getElementById("hargabeli").value);
            var up = Number(document.getElementById("upto").value);
            var ppn = Number(document.getElementById("ppn").value);
            var total = 0;
            var resultup = Number(hargabeli+(hargabeli*up/100));
            var resultppn = Number(resultup*ppn/100);
            var result = Number(resultup+resultppn);
            total = Math.round(result);
            
            document.getElementById("hargajual").value = total;
        }
        document.addEventListener("DOMContentLoaded", function(event) {
            harga();
        });

    </script>
    </head>
<body>
    <!--Breadcrumb-->
    <div class="container  mt-3">
        <div class="row align-items-center ">
            <div class="col-12  div-produk">
                <div class="navigasi" >
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb ">
                            <li class=" txt-desc breadcrumb-item"><a href="index.asp">Lengkapi Produk</a></li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!--Breadcrumb-->

    <!--Body Seller-->
    <div class="container" style="margin-top:1rem; ">
        <div class="" style="margin-top:1rem; ">
            <div class="row">
            <!--Tambah Produk Baru-->
            <div class="col-lg-0 col-md-0 col-sm-0 col-12" id="tambahproduk" style="padding: 20px 50px" >
                <div class="div-tambah-produk">
                    <span class="txt-judul" style="font-size:20px">Tambah Produk Baru</span><br>
                    <span class="txt-desc" >Hindari berjualan produk palsu/melanggar Hak Kekayaan Intelektual, supaya produkmu tidak dihapus.</span>
                    <form class="formproduk" action="P-Produk.asp"  method="POST" >
                        <div class="row mt-4">
                            <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                <span class="txt-judul" id="uploadproduk">Upload Produk</span>
                            <p class="txt-desc" >Format gambar .jpg .jpeg .png dan ukuran minimum 300 x 300px (Untuk gambar optimal gunakan ukuran minimum 700 x 700 px).</p>
                            <p class="txt-desc" >Pilih foto produk, Cantumkan min. 3 foto yang menarik agar produk semakin menarik pembeli.</p>
                            </div>
                            <div class="col-lg-0 col-md-0 col-sm-0 col-8 ">
                                <div class="row mt-4">
                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <div class="text-center potoproduk" >
                                            <label for="firstimg1" class="gambar">
                                            <img src="<%=base_url%>/assets/logo/upload.png" id="output1"   width="60" height="60" >
                                            <span class="txt-desc" style="font-size:10px;"> Gambar Utama </span>
                                            </label>
                                            <input type="file" name="firstimg1" id="firstimg1" style="display:none" onchange="loadFile1(event)"><br>
                                            <textarea name="image1" id="base64_1" rows="1" style="display:none" ></textarea>
                                        </div>
                                    </div>

                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <div class="text-center potoproduk">
                                            <label for="firstimg2" class="gambar">
                                            <img src="<%=base_url%>/assets/logo/upload.png" id="output2" width="60" height="60" >
                                            <span class="txt-desc text-center" style="font-size:10px;"> Depan </span>
                                            </label>
                                            <input type="file" name="firstimg2" id="firstimg2" style="display:none" onchange="loadFile2(event)"><br>
                                            <textarea name="image2" id="base64_2" rows="1"style="display:none"   ></textarea>
                                        </div>
                                    </div>

                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <div class="text-center potoproduk">
                                            <label for="firstimg3" class="gambar">
                                            <img src="<%=base_url%>/assets/logo/upload.png" id="output3" width="60" height="60">
                                            <span class="txt-desc text-center" style="font-size:10px;"> Belakang </span>
                                            </label>
                                            <input type="file" name="firstimg3" id="firstimg3" style="display:none" onchange="loadFile3(event)"><br>
                                            <textarea name="image3" id="base64_3" rows="1"style="display:none"></textarea>
                                        </div>
                                    </div>

                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <div class="text-center potoproduk">
                                            <label for="firstimg4" class="gambar">
                                            <img src="<%=base_url%>/assets/logo/upload.png" id="output4" width="60" height="60">
                                            <span class="txt-desc text-center" style="font-size:10px;"> Bawah </span>
                                            </label>
                                            <input type="file" name="firstimg4" id="firstimg4" style="display:none" onchange="loadFile4(event)"><br>
                                            <textarea name="image4" id="base64_4" rows="1"style="display:none"></textarea>
                                        </div>
                                    </div>

                                    <!--<div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <div class=" potoproduk">
                                            <label for="firstimg5">
                                            <img src="<%=base_url%>/assets/logo/upload.png" id="output5" width="60" height="60" ">
                                            </label>
                                            <input type="file" name="firstimg5" id="firstimg5" style="display:none" onchange="loadFile5(event)"><br>
                                            <textarea name="image5" id="base64_5" rows="1"  ></textarea>
                                        </div>
                                    </div>-->

                                    <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                        <div class="text-center potoproduk">
                                            <label for="firstimg6"  class="gambar">
                                                <img src="<%=base_url%>/assets/logo/upload.png" id="output6" width="60" height="60"><br>
                                                <span class="txt-desc text-center" style="font-size:10px;"> Atas </span>
                                            </label>
                                            <input type="file" name="firstimg6" id="firstimg6" style="display:none" onchange="loadFile6(event)"><br>
                                            <textarea name="image6" id="base64_6" rows="1" style="display:none"></textarea>
                                        </div>
                                    </div>
                                </div>
                                </div>
                            </div>
                </div>

                <div class="div-tambah-produk mt-4 mb-2">
                    <div class="row" >
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <span class="txt-judul mb-2" style="font-size:20px">Detail Produk</span>

                            <div class="row mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <span class="txt-desc">Nama Produk</span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                                    <input type="hidden" name="pdID" id="pdID" value="<%=upproduk("pdID")%>" >
                                    <textarea name="namaproduk" id="namaproduk" required class="form-tambah-produk"><%=upproduk("pdNama")%></textarea>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-2">
                                    <span class="txt-desc">Kategori Produk</span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                                    <select name="kategori" id="kategori" class="form-tambah-produk mt-2 txt-desc" aria-label="Default select example">
                                        <option value="<%=upproduk("catID") %>"><%=upproduk("catName")%></option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-3" style="display:none">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-2 mt-2">
                                    <span class="txt-desc"> Sub 1 </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                                    <select name="d" id="d" class="form-select mt-2 text-kategori2" aria-label="Default select example" style="width:48.5rem; ">
                                    <% do while not sub1.eof %>
                                    <option value="<%=sub1("scat1ID") %> "><%=sub1("scat1Name")%></option>
                                    <% sub1.movenext
                                    loop %>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-3"  style="display:none" >
                                <div class="col-lg-0 col-md-0 col-sm-0 col-2 mt-2">
                                    <span class="txt-desc"> Sub 2 </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-8">
                                    <select name="d" id="d" class="form-select mt-2 text-kategori2" aria-label="Default select example" style="width:48.5rem; ">
                                    <% do while not sub1.eof %>
                                    <option value="<%=sub1("scat1ID") %> "><%=sub1("scat1Name")%></option>
                                    <% sub1.movenext
                                    loop %>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3  mt-3">
                                    <span class="txt-desc">Merk</span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9  mt-2">
                                    <select name="merk" id="merk" class="form-tambah-produk mt-2 txt-desc" aria-label="Default select example">
                                        <option value="<%=upproduk("mrID")%> "><%=upproduk("mrNama")%></option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3  mt-3">
                                    <span class="txt-desc">Type Produk</span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9  mt-2">
                                    <input type="text" name="type" id="type" class="form-tambah-produk mt-2 " value="<%=upproduk("pdTypeProduk")%>" disabled="true">
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                            <fieldset class="row ">
                            <legend class=" txt-desc">Kondisi Produk</legend>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                            <div class="form-check">
                                <input class="form-check-input txt-desc" type="radio" name="kondisi" id="kondisi1" value="Y" checked>
                                <label class="form-check-label txt-desc" for="gridRadios1">
                                Baru
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input txt-desc" type="radio" name="kondisi" id="kondisi2" value="N">
                                <label class="form-check-label txt-desc" for="gridRadios2">
                                Bekas
                                </label>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                            <fieldset class="row">
                            <legend class="txt-desc ">Produk Berbahaya</legend>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                            <div class="form-check">
                                <input class="form-check-input txt-desc " type="radio" name="Dangerous" id="Dangerous" value="Y" checked>
                                <label class="form-check-label txt-desc " for="gridRadios1">
                                    Tidak
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input txt-desc " type="radio" name="Dangerous" id="Dangerous" value="N">
                                <label class="form-check-label txt-desc " for="gridRadios2">
                                Mengandung Baterai/Magnet/Cairan/Bahan Mudah Terbakar
                                </label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mt-4">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                            <fieldset class="row mb-6">
                            <legend class="col-form-label col-sm-5 pt-0 txt-desc ">Deksripsi</legend>
                            <p class="text-desc" >Pastikan deskripsi produk memuat penjelasan detail terkait produkmu agar pembeli mudah mengerti dan menemukan produkmu.</p>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                            <textarea  name="deskripsi" id="deksripsi" class="form-tambah-produk txt-desc"  id="deskripsi" rows="10" cols="80" required></textarea>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-4">
                            <span class="txt-desc"> Tanggal Produksi </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-4">
                            <input type="date" name="tglproduksi" id="tglproduksi" class="text-center form-tambah-produk txt-desc " style="width:26rem; heigth:100px">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-4">
                            <span class="txt-desc"> Tanggal Expired </span>
                        </div>
                        <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-4">
                            <input type="date" name="tglexp" id="tglexp" class="text-center form-tambah-produk txt-desc " style="width:26rem; heigth:100px">
                        </div>
                    </div>

                    <div class="row mt-4" >
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <span class="txt-judul mb-4" style="font-size:20px">Kelola Prodak</span>

                            <div class="row mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <span class="txt-desc"> Status Produk </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                                    <div class="form-check">
                                        <input class="form-check-input txt-desc " type="radio" name="statusproduk" id="statusproduk" value="Y" checked>
                                        <label class="form-check-label txt-desc " for="gridRadios1">
                                            Aktif
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input txt-desc " type="radio" name="statusproduk" id="statusproduk" value="N">
                                        <label class="form-check-label txt-desc " for="gridRadios2">
                                        Tidak Aktif
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <span class="txt-desc"> Stok Produk </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9">
                                    <input name="stok" id="stok" type="number" class="text-center form-tambah-produk txt-desc" style="width:26rem; height:38px" value="<%=upproduk("pdStokAwal")%>" required>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3 ">
                                    <span class="txt-desc"> SKU (Stock Keeping Unit) </span>
                                    <p class="text-desc" >Gunakan kode unik SKU jika kamu ingin menandai produkmu.</p>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9 ">
                                    <input name="sku" id="sku" type="text" class="form-tambah-produk txt-desc" style="width:26rem; height:38px" placeholder="Masukan SKU" value="<%=upproduk("pdPartNumber")%>"required >
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row mt-4" >
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <span class="txt-judul mb-4" style="font-size:20px">Harga</span>

                            <div class="row">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-4">
                                    <span class="txt-desc"> Minimum Pemesanan </span>
                                    <p class="text-desc" >Atur jumlah minimum yang harus dibeli untuk produk ini</p>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-4">
                                    <input name="minpesanan" id="minpesanan" type="number" class="form-tambah-produk text-center" style="width:26rem; height:38px" value="1" required >
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-4">
                                    <span class="txt-desc"> Harga </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-4">
                                    <div class="row">
                                        <div class="col-3">
                                            <span class="txt-desc"> Harga Beli </span>
                                        </div>
                                        <div class="col-6">
                                            <div class="input-group mb-3">
                                                <span class="input-group-text" id="basic-addon2">Rp.</span>
                                                <div class="input-group-append">
                                                    <input onkeyup="harga()" name="hargabeli" id="hargabeli" type="number" class="form-tambah-desc" style="width:10rem; height:38px; border-top-right-radius:10px;border-bottom-right-radius:10px"value="<%=upproduk("Harga")%>" required >
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-3">
                                            <span class="txt-desc"> Kenaikan Harga</span>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <div class="input-group ">
                                                <div class="input-group-append">
                                                    <input onkeyup="harga()" name="upto" id="upto" type="number" class=" text-center form-tambah-desc" style="width:11rem; height:38px; border-top-left-radius:10px;border-bottom-left-radius:10px" required >
                                                </div>
                                                <span class="input-group-text" id="basic-addon2">%</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-3">
                                            <span class="txt-desc"> PPN </span>
                                        </div>
                                        <div class="col-6 mb-3">
                                            <div class="input-group ">
                                                <div class="input-group-append">
                                                    <input onkeyup="harga()" name="ppn" id="ppn" type="number"  class=" text-center form-tambah-desc" style="width:11rem; height:38px; border-top-left-radius:10px;border-bottom-left-radius:10px" required >
                                                </div>
                                                <span class="input-group-text" id="basic-addon2">%</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-3">
                                            <span class="txt-desc"> Harga Jual </span>
                                        </div>
                                        <div class="col-6">
                                            <div class="input-group">
                                            <span class="input-group-text" id="basic-addon2">Rp.</span>
                                                <div class="input-group-append">
                                                    <input name="hargajual" id="hargajual" type="number"  class="form-tambah-desc" style="width:10rem; height:38px; border-top-right-radius:10px;border-bottom-right-radius:10px" required >
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-5 me-3">
                                    <span class="txt-desc"> Harga Grosir </span>
                                    <p class="text-desc" >Tambah harga grosir untuk pembelian jumlah tertentu.</p>
                                </div>
                                <div class="col-6 ms-2">
                                    <div class="input-group">
                                        <span class="input-group-text" id="basic-addon2">Rp.</span>
                                        <div class="input-group-append">
                                            <input name="hargagrosir" id="hargagrosir" type="number"  class="form-tambah-desc" style="width:10rem; height:38px; border-top-right-radius:10px;border-bottom-right-radius:10px" value="0" required >
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="row" >
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <span class="txt-judul mb-4" style="font-size:20px">Berat dan Pengiriman</span>

                            <div class="row">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3 mt-4">
                                    <span class="txt-desc"> Berat </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-4">
                                    <div class="input-group mb-3">
                                    <input name="berat" id="berat" type="number" class="form-tambah-produk txt-desc" style="width:15rem; heigth:100px" value="<%=upproduk("pdberat")%>" required>
                                        <div class="input-group-append">
                                            <span class="input-group-text" id="basic-addon2">gram</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3 ">
                                    <span class="txt-desc"> Volume </span>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-9">

                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-2">
                                            <span class="txt-desc"> Panjang </span>
                                        </div>
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-6">
                                            <div class="input-group mb-3">
                                                <input onkeyup="nilaivolume()" name="panjang" id="panjang" type="number" class="form-tambah-produk txt-desc" style="width:8rem; heigth:20px" value="<%=upproduk("pdPanjang")%>" required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text" id="basic-addon2">cm</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-2 mt-2">
                                            <span class="txt-desc"> Lebar </span>
                                        </div>
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-9 mt-2">
                                            <div class="input-group mb-3">
                                                <input onkeyup="nilaivolume()" name="lebar" id="lebar" type="number" class="form-tambah-produk txt-desc" style="width:8rem; heigth:20px" value="<%=upproduk("pdlebar")%>" required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text" id="basic-addon2">cm</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-2 mt-2">
                                            <span class="txt-desc"> Tinggi </span>
                                        </div>
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-6 mt-2">
                                            <div class="input-group mb-3">
                                                <input onkeyup="nilaivolume()" name="tinggi" id="tinggi" type="number" class="form-tambah-produk txt-desc" style="width:8rem; heigth:20px" value="<%=upproduk("pdTinggi")%>" required>
                                                <div class="input-group-append">
                                                    <span class="input-group-text" id="basic-addon2">cm</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-0 col-md-0 col-sm-0 col-4 mt-2">
                                            <input  name="totVol" id="totVol" type="readonly" class="form-tambah-produk txt-desc" style="width:19rem; text-align:center" value="<%=upproduk("pdVolume")%>" readonly >
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-3">
                                    <span class="txt-desc"> Alamat Pengiriman </span>
                                </div>
                                <div class="col-9">
                                    <select name="almID" id="almID" class="form-select mt-2 txt-desc" aria-label="Default select example" >
                                        <option value="">Pilih Alamat Pengiriman</option>
                                        <% do while not Alamat.eof %>
                                        <option value="<%=Alamat("almID") %>"><%=Alamat("almKota")%></option>
                                        <% Alamat.movenext
                                        loop %>
                                    </select>
                                </div>
                            </div>
                            
                            <!--<div class="row ">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                    <fieldset class="row mb-6">
                                    <legend class=" txt-desc">Asuransi Pengiriman</legend>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                    <div class="form-check">
                                        <input class="form-check-input txt-desc" type="radio" name="asuransi" id="asuransi" value="Y" checked>
                                        <label class="form-check-label txt-desc" for="gridRadios1">
                                        Wajib
                                        </label>
                                    </div>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-4">
                                    <div class="form-check">
                                        <input class="form-check-input txt-desc" type="radio" name="asuransi" id="asuransi" value="N" >
                                        <label class="form-check-label txt-desc" for="gridRadios1">
                                        Opsional
                                        </label>
                                    </div>
                                </div>
                            </div>-->

                            <div class="row mt-3">
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <fieldset class="row mb-6">
                                    <legend class=" txt-desc">Layanan Pengiriman</legend>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <div class="form-check">
                                        <input class="form-check-input txt-desc" type="checkbox" name="layanan" id="layanan" value="Kurir" checked>
                                        <label class="form-check-label txt-desc" for="gridRadios1">
                                        Kurir
                                        </label><br>
                                        <span class=" text-desc">*Minimal [ 1 ] KG </span>

                                    </div>
                                </div>
                                <div class="col-lg-0 col-md-0 col-sm-0 col-3">
                                    <div class="form-check">
                                        <input class="form-check-input txt-desc" type="checkbox" name="layanan" id="layanan" value="Reguler" >
                                        <label class="form-check-label txt-desc" for="gridRadios1">
                                        Kargo
                                        </label><br>
                                        <span class=" text-desc">*Minimal [ 20 ] KG </span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row mt-3">
                        <div class="col-lg-0 col-md-0 col-sm-0 col-12">
                            <button type="button" class="btn txt-desc btn-tambah ml-10 mt-2 mt-2 mb-2" onclick="window.open('<%=base_url%>/Seller/','_Self')" >Batal</button>
                            <input type="submit"  class="btn txt-desc btn-tambah  mt-2 mb-2" value="simpan">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <script>
        if (window.File && window.FileReader && window.FileList && window.Blob) {
        document.getElementById('firstimg1').addEventListener('change', SKUFileSelect1, false);
        } else {
        alert('The File APIs are not fully supported in this browser.');
        }

        function SKUFileSelect1(evt) {
        var f1 = evt.target.files[0];
        var reader1 = new FileReader();

        reader1.onload = (function(theFile1) {
            return function(e1) {
            var binaryData1 = e1.target.result;

            var base64String1 = window.btoa(binaryData1);

            document.getElementById('base64_1').value = base64String1;
            };
        })(f1);
        // Read in the image file as a data URL.
        reader1.readAsBinaryString(f1);
        }

        // Check for the File API support.
        if (window.File && window.FileReader && window.FileList && window.Blob) {
        document.getElementById('firstimg2').addEventListener('change', SKUFileSelect2, false);
        } else {
        alert('The File APIs are not fully supported in this browser.');
        }

        function SKUFileSelect2(evt) {
        var f2 = evt.target.files[0]; // FileList object
        var reader2 = new FileReader();
        // Closure to capture the file information.
        reader2.onload = (function(theFile2) {
            return function(e2) {
            var binaryData2 = e2.target.result;
            //Converting Binary Data to base 64
            var base64String2 = window.btoa(binaryData2);
            //showing file converted to base64
            document.getElementById('base64_2').value = base64String2;
            };
        })(f2);
        // Read in the image file as a data URL.
        reader2.readAsBinaryString(f2);
        }

        // Check for the File API support.
        if (window.File && window.FileReader && window.FileList && window.Blob) {
        document.getElementById('firstimg3').addEventListener('change', SKUFileSelect3, false);
        } else {
        alert('The File APIs are not fully supported in this browser.');
        }

        function SKUFileSelect3(evt) {
        var f3 = evt.target.files[0]; // FileList object
        var reader3 = new FileReader();
        // Closure to capture the file information.
        reader3.onload = (function(theFile3) {
            return function(e3) {
            var binaryData3 = e3.target.result;
            //Converting Binary Data to base 64
            var base64String3 = window.btoa(binaryData3);
            //showing file converted to base64
            document.getElementById('base64_3').value = base64String3;
            };
        })(f3);
        // Read in the image file as a data URL.
        reader3.readAsBinaryString(f3);
        }

        // Check for the File API support.
        if (window.File && window.FileReader && window.FileList && window.Blob) {
        document.getElementById('firstimg4').addEventListener('change', SKUFileSelect4, false);
        } else {
        alert('The File APIs are not fully supported in this browser.');
        }

        function SKUFileSelect4(evt) {
        var f4 = evt.target.files[0]; // FileList object
        var reader4 = new FileReader();
        // Closure to capture the file information.
        reader4.onload = (function(theFile4) {
            return function(e4) {
            var binaryData4 = e4.target.result;
            //Converting Binary Data to base 64
            var base64String4 = window.btoa(binaryData4);
            //showing file converted to base64
            document.getElementById('base64_4').value = base64String4;
            };
        })(f4);
        // Read in the image file as a data URL.
        reader4.readAsBinaryString(f4);
        }
        
        // // Check for the File API support.
        // if (window.File && window.FileReader && window.FileList && window.Blob) {
        // document.getElementById('firstimg5').addEventListener('change', SKUFileSelect5, false);
        // } else {
        // alert('The File APIs are not fully supported in this browser.');
        // }

        // function SKUFileSelect5(evt) {
        // var f5 = evt.target.files[0]; // FileList object
        // var reader5 = new FileReader();
        // // Closure to capture the file information.
        // reader5.onload = (function(theFile5) {
        //     return function(e5) {
        //     var binaryData5 = e5.target.result;
        //     //Converting Binary Data to base 64
        //     var base64String5 = window.btoa(binaryData5);
        //     //showing file converted to base64
        //     document.getElementById('base64_5').value = base64String5;
        //     };
        // })(f5);
        // // Read in the image file as a data URL.
        // reader5.readAsBinaryString(f5);
        // }

        // Check for the File API support.
        if (window.File && window.FileReader && window.FileList && window.Blob) {
        document.getElementById('firstimg6').addEventListener('change', SKUFileSelect6, false);
        } else {
        alert('The File APIs are not fully supported in this browser.');
        }

        function SKUFileSelect6(evt) {
        var f6 = evt.target.files[0]; // FileList object
        var reader6 = new FileReader();
        // Closure to capture the file information.
        reader6.onload = (function(theFile6) {
            return function(e6) {
            var binaryData6 = e6.target.result;
            //Converting Binary Data to base 64
            var base64String6 = window.btoa(binaryData6);
            //showing file converted to base64
            document.getElementById('base64_6').value = base64String6;
            };
        })(f6);
        // Read in the image file as a data URL.
        reader6.readAsBinaryString(f6);
        }
    

        function openDialog() {
            document.getElementById('fileid').click();
        }

        $("#merk").on("keyup", function(){
        let merk = $("#merk").val();
        // $.getJSON('tes.asp', function(data){
        console.log(data);
            //    $.each(data, function(i, data){
            //           console.log(data);
            //           if (kategori== data.IDMerk){
            //             $('.tampilmerk').html(`<>`)
            //           }
            //       })
            //       })
                });
    </script>
    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="<%=base_url%>/js/bootstrap.bundle.min.js"></script>    
</html>
