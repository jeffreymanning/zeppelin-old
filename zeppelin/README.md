# Java 8 (1.8.0_141) JRE server + Maven 3.5.0 + Python 2.7.5

## Components:
* Oracle Java "1.8.0_141" JRE Runtime Environment for Server
  Java(TM) SE Runtime Environment (build 1.8.0_141-b15)
  Java Home: $JAVA_HOME is setup (/usr)
* Apache Maven 3.5.0
  Maven home: /usr/apache-maven-3.5.0
* Python 2.7.5 (Default Centos7 install)
* Other tools: tar curl net-tools build-essential git wget unzip vim  

## Pull the image from Docker Repository

```bash
docker pull jeffreymanning/centos-base
```

## Base the image to build add-on components

```Dockerfile
FROM jeffreymanning/centos-base
```

## Run the image

Then, you're ready to run :
Make sure you create your work directory, e.g., /data

```bash
mkdir ./data
docker run -d --name my-centos-base -v $PWD/data:/data -i -t jeffreymanning/centos-base
```

## Build and Run your own image

Say, you will build the image "my/centos-base".

```bash
docker build -t my/centos-base .
```

## Shell into the Docker instance
```bash
docker exec -it <some-centos-base> /bin/bash
```

## Run Python code
To run Python code 

```bash
docker run --rm jeffreymanning/centos-base python -c 'print("Hello World")'
```
or,

```bash
docker run -i --rm jeffreymanning/centos-base python < myPyScript.py 
```

or,

```bash
mkdir ./data
echo "print('Hello World')" > ./data/myPyScript.py
docker run -it --rm --name some-centos-base -v "$PWD"/data:/data jeffreymanning/centos-base python myPyScript.py
```

or,

```bash
alias dpy='docker run --rm jeffreymanning/centos-base python'
dpy -c 'print("Hello World")'
```

## Compile or Run java while no local installation needed
Remember, the default working directory, /data, inside the docker container -- treat is as "/".
So, if you create subdirectory, "./data/workspace", in the host machine and
the docker container will have it as "/data/workspace".

```java
#!/bin/bash -x
mkdir ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
alias djavac='docker run -it --rm --name some-centos-base -v '$PWD'/data:/data jeffreymanning/centos-base javac'
alias djava='docker run -it --rm --name some-centos-base -v '$PWD'/data:/data jeffreymanning/centos-base java'

djavac HelloWorld.java
djava HelloWorld
```
And, the output:
```
Hello, World
```
Hence, the alias above, "djavac" and "djava" is your docker-based "javac" and "java" commands and
it will work the same way as your local installed Java's "javac" and "java" commands.
However, for larger complex projects, you might want to consider to use Docker-based IDE.
For example, try this docker-scala-ide:
[Scala IDE in Docker](https://github.com/stevenalexander/docker-scala-ide)
See also,
[Java Development in Docker](https://blog.giantswarm.io/getting-started-with-java-development-on-docker/)
