import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_mobile/models/covid_item.dart';

class CovidDetail extends StatefulWidget {
  final Covid_item coviddata;

  const CovidDetail({Key? key,required this.coviddata}) : super(key: key);

  @override
  State<CovidDetail> createState() => _CovidDetailState();
}

class _CovidDetailState extends State<CovidDetail> {
  late Covid_item _coviddata;

  @override
  void initState() {
    super.initState();
    _coviddata = widget.coviddata;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("${_coviddata.province}",
          style: GoogleFonts.prompt(fontSize: 20.0)),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/Doc.jpg",height: 300.0,),
          ),
          DataTable(columns: [
            DataColumn(label: Text('')),
            DataColumn(label: Text(_coviddata.txn_date)),
            DataColumn(label: Text('รวม')),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('ยอดผู้ติดเชื้อในประเทศ')),
              DataCell(Text(_coviddata.new_case.toString())),
              DataCell(Text(_coviddata.total_case.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text('ยอดผู้ติดเชื้อเข้าประเทศ')),
              DataCell(Text(_coviddata.new_case_excludeabroad.toString())),
              DataCell(Text(_coviddata.total_case_excludeabroad.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text('ยอดผู้เสียชีวิต')),
              DataCell(Text(_coviddata.new_death.toString())),
              DataCell(Text(_coviddata.total_death.toString())),
            ]),
          ])
        ],
      ),
    );
  }
}
