.PHONY : up

prepare :
	bundle install

lint :
	bundle exec rake rubocop

test :
	bundle exec rspec

up : prepare test lint