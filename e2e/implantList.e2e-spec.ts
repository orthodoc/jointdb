import { browser, element, by, ElementFinder } from 'protractor';

describe('ImplantList', () => {

    beforeEach(() => {
        browser.get('');
    });

    it('should switch into the implants page from menu', () => {
        element(by.css('.bar-button-menutoggle')).click()
            .then(() => {
                browser.driver.sleep(2000);
                expect(element.all(by.css('ion-label')).get(2).getText()).toEqual('Implants');
            });
    });

});