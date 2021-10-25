# QR Reader App

A Flutter mobile app that scans QR codes for websites URLs and plots map coordinates using Google Maps API.

## Description

This application scans QR codes for two types of data: Any website URL or map coordinates.

After scanning a website URL, the application will launch the browser or corresponding app if installed (Ex. Youtube) and browse the URL. After scanning map coordinates, these will be plotted on an interactive map using Google Maps API.

The map coordinates can be read from a QR code created from a text that follows this specific format: 'geo:Lat,Lng'\
*Ex. 'geo:49.49723313409295,8.45739344386002'*

Every scan will be stored in a local database and displayed so they can be accessed later.

## Implemented packages

Some of the most important packages used to build this app are:

- flutter_barcode_scanner
- url_launcher
- google_maps_flutter
- sqflite
- provider
- path_provider

