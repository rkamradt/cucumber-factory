require 'test/unit'
include Test::Unit::Assertions

Given /^That I try to sign in by navigating to the sign\-in screen$/ do
    Account.add("user@company.com", "password"); #add an account
end

Given /^I enter my email and password$/ do
    @email = "user@company.com";
    @password = "password";
end

When /^I submit the information$/ do
  # nothing to do without a GUI
end

When /^my email and password match$/ do
  @account = Account.find(@email,@password);
  if(@account == null) then
    throw "cannot find email/password";
  end
end

When /^my account is unverifieded$/ do
  if(@account.verified != false) then
    throw "account is verified";
  end
end

Then /^return that I am not yet verified and to check my email$/ do
    @navigation = Account.onNotVerified(@account);
    assert_equal @navigation.message, "SignupVerifiyCheckEmail"
end

Then /^be navigated to the please have patience screen$/ do
    assert_equal @navigation.screen, "SignupPleaseHavePatience"
end

When /^my account is unconfirmed$/ do
  if(@account.confirmed != false) then
    throw "account is confirmed";
  end
end

Then /^return that I am not yet confirmed and to check with my organization or supervisor$/ do
    @navigation = Account.onNotConfirmed(@account);
    assert_equal @navigation.message, "SignupNotYetConfirmed"
end

When /^my account is confirmed$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^return a key to the vendor, buyer, or internal user system$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^be navigated to the role\-home screen$/ do
  pending # express the regexp above with the code you wish you had
end

When /^my email and password dont match$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^return that my email and password dont match any in the system$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^be navigated back to the sign in screen$/ do
  pending # express the regexp above with the code you wish you had
end

