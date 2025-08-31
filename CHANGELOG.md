# Change Log

## 20250831 (2025-08-31)

* OS: **Rocky Linux 9.6 (Blue Onyx)**
* Main software versions:
  - **Git v2.51.0**
  - **Vim v9.1.1713**
  - **GNU Nano 8.6**

## 20250720 (2025-07-20)

* OS: **Rocky Linux 9.6 (Blue Onyx)**
* Main software versions:
  - **Git v2.50.1**
  - **Vim v9.1.1566**
  - **GNU Nano 8.5**
* Improve Docker Scout health score:
  - Add non-root user
  - Add SBOM and Provenance options to build command and extract it into independent `buildx` script
  - Compile `git` from source to avoid possible "Fixable critical or high vulnerabilities" compliance issues
* Add independent `test` script for image testing
* Extract shared arguments from `buildx` and `test` scripts into `.env` file as environment variables

## 20250713 (2025-07-13)

* OS: **Rocky Linux 9.6 (Blue Onyx)**
* Main software versions:
  - **Vim v9.1.1538**
  - **GNU Nano 8.5**

## 20250511 (2025-05-11)

* OS: **Rocky Linux 9.5 (Blue Onyx)**
* Main software versions:
  - **Vim 9.1.1382**
  - **GNU Nano 8.4**

## 20250315 (2025-03-15)

* Starting from this version, we use the build date as the version number.
* OS: **Rocky Linux 9.5 (Blue Onyx)**
* Main software versions:
  - **Vim 9.1.1202**
  - **GNU Nano 8.3**

## 3.8 (2025-02-06)

* OS: **Rocky Linux 9.5 (Blue Onyx)**
* Main software versions:
  - **Vim 9.1.1077**
  - **GNU Nano 8.3**

## 3.7 (2025-01-26)

* OS: **Rocky Linux 9.5 (Blue Onyx)**
* Main software versions:
  - **Vim 9.1.1054**
  - **GNU Nano 8.3**

## 3.6 (2025-01-02)

* OS: **Rocky Linux 9.5 (Blue Onyx)**
* Main software versions:
  - **Vim 9.1.0983**
  - **GNU Nano 8.3**

## 3.5 (2024-11-11)

* Migrated from [Taras-Dockerfiles/ubuntu-tuned](https://github.com/Taras-Dockerfiles/ubuntu-tuned), version numbers follow that project.
* OS: **Rocky Linux 9.4 (Blue Onyx)**
* Main software versions:
  - **Vim 9.1.0848**
  - **GNU Nano 8.2**
