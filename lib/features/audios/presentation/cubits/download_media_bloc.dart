// import 'package:bloc/bloc.dart';
// import 'package:audio_service/audio_service.dart';

// import '../widgets/play_audio/audio_player_task.dart';
// import 'audios_state.dart';

// class AudioPlayerCubit extends Cubit<AudiosState> {
//   AudioPlayerCubit() : super(AudioPlayerInitial());

//   // Start the audio player
//   void start() async {
//     await AudioService.start(
//       backgroundTaskEntrypoint: _backgroundTaskEntrypoint,
//       androidNotificationChannelName: 'My Channel',
//       androidNotificationOngoing: true,
//       androidStopForegroundOnPause: true,
//       androidNotificationIcon: 'mipmap/ic_launcher',
//     );
//   }

//   // Stop the audio player
//   void stop() async {
//     await AudioService.stop();
//   }

//   // Play or pause the audio player
//   void playPause() {
//     if (AudioService.playbackState.playing) {
//       AudioService.pause();
//     } else {
//       AudioService.play();
//     }
//   }

//   // Go to the next track
//   void next() {
//     AudioService.skipToNext();
//   }

//   // Go to the previous track
//   void previous() {
//     AudioService.skipToPrevious();
//   }
// }

// // Background task entry point
// void _backgroundTaskEntrypoint() {
//   AudioServiceBackground.run(() => AudioPlayerTask());
// }
