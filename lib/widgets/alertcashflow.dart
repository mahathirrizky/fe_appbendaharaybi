import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../responsive/responsive_layout.dart';
import '../bloc/bloc.dart';

class AlertCashFlow extends StatefulWidget {
  const AlertCashFlow({super.key});

  @override
  State<AlertCashFlow> createState() => _AlertCashFlowState();
}

class _AlertCashFlowState extends State<AlertCashFlow> {
  Uint8List? _imageBytes;
  final _jumlahdanaC = TextEditingController();
  final _keteranganC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;
  File? _image;
  final ImagePicker picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final permissionStatus = await Permission.camera.request();
    final galleryStatus = await Permission.storage.request();

    if (permissionStatus.isGranted && galleryStatus.isGranted) {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission not granted'),
        ),
      );
    }
  }

  Future<void> _getImageFromWeb() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        final fileBytes = result.files.single.bytes;
        _image = fileBytes != null ? File.fromRawPath(fileBytes) : null;
        _imageBytes = fileBytes;
      });
    }
  }

  void _simpanTransaction() {
    final jumlahdana =
        _jumlahdanaC.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    final keterangan = _keteranganC.text.trim();
    final jenis = _isIncome ? 'danamasuk' : 'danakeluar';
    _isIncome
        ? BlocProvider.of<CashflowBloc>(context).add(
            CashflowEventAdd(
                jumlahdana: int.parse(jumlahdana),
                keterangan: keterangan,
                jenis: jenis),
          )
        : BlocProvider.of<CashflowBloc>(context).add(
            CashflowEventAdd(
              jumlahdana: int.parse(jumlahdana),
              keterangan: keterangan,
              jenis: jenis,
              image: _image,
            ),
          );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('N E W  C A S H  F L O W')),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Dana Keluar'),
                Switch(
                  value: _isIncome,
                  onChanged: (newValue) {
                    setState(() {
                      _isIncome = newValue;
                    });
                  },
                ),
                const Text('Dana Masuk'),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'id',
                          decimalDigits: 0,
                          symbol: 'Rp ',
                        )
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Jumlah?',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Masukan Jumlah Dana';
                        }
                        return null;
                      },
                      controller: _jumlahdanaC,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: _isIncome ? 'Sumber Dana?' : "Untuk Keperluan?",
                    ),
                    controller: _keteranganC,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: _isIncome,
              child: const SizedBox(
                height: 5,
              ),
            ),
            if (!ResponsiveLayout.isDesktop(context))
              Visibility(
                visible: !_isIncome,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Ambil Gambar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('Pilih Gambar'),
                      ),
                    ),
                  ],
                ),
              ),
            Visibility(
              visible: _isIncome,
              child: const SizedBox(
                height: 5,
              ),
            ),
            if (ResponsiveLayout.isDesktop(context))
              Visibility(
                visible: !_isIncome,
                child: Row(
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
              ),
            _image != null
                ? Visibility(
                    visible: !_isIncome,
                    child: SizedBox(
                      height: 200,
                      child: kIsWeb
                          ? Image.memory(
                              _imageBytes!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              color: Colors.grey[600],
              child: const Text('Batal', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: Colors.grey[600],
              child: const Text('Enter', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _simpanTransaction();
              },
            ),
          ],
        ),
      ],
    );
  }
}
