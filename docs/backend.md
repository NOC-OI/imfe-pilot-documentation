Certainly! Here's the English translation of the provided text:

# API for User Authentication and Backend Calculations

This API serves a dual purpose:

1. It performs server-side calculations for the Digital Twin project focused on Haig Fras.
2. It manages and provides access to the user table, enabling authentication.

The API receives user data from the frontend, processes it, and returns data or calculation results.

You can find more detailed information in the [API repository](https://github.com/NOC-OI/imfe-pilot-api).

## API Overview

Detailed information about the API and its endpoints can be found in the "api" folder of the repository. This folder includes the "fast.py" file, which comprehensively describes all available endpoints and the corresponding functions they execute. Additionally, the v1 version of the calculations is documented in the "api/v1" folder.

## User Authentication

The user authentication system relies on OAuth connections with ORCID and Microsoft 365 systems. To enable this functionality, the following steps have been taken:

1. Register your application with ORCID and Microsoft.
2. Configure the frontend application to facilitate login and obtain code information.
3. Send this code to the backend to check if the user is among the authorized users (as listed in the "orcid.json" file).
4. Connection with the backend is facilitated through endpoints (GET and POST requests).
5. Create an "orcid.json" file, which should contain a list of ORCID IDs and Outlook email addresses that are permitted to access the frontend application.

More information can be found [here](authentication.md).

## Object Store Authentication

Some files within the object store are not publicly accessible. In such cases, you can use this repository to obtain signed URLs for the object store files. These signed URLs must be encrypted using a token before passing them to the frontend. The same token must be used by any system responsible for decrypting the signed URLs.

## Calculations

In this repository, we perform a list of calculations on the backend in order to obtain some statistics on the data or some biodiversity calculations.

The following calculations are currently being performed in this project:
- Calculation of mean, median, and standard deviation.
- Calculation of density.
- Calculation of biodiversity based on the Shannon index.
- Calculation of biodiversity based on the Inverse Simpson Index.