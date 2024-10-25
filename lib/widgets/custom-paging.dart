import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

enum CustomPagingStatus { reload, loading, refresh }

class CustomPaging<DataType, ItemType> extends StatefulWidget {
  /// 是否是分页
  final bool isPaging;

  /// 是否立即加载
  final bool refreshOnStart;

  /// 初始页
  final int initialPage;

  /// pageSize
  final int pageSize;

  /// page 字段名
  final String pageName;

  /// pageSize字段名
  final String pageSizeName;

  /// 数据处理函数
  final Future<List<ItemType>> Function(DataType)? dealFunction;

  /// 除page、pageSize外的参数
  final Map<String, dynamic> Function()? otherFetchParams;

  /// 请求函数
  final Future<DataType> Function(Map<String, dynamic>, CancelToken?)
      fetchFunction;

  /// Item builder.
  final Widget Function(BuildContext context, int index, ItemType item)
      itemBuilder;

  const CustomPaging({
    super.key,
    this.isPaging = true,
    this.refreshOnStart = true,
    this.initialPage = 1,
    this.pageSize = 20,
    this.pageName = 'pageNo',
    this.pageSizeName = 'pageSize',
    this.dealFunction,
    this.otherFetchParams,
    required this.fetchFunction,
    required this.itemBuilder,
  });

  @override
  State<CustomPaging> createState() => CustomPagingState<DataType, ItemType>();
}

class CustomPagingState<DataType, ItemType>
    extends State<CustomPaging<DataType, ItemType>> {
  final CancelToken _cancelToken = CancelToken();

  /// 数据集合
  List<ItemType> _data = [];

  /// page
  late int _page;

  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void initState() {
    _page = widget.initialPage;
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// 获取数据
  Future<void> _fetchData(CustomPagingStatus customPagingStatus) async {
    try {
      final Map<String, dynamic> fetchParams =
          widget.otherFetchParams != null ? widget.otherFetchParams!() : {};
      if (widget.isPaging) {
        fetchParams[widget.pageSizeName] = widget.pageSize;
        fetchParams[widget.pageName] = _page;
      }
      final result = await widget.fetchFunction(fetchParams, _cancelToken);
      if (!mounted) {
        return;
      }
      List<ItemType> newItems;
      if (widget.dealFunction != null) {
        newItems = await widget.dealFunction!(result);
      } else {
        newItems = result as List<ItemType>;
      }
      if (customPagingStatus == CustomPagingStatus.refresh) {
        // 刷新成功
        _controller.finishRefresh(IndicatorResult.success);
        if (widget.isPaging) {
          if (newItems.length < widget.pageSize) {
            _controller.finishLoad(IndicatorResult.noMore);
          } else {
            _controller.resetFooter();
          }
        }
        setState(() {
          _data = newItems;
        });
      } else {
        // 加载成功
        if (newItems.length < widget.pageSize) {
          _controller.finishLoad(IndicatorResult.noMore);
        } else {
          _controller.finishLoad(IndicatorResult.success);
          setState(() {
            _data.addAll(newItems);
          });
        }
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      if (customPagingStatus == CustomPagingStatus.refresh) {
        // 刷新失败
        _controller.finishRefresh(IndicatorResult.fail);
        _controller.resetFooter();
        setState(() {
          _data = [];
        });
      } else {
        // 加载失败
        _controller.finishLoad(IndicatorResult.fail);
      }
      print('error-------${error.toString()}');
      rethrow;
    }
  }

  /// 刷新
  void _onRefresh() async {
    try {
      print("_onRefresh");
      if (!mounted) {
        return;
      }
      _page = widget.initialPage;
      await _fetchData(CustomPagingStatus.refresh);
    } catch (error) {
      print('error-------${error.toString()}');
    }
  }

  /// 加载下一页
  Future<void> _onLoad() async {
    try {
      print("_onLoad");
      if (!mounted || !widget.isPaging) {
        return;
      }
      _page += 1;
      await _fetchData(CustomPagingStatus.loading);
    } catch (error) {
      print('error-------${error.toString()}');
    }
  }

  /// 外部调用 刷新
  void callRefresh() {
    if (_controller.headerState?.mode != IndicatorMode.inactive ||
        _controller.footerState?.mode != IndicatorMode.inactive) {
      return;
    }
    print("callRefresh");
    _controller.callRefresh();
  }

  /// 外部调用 加载
  void callLoad() {
    print("callLoad");
    if (!widget.isPaging) {
      return;
    }
    _controller.callLoad();
  }

  /// 外部调用 重新加载当前页
  void callReload() async {
    try {
      print("callReload");
      if (!mounted || !widget.isPaging) {
        return;
      }
      await _fetchData(CustomPagingStatus.reload);
    } catch (error) {
      print('error-------${error.toString()}');
    }
  }

  /// Build sliver.
  Widget _buildSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return widget.itemBuilder(context, index, _data[index]);
        },
        childCount: _data.length,
      ),
    );
  }

  /// 空白页
  Widget _buildEmptyWidget() {
    return SliverFillViewport(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const Center(
            child: Text("暂无数据～"),
          );
        },
        childCount: 1,
      ),
    );
  }

  /// Build slivers.
  List<Widget> _buildSlivers() {
    Widget? emptyWidget;
    if (_data.isEmpty) {
      emptyWidget = _buildEmptyWidget();
    }
    return [
      const HeaderLocator.sliver(),
      if (emptyWidget != null) emptyWidget,
      _buildSliver(),
      const FooterLocator.sliver(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      controller: _controller,
      refreshOnStart: widget.refreshOnStart,
      header: const ClassicHeader(
        position: IndicatorPosition.locator,
        showMessage: false,
        dragText: '下拉刷新',
        armedText: '松开刷新',
        readyText: '刷新中...',
        processingText: '刷新中...',
        processedText: '刷新成功',
        noMoreText: '没有更多了～',
        failedText: '刷新失败',
      ),
      footer: const ClassicFooter(
        position: IndicatorPosition.locator,
        showMessage: false,
        dragText: '上拉加载',
        armedText: '松开加载',
        readyText: '加载中...',
        processingText: '加载中...',
        processedText: '加载成功',
        noMoreText: '没有更多了～',
        failedText: '加载失败',
      ),
      onRefresh: _onRefresh,
      onLoad: !widget.isPaging || _data.isEmpty ? null : _onLoad,
      child: CustomScrollView(
        slivers: _buildSlivers(),
      ),
    );
  }
}