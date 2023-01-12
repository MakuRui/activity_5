import 'package:activity_5/models/image_model.dart';
import 'package:activity_5/widgets/image_loaded.dart';
import 'package:activity_5/widgets/image_permissions.dart';
import 'package:activity_5/widgets/pick_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final ImageModel _model;

  @override
  void initState() {
    super.initState();
    _model = ImageModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<ImageModel>(
        builder: (context, model, child) {
          Widget widget;

          switch(model.imageSection) {
            case ImageSection.noStoragePermission:
              widget = ImagePermissions(isPermanent: false, onPressed: checkPermissionsAndPick);
              break;
            case ImageSection.noStoragePermissionPermanent:
              widget = ImagePermissions(isPermanent: true, onPressed: checkPermissionsAndPick);
              break;
            case ImageSection.browseFiles:
              widget = PickFile(onPressed: checkPermissionsAndPick);
              break;
            case ImageSection.imageLoaded:
              widget = ImageLoaded(file: _model.file!);
              break;
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Activity 5'),
            ),
            body: widget,
          );
        },
      ),
    );
  }

  Future<void> checkPermissionsAndPick() async {
    final hasFilePermissions = await _model.requestPermission();
    if (hasFilePermissions) {
      try {
        await _model.pickFile();
      } on Exception catch (e) {
        debugPrint('Error when picking a file: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
            content: Text('An error occurred when picking a image file')));
      }
    }
  }

}
