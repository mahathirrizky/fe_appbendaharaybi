import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../responsive/responsive_layout.dart';
import '../bloc/bloc.dart';
import '../models/models.dart';

class AlertEditDana extends StatefulWidget {
  const AlertEditDana({super.key, required this.alurdana});
  final CashflowModel alurdana;

  @override
  State<AlertEditDana> createState() => _AlertEditDanaState();
}

class _AlertEditDanaState extends State<AlertEditDana> {
  File? _image;

  final ImagePicker picker = ImagePicker();
  @override
  void dispose() {
    // Membersihkan _image saat Stateful Widget dihapus dari tree
    _image?.delete();
    super.dispose();
  }

  Future<void> _getImageFromWeb() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController keteranganC =
        TextEditingController(text: widget.alurdana.keterangan);
    TextEditingController jumlahdanaC =
        TextEditingController(text: widget.alurdana.jumlah.toString());
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Text("E D I T  D A T A"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.alurdana.imageurl != null)
                GestureDetector(
                  onLongPress: () {
                    showImageViewer(
                        context, NetworkImage(widget.alurdana.imageurl!),
                        swipeDismissible: false);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.alurdana.imageurl!),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: jumlahdanaC,
                decoration: const InputDecoration(hintText: 'Jumlah dana'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: keteranganC,
                decoration: const InputDecoration(hintText: 'Keterangan'),
              ),
              const SizedBox(
                height: 15,
              ),
              if (!ResponsiveLayout.isDesktop(context))
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          // _getImage(ImageSource.camera);
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.camera);
                          if (pickedFile != null) {
                            setState(() {
                              _image = File(pickedFile.path);
                            });
                          }
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Ambil Gambar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () async {
                          // _getImage(ImageSource.gallery);
                          final pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              _image = File(pickedFile.path);
                            });
                          }
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('Pilih Gambar'),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              _image != null
                  ? GestureDetector(
                      onLongPress: () {
                        showImageViewer(context, Image.file(_image!).image,
                            swipeDismissible: true);
                      },
                      child: SizedBox(
                          height: 200,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              if (ResponsiveLayout.isDesktop(context))
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: _getImageFromWeb,
                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('Upload Gambar'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _image = null;
              });
            },
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<CashflowBloc>().add(
                    CashflowEventEdit(
                      jumlahdana: int.parse(jumlahdanaC.text),
                      keterangan: keteranganC.text,
                      id: widget.alurdana.id,
                      imageUrl: widget.alurdana.imageurl,
                      fileImage: _image,
                    ),
                  );
              Navigator.of(context).pop();
              setState(() {
                _image = null;
              });
            },
            child: const Text('Simpan'),
          ),
        ]);
  }
}
