clean: 
	flutter clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods 
	flutter pub get
	cd ios && pod install

xcode:
	open ios/Runner.xcworkspace

install:
	flutter pub get

ci:
	make format && make analyze && make test_coverage

format:
	dart format --set-exit-if-changed -l 120 lib

analyze:
	flutter analyze lib

generate_intl:
	flutter gen-l10n

build_runner_build:
	flutter packages pub run build_runner build -d --enable-experiment=records,patterns,sealed-class

build_runner_watch:
	flutter packages pub run build_runner watch -d --enable-experiment=records,patterns,sealed-class

# iOS
dev_ios:
	flutter build ipa 

prod_ios:
	flutter build ipa --release

# Android
dev_android:
	flutter build apk

prod_android:
	flutter build apk 

prod_android_bundle:
	flutter build appbundle 