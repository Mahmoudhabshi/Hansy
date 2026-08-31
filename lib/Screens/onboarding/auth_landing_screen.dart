import 'package:flutter/material.dart';
import 'package:hansy/theme/constant.dart';
import 'package:hansy/Screens/Login/login.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  void _onLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _onContactUs() {
  }

  void _onTermsAndConditions() {
  }

  void _onPrivacyPolicy() {
  }

  void _onAboutUs() {
  }

  void _onRateOurApp() {
  }

  void _onFacebook() {
  }

  void _onTikTok() {
  }

  void _onInstagram() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),

            Center(
              child: Image.asset(
                'assets/images/hansy_logo.png',
                color: AppColors.primaryRed,
                height: 26,
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Text( "Let's Get You Signed In",
                textAlign: TextAlign.center,
                style: AppTextStyles.loginTitle)
            ),
            const SizedBox(height: 6),
            Center(
                child: Text( 'Log in to continue and enjoy personalized features.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.loginSubtitle)
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => _onLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.submitRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Login',
                  style: AppTextStyles.buttonLabel,
                ),
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'Support',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            _MenuGroup(
              items: [
                _MenuItemData(
                  icon: Icons.call,
                  label: 'Contact Us',
                  onTap: _onContactUs,
                ),
                _MenuItemData(
                  icon: Icons.description,
                  label: 'Terms & Conditions',
                  onTap: _onTermsAndConditions,
                ),
                _MenuItemData(
                  icon: Icons.shield_outlined,
                  label: 'Privacy Policy',
                  onTap: _onPrivacyPolicy,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              'Our Company',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            _MenuGroup(
              items: [
                _MenuItemData(
                  icon: Icons.info_outline,
                  label: 'About us',
                  onTap: _onAboutUs,
                ),
                _MenuItemData(
                  icon: Icons.star_border,
                  label: 'Rate our app',
                  onTap: _onRateOurApp,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.inputBorder),
              ),
              child: Column(
                children: [
                  Text(
                    'Contact us with',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.submitRed,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialIconButton(icon: Icons.facebook, onTap: _onFacebook),
                      const SizedBox(width: 16),
                      _SocialIconButton(icon: Icons.tiktok, onTap: _onTikTok),
                      const SizedBox(width: 16),
                      _SocialIconButton(icon: Icons.camera_alt_outlined, onTap: _onInstagram),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Column(
                children: [
                  Text(
                    'Version v1.0.5',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '© Hansy - Developed By Media Creation',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}


/// Simple data holder for a single menu row inside a [_MenuGroup].
class _MenuItemData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;


  const _MenuItemData({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

/// Renders a list of menu rows as ONE floating card (single shadow,
/// single border radius) with a thin divider drawn between each row —
/// instead of each row being its own separate card.
class _MenuGroup extends StatelessWidget {
  final List<_MenuItemData> items;

  const _MenuGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _MenuRow(item: items[i]),
            if (i != items.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: AppColors.inputBorder,
              ),
          ],
        ],
      ),
    );
  }
}

/// A single tappable row inside a [_MenuGroup]. No individual shadow —
/// the shadow lives on the group container; rows are separated by a
/// [Divider] instead.
class _MenuRow extends StatelessWidget {
  final _MenuItemData item;

  const _MenuRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(item.icon, size: 20, color: AppColors.submitRed),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: Icon(icon, size: 18, color: AppColors.black),
      ),
    );
  }
}