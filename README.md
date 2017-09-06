[![Build Status](https://travis-ci.org/rackspaceautomationco/playtypus.svg?branch=master)](https://travis-ci.org/rackspaceautomationco/playtypus) [![Coverage Status](https://coveralls.io/repos/rackspaceautomationco/playtypus/badge.svg?branch=master)](https://coveralls.io/r/rackspaceautomationco/playtypus?branch=master) [![Gem Version](https://badge.fury.io/rb/playtypus.svg)](http://badge.fury.io/rb/playtypus)

       -/- /_   _
      _/__/ (__(/_                                        
                                                       
                     _                                 
              ,_    // __,       -/-     ,_         ,  
             _/_)__(/_(_/(__(_/__/__(_/__/_)__(_/__/_)_
             /              _/_     _/_ /              
            /              (/      (/  /               
                                                       
   
              _.-^~~^^^`~-,_,,~''''''```~,''``~'``~,
      ______,'  -o  :.  _    .          ;     ,'`,  `.
     (      -\.._,.;;'._ ,(   }        _`_-_,,    `, `,
      ``~~~~~~'   ((/'((((____/~~~~~~'(,(,___>      `~'

## About

The Playtypus is an eventmachine-based command line utility that plays HTTP calls.  A JSON input file (or files) tells The Playtypus what uri, method, headers, and body to send to a host, as well as the precise time to send each call.  Optional response logging will write all details of HTTP responses to disk by call sequence.

## Usage

1.  Install The Playtypus gem

       `$ gem install playtypus`

2.  Define a series of HTTP calls in a JSON file

       ```json
       [
        {
           "timestamp" : "1970-01-01T00:00:00.0000000000Z",
           "path" : "/v1/users",
           "verb" : "POST",
           "headers" : {
             "Content-Type" : "application/json",
             "X-AUTH-TOKEN" : "123456789"
           },
           "body" : {
             "user" : {
               "name" : "the playtypus",
               "domicile" : "github"
             }
           }
         },
         {
           "timestamp" : "1970-01-01T00:00:01.0000000000Z",
           "path" : "/v1/users/1",
           "verb" : "GET",
           "request_filename" : "list_requests.log",
           "headers" : {
             "Content-Type" : "application/xml"
           }
         }
       ]
       ```

3.  Tell The Playtpus to play

`$ playtypus play --host=http://localhost:8081 --call-log=log.json --response-log=responses/ --preserve-times`

## Command line arguments

This section describes required and optional arguments The Playtypus understands.

### help

Describes available commands or one specific command

### --host, -h

(Required) The HTTP protocol to use, as well as the host address to use in playback:

`--host=https://169.0.0.1:443/`

### --call-log, -c

(Required) A file or directory containing a JSON array of calls to play:

`--call-log=calls/`

### --response-log, -r

(Optional) A destination directory for response logs stored in sequence by call:

`--response-log=responses/`

### --preserve-times, --no-preserve-times

(Default=false) Specifies whether timestamps should be used in playback:

`--preserve-times`

## Call logs

Call logs specify arrays of JSON instructing The Playtypus what, as well as when, to play HTTP calls.  Five properties are used:

1.  timestamp - a string in ISO 8601 format.  The initial timestamp matters not--the relative distance between each timestamp defines the distance between two calls.

2.  path - a relative path to be appended to the global --host address

3.  verb - GET, PUT, POST, DELETE, et cetera

4.  headers - a dictionary of headers to send

5.  body - a payload in dictionary or string format

6. response_filename - by default, if you specify the response-log, playtypus will log files in that folder sequentially starting from 000000000.log. If you want to specify the actual log file name, add this to your call. Note: it will ALWAYS append to the file


## Contributing

1.  Fork/clone The Playtypus repo
2.  Make sure tests pass by running `rake` at the root of the project
3.  Add tests for your change.  Make your change, and make sure that tests pass by running `rake` again
4.  Commit to your fork using a good commit message
5.  Push and submit a pull request

## License

Distributed under the [MIT-LICENSE](/MIT-LICENSE)

