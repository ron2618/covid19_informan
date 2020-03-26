import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = new Random();
  List data;
  List data2;
  List data3;
  List<String> kurir;
  Future<String> getJsonData() async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull('http://api.u9.nu/covid19'),
    );
    //  print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['nasional'];
      data2 = convertDataToJson['wilayah'];
      data3 = convertDataToJson['berita'];
      //keranjang = data2[0]['id'];
    });

    return "Success";
  }

List datajember;
  Future<String> getJsonData2() async {
    var response = await http.get(
      //Encode the url
      Uri.encodeFull('https://rongamerindo.000webhostapp.com/?pass=onaldtamvan'),
    );
    //  print(response.body);

    setState(() {
      // ignore: deprecated_member_use
      var convertDataToJson = json.decode(response.body);
      datajember = convertDataToJson['jember'];
      // data2 = convertDataToJson['wilayah'];
      // data3 = convertDataToJson['berita'];
      //keranjang = data2[0]['id'];
    });

    return "Success";
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
    getJsonData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Informan Covid-19"),
        backgroundColor: Colors.orange,
      ),
      body: datajember[0] == null || data[0] == null ?
      CircularProgressIndicator():
      Column(
        children: <Widget>[
         
          //Corausel ngambil dari berita
          Expanded(
            child: Carousel(
              boxFit: BoxFit.cover,
              autoplay: false,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 6.0,
              dotIncreasedColor: Color(0xFFFF335C),
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.topRight,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              images: [
                data3.length != null
                    ? NetworkImage(
                        data3[random.nextInt(5)]['gambar'])
                    : NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRkOClf4EklmVKJEiMFW3xMDonARIfyUTMQpZqOik9yp8j_TlAE"),
                data3.length != null
                    ? NetworkImage(
                        data3[random.nextInt(5)]['gambar'])
                    : NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRkOClf4EklmVKJEiMFW3xMDonARIfyUTMQpZqOik9yp8j_TlAE"),
                data3.length != null
                    ? NetworkImage(
                        data3[random.nextInt(5)]['gambar'])
                    : NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRkOClf4EklmVKJEiMFW3xMDonARIfyUTMQpZqOik9yp8j_TlAE"),
              ],
            ),
          ),
          //akhircorausel
                //infomasi nasional
          Text("Infomasi Jember"),
          Expanded(
            child: datajember.length == null
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: datajember.length,
                    itemBuilder: (context, i) {
                      return Container(
                          child: datajember[i]['positif'] != null
                              ?  Column(
                                      children: <Widget>[
                                         Row(
                                          children: <Widget>[
                                            Text("kecamatan : "),
                                            Text(datajember[i]['kecamatan']
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("odp : "),
                                            Text(datajember[i]['odp']
                                                .toString())
                                          ],
                                        ),
                                      Row(
                                          children: <Widget>[
                                            Text("pdp : "),
                                            Text(datajember[i]['pdp']
                                                .toString())
                                          ],
                                        ),
                                       Row(
                                          children: <Widget>[
                                            Text("positif : "),
                                            Text(datajember[i]['positif']
                                                .toString())
                                          ],
                                        ),
                                   
                                      ],
                                    )
                                  : Container());
                              
                    }),
          ),
//akhir informasi nasional
          //infomasi nasional
          Text("Infomasi Nasional"),
          Expanded(
            child: data.length == null
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Container(
                          child: data[i]['positif_per_hari'] == null
                              ? data[i - 1]['positif_per_hari'] != null
                                  ? Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text("positif_per_hari : "),
                                            Text(data[i - 1]['positif_per_hari']
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("positif_kumulatif : "),
                                            Text(data[i - 1]
                                                    ["positif_kumulatif"]
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("perawatan : "),
                                            Text(data[i - 1]["perawatan"]
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("sembuh : "),
                                            Text(data[i - 1]["sembuh"]
                                                .toString())
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text("meninggal : "),
                                            Text(data[i - 1]["meninggal"]
                                                .toString())
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container()
                              : Container());
                    }),
          ),
//akhir informasi nasional
//informasi perwilayah
          Text("Infomasi Per Wilayah"),
          data2.length == null
              ? Container()
              : Expanded(
                  child: data2.length == null
                      ? CircularProgressIndicator()
                      : GridView.builder(
                          itemCount: data2.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return new Card(
                              child: new GridTile(
                                footer: new Text("Provinsi  : " +
                                    data2[index]['provinsi'].toString()),

                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        new Text("positif : " +
                                            data2[index]['positif'].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        new Text("sembuh : " +
                                            data2[index]['sembuh'].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        new Text("meninggal : " +
                                            data2[index]['meninggal']
                                                .toString()),
                                      ],
                                    ),
                                  ],
                                ), //just for testing, will fill with image later
                              ),
                            );
                          },
                        ),
                ),
          //akhir dari segalanya :'(
        ],
      ),
    );
  }
}
