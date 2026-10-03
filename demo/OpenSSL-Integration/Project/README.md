# OpenSSL Integration for 4D

A 4D application that integrates OpenSSL to generate and manage cryptographic assets using asynchronous, non-blocking execution via `4D.SystemWorker`.

## Features

- Generate Private Keys, CSRs, and self-signed certificates
- Produce signed XML documents for secure data exchange
- Deploy a 4D Web Server configured with generated certificates
- Cross-platform support (Windows & macOS)
- Non-blocking UI during cryptographic operations

## Requirements

- 4D 21 LTS
- OpenSSL 3.0 or later
- Windows 11 or macOS Tahoe 26 (Apple Silicon)

## Installing OpenSSL

**Windows**
```
winget install openssl
```

**macOS**
```
brew install openssl
```

## OpenSSL Path

The app auto-detects the OpenSSL binary on startup. If your installation is in a non-standard location, you can manually specify the path in the app settings — it will be stored for all subsequent operations.