/// Every user-facing string lives here, in English (en) AND Kannada (kn).
/// Other languages fall back to English. Use t(lang, key, {placeholders}).
const Map<String, Map<String, String>> _t = {
  'en': {
    'step': 'Step {a} of {b}', 'next': 'Next', 'finish': 'Finish setup', 'langName': 'English',
    'q_lang': 'Choose your language', 'q_phone': 'Your mobile number', 'q_otp': 'Enter the 6-digit OTP',
    'q_for': 'Who is your PG for?', 'q_loc': 'Where is your PG?', 'q_floors': 'How many floors?',
    'q_rooms': 'How many rooms on each floor?', 'q_types': 'What type is each room?',
    'q_rent': 'Monthly rent for one bed', 'q_food': 'Do you provide food?',
    'q_dep': 'Deposit and notice period', 'q_due': 'Which day is rent due?',
    'phone_note': 'We send an OTP by SMS. On most phones it fills in by itself.',
    'ladies': 'Ladies', 'gents': 'Gents', 'both': 'Both (co-living)',
    'useloc': 'Use my current location', 'locok': 'Location saved',
    'locfail': 'Could not get location here. You can skip and add it later.', 'skip': 'Skip for now',
    'count_ground': 'Count the ground floor too.', 'rooms': 'rooms', 'samefloor': 'Same on every floor?',
    'yes': 'Yes', 'no': 'No', 'floor': 'Floor {n}',
    'pick_type': '1. Pick a type', 'tap_rooms': '2. Tap the rooms that are this type',
    'copy1': 'Same on every floor? Copy Floor 1 to all', 'copied': 'Floor 1 copied to all floors',
    't1': 'Single', 't2': '2 share', 't3': '3 share', 't4': '4 share',
    'r1': 'Single room', 'r2': '2 sharing', 'r3': '3 sharing', 'r4': '4 sharing', 'other': 'Other',
    'rent_note': 'We only ask about the room types you have.', 'rent_other': 'Rent for one bed (₹)',
    'f3': 'Breakfast, lunch, dinner', 'f2': 'Breakfast + dinner', 'f0': 'No food',
    'dep': 'Deposit', 'dep1': '1 month rent', 'dep0': 'No deposit', 'notice': 'Notice period',
    'n15': '15 days', 'n1': '1 month', 'n2': '2 months',
    'd1': '1st of every month', 'd5': '5th of every month', 'd10': '10th of every month',
    'dj': 'Same date they joined', 'due_note': 'We remind tenants on WhatsApp automatically.',
    'ready': 'Your PG is ready!', 'summary': '{f} floors · {r} rooms · {b} beds', 'empty': 'Empty',
    'due': 'Rent due', 'tapchange': 'Tap a room to change its type',
    'addt': 'Add tenants', 'a_photo': 'Notebook photo', 'a_link': 'WhatsApp link', 'a_say': 'Say it',
    'soon': 'Next step: tenant screens. Coming soon.',
    'edit': 'Change answers', 'restart': 'Start again', 'sum_rooms': '{f} floors × {r} rooms = {t} rooms',
    'soonLang': 'Coming soon', 'sending': 'Please wait…', 'sendOtp': 'Send OTP', 'verify': 'Verify',
    'otpSentTo': 'OTP sent to +91 {p}', 'resend': 'Change number',
    'badOtp': 'Wrong OTP. Please check and try again.',
    'smsFail': 'Could not send SMS. Check the number and try again.',
    'tooMany': 'Too many tries. Please wait a few minutes.', 'logout': 'Log out', 'saved': 'Saved',
    'netFail': 'No internet. Your answers are kept and will save when you are back online.',
    'a_back': 'Back', 'a_lang': 'Change language', 'a_speak': 'Read aloud', 'a_mic': 'Speak your answer',
    'a_less': 'Less', 'a_more': 'More', 'voiceSoon': 'Voice is coming soon.',
  },
  'kn': {
    'step': 'ಹಂತ {a} / {b}', 'next': 'ಮುಂದೆ', 'finish': 'ಸೆಟಪ್ ಮುಗಿಸಿ', 'langName': 'ಕನ್ನಡ',
    'q_lang': 'ಭಾಷೆ ಆಯ್ಕೆ ಮಾಡಿ', 'q_phone': 'ನಿಮ್ಮ ಮೊಬೈಲ್ ನಂಬರ್', 'q_otp': '6 ಅಂಕಿಯ OTP ನಮೂದಿಸಿ',
    'q_for': 'ನಿಮ್ಮ PG ಯಾರಿಗೆ?', 'q_loc': 'ನಿಮ್ಮ PG ಎಲ್ಲಿದೆ?', 'q_floors': 'ಎಷ್ಟು ಮಹಡಿಗಳಿವೆ?',
    'q_rooms': 'ಪ್ರತಿ ಮಹಡಿಯಲ್ಲಿ ಎಷ್ಟು ಕೋಣೆಗಳು?', 'q_types': 'ಪ್ರತಿ ಕೋಣೆ ಯಾವ ರೀತಿ?',
    'q_rent': 'ಒಂದು ಬೆಡ್‌ಗೆ ತಿಂಗಳ ಬಾಡಿಗೆ', 'q_food': 'ಊಟ ಕೊಡುತ್ತೀರಾ?',
    'q_dep': 'ಡೆಪಾಸಿಟ್ ಮತ್ತು ನೋಟೀಸ್', 'q_due': 'ಬಾಡಿಗೆ ಯಾವ ದಿನ ಕೊಡಬೇಕು?',
    'phone_note': 'SMS ಮೂಲಕ OTP ಕಳುಹಿಸುತ್ತೇವೆ. ಹೆಚ್ಚಿನ ಫೋನ್‌ಗಳಲ್ಲಿ ತಾನಾಗಿಯೇ ತುಂಬುತ್ತದೆ.',
    'ladies': 'ಮಹಿಳೆಯರಿಗೆ', 'gents': 'ಪುರುಷರಿಗೆ', 'both': 'ಎಲ್ಲರಿಗೂ',
    'useloc': 'ನನ್ನ ಜಾಗ ಬಳಸಿ', 'locok': 'ಜಾಗ ಉಳಿಸಲಾಗಿದೆ',
    'locfail': 'ಇಲ್ಲಿ ಜಾಗ ಸಿಗಲಿಲ್ಲ. ಈಗ ಬಿಟ್ಟು ನಂತರ ಸೇರಿಸಬಹುದು.', 'skip': 'ಈಗ ಬಿಡಿ',
    'count_ground': 'ನೆಲ ಮಹಡಿಯನ್ನೂ ಸೇರಿಸಿ ಎಣಿಸಿ.', 'rooms': 'ಕೋಣೆಗಳು', 'samefloor': 'ಎಲ್ಲಾ ಮಹಡಿಯಲ್ಲೂ ಇಷ್ಟೇ?',
    'yes': 'ಹೌದು', 'no': 'ಇಲ್ಲ', 'floor': 'ಮಹಡಿ {n}',
    'pick_type': '1. ರೀತಿ ಆಯ್ಕೆ ಮಾಡಿ', 'tap_rooms': '2. ಆ ರೀತಿಯ ಕೋಣೆಗಳ ಮೇಲೆ ಒತ್ತಿ',
    'copy1': 'ಎಲ್ಲಾ ಮಹಡಿ ಒಂದೇ? ಮಹಡಿ 1 ನಕಲಿಸಿ', 'copied': 'ಮಹಡಿ 1 ಎಲ್ಲಾ ಮಹಡಿಗೆ ನಕಲಿಸಲಾಗಿದೆ',
    't1': 'ಒಬ್ಬರಿಗೆ', 't2': 'ಇಬ್ಬರಿಗೆ', 't3': 'ಮೂವರಿಗೆ', 't4': 'ನಾಲ್ವರಿಗೆ',
    'r1': 'ಒಬ್ಬರ ಕೋಣೆ', 'r2': 'ಇಬ್ಬರ ಕೋಣೆ', 'r3': 'ಮೂವರ ಕೋಣೆ', 'r4': 'ನಾಲ್ವರ ಕೋಣೆ', 'other': 'ಬೇರೆ',
    'rent_note': 'ನಿಮ್ಮಲ್ಲಿರುವ ಕೋಣೆಗಳ ಬಗ್ಗೆ ಮಾತ್ರ ಕೇಳುತ್ತೇವೆ.', 'rent_other': 'ಒಂದು ಬೆಡ್ ಬಾಡಿಗೆ (₹)',
    'f3': '3 ಹೊತ್ತು ಊಟ', 'f2': 'ತಿಂಡಿ + ರಾತ್ರಿ ಊಟ', 'f0': 'ಊಟ ಇಲ್ಲ',
    'dep': 'ಡೆಪಾಸಿಟ್', 'dep1': '1 ತಿಂಗಳ ಬಾಡಿಗೆ', 'dep0': 'ಡೆಪಾಸಿಟ್ ಇಲ್ಲ', 'notice': 'ನೋಟೀಸ್ ಅವಧಿ',
    'n15': '15 ದಿನ', 'n1': '1 ತಿಂಗಳು', 'n2': '2 ತಿಂಗಳು',
    'd1': 'ತಿಂಗಳ 1ನೇ ತಾರೀಖು', 'd5': 'ತಿಂಗಳ 5ನೇ ತಾರೀಖು', 'd10': 'ತಿಂಗಳ 10ನೇ ತಾರೀಖು',
    'dj': 'ಸೇರಿದ ದಿನದಂದು', 'due_note': 'ಬಾಕಿ ಇದ್ದವರಿಗೆ WhatsApp ನಲ್ಲಿ ತಾನಾಗಿಯೇ ನೆನಪಿಸುತ್ತೇವೆ.',
    'ready': 'ನಿಮ್ಮ PG ಸಿದ್ಧ!', 'summary': '{f} ಮಹಡಿ · {r} ಕೋಣೆ · {b} ಬೆಡ್', 'empty': 'ಖಾಲಿ',
    'due': 'ಬಾಡಿಗೆ ಬಾಕಿ', 'tapchange': 'ಕೋಣೆ ಒತ್ತಿ ರೀತಿ ಬದಲಿಸಿ',
    'addt': 'ಬಾಡಿಗೆದಾರರನ್ನು ಸೇರಿಸಿ', 'a_photo': 'ನೋಟ್‌ಬುಕ್ ಫೋಟೋ', 'a_link': 'WhatsApp ಲಿಂಕ್', 'a_say': 'ಮಾತನಾಡಿ',
    'soon': 'ಮುಂದಿನ ಹಂತ: ಬಾಡಿಗೆದಾರರ ಪರದೆಗಳು. ಶೀಘ್ರದಲ್ಲೇ.',
    'edit': 'ಉತ್ತರ ಬದಲಿಸಿ', 'restart': 'ಮತ್ತೆ ಶುರು ಮಾಡಿ', 'sum_rooms': '{f} ಮಹಡಿ × {r} ಕೋಣೆ = {t} ಕೋಣೆಗಳು',
    'soonLang': 'ಶೀಘ್ರದಲ್ಲೇ', 'sending': 'ದಯವಿಟ್ಟು ಕಾಯಿರಿ…', 'sendOtp': 'OTP ಕಳುಹಿಸಿ', 'verify': 'ಪರಿಶೀಲಿಸಿ',
    'otpSentTo': '+91 {p} ಗೆ OTP ಕಳುಹಿಸಲಾಗಿದೆ', 'resend': 'ನಂಬರ್ ಬದಲಿಸಿ',
    'badOtp': 'OTP ತಪ್ಪಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.', 'smsFail': 'SMS ಕಳುಹಿಸಲಾಗಲಿಲ್ಲ. ನಂಬರ್ ಪರಿಶೀಲಿಸಿ.',
    'tooMany': 'ತುಂಬಾ ಪ್ರಯತ್ನಗಳು. ಕೆಲವು ನಿಮಿಷ ಕಾಯಿರಿ.', 'logout': 'ಲಾಗ್ ಔಟ್', 'saved': 'ಉಳಿಸಲಾಗಿದೆ',
    'netFail': 'ಇಂಟರ್ನೆಟ್ ಇಲ್ಲ. ಉತ್ತರಗಳು ಉಳಿದಿವೆ, ಆನ್‌ಲೈನ್ ಬಂದಾಗ ಉಳಿಸುತ್ತೇವೆ.',
    'a_back': 'ಹಿಂದೆ', 'a_lang': 'ಭಾಷೆ ಬದಲಿಸಿ', 'a_speak': 'ಓದಿ ಹೇಳಿ', 'a_mic': 'ನಿಮ್ಮ ಉತ್ತರ ಹೇಳಿ',
    'a_less': 'ಕಡಿಮೆ', 'a_more': 'ಹೆಚ್ಚು', 'voiceSoon': 'ಧ್ವನಿ ಶೀಘ್ರದಲ್ಲೇ ಬರುತ್ತದೆ.',
  },
};

String t(String lang, String key, [Map<String, Object> v = const {}]) {
  var s = _t[lang]?[key] ?? _t['en']![key] ?? key;
  v.forEach((k, val) => s = s.replaceAll('{$k}', '$val'));
  return s;
}

class Lang {
  final String id, label;
  final bool soon;
  const Lang(this.id, this.label, {this.soon = false});
}

/// The language picker lists each language in its own script.
const langs = [
  Lang('en', 'English'),
  Lang('kn', 'ಕನ್ನಡ'),
  Lang('hi', 'हिंदी', soon: true),
  Lang('ta', 'தமிழ்', soon: true),
  Lang('te', 'తెలుగు', soon: true),
];
