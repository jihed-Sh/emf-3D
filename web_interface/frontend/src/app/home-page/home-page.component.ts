import {Component, OnInit} from '@angular/core';
import {ElectroService} from "../service/ElectroService";

@Component({
  selector: 'app-home-page',
  templateUrl: './home-page.component.html',
  styleUrls: ['./home-page.component.scss']
})
export class HomePageComponent implements OnInit{

    lineData: any;
    barData: any;
    barOptions: any;
    lineOptions: any;
    pieData: any;
    pieOptions: any;
     zValues: any | number=[];
     xValues:any |number=[];
     yValues:any |number=[];
     emfValues:any |number=[];
    equipements=[
        {
            name:"Pc",
            statue:"Medium",
            date:"2023/04/12"
        },
        {
            name:"Voltmeter",
            statue:"Medium",
            date:"2023/03/17"
        },
        {
            name:"Phone",
            statue:"Medium",
            date:"2023/1/27"
        }
    ] ;
    constructor(private electroService:ElectroService) {
    }

    ngOnInit() {
        this.electroService.getData().subscribe(
            {
                next:value =>{
                    this.zValues=value.zvalues;
                    this.xValues=value.xvalues;
                    this.yValues=value.yvalues;
                    this.emfValues=value.emfValues;
                    console.log(this.zValues)
                    console.log(this.xValues)
                    console.log(this.yValues)
                    console.log(this.emfValues)
                    this.initCharts();
                },
                error:(e)=>{
                    console.log("error")
                }
            }

        )


    }

    initCharts() {
        const documentStyle = getComputedStyle(document.documentElement);
        const textColor = documentStyle.getPropertyValue('--text-color');
        const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
        const surfaceBorder = documentStyle.getPropertyValue('--surface-border');
        this.barData = {
            labels: Array(40).fill(' ').join(''),
            datasets: [
                {
                    label: 'My First dataset',
                    backgroundColor: documentStyle.getPropertyValue('--primary-500'),
                    borderColor: documentStyle.getPropertyValue('--primary-500'),
                    data: this.emfValues
                },
            ]
        };
        this.barOptions = {
            plugins: {
                legend: {
                    labels: {
                        fontColor: textColor
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: textColorSecondary,
                        font: {
                            weight: 500
                        }
                    },
                    grid: {
                        display: false,
                        drawBorder: false
                    }
                },
                y: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                },
            }
        };
        this.pieData = {
            labels: ['High Danger', 'Medium', 'Low'],
            datasets: [
                {
                    data: [540, 325, 702],
                    backgroundColor: [
                        documentStyle.getPropertyValue('--red-500'),
                        documentStyle.getPropertyValue('--orange-500'),
                        documentStyle.getPropertyValue('--green-500')
                    ],
                    hoverBackgroundColor: [
                        documentStyle.getPropertyValue('--red-400'),
                        documentStyle.getPropertyValue('--orange-400'),
                        documentStyle.getPropertyValue('--green-400')
                    ]
                }]
        };
        this.pieOptions = {
            plugins: {
                legend: {
                    labels: {
                        usePointStyle: true,
                        color: textColor
                    }
                }
            }
        };
        this.lineData = {
            labels: Array(40).fill(' ').join(''),
            datasets: [
                {
                    label: 'X',
                    data: this.xValues,
                    fill: false,
                    backgroundColor: documentStyle.getPropertyValue('--purple-500'),
                    borderColor: documentStyle.getPropertyValue('--purple-500'),
                    tension: .4
                },
                {
                    label: 'Y',
                    data: this.yValues,
                    fill: false,
                    backgroundColor: documentStyle.getPropertyValue('--primary-500'),
                    borderColor: documentStyle.getPropertyValue('--primary-500'),
                    tension: .4
                },
                {
                    label: 'Z',
                    data: this.zValues,
                    fill: false,
                    backgroundColor: documentStyle.getPropertyValue('--teal-300'),
                    borderColor: documentStyle.getPropertyValue('--teal-300'),
                    tension: .4
                }
            ]
        };
        this.lineOptions = {
            plugins: {
                legend: {
                    labels: {
                        fontColor: textColor
                    }
                }
            },
            scales: {
                x: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                },
                y: {
                    ticks: {
                        color: textColorSecondary
                    },
                    grid: {
                        color: surfaceBorder,
                        drawBorder: false
                    }
                },
            }
        };

    }
}
