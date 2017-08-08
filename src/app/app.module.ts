import { NgModule, ErrorHandler }                   from '@angular/core';
import { BrowserModule }                            from '@angular/platform-browser';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { StatusBar }                                from '@ionic-native/status-bar';
import { SplashScreen }                             from '@ionic-native/splash-screen';
import { JointdbApp }                              from './app.component';
import { ClickerList, PagesModule, Page2, ImplantList }          from '../pages';
import { ClickersService, StorageService }          from '../services';

@NgModule({
  declarations: [
    JointdbApp,
  ],
  imports: [
    BrowserModule,
    PagesModule,
    IonicModule.forRoot(JointdbApp),
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    JointdbApp,
    ClickerList,
    Page2,
    ImplantList,
  ],
  providers: [
    StatusBar,
    SplashScreen,
    ClickersService,
    StorageService,
    {provide: ErrorHandler, useClass: IonicErrorHandler},
  ],
})

export class AppModule {}
