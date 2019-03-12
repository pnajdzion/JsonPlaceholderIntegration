# Apex Integration with JSON Placeholder

Apex REST Integration to get Photos from JSON Placeholder

# Features
1. Schedulable class to download Photos once per day
2. Lightning app to preview Photos records ( + Photo title filter)
3. "Send Email" button on Lightning app, that allows to send filtered list to email

# Usage
1. Schedulable class <br/>
Execute this code in Apex Anonymous Window to set Schedulable class to Download Photos everyday at 6AM:
` System.schedule('Get Photos', '0 0 6 * * ?', new JSONPlaceholderSynchronizator()); `

2. Lighning app <br/>
Simply filter Photo list by enter some text and click "Apply filter".

3. Send Email button <br/>
Photo list can be send to an email. Just click "Send list to email" and enter email in new window.
