class Rank {
  final String title;
  final String emoji;
  final String description;
  final int minDays;
  final int maxDays;

  const Rank({
    required this.title,
    required this.emoji,
    required this.description,
    required this.minDays,
    required this.maxDays,
  });

  static const List<Rank> ranks = [
    Rank(
      title: 'Newcomer',
      emoji: '🌱',
      description: 'The journey begins',
      minDays: 0,
      maxDays: 2,
    ),
    Rank(
      title: 'First Step',
      emoji: '👣',
      description: 'You showed up',
      minDays: 3,
      maxDays: 6,
    ),
    Rank(
      title: 'Momentum Builder',
      emoji: '🌿',
      description: 'Early consistency forming',
      minDays: 7,
      maxDays: 9,
    ),
    Rank(
      title: 'Rising Challenger',
      emoji: '⚡',
      description: 'You are gaining control',
      minDays: 10,
      maxDays: 13,
    ),
    Rank(
      title: 'Two-Week Warrior',
      emoji: '🗡️',
      description: '14 days of commitment — strong start',
      minDays: 14,
      maxDays: 20,
    ),
    Rank(
      title: 'Consistency Seeker',
      emoji: '🎯',
      description: 'Your discipline is growing',
      minDays: 21,
      maxDays: 29,
    ),
    Rank(
      title: 'Habit Builder',
      emoji: '🔥',
      description: '30 days — a powerful milestone',
      minDays: 30,
      maxDays: 39,
    ),
    Rank(
      title: 'Unbreakable',
      emoji: '🛡️',
      description: '40 days — a rare achievement',
      minDays: 40,
      maxDays: 59,
    ),
    Rank(
      title: 'Focused Achiever',
      emoji: '🧠',
      description: 'Consistency sharpening your mindset',
      minDays: 60,
      maxDays: 74,
    ),
    Rank(
      title: 'Daily Champion',
      emoji: '🏅',
      description: 'You keep showing up',
      minDays: 75,
      maxDays: 89,
    ),
    Rank(
      title: 'Momentum Master',
      emoji: '💪',
      description: 'Your progress is undeniable',
      minDays: 90,
      maxDays: 99,
    ),
    Rank(
      title: 'Century Builder',
      emoji: '💯',
      description: '100 days of dedication',
      minDays: 100,
      maxDays: 119,
    ),
    Rank(
      title: 'Legendary Discipline',
      emoji: '⭐',
      description: '120 days — an elite milestone',
      minDays: 120,
      maxDays: 149,
    ),
    Rank(
      title: 'Master of Consistency',
      emoji: '💎',
      description: 'Your habit is now powerful',
      minDays: 150,
      maxDays: 179,
    ),
    Rank(
      title: 'Elite Warrior',
      emoji: '🏆',
      description: 'Half year dedication approaching',
      minDays: 180,
      maxDays: 209,
    ),
    Rank(
      title: 'Legend in Progress',
      emoji: '🌟',
      description: 'Your discipline defines you',
      minDays: 210,
      maxDays: 239,
    ),
    Rank(
      title: 'Unstoppable Force',
      emoji: '🌊',
      description: 'Your focus is unmatched',
      minDays: 240,
      maxDays: 269,
    ),
    Rank(
      title: 'Grand Champion',
      emoji: '👑',
      description: 'Your progress is extraordinary',
      minDays: 270,
      maxDays: 299,
    ),
    Rank(
      title: 'Mythic Performer',
      emoji: '🔮',
      description: 'Few reach this level',
      minDays: 300,
      maxDays: 329,
    ),
    Rank(
      title: 'Legendary Streak',
      emoji: '🌠',
      description: 'Your commitment inspires everyone',
      minDays: 330,
      maxDays: 364,
    ),
    Rank(
      title: 'Year Conqueror',
      emoji: '🚀',
      description: '365 days — ultimate dedication',
      minDays: 365,
      maxDays: 365,
    ),
    Rank(
      title: 'Timeless Legend',
      emoji: '✨',
      description: 'Beyond one year of mastery',
      minDays: 366,
      maxDays: 99999,
    ),
  ];

  static Rank getRankForDays(int days) {
    for (int i = ranks.length - 1; i >= 0; i--) {
      if (days >= ranks[i].minDays) {
        return ranks[i];
      }
    }
    return ranks[0];
  }

  static Rank? getNextRank(int days) {
    final current = getRankForDays(days);
    final currentIndex = ranks.indexOf(current);
    if (currentIndex < ranks.length - 1) {
      return ranks[currentIndex + 1];
    }
    return null;
  }
}
