import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePermissions extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback onPressed;
  const ImagePermissions({Key? key,
    required this.isPermanent,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
            const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
            child: Text(
              'Read files permission',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: const Text(
              'We need to request your permission to '
                  'read local files in order to load them into the app',
              textAlign: TextAlign.center,
            ),
          ),
          if (isPermanent)
            Container(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 24.0,
                right: 16.0,
              ),
              child: ElevatedButton(
                child: Text(
                    isPermanent ? 'Open settings' : 'Allow access'),
                onPressed: () => isPermanent ? openAppSettings() : onPressed(),
              ),
            )
        ],
      ),
    );
  }
}
