About
=====

Thid gem's first focus is to provide support for the following prtg api resources:

- **passhash:**       Retrieve passhash for later authentications
- **channels:**       List of the channels of a sensor (sensor ID required)
- **devices:**        List of all devices
- **groups:**         List of all groups
- **maps:**           List of maps
- **messages:**       List of most recent log entries
- **reports:**        List of reports
- **sensors:**        List of all sensors
- **sensortree:**     A tree-like structure of groups, devices and sensors
- **storedreports:**  List of most recent PDF reports (report ID reqiured)
- **todos:**          List of most recent todos
- **values:**         List of most recent results of a sensor (sensor ID required)

Oher resources like graphs and object manipulation maybe follow later.


Changelog
=========

## 0.0.7
- Change the query 'objid' to 'id'
  This reacts to changes in Prtg api version 13.2.3.1927.

## 0.0.6
- Add Accept-Encoding header to API calls.
  Otherwise Prtg version 13.2.3.1927 seems to faulty compress response data.
