name := "notesWithPlay"

version := "1.0-SNAPSHOT"

resolvers ++= Seq(
  "Typesafe repository" at "http://repo.typesafe.com/typesafe/releases/",
  "Local Maven Repositor" at "file://"+Path.userHome.absolutePath+"/.m2/repository"
)

libraryDependencies ++= Seq(
  javaCore,
  javaJdbc,
  javaEbean,
  cache,
  javaJpa,
  "org.hibernate" % "hibernate-entitymanager" % "3.6.10.Final",
  "postgresql" % "postgresql" % "9.1-901.jdbc4"
)     

play.Project.playJavaSettings