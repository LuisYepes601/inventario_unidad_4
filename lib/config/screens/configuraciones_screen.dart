import 'package:flutter/material.dart';
import '../../../config/theme_provider.dart';

class ConfiguracionesScreen extends StatefulWidget {
  const ConfiguracionesScreen({super.key});

  @override
  State<ConfiguracionesScreen> createState() => _ConfiguracionesScreenState();
}

class _ConfiguracionesScreenState extends State<ConfiguracionesScreen> {
  bool _notificacionesVisuales = true;

  static const darkForestGreen = Color(0xFF047857);
  static const softGreenBg = Color(0xFFECFDF5);
  static const slateDark = Color(0xFF0F172A);
  static const slateMuted = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, letterSpacing: 0.3),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // --- SECCIÓN: APARIENCIA Y TEMA ---
          _buildSectionHeader('Apariencia y Visualización'),
          const SizedBox(height: 10),
          _buildSettingsCard(
            context,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF334155) : softGreenBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: isDark ? const Color(0xFF10B981) : darkForestGreen,
                  size: 22,
                ),
              ),
              title: const Text(
                'Modo Oscuro',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                isDark ? 'Tema Slate Dark activo' : 'Tema Forest Green Claro activo',
                style: const TextStyle(fontSize: 12, color: slateMuted),
              ),
              trailing: Switch.adaptive(
                value: themeProvider.isDarkMode,
                activeColor: const Color(0xFF10B981),
                onChanged: (val) {
                  setState(() {
                    themeProvider.toggleTheme(val);
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // --- SECCIÓN: SISTEMA Y REPORTES ---
          _buildSectionHeader('Preferencias de Reportes'),
          const SizedBox(height: 10),
          _buildSettingsCard(
            context,
            child: Column(
              children: [
                SwitchListTile.adaptive(
                  value: _notificacionesVisuales,
                  activeColor: isDark ? const Color(0xFF10B981) : darkForestGreen,
                  title: const Text(
                    'Confirmaciones al Exportar PDF',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  subtitle: const Text(
                    'Mostrar notificación flotante tras generar documentos',
                    style: TextStyle(fontSize: 12, color: slateMuted),
                  ),
                  onChanged: (val) => setState(() => _notificacionesVisuales = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- SECCIÓN: INFORMACIÓN DE LA APP ---
          _buildSectionHeader('Información del Sistema'),
          const SizedBox(height: 10),
          _buildSettingsCard(
            context,
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info_outline_rounded, color: slateMuted),
                  title: Text('Versión de la App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  trailing: Text('v2.4.0 Executive', style: TextStyle(color: slateMuted, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.cloud_done_outlined, color: slateMuted),
                  title: const Text('Estado del Servidor', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF064E3B) : softGreenBg,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Online (Render)', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: slateMuted,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}