import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KalkulatorOhm(),
    );
  }
}

class KalkulatorOhm extends StatefulWidget {
  const KalkulatorOhm({super.key});

  @override
  State<KalkulatorOhm> createState() => _KalkulatorOhmState();
}

class _KalkulatorOhmState extends State<KalkulatorOhm> {
  final vCtrl = TextEditingController();
  final iCtrl = TextEditingController();
  final rCtrl = TextEditingController();

  String pilihan = 'Tegangan';
  String hasil = '';

  void hitung() {
    final v = double.tryParse(vCtrl.text);
    final i = double.tryParse(iCtrl.text);
    final r = double.tryParse(rCtrl.text);

    String jawaban = '';

    if (pilihan == 'Tegangan' && i != null && r != null && i >= 0 && r >= 0) {
      jawaban = 'V = $i × $r = ${i * r} Volt';
    } else if (pilihan == 'Arus' && v != null && r != null && v >= 0 && r > 0) {
      jawaban = 'I = $v ÷ $r = ${v / r} Ampere';
    } else if (pilihan == 'Hambatan' &&
        v != null &&
        i != null &&
        v >= 0 &&
        i > 0) {
      jawaban = 'R = $v ÷ $i = ${v / i} Ohm';
    } else {
      jawaban = 'Masukkan angka yang benar!';
    }

    setState(() {
      hasil = jawaban;
    });
  }

  @override
  void dispose() {
    vCtrl.dispose();
    iCtrl.dispose();
    rCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kalkulator Hukum Ohm'),
        backgroundColor: const Color(0xFFD2B48C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Rumus: V = I × R',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B6F47),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: pilihan,
              decoration: const InputDecoration(
                labelText: 'Pilih Perhitungan',
                border: OutlineInputBorder(),
              ),
              items: ['Tegangan', 'Arus', 'Hambatan']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  pilihan = value!;
                  hasil = '';
                });
              },
            ),
            const SizedBox(height: 15),
            if (pilihan == 'Tegangan' || pilihan == 'Hambatan')
              TextField(
                controller: pilihan == 'Tegangan' ? iCtrl : vCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: pilihan == 'Tegangan'
                      ? 'Arus (Ampere)'
                      : 'Tegangan (Volt)',
                  border: const OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 15),
            if (pilihan == 'Tegangan' || pilihan == 'Arus')
              TextField(
                controller: pilihan == 'Tegangan' ? rCtrl : vCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: pilihan == 'Tegangan'
                      ? 'Hambatan (Ohm)'
                      : 'Tegangan (Volt)',
                  border: const OutlineInputBorder(),
                ),
              ),
            if (pilihan == 'Arus' || pilihan == 'Hambatan') ...[
              const SizedBox(height: 15),
              TextField(
                controller: pilihan == 'Arus' ? rCtrl : iCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText:
                      pilihan == 'Arus' ? 'Hambatan (Ohm)' : 'Arus (Ampere)',
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hitung,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD2B48C),
                foregroundColor: Colors.white,
              ),
              child: const Text('HITUNG'),
            ),
            const SizedBox(height: 20),
            Text(
              hasil,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B6F47),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
