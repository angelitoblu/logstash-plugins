logstash-plugins
================

These are some (pretty bad) plugins that I wrote to simplify some tasks for myself.

splitter.rb 

For some data I was working on, using split() seemed to be the quickest way to 
fix it up. So, I wrote this. It's pretty single-minded in purpose but could
be an actually useful plugin with some creativity.

Note: Good bad or ugly logs are often consistant. Why build a grok pattern 
for something when a given value is always the 4th column in? Think of
doing the 'cat filename | awk '{print $1}' - which is pretty much what this
could be.

tattle.rb

I wanted some ability to see what stuff looks like instead of logstash without
going to using -vv.

This plugin could have more flexibility in it as well to only output certian
fields.


Use
===

Make a logstash/filters directory in your logstash directory (or wherever) and
start up logstash with the following

    java -jar logstash.jar agent --pluginpath . 

or

    java -jar logstash.jar agent --pluginpath /some/long/and/windy/path
