import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_action.dart';
import 'package:multiplemodel_redux/redux/product/product_actions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class AddProductPageViewModel{
  final Product entry;
  final Function(Product) onItemChanged;
  final Function onSavePressed;

  AddProductPageViewModel({
    this.entry,
    this.onItemChanged,
    this.onSavePressed,
  });
}

class AddProductPage extends StatefulWidget{
  @override
  State<AddProductPage> createState(){
    return new AddProductPageState();
  }
}

class AddProductPageState extends State<AddProductPage>{
  TextEditingController _textControllerName;
  TextEditingController _textControllerPrice;
  TextEditingController _textControllerNumber;
  Future<File> _imageFile;
  String _path;
  VoidCallback listener;

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textControllerName = new TextEditingController();
    _textControllerPrice = new TextEditingController();
    _textControllerNumber = new TextEditingController();

    listener = () {
      setState(() {});
    };
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            _path = snapshot.data.path;
            return Image.file(
              snapshot.data,
              height: 240.0,
              fit: BoxFit.cover,
            );
          } else if (snapshot.error != null) {
            return const Text(
              'Error picking image.',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'You have not yet picked an image.',
              textAlign: TextAlign.center,
            );
          }
        });
  }

  Future<Null> uploadFile(String filepath, String fileName) async {
    final ByteData bytes = await rootBundle.load(filepath);
    final Directory tempDir = Directory.systemTemp;
    final File file = File('${tempDir.path}/$fileName');
    file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

    ImageProperties properties = await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(file.path, quality: 60,
        targetWidth: 300, targetHeight: 600);


    final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask task = ref.putFile(compressedFile);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<AppState, AddProductPageViewModel>(
        converter: (store){
          Product activeProduct = store.state.addProductState.activeProduct;
          return new AddProductPageViewModel(
              entry: activeProduct,
              onItemChanged: (entry) => store.dispatch(new UpdateActiveProductAction(entry)),
              onSavePressed: () {
                DateTime dateTime = new DateTime.now();
                String fileName = "${dateTime.millisecondsSinceEpoch.toString()}.jpg";
                activeProduct.imgFile = fileName;
                uploadFile(_path,fileName);
                store.dispatch(new AddProductAction(activeProduct));
                Navigator.of(context).pop();
              }
          );
        },
        builder: (context, viewModel){
          return Scaffold(
            appBar: _createAppBar(context, viewModel),
            body: Column(
              children: <Widget>[
                ListTile(
                  title: _previewImage(),
                ),
                ListTile(
                  leading: Icon(Icons.title, color: Colors.grey[500]),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Product Name'
                    ),
                    controller: _textControllerName,
                    onChanged: (value){
                      viewModel.onItemChanged(viewModel.entry..name = value);
                    },
                  ),
                ),
                new ListTile(
                  leading: new Icon(Icons.attach_money, color: Colors.grey[500]),
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Price',
                    ),
                    controller: _textControllerPrice,
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      viewModel.onItemChanged
                        (viewModel.entry..price = double.parse(value));
                    },
                  ),
                ),
                new ListTile(
                  leading: new Icon(Icons.content_paste, color: Colors.grey[500]),
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: 'Number'
                    ),
                    controller: _textControllerNumber,
                    keyboardType: TextInputType.number,
                    onChanged: (value){
                      viewModel.onItemChanged
                        (viewModel.entry..number = int.parse(value));
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery);
                  },
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera);
                    },
                    heroTag: 'image1',
                    tooltip: 'Take a Photo',
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ]
          ),
        );
      },
    );
  }

  Widget _createAppBar(BuildContext context, AddProductPageViewModel viewModel){
    TextStyle actionStyle =
        Theme.of(context).textTheme.subhead.copyWith(color: Colors.white);
    Text title = const Text("New Product");
    List<Widget> actions = [];
    actions.add(new FlatButton(
        onPressed: (){
          viewModel.onSavePressed();
          Navigator.of(context).pop();
        },
        child: Text(
          'SAVE',
          style: actionStyle,
        ),
    ));

    return new AppBar(
      title: title,
      actions: actions,
    );
  }
}
