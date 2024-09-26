import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AssetWidget extends StatelessWidget {
  final Asset asset;
  final double? width;
  final File? file;
  final double? height;
  final Color? color;
  final BoxFit? boxFit;
  final String? firstName;
  final String? lastName;
  final String? placeHolder;
  final bool? isCircular;
  final VoidCallback? onClick;
  final bool flip;
  final bool showLowQuality;
  final int? cacheWidthSize;
  final int? cacheHeightSize;
  Function(DownloadProgress progress)? percentageCallback;

  AssetWidget({
    Key? key,
    required this.asset,
    this.width,
    this.file,
    this.firstName,
    this.onClick,
    this.placeHolder = "", //"assets/images/png/user_img.png",
    this.isCircular = false,
    this.lastName,
    this.height,
    this.color,
    this.percentageCallback,
    this.boxFit,
    this.flip = false,
    this.showLowQuality = false,
    this.cacheWidthSize,
    this.cacheHeightSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (asset.type) {
      case AssetType.png:
        return Transform.flip(
            flipX: flip,
            child: Image(
              image: AssetImage(asset.path),
              width: width,
              height: height,
              fit: boxFit,
              color: color,
            ));
      case AssetType.svg:
        return asset.path != ""
            ? Transform.flip(
                flipX: flip,
                child: SvgPicture.asset(
                  asset.path,
                  width: width,
                  height: height,
                  color: color,
                  fit: boxFit ?? BoxFit.fill,
                ))
            : const SizedBox();
      case AssetType.file:
        return asset.file != null
            ? Transform.flip(
                flipX: flip,
                child: Image.file(
                  filterQuality: (showLowQuality == true)
                      ? FilterQuality.low
                      : FilterQuality.medium,
                  cacheWidth: cacheWidthSize,
                  cacheHeight: cacheHeightSize,
                  asset.file!,
                  width: width,
                  height: height,
                  color: color,
                  fit: boxFit ?? BoxFit.contain,
                ))
            : const SizedBox();
      case AssetType.network:
        try {
          var widget = InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Transform.flip(
                flipX: flip,
                child: CachedNetworkImage(
                  // memCacheHeight: 100,
                  // memCacheWidth: 100,
                  // maxHeightDiskCache: 1024,
                  // maxWidthDiskCache: 1024,
                  height: height,
                  width: width,
                  imageUrl: asset.path,
                  fit: boxFit ?? BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return uiShow(imageProvider, botFit: boxFit);
                  },
                  errorWidget: (context, url, error) {
                    return loadingWidget();
                  },
                  progressIndicatorBuilder: (context, url, progress) {
                    if (percentageCallback != null) {
                      percentageCallback!(progress);
                    }
                    return Center(
                      child: SizedBox(
                          width: 80.w,
                          height: 80.w,
                          child: const CircularProgressIndicator()),
                    );
                  },
                )),
          );

          return widget;
        } catch (e) {
          return const Icon(Icons.broken_image_outlined);
          return loadingWidget(placeHolder: placeHolder);
        }
    }
  }

  Widget loadingWidget({String? placeHolder}) {
    return const Center(child: Icon(Icons.error_outline, color: Colors.red));
  }
}

enum AssetType { png, svg, file, network }

class Asset {
  String path;
  AssetType type;
  File? file;

  Asset({required this.path, required this.type, this.file});
}

Container uiShow(ImageProvider<Object> imageProvider, {BoxFit? botFit}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2.r),
      image: DecorationImage(
        image: imageProvider,
        fit: botFit ?? BoxFit.cover,
      ),
    ),
  );
}
