Feature: In order to access the manufacturing system as a user I must sign in to identify myself.  If I have not signed in before, I must provide user identification including an email which will be verified and a source of confirmation.  A user is a person that belongs either to a vendoring organization (from whom we buy stuff), a buying organization (to whom we sell stuff), or an internal user.  The person that belong to a vendoring organization is known simply as a vendor.  The person that belongs to a buying organization is known as a client.  An internal user must have a listed supervisor to confirm them, unless there are no other internal users, in which case the person is the 'super-user'.  A user must be verified via an email to the one they listed, and confirmed via an email to the organization to which they belong or in the case of an internal user, by their superviser.  The super-user will have their email verified, but will automatically be confirmed.  A person that has been confirmed will be considered to have an account

   Scenario: Sign up as a vendor with no account
       Given That I have no account
       When I try to sign up
       And I give my name, password (x2), company, email and role
       And the email is in a valid format and does not already exist in the system
       And the two passwords match
       And the company is a known vendoring organization
       And the role is valid for a vendor account
       Then an email should be sent to me to verify its validity which will include a link to add me to the system
       And an unconfirmed, unverified account will be created
       And an email will be sent to the company with a link to confirm me to the system
       And return instruction to me to check my email (and navigation code for GUI interface)

   Scenario: Sign up as a client with no account
       Given That I have no account
       When I try to sign up
       And I give my name, password (x2), company, email and role
       And the email is in a valid format and does not already exist in the system
       And the two passwords match
       And the company is a known buying organization
       And the role is valid for a client account
       Then an email should be sent to me to verify its validity which will include a link to add me to the system
       And an unconfirmed, unverified account will be created
       And an email will be sent to the company with a link to confirm me to the system
       And return instruction to me to check my email (and navigation code for GUI interface)

   Scenario: Sign up as an internal user with no account
       Given That I have no account
       When I try to sign up
       And I give my name, password (x2), supervisor, email and role
       And the email is in a valid format and does not already exist in the system
       And the two passwords match
       And the supervisor is known
       And the role is valid for a internal user account
       Then an email should be sent to me to verify its validity which will include a link to add me to the system
       And an unconfirmed, unverified account will be created
       And an email will be sent to my supervisor with a link to confirm me to the system
       And return instruction to me to check my email (and navigation code for GUI interface)

   Scenario: Sign up as the first internal user with no account
       Given That I have no account
       And no other internal users exist
       When I try to sign up
       And I give my name, password (x2), and email
       And the email is in a valid format
       And the two passwords match
       Then an email should be sent to me to verify its validity which will include a link to add me to the system
       And an unverified account will be created
       And return instruction to me to check my email (and navigation code for GUI interface)

   Scenario: Sign in as a vendor with an unconfirmed account
       Given That I have an account
       And it is unconfirmed
       When I try to sign in
       And I give my name and password
       And they are correct
       Then return that I am not yet confirmed and to check with my organization (and navigation code for GUI interface)

   Scenario: Sign in as a client with an unconfirmed account
       Given That I have an account
       And it is unconfirmed
       When I try to sign in
       And I give my name and password
       And they are correct
       Then return that I am not yet confirmed and to check with my organization (and navigation code for GUI interface)

   Scenario: Sign in as a internal user with an unconfirmed account
       Given That I have an account
       And it is unconfirmed
       When I try to sign in
       And I give my name and password
       And they are correct
       Then return that I am not yet confirmed and to check with my supervisor (and navigation code for GUI interface)

   Scenario: Sign in as a vendor with a confirmed account
       Given That I have an account
       And it is confirmed
       When I try to sign in
       And I give my name and password
       And they are correct
       Then return a key to the vendor system (and navigation code for GUI interface)

   Scenario: Sign in as a client with a confirmed account
       Given That I have an account
       And it is confirmed
       When I try to sign in
       And I give my name and password
       And they are correct
       Then return a key to the client system (and navigation code for GUI interface)

   Scenario: Sign in as a internal user with a confirmed account
       Given That I have an account
       And it is confirmed
       When I try to sign in
       And I give my name and password
       And they are correct
       Then return a key to the internal user system (and navigation code for GUI interface)

   Scenario: Periodically check if an account has been created, but unverified or unconfirmed in five days
       Given that an unverified or unconfirmed account exists
       And five days have passed since the account was created
       Then delete the account
       And send a message to the account email that they must re-register
       And send a message to the organization/supervisor that the user tried to create an account but it was unverified or unconfirmed
