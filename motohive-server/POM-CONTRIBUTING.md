Parent/Child POM - Quick Contribution Guide

Purpose
-------
This document explains how to keep child module POM files minimal and avoid duplication by centralizing versions, plugins and common dependencies in the parent POM (`motohive-server/pom.xml`).

Rules
-----
1. Centralize versions
   - Put library and plugin versions in the parent POM's `<properties>` and/or `dependencyManagement`.
   - Use BOM imports (e.g., Spring Boot / Spring Cloud) in the parent `dependencyManagement` to keep versions consistent.

2. dependencyManagement vs dependencies
   - Use `<dependencyManagement>` to pin versions for libraries used across modules, but let modules declare the dependency themselves (no version required).
   - Put a dependency into the parent `<dependencies>` only when every module should automatically inherit it.

3. Plugins
   - Put plugin versions and shared configuration in `<pluginManagement>` of the parent.
   - Apply common plugins in the parent's `<build><plugins>` so modules inherit the behavior without repeating plugin declarations.
   - Only define plugin execution/configuration in a child POM when the module needs behavior different from the global default.

4. Annotation processors
   - Configure annotation processor paths in the parent (maven-compiler-plugin configuration in pluginManagement) so children don't repeat them.

5. Child POM minimal template
   Use this minimal structure for child modules:

   ```xml
   <project ...>
     <modelVersion>4.0.0</modelVersion>
     <parent>
       <groupId>com.motohive</groupId>
       <artifactId>motohive-server</artifactId>
       <version>1.0.0</version>
       <relativePath>..</relativePath>
     </parent>

     <artifactId>my-module</artifactId>
     <packaging>jar</packaging>
     <name>My Module</name>

     <dependencies>
       <!-- reference versions are managed in parent/dependencyManagement -->
       <dependency>
         <groupId>org.mapstruct</groupId>
         <artifactId>mapstruct</artifactId>
       </dependency>
     </dependencies>

   </project>
   ```

6. Verifying inheritance
   - To inspect what a module inherits: `mvn -pl <module> help:effective-pom`
   - To build the entire project: `mvn -DskipTests clean install`

7. Enforcer and CI
   - The parent includes the Maven Enforcer plugin to ensure consistent Java version and dependency convergence.
   - If Enforcer fails locally, fix the violating child POM (usually duplicate/version mismatch) and re-run.

When to modify parent vs child
-----------------------------
- If a change affects all (or most) modules (e.g., annotation processors, java version, plugin versions), update the parent.
- If a change is module-specific (e.g., an extra plugin execution only for that module), add it only to that child's POM.

Questions / Help
----------------
If you're unsure where to add a version or plugin, ask in the team channel or open a quick PR referencing this guide.