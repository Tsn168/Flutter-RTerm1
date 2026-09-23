import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String tableName;
  final VoidCallback? onViewMenu;

  const WelcomeScreen({super.key, this.tableName = 'Table 05', this.onViewMenu});

  @override
  Widget build(BuildContext context) {
    const brown = Color(0xFF8B3A1A);
    const lightBrown = Color(0xFFF5D5C0);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5FA),
        elevation: 0,
        title: Text(
          'Welcome - $tableName',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top section: icon + Welcome text
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Restaurant icon circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: lightBrown,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.restaurant,
                        size: 56,
                        color: brown,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Middle card: table name
            Container(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Table name badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8E8F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tableName,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: brown,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                      children: [
                        const TextSpan(text: 'You are ordering from '),
                        TextSpan(
                          text: tableName,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // View Menu button
            ElevatedButton(
              onPressed: onViewMenu,
              style: ElevatedButton.styleFrom(
                backgroundColor: brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'View Menu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
