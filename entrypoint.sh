#!/bin/sh

bundle exec ruby demo.rb &

nginx -g 'daemon off;'
