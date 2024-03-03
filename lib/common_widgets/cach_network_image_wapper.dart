import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

class CachNetworkImageWapper extends StatelessWidget {
  final String url;
  final Widget? loader;
  final Widget? error;
  final BoxFit? fit;
  final double? width;
  final double? hight;
  const CachNetworkImageWapper(
      {super.key,
      this.error,
      required this.url,
      this.loader,
      this.fit,
      this.width,
      this.hight});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: hight,
      placeholder: (context, url) => loader ?? UIGlobal.iPhoneLoading(context),
      errorWidget: (context, url, error) =>
          Image.asset(ImagesPaths.intro2) as Widget,
    );
  }
}
