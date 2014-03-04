public with sharing class ChatterSweepController {

        private final chatter__c chatter; 
        public Boolean posts{get; set;}
        public Boolean comments{get; set;}
        public Boolean uploadContent {get; set;}
        
        public ChatterSweepController(ApexPages.StandardController controller) {
                this.chatter = (Chatter__c)controller.getRecord();
        }

        public PageReference DeleteChatter() {
        
        List<FeedItem> deleteFeeds = new List<FeedItem>();
        List<FeedComment> deleteComments = new List<FeedComment>();
        
        //delete feedItems 
        if (posts == true){
            List<FeedItem> fi = [Select Id from FeedItem where createdDate >=: chatter.start_date__c and createdDate <=: chatter.end_date__c];
            //system.debug('<<< Delete >>> ' ); 
            for (feedItem f : fi){
            deleteFeeds.add(f); 
            }    
            
            delete deleteFeeds;
        }
        
        //delete feedComments 
         if (comments == true){
            List<FeedComment> fc = [Select Id from FeedComment where createdDate >=: chatter.Start_date__c and createdDate <=: chatter.End_date__c];
            for (feedComment f : fc){
            deleteComments.add(f);
            }   
            
            delete deleteComments;
        }
        PageReference pg = new PageReference ('/apex/chatterSweeper');    
        return pg;
   }     
      

}
