import { JointdbApp }                      from './app.component';
import { MenuMock, NavMock, PlatformMock, StatusBarMock, SplashScreenMock } from 'ionic-mocks';
import { Page2 }                           from '../pages';

let instance: JointdbApp = null;

describe('JointdbApp', () => {

  beforeEach(() => {
    instance = new JointdbApp((<any> PlatformMock.instance()), (<any> MenuMock.instance()), (<any>SplashScreenMock.instance()), (<any>StatusBarMock.instance()));
    instance['nav'] = NavMock.instance();
  });

  it('initialises with three possible pages', () => {
    expect(instance['pages'].length).toEqual(3);
  });

  it('initialises with a root page', () => {
    expect(instance['rootPage']).not.toBe(null);
  });

  it('opens a page', () => {
    instance.openPage(instance['pages'][1]);
    expect(instance['menu']['close']).toHaveBeenCalled();
    expect(instance['nav'].setRoot).toHaveBeenCalledWith(Page2);
  });
});
