When /^I go to "(.*?)"$/ do |path|
  visit path
end

Then /^the css guidelines should be followed$/ do
  cactus_report = find('#cactus')
  failures = cactus_report.all(".cactus_fail")

  raise("Could not find a cactus report") unless cactus_report.present?

  if failures.present?
    message = "Css guidelines not followed on '#{page.current_url}'\n"
      failures.each do |failure|
        message += "- #{failure.text}\n"
      end
    raise(message)
  end
end

