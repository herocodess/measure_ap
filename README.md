# MeasureAp

A “one-stop” app that allows a clinician to administer a paperless
assessment at bedside for their patients.

## Project setup.

This project runs out of the box. All that is needed is to do ```flutter run``` and select your emulator, simulator, or real device.

## Development Assumptions
I didn't really make any assumptions per se, as the instructions were clear and concise.

## Development Challenges Faced
The only challenge I faced developing this project was the ```Gradient Button```.
I tried building the blur shadow effect using a ```ShaderMask``` but it wasn't working as the fade at the bottom of the blur wasn't "fading", so I scrapped that out.
The next thing I tried was using ```BoxShadow``` and ```LinearGradient``` in a container, but still to no avail.

So I devised a workaround for the widget. What I did was to export the blur background from Figma and use a combination of the ``Stack`` and ``Transform.translate`` widgets to solve it.

## Additional Feature Improvements

- I added some minor animations just to improve the user experience and feel of the application.
- I implemented localizations in the event where another translation or language wants to be added to the application.
