Feature: Default Reminder Interval
  As a user
  In order to start monitoring my awareness throughout the day
  I want to receive my first reminder at the recommended time

  Background:
    Given I am a Presence user
    And I am using the default interval

  Scenario: User receives her first notification after 30 minutes have passed
    When 30 minutes pass
    Then I should be reminded with a push notification

  Scenario: User does not receive her first notification before 30 minutes have passed
    When 29 minutes pass
    Then I should not be reminded

