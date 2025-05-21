---
title: Capsules Management
description: Learn the different ways you can manage your Capsule.
---

# Capsule Management

A [Capsule](../../FAQ/what-is-a-capsule/) provides the server for hosting an application on Code Capsules. In this reference guide, we'll take a look at the different options you have for managing your Capsule while it's deployed.

## Turning off a Capsule

You can turn off your Capsule by toggling the radio button at the top right of the Capsule's page. 

![Turn Off a Capsule](../assets/reference/capsule-management/capsule-toggle-button.png)

The most common reason for turning a Capsule off is if you've changed or added an environment variable, in which case you'll need to toggle the Capsule back on after a few seconds for the new variable to be accessible. Depending on the purpose of your application, you might also want to turn your Capsule off during periods of inactivity to save on the cost of running your application on Code Capsules.

## Scale a Capsule

It is possible to allocate more resources to your Capsule depending on how much traffic your application will be getting and its computational needs. To view the different scaling options available for your Capsule, navigate to the "Scale" tab while on your Capsule's page.

![Scale a Capsule](../assets/reference/capsule-management/scale-capsule.png)

Choose the package with the Capsule resources that best suit your needs by clicking on the item.

## Monitor Capsule Metrics

Each Capsule tracks its usage data and you can view this information by opening the "Metrics" tab on your Capsule's page. 

![Monitor Capsule Metrics](../assets/reference/capsule-management/capsule-metrics.png)

## Delete a Capsule

When you no longer wish to host your application on Code Capsules, delete your Capsule by navigating to the "Details" tab of the Capsule page and scrolling to the bottom. 

![Delete Capsule](../assets/reference/capsule-management/delete-capsule.png)

Click on the "Delete Capsule" button. A dialog will pop up asking you whether you're sure about deleting the Capsule since this action isn't reversible. If you're sure, enter the Capsule's name to activate the delete button and click "Delete" to confirm your changes. 
