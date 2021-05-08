import { LightningElement,track,wire,api } from 'lwc';
import EVENT_ID from '@salesforce/schema/Event__c.Id';
import MINUTES_SPENT_FIELD from '@salesforce/schema/Event__c.Minutes_Spent__c';
import { getRecord,updateRecord,generateRecordInputForUpdate,getFieldValue} from 'lightning/uiRecordApi';
import {CurrentPageReference} from 'lightning/navigation';

export default class EventTimer extends LightningElement {
    @api recordId;
    @track mintimeValue;
    @track showStartBtn = true;
    @track disablestartBtn = false;
    @track disablestopBtn = false;
    @track timeVal = '0:0:0:0';
    timeIntervalInstance;
    totalMilliseconds = 0;

    @wire(CurrentPageReference)
    currentPageReference;

    @wire(getRecord, { recordId: '$recordId', fields: [MINUTES_SPENT_FIELD] })
    events;

    connectedCallback() {
        
    }


    start(event) {
        this.showStartBtn = false;
        this.disablestartBtn = true;
        this.disablestopBtn = false;
        var parentThis = this;

        // Run timer code in every 100 milliseconds
        this.timeIntervalInstance = setInterval(function() {

            // Time calculations for hours, minutes, seconds and milliseconds
            var hours = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((parentThis.totalMilliseconds % (1000 * 60)) / 1000);
            var milliseconds = Math.floor((parentThis.totalMilliseconds % (1000)));
            
            // Output the result in the timeVal variable
            parentThis.timeVal = hours + ":" + minutes + ":" + seconds + ":" + milliseconds;   
            parentThis.totalMilliseconds += 100;
        }, 100);

    }

    stop(event) {
        this.showStartBtn = true;
        this.disablestopBtn = true;
        this.disablestartBtn = false;

        clearInterval(this.timeIntervalInstance);
        const fields = {};
        fields[EVENT_ID.fieldApiName] = this.recordId;
        const totalMinSpent = (this.totalMilliseconds / 60000).toString();

        fields[MINUTES_SPENT_FIELD.fieldApiName] = totalMinSpent;

        const record = { fields };
        console.log("record"+ record);

        updateRecord(record)
            .then(() => {
               console.log("success");
            })
            .catch(error => {
                console.log(error);
            });

    }

    disconnectedCallback() {
        if(this.currentPageReference.attributes.recordId == this.recordId){
             const fields = {};
            fields[EVENT_ID.fieldApiName] = this.recordId;
            // Adding up the time
 
            let orgtime = getFieldValue(this.events.data, MINUTES_SPENT_FIELD);
            const toMinutes = (this.totalMilliseconds/ 60000).toString();

            fields[MINUTES_SPENT_FIELD.fieldApiName] = (parseFloat(orgtime) + parseFloat(toMinutes)).toFixed(2);

            const record = { fields };
    
            updateRecord(record)
                .then(() => {
                   console.log("success");
                })
                .catch(error => {
                    console.log(error);
                });
            }  
        }
   
        reset(event) {
            this.timeVal = '0:0:0:0';
            this.totalMilliseconds = 0;
            clearInterval(this.timeIntervalInstance);
        }


}