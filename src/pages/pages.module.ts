import { NgModule }         from '@angular/core';
import { IonicModule }      from 'ionic-angular';
import { ComponentsModule } from '../components';
import { ClickerList }      from './clickerList/clickerList';
import { Page2 }            from './page2/page2';
import { ImplantList } from './implantList/implantList';

@NgModule({
  declarations: [
    ClickerList,
    Page2,
    ImplantList,
  ],
  imports: [ IonicModule, ComponentsModule ],
  exports: [
    ClickerList,
    // Page2,
  ],
  entryComponents: [],
  providers: [ ],
})

export class PagesModule {}
