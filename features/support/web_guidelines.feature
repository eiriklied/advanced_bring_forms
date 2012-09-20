Feature: Web guidelines
  In order to verify that my application follows postens css guidelines
  As a developer
  I want to check my applications styles

  @javascript
  Scenario: Web guidelines should be followed for dogs page
    When I go to "/"
    Then the css guidelines should be followed
    When I go to "/complaints/confirmation"
    Then the css guidelines should be followed
  
  
  