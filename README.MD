# Galen IDE integration

Vote on [`Kickstarter`](https://www.kickstarter.com/projects/1453417775/1487427501) for the project.

[![Build Status](https://travis-ci.org/hypery2k/galen_ide.svg?branch=master)](https://travis-ci.org/hypery2k/galen_ide)
[![Build Status](https://martinreinhardt-online.de/jenkins/buildStatus/icon?job=Galen/Galen_IDE_build)](https://martinreinhardt-online.de/jenkins/job/Galen/Galen_IDE_build)
[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=mreinhardt&url=https://github.com/hypery2k/galen_ide&title=badges&language=&tags=github&category=software)

> Integration for Web, Eclipse and IDEA development environement for the [GalenFramework](http://galenframework.com)


> Feel free to donate
> 
> <a href='http://www.pledgie.com/campaigns/27462'><img alt='Click here to lend your support to: Galen IDE and make a donation at www.pledgie.com !' src='http://www.pledgie.com/campaigns/27462.png?skin_name=chrome' border='0' /></a> <a target="_blank" href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=345EFPLG3PGZU">
> <img alt="" border="0" src="https://www.paypalobjects.com/de_DE/DE/i/btn/btn_donateCC_LG.gif"/>
> </img></a>
> Or donate [Bitcoins](bitcoin:3NKtxw1SRYgess5ev4Ri54GekoAgkR213D):
> [![Bitcoin](https://martinreinhardt-online.de/bitcoin.png)](bitcoin:3NKtxw1SRYgess5ev4Ri54GekoAgkR213D)
> 
> Also via [greenaddress](https://greenaddress.it/pay/GA3ZPfh7As3Gc2oP6pQ1njxMij88u/)

## Try it out


### Eclipse
#### Update Site

Plugin is available as [continous build](https://martinreinhardt-online.de/update_sites/galen_ide/nightly/repository/). The latest working build is published there.

#### build

Download [Xtext Eclipse Beta](https://www.eclipse.org/Xtext/news.html#download-links) and copy the [latest plugins](https://github.com/hypery2k/galen_ide/releases/latest) into the dropins folder:
![](docs/screenshots/eclipse.png)

### IDEA

#### Update Site

Plugin is available via [nightly channel](https://plugins.jetbrains.com/plugin/8302). The latest working build is published there.

#### build
```bash
cd com.galenframework.layout.spec
cd com.galenframework.layout.spec.idea
./gradlew runIdea
````
![](docs/screenshots/idea.png)

### Web

Preview is available [here](https://martinreinhardt-online.de/galen_ide/).

See 
