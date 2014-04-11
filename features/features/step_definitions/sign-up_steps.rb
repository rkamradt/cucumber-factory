require 'test/unit'
include Test::Unit::Assertions


class Navigation
    def self.goto(screenname)
    end
end

class Email
    def self.send(template)
    end
    def self.checkIfEmailDomainMatchesCompany(email, company)
        return true;
    end
    def self.checkEmailFormat(email)
        return true;
    end
end

class Company
    def initialize(name)
    end
    def self.checkIfCompanyExists(company)
        return true;
    end
end

class Role
    def initialize(name)
    end
    def checkRole(company, supervisor)
        return true;
    end
end

class Account
    def initialize(name, password, email, company, supervisor, role)
    end
    def setVerified(varified)
    end
    def remove()
    end
    def self.checkIfPersonExists(name)
        return true;
    end
    def self.checkPassword(password)
        return true;
    end
    def self.checkPasswordComfirmation(password, confirmation)
        return true;
    end
    def self.checkIfEmailExists(email)
        return false;
    end
    def self.checkIfNoAccountsExist() 
        return true;
    end
end

@email
@name
@password
@confirmation
@company
@supervisor
@role
@account

Given /^That I try to sign up as vendor, client, or internal\-user$/ do
end

Given /^I give my name, password twice, company or supervisor, email and role$/ do
  @name = "My Name"
  @password = "password"
  @confirmation = "confirmation"
  @company = Company.new("CheapMart")
  @supervisor
  @email = "myname@cheapmart.com"
  @role = Role.new("nagger")
end

Given /^the email is in a valid format name@domain$/ do
  assert_equal Email.checkEmailFormat(@email), true
end

Given /^email does not already exist in the system$/ do
  assert_equal Account.checkIfEmailExists(@email), false
end

Given /^the email domain matches the company$/ do
  assert_equal Email.checkIfEmailDomainMatchesCompany(@email,@company),true
end

Given /^the two passwords match$/ do
  assert_equal Account.checkPasswordComfirmation(@password,@confirmation),true
end

Given /^the password meets given criteria at least 8 characters, with one digit and one puntuation$/ do 
  assert_equal Account.checkPassword(@password), true
end

When /^the company is a known vendoring, client organization or supervisor is valid supervisor$/ do
  if(@company) then
    assert_equal Company.checkIfCompanyExists(@company), true
  elsif(@supervisor) then
    assert_equal Account.checkIfPersonExists(@supervisor), true
  else
    throw "neither company or supervisor exist"
  end
end

When /^the role is valid role for user type$/ do
  assert_equal @role.checkRole(@company, @supervisor), true
end

Then /^an email should be sent to me to verify its validity which will include a link to add me to the system$/ do
  Email.send("Verify")
end

Then /^an unconfirmed, unverified account will be created$/ do
  @account = Account.new(@name, @password, @email, @company, @supervisor, @role);
end

Then /^be navigated to the check my email screen$/ do
  Navigation.goto("CheckEmailScreen");
end

When /^no other internal users exist$/ do
  assert_equal Account.checkIfNoAccountsExist(), true;
end

Then /^an unverified account will be created$/ do
  @account = Account.new(@name, @password, @email, @company, @supervisor, @role);
end

When /^an unverified account exists$/ do
  @account = Account.new(@name, @password, @email, @company, @supervisor, @role);
end

When /^five days have passed since the account was created$/ do
end

Then /^delete the account$/ do
  @account.remove()
end

When /^an unconfirmed account exists$/ do
  @account = Account.new(@name, @password, @email, @company, @supervisor, @role);
  @account.setVerified(true);
end

Then /^send an email to the account that they must sign\-up again$/ do
  Email.send("SignUpAgain")
end

Then /^send an email to the organization\/supervisor that the user tried to create an account but it was unconfirmed in time and to go apologize profusely to the user$/ do
  Email.send("ConfirmationTimeout")
end
