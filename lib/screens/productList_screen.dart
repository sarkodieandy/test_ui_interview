import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            const Text(
              "Filter by:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(title: const Text("Price below 100"), onTap: () {}),
            ListTile(title: const Text("Price above 100"), onTap: () {}),
            ListTile(title: const Text("Rating 4.5+"), onTap: () {}),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            const Text(
              "Sort by:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(title: const Text("Price: Low to High"), onTap: () {}),
            ListTile(title: const Text("Price: High to Low"), onTap: () {}),
            ListTile(title: const Text("Rating: High to Low"), onTap: () {}),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    final crossAxisCount = isTablet ? 3 : 2;
    final aspectRatio = isTablet
        ? 0.82
        : 0.74; // ✅ adjusted for perfect balance

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ===== Header =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular products",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            _buildOutlinedButton(
                              label: "Filter",
                              icon: Icons.arrow_drop_down,
                              onPressed: _showFilterOptions,
                            ),
                            const SizedBox(width: 8),
                            _buildOutlinedButton(
                              label: "Sort by",
                              icon: Icons.arrow_drop_down,
                              onPressed: _showSortOptions,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ===== Product Grid =====
                    Expanded(
                      child: GridView.builder(
                        itemCount: provider.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: aspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          final product = provider.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        side: const BorderSide(color: Color(0xFF007F5F)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(icon, color: Colors.black, size: 20),
        ],
      ),
    );
  }
}
