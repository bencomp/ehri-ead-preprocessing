# Add unit titles

This XSLT stylesheet adds a `<unittitle>` to `<did>` elements without existing unit titles.

## What does it do?

The following rules are followed:

1. take the parent unit's title and append ` / [unitid]`.

## What has to be done?

It should use the first words of the unit's scope and content if it's available.

It should log the changes made as a processing step.

## Installing

The Bash script currently relies on `~/Applications/saxon9he.jar`. 
You don't strictly need this script.

## Use

Use your favourite XSLT processor.

## Licence

TBD
