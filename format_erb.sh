#!/bin/sh
set -eo pipefail
echo "Running HTML Beautifier..."
bundle exec htmlbeautifier app/views/*/*.html.erb

echo "Running ERB Lint..."
bundle exec erb_lint --autocorrect app/views/*/*.html.erb