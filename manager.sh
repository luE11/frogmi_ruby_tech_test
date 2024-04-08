#!/bin/bash
action=$1

case $action in

  run)
    bundle exec ruby app.rb
    ;;

  test)
    bundle exec ruby specs/models/feature_model_spec.rb
    ;;

  *)
    echo "Unknown option"
   ;;
esac
