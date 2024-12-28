import 'package:ecommerce_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/pages/bloc/ecommerce_bloc.dart';

class AddProductPage extends StatefulWidget {
  final String? productId;
  final String? productName;
  final double? productPrice;
  final String? productImageUrl;
  final bool isEdit;

  const AddProductPage({
    super.key,
    this.productId,
    this.productName,
    this.productPrice,
    this.productImageUrl,
    this.isEdit = false,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _nameController.text = widget.productName ?? '';
      _priceController.text = widget.productPrice?.toString() ?? '';
      _imageUrlController.text = widget.productImageUrl ?? '';
    }
  }

  void _saveProduct(BuildContext context) {
    final name = _nameController.text;
    final price = _priceController.text;
    final imageUrl = _imageUrlController.text;

    if (name.isEmpty || price.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son requeridos.')),
      );
      return;
    }

    if (widget.isEdit) {
      context.read<EcommerceBloc>().add(UpdateProductEvent(
        productId: widget.productId!,
        description: name,
        price: int.tryParse(price) ?? 0,
        imageUrl: imageUrl,
      ));
    } else {
      context.read<EcommerceBloc>().add(CreateNewProductsEvent(
        description: name,
        price: int.tryParse(price) ?? 0, 
        imageUrl: imageUrl,
      ));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto guardado exitosamente.')),
    );

    _nameController.clear();
    _priceController.clear();
    _imageUrlController.clear();

    Navigator.pop(context); 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Producto' : 'Nuevo Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'URL de la imagen',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _saveProduct(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.green,
              ),
              child: Text('Guardar Producto', 
                style: TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
