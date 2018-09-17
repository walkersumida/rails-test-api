bundle exec rake db:create
bundle exec rake db:migrate
[ -f /tmp/rails_test_api.pid ] && rm /tmp/rails_test_api.pid || echo "Not found"
bundle exec rails s -p 3000 -P /tmp/rails_test_api.pid -b '0.0.0.0'

