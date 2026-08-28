import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const SBTAApp());
}

class SBTAApp extends StatefulWidget {
  const SBTAApp({super.key});

  @override
  State<SBTAApp> createState() => _SBTAAppState();
}

class _SBTAAppState extends State<SBTAApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SBTA Smart Agriculture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.green,
        cardTheme: const CardThemeData(margin: EdgeInsets.symmetric(vertical: 6)),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        cardTheme: const CardThemeData(margin: EdgeInsets.symmetric(vertical: 6)),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SBTADashboard(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}

class SBTADashboard extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SBTADashboard({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SBTADashboard> createState() => _SBTADashboardState();
}

class _SBTADashboardState extends State<SBTADashboard> {
  // === بيانات النبات والتربة الأصلية ===
  double health = 80.0;
  double height = 2.0;
  int leafCount = 4;
  
  // تقرير التربة
  double phLevel = 7.0;
  double moisture = 50.0;
  double nitrogen = 45.0;
  double phosphorus = 35.0;
  double potassium = 40.0;
  double organicMatter = 25.0;
  double temperature = 22.0;
  double salinity = 0.5;
  double compaction = 30.0;
  double microbialActivity = 60.0;

  // تقرير DNA
  double genomeIntegrity = 95.0;
  double mutationRate = 0.02;
  double dnaQuality = 92.0;
  int chromosomeCount = 14;
  double epigeneticMarkers = 65.0;
  Map<String, double> geneExpression = {
    'Growth Genes': 85.0,
    'Stress Resistance': 70.0,
    'Nutrient Uptake': 80.0,
    'Photosynthesis': 90.0,
    'Root Development': 75.0
  };
  Map<String, double> proteinLevels = {
    'LEA Proteins': 72.0,
    'Proline': 65.0,
    'Rubisco': 88.0
  };

  // تقرير الأنسجة
  double cellDivisionRate = 75.0;
  double cellWallThickness = 2.5;
  double lignification = 45.0;
  double vascularDevelopment = 70.0;
  double tissueDensity = 0.85;
  Map<String, double> tissueTypes = {
    'Meristem': 80.0,
    'Xylem': 70.0,
    'Phloem': 75.0,
    'Epidermis': 85.0,
    'Parenchyma': 90.0,
    'Collenchyma': 65.0
  };

  // تقرير التشريح
  double primaryRootLength = 15.0;
  int secondaryRoots = 8;
  double rootHairDensity = 85.0;
  double rootCapHealth = 90.0;
  int internodes = 6;
  double stemDiameter = 0.8;
  double flexibility = 70.0;
  double barkThickness = 0.2;
  int stomataDensity = 450;
  int chloroplastCount = 120;
  double leafThickness = 0.3;

  // متطلبات النبات
  double waterNeeded = 0.0;
  double fertilizerNeeded = 0.0;
  double nitrogenNeeded = 0.0;
  double phosphorusNeeded = 0.0;
  double potassiumNeeded = 0.0;
  
  String currentReport = "soil";
  String logMessage = "Auto-updates active • Systems fully functional";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    calculateNeeds();
    timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (mounted) {
        simulateEnvironment();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void calculateNeeds() {
    if (moisture < 40) {
      double baseWater = 1.0 + (height * 0.1);
      waterNeeded = max(0.5, baseWater - (moisture / 100));
    } else {
      waterNeeded = 0.0;
    }
    
    if (nitrogen < 40 || phosphorus < 35 || potassium < 35) {
      nitrogenNeeded = max(0, (50 - nitrogen) * 0.2);
      phosphorusNeeded = max(0, (45 - phosphorus) * 0.15);
      potassiumNeeded = max(0, (45 - potassium) * 0.15);
      fertilizerNeeded = nitrogenNeeded + phosphorusNeeded + potassiumNeeded;
    } else {
      nitrogenNeeded = 0.0;
      phosphorusNeeded = 0.0;
      potassiumNeeded = 0.0;
      fertilizerNeeded = 0.0;
    }
  }

  void simulateEnvironment() {
    setState(() {
      phLevel = max(4.0, min(9.0, phLevel + (Random().nextDouble() * 0.4 - 0.2)));
      moisture = max(0, min(100, moisture + (Random().nextDouble() * 10 - 5)));
      nitrogen = max(0, min(100, nitrogen + (Random().nextDouble() * 6 - 3)));
      phosphorus = max(0, min(100, phosphorus + (Random().nextDouble() * 4 - 2)));
      potassium = max(0, min(100, potassium + (Random().nextDouble() * 4 - 2)));
      temperature = max(5, min(35, temperature + (Random().nextDouble() * 2 - 1)));
      microbialActivity = max(0, min(100, microbialActivity + (Random().nextDouble() * 10 - 5)));

      genomeIntegrity = max(70, min(100, genomeIntegrity + (Random().nextDouble() * 1.5 - 1.0)));
      mutationRate = max(0, min(0.1, mutationRate + (Random().nextDouble() * 0.015 - 0.005)));
      dnaQuality = max(60, min(100, dnaQuality + (Random().nextDouble() * 3 - 2)));
      geneExpression.forEach((key, val) => geneExpression[key] = max(0, min(100, val + (Random().nextDouble() * 6 - 3))));
      proteinLevels.forEach((key, val) => proteinLevels[key] = max(0, min(100, val + (Random().nextDouble() * 4 - 2))));

      cellDivisionRate = max(0, min(100, cellDivisionRate + (Random().nextDouble() * 6 - 3)));
      lignification = max(0, min(100, lignification + (Random().nextDouble() * 4 - 2)));
      vascularDevelopment = max(0, min(100, vascularDevelopment + (Random().nextDouble() * 3 - 1)));
      primaryRootLength = max(5, min(50, primaryRootLength + (Random().nextDouble() * 1.5 - 0.5)));
      stemDiameter = max(0.3, min(3.0, stemDiameter + (Random().nextDouble() * 0.07 - 0.02)));

      health = max(0, min(100, health + (Random().nextDouble() * 4 - 2)));
      if (Random().nextDouble() < 0.15) {
        leafCount = min(12, leafCount + 1);
        height = min(15.0, height + Random().nextDouble() * 0.3);
      }

      if (waterNeeded > 0.5 || fertilizerNeeded > 5.0) {
        health = max(0, health - (waterNeeded > 0.5 ? 1.0 : 0.0) - (fertilizerNeeded > 5.0 ? 1.5 : 0.0));
      }

      calculateNeeds();
      logMessage = "Data automatically updated sync successful";
    });
  }

  void applyWater() {
    setState(() {
      if (waterNeeded > 0) {
        double fulfilled = waterNeeded;
        moisture = min(100, moisture + (fulfilled * 15.0));
        phLevel = max(4.0, min(9.0, phLevel + (Random().nextDouble() * 0.2 - 0.1)));
        microbialActivity = min(100, microbialActivity + (Random().nextDouble() * 2 + 1));
        health = min(100, health + min(3.0, fulfilled * 2));
        logMessage = "Water applied! ${fulfilled.toStringAsFixed(2)}L injected.";
      } else {
        logMessage = "Soil moisture is already at optimal level.";
      }
      calculateNeeds();
    });
  }

  void applyFertilizer() {
    setState(() {
      if (fertilizerNeeded > 0) {
        double fulfilled = fertilizerNeeded;
        nitrogen = min(100, nitrogen + (fulfilled * 0.8));
        phosphorus = min(100, phosphorus + (fulfilled * 0.6));
        potassium = min(100, potassium + (fulfilled * 0.7));
        phLevel = max(4.0, min(9.0, phLevel + (Random().nextDouble() * 0.3 - 0.2)));
        organicMatter = min(100, organicMatter + (Random().nextDouble() * 1.0 + 0.5));
        health = min(100, health + min(5.0, fulfilled * 0.3));
        logMessage = "Biotech Fertilizer applied! ${fulfilled.toStringAsFixed(2)}g added.";
      } else {
        logMessage = "Nutrient matrix is balanced. No fertilizer required.";
      }
      calculateNeeds();
    });
  }

  void resetSimulation() {
    setState(() {
      health = 80.0; height = 2.0; leafCount = 4;
      phLevel = 7.0; moisture = 50.0; nitrogen = 45.0; phosphorus = 35.0; potassium = 40.0;
      organicMatter = 25.0; temperature = 22.0; salinity = 0.5; compaction = 30.0; microbialActivity = 60.0;
      genomeIntegrity = 95.0; mutationRate = 0.02; dnaQuality = 92.0; chromosomeCount = 14; epigeneticMarkers = 65.0;
      cellDivisionRate = 75.0; cellWallThickness = 2.5; lignification = 45.0; vascularDevelopment = 70.0; tissueDensity = 0.85;
      primaryRootLength = 15.0; secondaryRoots = 8; rootHairDensity = 85.0; rootCapHealth = 90.0;
      internodes = 6; stemDiameter = 0.8; flexibility = 70.0; barkThickness = 0.2; stomataDensity = 450;
      logMessage = "Simulation matrix completely re-initialized.";
      calculateNeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SBTA Smart Farm System', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => widget.onThemeChanged(!widget.isDarkMode),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    height: 240,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: widget.isDarkMode 
                          ? [colorScheme.surfaceContainerHighest, colorScheme.surface] 
                          : [Colors.blue.shade50, Colors.white],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 12, left: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('🌱 Height: ${height.toStringAsFixed(1)} cm', style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text('🌿 Leaves: $leafCount count', style: const TextStyle(fontWeight: FontWeight.w600)),
                              Text('❤️ Health: ${health.toStringAsFixed(0)}%', style: TextStyle(fontWeight: FontWeight.bold, color: health > 50 ? Colors.green : Colors.red)),
                            ],
                          ),
                        ),
                        CustomPaint(
                          size: const Size(double.infinity, 240),
                          painter: Plant25DPainter(
                            heightFactor: height / 15.0, 
                            leafCount: leafCount, 
                            moisture: moisture,
                            health: health,
                            isDark: widget.isDarkMode,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildRequirementChip(
                          icon: Icons.water_drop, 
                          label: waterNeeded > 0.1 ? '${waterNeeded.toStringAsFixed(1)}L Needed' : 'Water OK', 
                          isCritical: waterNeeded > 0.1,
                        ),
                        _buildRequirementChip(
                          icon: Icons.science, 
                          label: fertilizerNeeded > 0.1 ? '${fertilizerNeeded.toStringAsFixed(1)}g Fert' : 'Nutrients OK', 
                          isCritical: fertilizerNeeded > 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'soil', label: Text('Soil'), icon: Icon(Icons.layers)),
                    ButtonSegment(value: 'dna', label: Text('DNA'), icon: Icon(Icons.science)),
                    ButtonSegment(value: 'tissue', label: Text('Tissue'), icon: Icon(Icons.biotech)),
                    ButtonSegment(value: 'anatomy', label: Text('Anatomy'), icon: Icon(Icons.account_tree)),
                  ],
                  selected: {currentReport},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      currentReport = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: KeyedSubtree(
                        key: ValueKey<String>(currentReport),
                        child: _getReportWidget(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: applyWater, 
                        icon: const Icon(Icons.water_drop), 
                        label: const Text('Irrigate'),
                        style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: applyFertilizer, 
                        icon: const Icon(Icons.biotech), 
                        label: const Text('Fertilize'),
                        style: FilledButton.styleFrom(backgroundColor: Colors.green),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      onPressed: resetSimulation, 
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reset Simulation',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    logMessage, 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic, color: colorScheme.outline),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRequirementChip({required IconData icon, required String label, required bool isCritical}) {
    return Row(
      children: [
        Icon(icon, color: isCritical ? Colors.orange : Colors.green, size: 20),
        const SizedBox(width: 6),
        Text(
          label, 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: isCritical ? Colors.orange.shade700 : Colors.green.shade700,
          ),
        ),
      ],
    );
  }

  Widget _getReportWidget() {
    switch (currentReport) {
      case 'soil': return _buildSoilReport();
      case 'dna': return _buildDNAReport();
      case 'tissue': return _buildTissueReport();
      case 'anatomy': return _buildAnatomyReport();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildMetricRow(String label, String value, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            color: color,
            backgroundColor: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(4),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildSoilReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📋 CHEMICAL & PHYSICAL SOIL MATRIX', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Divider(),
        _buildMetricRow('pH Balance (Optimal 6-7.5)', phLevel.toStringAsFixed(2), (phLevel - 4) / 5, Colors.amber),
        _buildMetricRow('Soil Moisture Content', '${moisture.toStringAsFixed(1)}%', moisture / 100, Colors.blue),
        _buildMetricRow('Nitrogen (N) Content', '${nitrogen.toStringAsFixed(1)}%', nitrogen / 100, Colors.green),
        _buildMetricRow('Phosphorus (P) Content', '${phosphorus.toStringAsFixed(1)}%', phosphorus / 100, Colors.orange),
        _buildMetricRow('Potassium (K) Content', '${potassium.toStringAsFixed(1)}%', potassium / 100, Colors.purple),
        _buildMetricRow('Microbial Activity Index', '${microbialActivity.toStringAsFixed(1)}%', microbialActivity / 100, Colors.teal),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('• Temp: ${temperature.toStringAsFixed(1)}°C'),
            Text('• Salinity: ${salinity.toStringAsFixed(2)} dS/m'),
            Text('• Compaction: ${compaction.toStringAsFixed(0)}%'),
          ],
        )
      ],
    );
  }

  Widget _buildDNAReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🧬 GENOME SEQUENCING ANALYSIS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Divider(),
        _buildMetricRow('Genome Integrity Rate', '${genomeIntegrity.toStringAsFixed(1)}%', genomeIntegrity / 100, Colors.blue),
        _buildMetricRow('Overall DNA Quality Score', '${dnaQuality.toStringAsFixed(0)}/100', dnaQuality / 100, Colors.indigo),
        _buildMetricRow('Epigenetic Markers Stability', '${epigeneticMarkers.toStringAsFixed(1)}%', epigeneticMarkers / 100, Colors.cyan),
        const SizedBox(height: 6),
        Text('• Chromosomes Count: $chromosomeCount pairs   • Mutation Rate: ${mutationRate.toStringAsFixed(3)}%'),
        const Divider(height: 16),
        const Text('Gene Expressions / Profiles:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...geneExpression.entries.map((e) => _buildMetricRow(e.key, '${e.value.toStringAsFixed(0)}%', e.value / 100, Colors.purple.shade300)),
      ],
    );
  }

  Widget _buildTissueReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🔬 HISTOLOGICAL TISSUE DEVELOPMENT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Divider(),
        _buildMetricRow('Cell Division Rate', '${cellDivisionRate.toStringAsFixed(1)}%', cellDivisionRate / 100, Colors.green),
        _buildMetricRow('Vascular Network Development', '${vascularDevelopment.toStringAsFixed(1)}%', vascularDevelopment / 100, Colors.teal),
        _buildMetricRow('Lignification Progression', '${lignification.toStringAsFixed(1)}%', lignification / 100, Colors.brown),
        const SizedBox(height: 6),
        Text('• Cell Wall Thickness: ${cellWallThickness.toStringAsFixed(2)} μm   • Density: ${tissueDensity.toStringAsFixed(2)} g/cm³'),
        const Divider(height: 16),
        const Text('Tissue Micro-Components:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...tissueTypes.entries.map((e) => _buildMetricRow(e.key, '${e.value.toStringAsFixed(0)}%', e.value / 100, Colors.lightGreen)),
      ],
    );
  }

  Widget _buildAnatomyReport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🌿 MORPHOLOGICAL PLANT ANATOMY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Divider(),
        const Text('Root Subsystem Architecture', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple)),
        _buildMetricRow('Root Hair Density', '${rootHairDensity.toStringAsFixed(0)}%', rootHairDensity / 100, Colors.purple.shade300),
        _buildMetricRow('Root Cap Health Status', '${rootCapHealth.toStringAsFixed(0)}%', rootCapHealth / 100, Colors.purple.shade400),
        Text('• Primary Root Length: ${primaryRootLength.toStringAsFixed(1)} cm   • Lateral Roots: $secondaryRoots count'),
        const Divider(height: 16),
        const Text('Stem & Foliar Anatomy Profile', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
        Text('• Node Internodes Count: $internodes        • Stem Diameter: ${stemDiameter.toStringAsFixed(2)} cm'),
        Text('• Structural Stem Flexibility: ${flexibility.toStringAsFixed(0)}%  • Bark Protective Layer: ${barkThickness.toStringAsFixed(2)} mm'),
        Text('• Foliar Stomata Micro Density: $stomataDensity/mm²  • Chloroplasts: $chloroplastCount/cell'),
      ],
    );
  }
}

