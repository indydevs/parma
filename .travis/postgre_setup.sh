#!/bin/bash
cp config/application.exs.travis config/application.exs
psql -c 'create database travis_ci_test;' -U postgres