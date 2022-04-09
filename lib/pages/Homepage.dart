import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:project_mobile/models/covid_item.dart';
import 'package:project_mobile/pages/Covid_detail.dart';
import 'package:project_mobile/pages/covid_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List> _covid_list;

  @override
  void initState() {
    super.initState();
    _covid_list = _loadFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLUTTER COVID'),
      ),
      body: Stack(children: [
        FutureBuilder<List>(
          future: _covid_list,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              var data = snapshot.data!;
              print(data.length);
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: data.length,
                itemBuilder: (con, index) =>
                    _buildListItem(con, index, data[index]),
              );
            }
            return SizedBox.shrink();
          },
        )
      ]),
    );
  }
}

Future<List> _loadFoods() async {
  final url = Uri.parse(
      'https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces');
  var response = await http.get(url);

  var json = jsonDecode(response.body);

  return json.map<Covid_item>((item) => Covid_item.fromJson(item)).toList();
}

Widget _buildListItem(BuildContext context, int index, Covid_item covidItem) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.all(8.0),
    elevation: 5.0,
    shadowColor: Colors.black.withOpacity(0.2),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  CovidDetail(coviddata: covidItem,)),
        );
      },
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/care.png",
                    height: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        covidItem.province,
                        style: GoogleFonts.prompt(fontSize: 20.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${covidItem.txn_date.toString()}   ',
                            style: GoogleFonts.prompt(fontSize: 15.0),
                          ),
                          Icon(Icons.coronavirus,color: Colors.green,),
                          Text(
                            '${covidItem.total_case.toString()}(+${covidItem.new_case}) คน',
                            style: GoogleFonts.prompt(fontSize: 15.0),
                          ),
                          SizedBox(width: 10.0,),
                          Text(
                            '☠️${covidItem.total_death.toString()}(+${covidItem.new_death}) คน',
                            style: GoogleFonts.prompt(fontSize: 15.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );


}

