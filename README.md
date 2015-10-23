# Galen IDE integration

Vote on [`Kickstarter`](https://www.kickstarter.com/projects/1453417775/plugins-for-intellij-and-eclipse-for-galen-layout) for the project.

[![Build Status](https://travis-ci.org/hypery2k/galen_ide.svg?branch=master)](https://travis-ci.org/hypery2k/galen_ide) [![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=mreinhardt&url=https://github.com/hypery2k/galen_ide&title=badges&language=&tags=github&category=software)

> Integration for Web, Eclipse and IDEA development environement for the [GalenFramework](http://galenframework.com)

Feel free to donate

<a href='http://www.pledgie.com/campaigns/27462'><img alt='Click here to lend your support to: Galen IDE and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/27462.png?skin_name=chrome' border='0' /></a> <a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=345EFPLG3PGZU">
<img alt="" border="0" src="https://www.paypalobjects.com/de_DE/DE/i/btn/btn_donateCC_LG.gif"/>
</img></a>

## Try it out


### Eclipse
Download [Xtext Eclipse Beta](https://www.eclipse.org/Xtext/news.html#download-links) and copy the [latest plugins](https://github.com/hypery2k/galen_ide/releases/latest) into the dropins folder:
![](docs/screenshots/eclipse.png)


### IDEA
```bash
cd com.galenframework.parent
cd com.galenframework.idea
./gradlew runIdea
````
![](docs/screenshots/idea.png)

## Dev instructions

For local setup use [Xtext 2.9.0beta5](https://www.eclipse.org/modeling/tmf/downloads/?showAll=1&hlbuild=S201510020259&project=xtext#S201510020259) or above and clone this repository.

Then in the repository run:

```bash
cd com.galenframework.parent
mvn install eclipse:eclipse
```
