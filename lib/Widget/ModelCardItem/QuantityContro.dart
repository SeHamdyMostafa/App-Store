import 'package:flutter/material.dart';

class QuantityControlWidget extends StatefulWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final bool isUpdating;

  QuantityControlWidget({
    required this.quantity,
    required this.onQuantityChanged,
    this.isUpdating = false,
  });

  @override
  _QuantityControlWidgetState createState() => _QuantityControlWidgetState();
}

class _QuantityControlWidgetState extends State<QuantityControlWidget> {
  void _increaseQuantity() {
    if (!widget.isUpdating) {
      widget.onQuantityChanged(widget.quantity + 1);  // زيادة الكمية
    }
  }

  void _decreaseQuantity() {
    if (!widget.isUpdating && widget.quantity > 1) {
      widget.onQuantityChanged(widget.quantity - 1);  // تقليص الكمية ولكن لا تقل عن 1
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: widget.isUpdating ? null : _decreaseQuantity,
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.orange,
                width: 2.0,
              ),
            ),
            child: Icon(Icons.remove, color: Colors.black),
          ),
        ),
        SizedBox(height: 5),
        Text(
          '${widget.quantity}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 5),
        InkWell(
          onTap: widget.isUpdating ? null : _increaseQuantity,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.orange,
                width: 2.0,
              ),
            ),
            child: Icon(Icons.add, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
