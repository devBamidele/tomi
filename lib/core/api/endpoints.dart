class Endpoints {
  static const base = 'http://localhost:3000';

  ////////////////////////////////////
  // Assessment Match Endpoint
  static const submitAnswers = '$base/match';

  static geminiAI(String apiKey) =>
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey';

  static String youtubeSearchUrl({
    required String query,
    required String apiKey,
    int maxResults = 20,
  }) {
    final encodedQuery = Uri.encodeComponent(query);
    return 'https://www.googleapis.com/youtube/v3/search'
        '?part=snippet'
        '&q=$encodedQuery'
        '&key=$apiKey'
        '&maxResults=$maxResults'
        '&type=video';
  }

  static const login = "$base/auth/login";
  static const signUp = "$base/auth/signup";
}
