# Setup

## Prepare

* Install [Xtext](https://eclipse.org/xtend/download.html)
* Install [xtext-utils](Xtext-Testutils) as update-site:
``` 
http://xtext-utils.eclipselabs.org.codespot.com/git.distribution/releases/unittesting-0.9.x
```

## Dev instructions

Clone this repository.

Then in the repository run:

```bash
cd com.galenframework.layout.spec.
mvn install eclipse:eclipse idea:idea -DskipTests=true
```