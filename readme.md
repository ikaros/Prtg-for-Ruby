PRTG API for ruby
=================

Currently the gem provides  read only access to the prtg api.  
The later version should also be able to modify and create objects.

### Working
- **/api/table.xml** - Property/Status of Multiple Objects
- **/api/historicdata.xml** - Historic Data
- **/api/getpasshash.htm** - Passhash for later authentications

### Not yet implemented
- **/api/getobjectproperty.htm** - Get object property/setting
- **/api/getobjectstatus.htm** - Get object status
- **/api/getsensordetails.xml** - Get details about a sensor 
- **/api/getstatus.xml** - Get number of alarms,messages, etc.
- **/api/rename.htm** - Rename an object
- **/api/setpriority.htm** - Set priority of an object
- **/apisetobjectproperty.htm** - Change properties of objects
- **/api/pause.html** - Pause object
- **/api/pauseobjectfor.html** - Pause object for a given time
- **/api/simulate.htm** - Pause and simulate an error state
- **/api/acknowledgealarm.htm** - Ackknowledge an error
- **/api/scannow.htm** - Scan a sensor now
- **/api/discovernow.htm** - Run Auto Discovery for an object
- **/api/setposition.htm** - Move object in sensor tree
- **/api/reportaddsensor.htm** - Add object to a report
- **/api/notificationtest.htm** - Test a notification
- **/api/deleteobject.htm** - Delete an object
- **/api/duplicateobject.htm** - Duplicate a object
- **/chart.svg/png** - Live Sensor Graphs

Usage
=====

Instantiate new client
```ruby
require "prtg"

config = {}

config[:host] = Net::HTTP.new HOST, PORT
config[:host].use_ssl = true
config[:host].verify_mode = OpenSSL::SSL::VERIFY_NONE

config[:username] = USERNAME
config[:passhash] = PASSHASH

client = Prtg::Client.new(config)

```

Fetch name and objid of all sensors
```ruby
client.table.content(:sensors).columns(:objid, :name)
```

Fetch name and objid of all sensors which have a given tag
```ruby
client.table\
      .content(:sensors)\
      .columns(:objid, :name)\
      .filter_tags(:given_tag)
```

Get only the first
```ruby
client.table.content(:sensors).count(1)
```

Get only the second
```ruby
client.table.content(:sensors).count(1).start(2)
```


Changelog
=========

## 0.1.0
- Now historic data can be queried
- **Client#live_data** is deprecated and will be removed in the next version.
  The new api now maps the api's url pattern.

## 0.0.7
- Change the query 'objid' to 'id'.
  This reacts to changes in Prtg api version 13.2.3.1927.

## 0.0.6
- Add Accept-Encoding header to API calls.
  Otherwise Prtg version 13.2.3.1927 seems to faulty compress response data.
