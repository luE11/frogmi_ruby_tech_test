#!/bin/bash
action=$1

case $action in

  run)
    bundle exec ruby app.rb
    ;;

  test)
    bundle exec ruby specs/models/feature.model.rb
    ;;

  *)
    echo "Unknown option"
   ;;
esac
