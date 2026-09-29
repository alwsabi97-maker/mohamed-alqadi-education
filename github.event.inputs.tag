name: Build and Release APK

on:
  workflow_dispatch:
    inputs:
      tag:
        description: 'Release tag (e.g. v1.0.0)'
        required: true
        default: 'v1.0.0'

jobs:
  build:
    name: Build APK and create Release
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: 'stable'

      - name: Install dependencies
        run: flutter pub get

      - name: Build release APK
        run: flutter build apk --release

      - name: Create GitHub Release and upload APK
        uses: ncipollo/release-action@v1
        with:
          tag: ${{ github.event.inputs.tag }}
          files: build/app/outputs/flutter-apk/app-release.apk
