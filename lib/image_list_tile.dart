import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ImageListTile extends RenderObjectWidget {
  ImageListTile({
    required this.thumbnail,
    required this.title,
    required this.titleBackgroundColor,
  });

  final Widget thumbnail;
  final Widget title;
  final Color titleBackgroundColor;

  @override
  _ImageListTileElement createElement() => _ImageListTileElement(this);

  @override
  _ImageListTileRenderBox createRenderObject(BuildContext context) =>
      _ImageListTileRenderBox(
        titleBackgroundColor: titleBackgroundColor,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _ImageListTileRenderBox renderObject,
  ) {
    renderObject..titleBackgroundColor = titleBackgroundColor;
  }
}

enum _ImageListTileSlot {
  thumbnail,
  title,
}

class _ImageListTileElement extends RenderObjectElement {
  _ImageListTileElement(ImageListTile widget) : super(widget);

  final Map<_ImageListTileSlot, Element> slotToChild = {};

  @override
  ImageListTile get widget => super.widget as ImageListTile;

  @override
  _ImageListTileRenderBox get renderObject =>
      super.renderObject as _ImageListTileRenderBox;

  @override
  void visitChildren(ElementVisitor visitor) {
    slotToChild.values.forEach(visitor);
  }

  @override
  void forgetChild(Element child) {
    slotToChild.remove(child.slot);
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _update(_ImageListTileSlot.title, widget.title);
    _update(_ImageListTileSlot.thumbnail, widget.thumbnail);
  }

  @override
  void update(covariant RenderObjectWidget newWidget) {
    super.update(newWidget);
    _update(_ImageListTileSlot.title, widget.title);
    _update(_ImageListTileSlot.thumbnail, widget.thumbnail);
  }

  void _update(_ImageListTileSlot slot, Widget? widget) {
    final oldWidget = slotToChild[slot];
    final newWidget = updateChild(oldWidget, widget, slot);
    if (oldWidget != null) {
      slotToChild.remove(slot);
    }
    if (newWidget != null) {
      slotToChild[slot] = newWidget;
    }
  }

  @override
  void insertRenderObjectChild(
    covariant RenderObject child,
    covariant _ImageListTileSlot slot,
  ) {
    switch (slot) {
      case _ImageListTileSlot.title:
        renderObject.title = child as RenderBox;
        break;
      case _ImageListTileSlot.thumbnail:
        renderObject.thumbnail = child as RenderBox;
        break;
    }
  }

  @override
  void removeRenderObjectChild(
    covariant RenderObject child,
    covariant _ImageListTileSlot slot,
  ) {
    switch (slot) {
      case _ImageListTileSlot.title:
        renderObject.title = null;
        break;
      case _ImageListTileSlot.thumbnail:
        renderObject.thumbnail = null;
        break;
    }
  }

  @override
  void moveRenderObjectChild(
    covariant RenderObject child,
    covariant Object? oldSlot,
    covariant Object? newSlot,
  ) {}
}

class _ImageListTileRenderBox extends RenderBox {
  _ImageListTileRenderBox({
    required Color titleBackgroundColor,
  }) : _titleBackgroundColor = titleBackgroundColor;

  static final _titlePadding = 8.0;

  final Map<_ImageListTileSlot, RenderBox> children = {};

  Color _titleBackgroundColor;

  Color get titleBackgroundColor => _titleBackgroundColor;

  set titleBackgroundColor(Color value) {
    if (_titleBackgroundColor == value) {
      return;
    }
    _titleBackgroundColor = value;
    markNeedsLayout();
  }

  RenderBox? _thumbnail;

  RenderBox? get thumbnail => _thumbnail;

  set thumbnail(RenderBox? value) {
    _thumbnail = _updateChild(_thumbnail, value, _ImageListTileSlot.thumbnail);
  }

  RenderBox? _title;

  RenderBox? get title => _title;

  set title(RenderBox? value) {
    _title = _updateChild(_title, value, _ImageListTileSlot.title);
  }

  RenderBox? _updateChild(
    RenderBox? oldChild,
    RenderBox? newChild,
    _ImageListTileSlot slot,
  ) {
    if (oldChild != null) {
      dropChild(oldChild);
      children.remove(slot);
    }
    if (newChild != null) {
      children[slot] = newChild;
      adoptChild(newChild);
    }
    return newChild;
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    children.values.forEach((e) => e.attach(owner));
  }

  @override
  void detach() {
    super.detach();
    children.values.forEach((e) => e.detach());
  }

  @override
  void redepthChildren() {
    children.values.forEach(redepthChild);
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    children.values.forEach(visitor);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return thumbnail?.getMinIntrinsicHeight(width) ?? 0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return thumbnail?.getMaxIntrinsicHeight(width) ?? 0;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return thumbnail?.getMinIntrinsicWidth(height) ?? 0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return thumbnail?.getMaxIntrinsicWidth(height) ?? 0;
  }

  @override
  void performLayout() {
    final title = this.title;
    final thumbnail = this.thumbnail;
    final loose = constraints.loosen();
    final thumbnailSize = thumbnail == null
        ? Size.zero
        : (thumbnail..layout(loose.tighten(), parentUsesSize: true)).size;
    final titleSize = title == null
        ? Size.zero
        : (title
              ..layout(
                loose.tighten(width: thumbnailSize.width - (_titlePadding * 2)),
                parentUsesSize: true,
              ))
            .size;
    if (title != null) {
      final parentData = title.parentData! as BoxParentData;
      parentData.offset = Offset(
        _titlePadding,
        thumbnailSize.height + _titlePadding,
      );
    }
    size = constraints.constrain(
      Size(
        thumbnailSize.width,
        thumbnailSize.height + titleSize.height + _titlePadding,
      ),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    _paint(context, offset, thumbnail);
    final title = this.title;
    context.canvas.drawRect(
      Rect.fromLTWH(
        offset.dx,
        offset.dy + (thumbnail?.size.height ?? 0),
        title == null ? 0 : title.size.width + _titlePadding * 2,
        title == null ? 0 : title.size.height + _titlePadding * 2,
      ),
      Paint()..color = titleBackgroundColor,
    );
    _paint(context, offset, title);
  }

  void _paint(PaintingContext context, Offset offset, RenderBox? box) {
    if (box == null) {
      return;
    }
    context.paintChild(
      box,
      (box.parentData! as BoxParentData).offset + offset,
    );
  }
}
