import { browser, element, by } from 'protractor';

describe('JointdbApp', () => {

  beforeEach(() => {
    browser.get('');
  });

  it('should have a title', () => {
    expect(browser.getTitle()).toEqual('JointDB');
  });

  it('should have {nav}', () => {
    expect(element(by.css('ion-navbar')).isPresent()).toEqual(true);
  });

  it('should have correct nav text for Home', () => {
    expect(element(by.css('ion-navbar:first-child')).getText()).toContain('JointDB');
  });

  it('has a menu button that displays the left menu', () => {
    element(by.css('.bar-button-menutoggle')).click()
      .then(() => {
        browser.driver.sleep(2000); // wait for the animation
        expect(element.all(by.css('.toolbar-title')).first().getText()).toEqual('Menu');
      });
  });

  it('the left menu has a link with title Clickers', () => {
    element(by.css('.bar-button-menutoggle')).click()
      .then(() => {
        browser.driver.sleep(2000); // wait for the animation
        expect(element.all(by.css('ion-label')).get(0).getText()).toEqual('Clickers');
      });
  });

  it('the left menu has a link with title Goodbye Ionic', () => {
    element(by.css('.bar-button-menutoggle')).click()
      .then(() => {
        browser.driver.sleep(2000); // wait for the animation
        expect(element.all(by.css('ion-label')).get(1).getText()).toEqual('Goodbye Ionic');
      });
  });

  it('the left menu has a link with title Implants', () => {
    element(by.css('.bar-button-menutoggle')).click()
      .then(() => {
        browser.driver.sleep(2000);
        expect(element.all(by.css('ion-label')).get(2).getText()).toEqual('Implants');
      });
  });
});
