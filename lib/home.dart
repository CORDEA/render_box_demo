import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
    );
  }
}

class _RenderObjectWidget extends RenderObjectWidget {
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

class _RenderObjectElement extends RenderObjectElement {
  _RenderObjectElement(_RenderObjectWidget widget) : super(widget);

  @override
  RenderObjectWidget get widget => super.widget as _RenderObjectWidget;

  @override
  RenderObject get renderObject => super.renderObject as _RenderBox;
}

class _RenderBox extends RenderBox {
  @override
  double computeMinIntrinsicHeight(double width) {
    // TODO: implement computeMinIntrinsicHeight
    return super.computeMinIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    // TODO: implement computeMaxIntrinsicHeight
    return super.computeMaxIntrinsicHeight(width);
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    // TODO: implement computeMinIntrinsicWidth
    return super.computeMinIntrinsicWidth(height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    // TODO: implement computeMaxIntrinsicWidth
    return super.computeMaxIntrinsicWidth(height);
  }

  @override
  void performLayout() {
    // TODO: implement performLayout
    super.performLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // TODO: implement paint
    super.paint(context, offset);
  }
}
