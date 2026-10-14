import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_providers.dart';
import '../providers/theme_providers.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key});

  // Data dummy 4 buku
  final List<Book> dummyBooks = [
    Book(
      id: 'b1',
      title: 'Clean Code',
      author: 'Robert C Martin',
      price: 85000,
      imageUrl: 'assets/images/b1.jpg',
    ),
    Book(
      id: 'b2',
      title: 'Learning JavaScript Dessign Patterns',
      author: 'Addy Osmani',
      price: 95000,
      imageUrl: 'assets/images/b2.jpg',
    ),
    Book(
      id: 'b3',
      title: 'Phyton Crash Course',
      author: 'Erric Mathess',
      price: 110000,
      imageUrl: 'assets/images/b3.jpeg',
    ),
    Book(
      id: 'b4',
      title: 'The Pragmatic Programmer',
      author: 'David Thomas',
      price: 98000,
      imageUrl: 'assets/images/b4.jpg',
    ),
    Book(
      id: 'b5',
      title: 'One Piece Vol:104',
      author: 'Eichiro Oda',
      price: 98000,
      imageUrl: 'assets/images/b5.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Buku Sandi', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          // Tombol Ganti Tema (Light/Dark Mode)
          IconButton(
            icon: Icon(
              context.watch<ThemeProviders>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProviders>().toggleTheme();
            },
          ),
          // Tombol Ikon Keranjang dengan Badge Jumlah Item
          Consumer<CartProviders>(
            builder: (context, cart, child) {
              return Badge(
                label: Text('${cart.totalItems}'),
                isLabelVisible: cart.totalItems > 0,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    // Pindah ke halaman Keranjang Belanja
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      // Menampilkan daftar buku menggunakan ListView
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: dummyBooks.length,
        itemBuilder: (ctx, i) {
          final book = dummyBooks[i];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      book.imageUrl,
                      width: 60,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 80,
                        color: Colors.red[300],
                        child: const Icon(Icons.book, size: 40),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(book.author),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${book.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Tombol Tambah ke Keranjang
                  ElevatedButton(
                    onPressed: () {
                      // Menggunakan context.read untuk memanggil fungsi tanpa mendengarkan perubahan terus-menerus
                      context.read<CartProviders>().addItem(book);

                      // Menampilkan notifikasi kecil (SnackBar)
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${book.title} ditambahkan ke keranjang'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Text('Tambah'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}