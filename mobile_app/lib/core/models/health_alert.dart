enum AlertLevel { info, warning, critical }

class HealthAlert {
  final String id;
  final String title;
  final String message;
  final AlertLevel level;
  final DateTime timestamp;
  final String? recommendedAction;

  const HealthAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.level,
    required this.timestamp,
    this.recommendedAction,
  });

  static List<HealthAlert> mockAlerts() => [
    HealthAlert(
      id: 'a1',
      title: 'Alerte Glycémie Critique',
      message: 'Hypoglycémie sévère détectée : 45 mg/dL. Le seuil critique est atteint.',
      level: AlertLevel.critical,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      recommendedAction: 'Consommez immédiatement 15g de glucides rapides (sucre, jus de fruit). Appelez les urgences si perte de conscience.',
    ),
    HealthAlert(
      id: 'a2',
      title: 'Interaction Médicament-Maladie',
      message: 'Vous prenez du Diclofenac (AINS) alors que vous souffrez d\'asthme. Les AINS peuvent déclencher des crises d\'asthme sévères.',
      level: AlertLevel.warning,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      recommendedAction: 'Contactez votre médecin pour évaluer la nécessité de ce traitement ou envisager une alternative (ex: Paracétamol).',
    ),
    HealthAlert(
      id: 'a3',
      title: 'Tension artérielle élevée',
      message: 'Votre dernière mesure de tension montre une valeur de 150/95 mmHg, au-delà des normes.',
      level: AlertLevel.warning,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      recommendedAction: 'Reposez-vous 15 minutes et reprenez votre mesure. Consultez votre médecin si cela persiste.',
    ),
    HealthAlert(
      id: 'a4',
      title: 'Rappel suivi Cholestérol',
      message: 'Votre dernier taux de cholestérol (185 mg/dL) date du 10/04/2026. Il est dans la norme mais un suivi régulier est recommandé.',
      level: AlertLevel.info,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      recommendedAction: 'Pensez à planifier votre prochain bilan lipidique dans 3 mois.',
    ),
    HealthAlert(
      id: 'a5',
      title: 'Rappel Allergie Pénicilline',
      message: 'Sécurité : Vous avez une allergie enregistrée à la Pénicilline.',
      level: AlertLevel.info,
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      recommendedAction: 'Assurez-vous de toujours signaler cette allergy lors de toute nouvelle consultation médicale ou dentaire.',
    ),
  ];
}