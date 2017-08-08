'use strict';

import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';

@Component({
    templateUrl: './implantList.html',
})

export class ImplantList {

    public title: string;
    private nav: NavController;

    constructor(
        nav: NavController,
    ) {
        this.nav = nav;
        this.title = 'Implants';
    }
}
