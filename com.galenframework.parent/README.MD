# Setup

## Prepare

* Install [Xtext 2.9.0beta5](https://www.eclipse.org/modeling/tmf/downloads/?showAll=1&hlbuild=S201510020259&project=xtext#S201510020259
* Install [xtext-utils](Xtext-Testutils) as update-site:
``` 
http://xtext-utils.eclipselabs.org.codespot.com/git.distribution/releases/unittesting-0.9.x
```

## Dev instructions

Clone this repository.

Then in the repository run:

```bash
cd com.galenframework.parent
mvn install eclipse:eclipse idea:idea -DskipTests=true
```