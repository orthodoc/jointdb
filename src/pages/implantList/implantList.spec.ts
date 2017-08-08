import { ComponentFixture, async } from '@angular/core/testing';
import { TestUtils } from '../../test';
import { ImplantList } from './implantList';

let fixture: ComponentFixture<ImplantList> = null;
let instance: any = null;

describe('ImplantList', () => {
    beforeEach(async(() => TestUtils.beforeEachCompiler([ImplantList]).then(compiled => {
        fixture = compiled.fixture;
        instance = compiled.instance;
        fixture.detectChanges();
    })));

    afterEach(() => {
        fixture.destroy();
    });

    it('initialises', () => {
        expect(instance).toBeTruthy();
    });

});