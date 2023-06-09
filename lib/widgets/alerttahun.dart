import 'package:flutter/material.dart';

class AlertTahun extends StatefulWidget {
  AlertTahun(
      {Key? key,
      required this.tahun,
      required this.tahunaktif,
      required this.onTahunSelected})
      : super(key: key);

  final List<int> tahun;
  int tahunaktif;
  final ValueChanged<int> onTahunSelected;
  @override
  State<AlertTahun> createState() => _AlertTahunState();
}

class _AlertTahunState extends State<AlertTahun> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Center(child: Text("T A H U N")),
      content: SizedBox(
        height: 200,
        width: 200,
        child: GridView.builder(
            itemCount: widget.tahun.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Perform actions when a year is tapped
                  setState(() {
                    widget.tahunaktif = widget.tahun[index];
                  });
                  widget.onTahunSelected(
                      widget.tahunaktif); // Call the callback function
                  Navigator.of(context).pop(widget
                      .tahunaktif); // Return the selected tahunaktif value
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.tahunaktif == widget.tahun[index]
                        ? Colors.grey[400]
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      widget.tahun[index].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
