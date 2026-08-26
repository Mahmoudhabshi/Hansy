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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.black,
        title: const Text('Login / Sign up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              Center(
                child: Image.asset(
                  'assets/images/hansy_logo.png',
                  color: AppColors.primaryRed,
                  height: 26,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Let's Get You Signed In",
                textAlign: TextAlign.center,
                style: AppTextStyles.loginTitle,
              ),
              const SizedBox(height: 6),
              Text(
                'Log in to continue and enjoy personalized features.',
                textAlign: TextAlign.center,
                style: AppTextStyles.loginSubtitle,
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
                  child: Text('Login', style: AppTextStyles.buttonLabel,
                  selectionColor: AppColors.primaryRed,),
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
              _MenuTile(
                icon: Icons.call,
                label: 'Contact Us',
                onTap: _onContactUs,
                backgroundColor: AppColors.white,

              ),
              const SizedBox(height: 10),
              _MenuTile(
                icon: Icons.description,
                label: 'Terms & Conditions',
                onTap: _onTermsAndConditions,
                backgroundColor: AppColors.white,

              ),
              const SizedBox(height: 10),
              _MenuTile(
                icon: Icons.shield_outlined,
                label: 'Privacy Policy',
                onTap: _onPrivacyPolicy,
                backgroundColor: AppColors.white,
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
              _MenuTile(
                icon: Icons.info_outline,
                label: 'About us',
                onTap: _onAboutUs,
                backgroundColor: AppColors.white,
              ),
              const SizedBox(height: 10),
              _MenuTile(
                icon: Icons.star_border,
                label: 'Rate our app',
                onTap: _onRateOurApp,
                backgroundColor: AppColors.white,
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
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14)
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
          for (int i=0; i < SettinsGroup.length; i++) ...[
            children[i],
            if (i != children.length -1)
              Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: AppColors.inputBorder,
    )
    ] 
            // child: Padding(
            //   padding: const EdgeInsets.only(bottom:12),
            //   child: Material(
            //     color: AppColors.white,
            //     borderRadius: BorderRadius.circular(12),
            //     child: InkWell(
            //       borderRadius: BorderRadius.circular(12),
            //       onTap: onTap,
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(10),
            //             child: Icon(icon, size: 20, color: AppColors.submitRed),
            //           ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 20, color: AppColors.textGrey),
                    ],
                  ),
        ],
      ),
            ),
          ),
        ),
      ),
    );
  }
}

 class SettingsGroup extends StatelessWidget{
  final List<Widget> children;
  
  const SettingsGroup ({super.key, required this.children});


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

