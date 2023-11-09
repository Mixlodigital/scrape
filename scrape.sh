#!/bin/bash

# Base URL for the website
base_url="http://www.yell.com"

# Total number of pages to scrape
total_pages=100

# Delay in seconds (for example, 10 seconds)
delay=10

# User-Agent string to identify the scraper
user_agent="Mozilla/5.0"

# Loop through the number of pages
for ((page=1; page<=total_pages; page++))
do
    # Download the page with the specified User-Agent
    curl -A "$user_agent" -o "webpage-${page}.html" "${base_url}?page=${page}"

    # Use Perl to parse emails with a robust regex and append to emails.txt
    perl -ne 'print "$&\n" while /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/g' "webpage-${page}.html" >> emails.txt

    # Wait for the specified delay before making the next request
    sleep "$delay"
done

echo "Scraping complete."
