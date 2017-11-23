global class DataLoad{
    public String sjson{get; set;}
    
    
    public void post(){
     Storage__c store = new Storage__c();
     store.JSON__c = sjson;
     insert store;
     }
    
    @RemoteAction
    global static String listFields(String type){ 
    
    if(String.isBlank(type)){ type ='Account';System.debug('##############DEFAULT##############');}

    System.debug('/////////////'+type);
     Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
     Schema.SObjectType leadSchema = schemaMap.get(type);
     Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
    JSONGenerator gen = JSON.createGenerator(false);
    gen.writeStartArray();

    for (String fieldName: fieldMap.keySet()) {
        if(fieldMap.get(fieldName).getDescribe().isPermissionable()){
        gen.writeStartObject();
        gen.writeStringField('name',fieldMap.get(fieldName).getDescribe().getLabel());
        gen.writeStringField('api_name',fieldName);
        gen.writeEndObject();
           }         
         else{System.debug(fieldName);}
         }
        gen.writeEndArray();  
        System.debug(gen.getAsString());
       return gen.getAsString();
    }
    
    @RemoteAction
    global static List<String> getTypes() {

           List<string> SObjectList = new List<string>();
 
         SObjectList.add('Account');
         SObjectList.add('Asset');
         SObjectList.add('Campaign');
         SObjectList.add('Case');
         SObjectList.add('Lead');
         SObjectList.add('Contact');
         SObjectList.add('Contract');
         //SObjectList.add('Document');
         //SObjectList.add('Group');
         SObjectList.add('Idea');
         //SObjectList.add('Macro');
         SObjectList.add('Opportunity');
         SObjectList.add('Order');
         SObjectList.add('Product2');
         //SObjectList.add('Profile');
         //SObjectList.add('Report');
 for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
    {
        Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
        if(describeSObjectResultObj.isCustom())
        {
            String name = objTyp.getDescribe().getName();
            
                SobjectList.add(name);
            
        }
    }

   

return SObjectList;
             

}
   
   
   }