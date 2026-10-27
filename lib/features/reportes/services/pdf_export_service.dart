import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../productos/models/producto.dart';

class PdfExportService {
  static Future<void> exportarProductosPdf(
      BuildContext context, List<Producto> productos) async {
    final pdf = pw.Document();

    const primaryColor = PdfColor.fromInt(0xFF047857); // Forest Green Executive
    const darkSlate = PdfColor.fromInt(0xFF0F172A);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Encabezado del documento
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'INFORME DE INVENTARIO',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Gestión de Productos - Panel Administrativo',
                      style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                    ),
                  ],
                ),
                pw.Text(
                  'Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                ),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Divider(color: primaryColor, thickness: 1.5),
            pw.SizedBox(height: 16),

            // Tabla de Productos
            pw.TableHelper.fromTextArray(
              border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white,
                fontSize: 10,
              ),
              headerDecoration: const pw.BoxDecoration(color: primaryColor),
              cellStyle: const pw.TextStyle(fontSize: 9, color: darkSlate),
              cellPadding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              headers: ['SKU', 'Producto', 'Categoría', 'Marca', 'Precio', 'Stock'],
              data: productos.map((prod) {
                return [
                  prod.sku,
                  prod.nombre,
                  prod.categoriaNombre,
                  prod.marcaNombre,
                  '\$${prod.precio.toStringAsFixed(2)}',
                  '${prod.stock} u.',
                ];
              }).toList(),
            ),

            pw.SizedBox(height: 20),

            // Total de productos al final
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Text(
                  'Total de Registros: ${productos.length}',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 11,
                    color: darkSlate,
                  ),
                ),
              ),
            ),
          ];
        },
      ),
    );

    // Previsualizar / Imprimir / Descargar
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Inventario_Productos_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }
}