import { NgModule } from '@angular/core';
import { HashLocationStrategy, LocationStrategy } from '@angular/common';
import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';
import { AppLayoutModule } from './layout/app.layout.module';
import { NotfoundComponent } from './demo/components/notfound/notfound.component';
import { ProductService } from './demo/service/product.service';
import { CountryService } from './demo/service/country.service';
import { CustomerService } from './demo/service/customer.service';
import { EventService } from './demo/service/event.service';
import { IconService } from './demo/service/icon.service';
import { NodeService } from './demo/service/node.service';
import { PhotoService } from './demo/service/photo.service';
import { HomePageComponent } from './home-page/home-page.component';
import { LoginPageComponent } from './login-page/login-page.component';
import { SkeletonPageComponent } from './skeleton-page/skeleton-page.component';
import {ButtonModule} from "primeng/button";
import {CheckboxModule} from "primeng/checkbox";
import {InputTextModule} from "primeng/inputtext";
import {PasswordModule} from "primeng/password";
import {FormsModule} from "@angular/forms";
import {ChartModule} from "primeng/chart";
import {ElectroService} from "./service/ElectroService";
import {TableModule} from "primeng/table";

@NgModule({
    declarations: [
        AppComponent, NotfoundComponent, HomePageComponent, LoginPageComponent, SkeletonPageComponent
    ],
    imports: [
        AppRoutingModule,
        AppLayoutModule,
        ButtonModule,
        CheckboxModule,
        InputTextModule,
        PasswordModule,
        FormsModule,
        ChartModule,
        TableModule
    ],
    providers: [
        { provide: LocationStrategy, useClass: HashLocationStrategy },
        CountryService, CustomerService, EventService, IconService, NodeService,
        PhotoService, ProductService,ElectroService
    ],
    bootstrap: [AppComponent]
})
export class AppModule { }
