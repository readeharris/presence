Feature: Default Reminder Interval
  As a user
  In order to start monitoring my awareness throughout the day
  I want to receive my first reminder at the recommended time

  Background:
    Given I am a Presence user
    And I am using the default interval
    And push notifications are stubbed

  Scenario: User receives her first notification after 30 minutes have passed
    Given 30 minutes pass
    And the reminder job runs
    Then I should be reminded via push notification

  Scenario: User does not receive her first notification before 30 minutes have passed
    Given 29 minutes pass
    And the reminder job runs
    Then I should not be reminded via push notification

