# Suncalc for OpenFaaS

## Description

Calculation of the times for the sun setting, rising, and the beginning and end of the "golden hour" at the server level; to be consumed by any client capable of making an HTTP request.

## Usage

Make a request to your OpenFaaS instance with a JSON payload containing the latitude and longitude coordinates of the location desired.

Example request for _1 Infinite Loop, Cupertino, CA_:
```bash
curl http://192.168.1.80:8080/function/suncalc -d "{\"latitude\": 37.3317, \"longitude\": -122.0303}"
```

## License

This project is licensed under the MIT license, see LICENSE file for further details.
