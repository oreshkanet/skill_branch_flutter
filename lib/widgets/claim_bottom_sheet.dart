import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 16),
          _buildRow(context, 'adult'),
          _buildRow(context, 'harm'),
          _buildRow(context, 'bully'),
          _buildRow(context, 'spam'),
          _buildRow(context, 'copyright'),
          _buildRow(context, 'hate'),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AppColors.grayChateau,
          ),
          child: Text(text.toUpperCase()),
        ),
        onTap: () {
          Navigator.of(context).pop(text);
        },
      ),
    );
  }
}
