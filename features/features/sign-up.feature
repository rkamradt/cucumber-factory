Feature: In order to access the manufacturing system as a user I must sign up to create an account for myself.  I must provide user identification including a name (for display and search purposes only) a password, a company or supervisor, and email, and a role.  The password must be at least 8 characters in length and contain at least one alpha character, one number, and one punctuation and must be entered twice to confirm. The email must be of valid email format (name@domain), and the domain must match your company domain and will be used as a source of verification (an email will be sent to that address, and in which a response will be requested). The email must unique, and will be used to uniquely identify this person  An internal user must have a listed supervisor as opposed to a company to confirm them. If there are no other internal users, the email will be validated, but no confirmation is necessary, and the person will be considered the 'super-user'. Top-level supervisors should use the 'super-user' for confirmation.  This will distribute the load for confirmation. If a company is given, the role must match that given for that type of company (vendoring or buying).  If a supervisor is given, the role must match an internal role. Email and password may be hashed together to provide quick lookup and hidden password.


   Background:
       Given That I try to sign up as vendor, client, or internal-user
       And I give my name, password twice, company or supervisor, email and role
       And the email is in a valid format name@domain
       And email does not already exist in the system
       And the email domain matches the company 
       And the two passwords match
       And the password meets given criteria at least 8 characters, with one digit and one puntuation
       
   Scenario: Sign up as a vendor, client, internal user
       When I submit the information
       And the company is a known vendoring, client organization or supervisor is valid supervisor
       And the role is valid role for user type
       Then an email should be sent to me to verify its validity which will include a link to add me to the system
       And an unconfirmed, unverified account will be created
       And be navigated to the check my email screen

   Scenario: Sign up as the first internal user
       When I submit the information
       And no other internal users exist
       Then an email should be sent to me to verify its validity which will include a link to add me to the system
       And an unverified account will be created
       And be navigated to the check my email screen
              
   Scenario: Periodically check if an account has been created, but unverified in five days
       When an unverified account exists
       And five days have passed since the account was created
       Then delete the account
       And send a message to the account email that they must sign-up again
       
   Scenario: Periodically check if an account has been created, but unconfirmed in five days
       When an unconfirmed account exists
       And five days have passed since the account was created
       Then delete the account
       And send an email to the account that they must sign-up again
       And send an email to the organization/supervisor that the user tried to create an account but it was unconfirmed in time and to go apologize profusely to the user
