#!/bin/sh

git add . && git commit . && git push && cap deploy:migrations
