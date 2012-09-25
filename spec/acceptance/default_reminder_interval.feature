Feature: Default Reminder Interval
  As a user
  In order to start monitoring my awareness throughout the day
  I want to receive my first reminder at the recommended time

  Scenario: User receives her first notification after 30 minutes
    Given I am a Presence user
    And I am monitoring my awareness
    And 30 minutes pass
    And the reminder job runs
    Then I should be reminded

  # Scenario: User does not receive her first notification before 30 minutes have passed
  #   Given I am a Presence user
  #   And I have started my awareness monitor
  #   And 29 minutes pass
  #   And the reminder job runs
  #   Then I should not be reminded