class Plant25DPainter extends CustomPainter {
  final double heightFactor;
  final int leafCount;
  final double moisture;
  final double health;
  final bool isDark;

  Plant25DPainter({
    required this.heightFactor,
    required this.leafCount,
    required this.moisture,
    required this.health,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final soilTopY = size.height - 70;

    final soilColor = Color.lerp(const Color(0xFF96643C), const Color(0xFF412614), moisture / 100)!;
    final potColor = isDark ? const Color(0xFF914123) : const Color(0xFFC35F37);

    final potPath = Path()
      ..moveTo(centerX - 70, soilTopY)
      ..lineTo(centerX + 70, soilTopY)
      ..lineTo(centerX + 50, size.height - 20)
      ..lineTo(centerX - 50, size.height - 20)
      ..close();
    canvas.drawPath(potPath, Paint()..color = potColor);
    canvas.drawPath(potPath, Paint()..color = Colors.black.withOpacity(0.2)..style = PaintingStyle.stroke..strokeWidth = 2);

    canvas.drawOval(
      Rect.fromCenter(center: Offset(centerX, soilTopY), width: 140, height: 24),
      Paint()..color = soilColor,
    );

    final rootPaint = Paint()
      ..color = const Color(0xFFE1C8A0).withAlpha(180)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final currentRootDepth = 15 + (heightFactor * 30);
    canvas.drawLine(Offset(centerX, soilTopY + 4), Offset(centerX, soilTopY + currentRootDepth), rootPaint);
    canvas.drawLine(Offset(centerX, soilTopY + 12), Offset(centerX - 20, soilTopY + currentRootDepth - 5), rootPaint..strokeWidth = 1.5);
    canvas.drawLine(Offset(centerX, soilTopY + 18), Offset(centerX + 25, soilTopY + currentRootDepth), rootPaint);

    final plantHealthColor = Color.lerp(Colors.orange.shade700, Colors.green.shade600, health / 100)!;
    final stemPaint = Paint()
      ..color = plantHealthColor
      ..strokeWidth = 5 + (heightFactor * 3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final targetStemHeight = 30 + (heightFactor * 90);
    final stemTopY = soilTopY - targetStemHeight;

    final stemPath = Path()
      ..moveTo(centerX, soilTopY - 4)
      ..quadraticBezierTo(centerX - 10, soilTopY - (targetStemHeight / 2), centerX, stemTopY);
    canvas.drawPath(stemPath, stemPaint);

    final leafPaint = Paint()
      ..color = Color.lerp(Colors.lightGreen.shade400, Colors.green.shade700, health / 100)!
      ..style = PaintingStyle.fill;

    for (int i = 0; i < leafCount; i++) {
      final fraction = (i + 1) / (leafCount + 1);
      final leafY = soilTopY - (targetStemHeight * fraction);
      final isLeft = i % 2 == 0;
      final leafSideX = isLeft ? centerX - 22 - (i * 2) : centerX + 22 + (i * 2);

      canvas.drawOval(
        Rect.fromCenter(center: Offset(leafSideX, leafY), width: 24, height: 12),
        leafPaint,
      );
      
      canvas.drawLine(
        Offset(isLeft ? centerX - 10 : centerX + 10, leafY), 
        Offset(leafSideX, leafY), 
        Paint()..color = const Color(0x66FFFFFF)..strokeWidth = 1,
      );
    }
  }

  @override
  bool shouldRepaint(covariant Plant25DPainter oldDelegate) {
    return oldDelegate.heightFactor != heightFactor ||
           oldDelegate.leafCount != leafCount ||
           oldDelegate.moisture != moisture ||
           oldDelegate.health != health ||
           oldDelegate.isDark != isDark;
  }
}