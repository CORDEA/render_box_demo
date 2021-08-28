import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
    );
  }
}

class _RenderObjectWidget extends RenderObjectWidget {
  _RenderObjectWidget(this.title);

  final Widget title;

  @override
  _RenderObjectElement createElement() => _RenderObjectElement(this);

  @override
  _RenderBox createRenderObject(BuildContext context) => _RenderBox();

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderBox renderObject,
  ) {}
}

enum _RenderBoxSlot {
  title,
}

class _RenderObjectElement extends RenderObjectElement {
  _RenderObjectElement(_RenderObjectWidget widget) : super(widget);

  final Map<_RenderBoxSlot, Element> slotToChild = {};

  @override
  _RenderObjectWidget get widget => super.widget as _RenderObjectWidget;

  @override
  _RenderBox get renderObject => super.renderObject as _RenderBox;

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
    _update(_RenderBoxSlot.title, widget.title);
  }

  @override
  void update(covariant RenderObjectWidget newWidget) {
    super.update(newWidget);
    _update(_RenderBoxSlot.title, widget.title);
  }

  void _update(_RenderBoxSlot slot, Widget? widget) {
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
    covariant _RenderBoxSlot slot,
  ) {
    switch (slot) {
      case _RenderBoxSlot.title:
        renderObject.title = child as RenderBox;
        break;
    }
  }

  @override
  void removeRenderObjectChild(
    covariant RenderObject child,
    covariant _RenderBoxSlot slot,
  ) {
    switch (slot) {
      case _RenderBoxSlot.title:
        renderObject.title = null;
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

class _RenderBox extends RenderBox {
  final Map<_RenderBoxSlot, RenderBox> children = {};

  RenderBox? _title;

  RenderBox? get title => _title;

  set title(RenderBox? value) {
    _title = _updateChild(_title, value, _RenderBoxSlot.title);
  }

  RenderBox? _updateChild(
    RenderBox? oldChild,
    RenderBox? newChild,
    _RenderBoxSlot slot,
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
  double computeMinIntrinsicHeight(double width) {
    return title?.getMinIntrinsicHeight(width) ?? 0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return title?.getMaxIntrinsicHeight(width) ?? 0;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return title?.getMinIntrinsicWidth(height) ?? 0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return title?.getMaxIntrinsicWidth(height) ?? 0;
  }

  @override
  void performLayout() {
    final title = this.title;
    final loose = constraints.loosen();
    final titleSize = title == null
        ? Size.zero
        : (title..layout(loose.tighten(), parentUsesSize: true)).size;
    size = constraints.constrain(Size(loose.maxWidth, titleSize.height));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
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
