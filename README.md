# movie_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assignment

    1) The task is to create a list of movie information where each grid defines a single movie.
    2) By clicking on each item open the movie detail screen.
    3) The UI needs to be similar to the attached image. Use the below APIs to populate the data. Also, have a history page where all the searched movies are listed.

## Movie Search GET API
 
    https://omdbapi.com/?s=<SEARCH>&apikey=YOUR_API_KEY
    pass the search character of the movie name to the URL by replacing <SEARCH>

## Movie Detail GET API

    https://omdbapi.com/?i=<imdbID>&apikey=YOUR_API_KEY
    pass imdbID you will get from the first API.

## Example:

    https://omdbapi.com/?s=marvel&apikey=YOUR_API_KEY

## App UI

<p float="left"> 
<img src="https://firebasestorage.googleapis.com/v0/b/chat-app-a0950.appspot.com/o/android_task_screen.jpeg?alt=media&token=0e508795-e3e4-473e-b708-73c3164cdbe5" width="800" height="600">
</p>

## NOTE : 

    If possible, follow the MVVM architecture pattern

## Demo APK

[Click here](https://github.com/patildarshan66/movie-app/blob/master/movie-app.apk) for download demo app.

