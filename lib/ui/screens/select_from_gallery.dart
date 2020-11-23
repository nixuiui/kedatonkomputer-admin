import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kedatonkomputer/ui/widget/box.dart';
import 'package:kedatonkomputer/ui/widget/button.dart';

class SelectFromGallery extends StatefulWidget {
  @override
  _SelectFromGalleryState createState() => _SelectFromGalleryState();
}

class _SelectFromGalleryState extends State<SelectFromGallery> {

  bool isLoading = false;
  File _imageFile;
  Future getImage(ImageSource source) async {
    setState(() {
      ImagePicker.pickImage(source: source).then((value) => setState(() => _imageFile = value));
    });
  }

  @override
  void initState() {
    getImage(ImageSource.gallery);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Gambar"),
      ),
      body: Box(
        padding: 16,
        child: Center(
          child: _imageFile != null ? Container(
            padding: EdgeInsets.all(16),
            child: _imageFile != null ? Image.file(_imageFile) : Text("No Image Selected")
          ) : Stack(
            children: <Widget>[
              Image.asset("assets/border_select_photo.png", width: 300, height: 300),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Image.asset("assets/empty_img.png"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _imageFile == null ? RaisedButtonPrimary(
            text: "Pilih Gambar",
            onPressed: () => getImage(ImageSource.gallery)
          ) : Row(
            children: <Widget>[
              Expanded(
                child: OutlineButtonPrimary(
                  text: "Pilih Ulang",
                  fontSize: 14,
                  onPressed: () => getImage(ImageSource.gallery)
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: RaisedButtonPrimary(
                  isLoading: isLoading,
                  text: "Unggah",
                  fontSize: 14,
                  onPressed: _imageFile == null ? null : () => selectImage()
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  selectImage() async {
    setState(() => isLoading = true);
    var file = _imageFile;
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "${file.absolute.path}_compressed.jpg",
      quality: 88,
    );
    Navigator.of(context).pop({'file': result});
  }
}