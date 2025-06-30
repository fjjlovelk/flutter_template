import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/config/theme_config.dart';
import 'package:flutter_template/utils/modal_util.dart';
import 'package:get/get.dart';

class AdvanceSearch extends StatelessWidget {
  /// 默认查询条件
  final Widget? defaultContent;

  /// overlay中的查询条件
  final Widget? overlayContent;

  /// 重置
  final VoidCallback onReset;

  /// 搜索
  final VoidCallback onSearch;

  final LayerLink _layerLink = LayerLink();

  /// 遮罩层是否打开
  final _isOverlayShow = false.obs;

  AdvanceSearch({
    super.key,
    this.defaultContent,
    this.overlayContent,
    required this.onReset,
    required this.onSearch,
  });

  /// 打开遮罩
  void _showOverlay(BuildContext context) {
    _isOverlayShow.value = true;
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Stack(
            children: [
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    _hideOverlay(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    _hideOverlay(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: ThemeConfig.modalBackgroundColor,
                  ),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                child: _buildContent(context),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 隐藏遮罩
  void _hideOverlay(BuildContext context) {
    Navigator.of(context).pop();
    _isOverlayShow.value = false;
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ThemeConfig.miniPadding),
      decoration: BoxDecoration(
        color: ThemeConfig.n1,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ThemeConfig.radius),
          bottomRight: Radius.circular(ThemeConfig.radius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (overlayContent != null) overlayContent!,
          ModalUtil.modalFooter(onReset: onReset, onConfirm: onSearch),
        ],
      ),
    ).animate().scaleY(
      duration: 150.ms,
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        color: ThemeConfig.white,
        child: Row(
          children: [
            Expanded(child: defaultContent ?? const SizedBox()),
            TextButton(
              onPressed: () {
                _showOverlay(context);
              },
              child: Row(
                children: [
                  Obx(
                    () => Text(
                      '筛选',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: _isOverlayShow.value
                            ? ThemeConfig.primary
                            : ThemeConfig.n7,
                      ),
                    ),
                  ),
                  SizedBox(width: 1.r),
                  Obx(
                    () => Icon(
                      Icons.filter_alt_outlined,
                      size: 16.sp,
                      color: _isOverlayShow.value
                          ? ThemeConfig.primary
                          : ThemeConfig.n7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
