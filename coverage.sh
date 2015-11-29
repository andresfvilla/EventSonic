#!/bin/sh
# First Run Tests
xcodebuild test -workspace EventSonic/EventSonic.xcworkspace/ \
	-scheme 'EventSonic' \
	-configuration Debug \
	-destination 'platform=iOS Simulator,name=iPhone 5s,OS=8.1' | xcpretty -c

#Above we're piping output through xcpretty, which is not required
#but very nice! (gem install xcpretty)

# Now Produce Test Coverage Report
groovy http://frankencover.it/with -source-dir MyProject/Classes \
	-required-coverage 85

#We set required coverage to 85% - build fails if coverage
#falls below this value.
