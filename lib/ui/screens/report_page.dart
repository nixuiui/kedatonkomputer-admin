import 'dart:io';

import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:kedatonkomputer/core/bloc/order/order_bloc.dart';
import 'package:kedatonkomputer/core/bloc/order/order_event.dart';
import 'package:kedatonkomputer/core/bloc/order/order_state.dart';
import 'package:kedatonkomputer/core/models/report_model.dart';
import 'package:kedatonkomputer/helper/app_consts.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/loading.dart';
import 'package:kedatonkomputer/ui/widget/text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  var bloc = OrderBloc();
  var isLoading = true;
  ReportResponse report;
  DateTime fromDate;
  DateTime toDate;

  final pdf = pw.Document();

  @override
  void initState() {
    var now = DateTime.now();
    fromDate = DateTime(now.year, now.month, now.day-30, 0, 0);
    toDate = DateTime(now.year, now.month, now.day, 00, 00);

    refresh();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  writeOnPdf(){
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context){
          var rows = <List<String>>[];
          rows.add(<String>['Nama', 'Stok', 'Harga Jual', 'Penjualan Hasil', 'Order Dicancel', "Income"]);
          report.myReport.forEach((item) {
            rows.add(<String>[
              "${item?.name ?? ''} (${item?.merkProduct ?? ''})", 
              item?.stock?.toString() ?? "", 
              rupiah(item?.sellPrice ?? ""),
              item?.totalDone?.toString() ?? "",
              item?.totalDibatalkan?.toString() ?? "",
              rupiah(item?.totalPendapatan ?? "")
            ]);
          });
          return <pw.Widget>  [
            pw.Header(
              level: 1,
              child: pw.Center(child: pw.Text("Laporan Penjualan"))
            ),
            pw.SizedBox(height: 16),
            pw.Table.fromTextArray(context: context, data: rows)
          ];
        },
      )
    );
  }

  refresh() {
    setState(() {
      isLoading = true;
    });
    bloc.add(GetReport(
      fromDate: DateFormat("yyyy-MM-dd").format(fromDate),
      toDate: DateFormat("yyyy-MM-dd").format(toDate),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is ReportLoaded) {
          setState(() {
            isLoading = false;
            report = state.data;
          });
        } else if(state is OrderFailure) {
          Toast.show(state.error, context);
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Report"),
        ),
        body: Column(
          children: [
            Box(
              padding: 16,
              boxShadow: [AppBoxShadow.type3],
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelText("Dari"),
                        Text(DateFormat("yyyy-MM-dd").format(fromDate)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelText("Sampai"),
                        Text(DateFormat("yyyy-MM-dd").format(toDate)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: isLoading ? LoadingCustom() : Icon(Icons.edit), 
                    onPressed: () => selectDate(context)
                  )
                ],
              )
            ),
          ],
        ),
        floatingActionButton: isLoading ? Text("") : FloatingActionButton(
          onPressed: ()async{
            writeOnPdf();
            await savePdf();

            Directory documentDirectory = await getApplicationDocumentsDirectory();

            String documentPath = documentDirectory.path;

            String fullPath = "$documentPath/example.pdf";

            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PdfPreviewScreen(path: fullPath,)
            ));

          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  Future savePdf() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/example.pdf");

    file.writeAsBytesSync(pdf.save());
  }

  selectDate(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: new DateTime(1960),
        lastDate: new DateTime.now()
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[1];
        refresh();
      });
    }
  }
}

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  PdfPreviewScreen({this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Penjualan")
      ),
      body: PDFViewerScaffold(
        path: path,
      )
    );
  }
}