sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/bosch/po/managepo/test/integration/FirstJourney',
		'com/bosch/po/managepo/test/integration/pages/POsList',
		'com/bosch/po/managepo/test/integration/pages/POsObjectPage',
		'com/bosch/po/managepo/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/bosch/po/managepo') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);