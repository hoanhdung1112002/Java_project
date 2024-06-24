# Project Java_08
## Technology
1. Spring boot 2.6.2
    - Documentation: https://spring.io/projects/spring-boot
2. Bootstrap v5.1.3
    - Documentation: https://getbootstrap.com/docs/5.1/getting-started/introduction
3. Icon
    - https://icons.getbootstrap.com/
4. Alert
    - SweetAlert: https://sweetalert2.github.io
5. Table
    - DataTable: https://www.datatables.net
6. Text editor
    - TinyMCE: https://www.tiny.cloud/

### Git Flow
- Step 1: Change label of task to processing
- Step 2: Checkout to dev, pull newest code from dev
    ```
    git pull origin dev
    ```
- Step 3: Create branch for task, base in branch `dev`

    **Rule of branch name:**

    - If issue have label is `'Feature'`, branch name start with `feat/`
    - If issue have label is `'Bug'`, branch name start with `fix/`
    - After that, concat with string `java08-[issueId]`

    Example: Issue is `Feature`, Id is `123`, Name is `Create Page login`. Branch name is `feat/java08-123`
    ```
    git checkout -b feat/java08-123 dev
    ```
- Step 4: When commit, message of commit follow rule
    - If issue have label is `'Feature'`, branch name start with `feat: `
    - If issue have label is `'Bug'`, branch name start with `fix: `
    - Next is string `[#[issueId]]`
    - Next is commit content

    Example: `feat: [#123] Coding layout for page login`
- Step 5: When merge, message of merge follow rule
    - If issue have label is `'Feature'`, branch name start with `feat: `
    - If issue have label is `'Bug'`, branch name start with `fix: `
    - Next is string `[#[issueId]]`
    - Next is merge content

    Example: `feat: [#123] Coding layout for page login`
#### Visual studio code Extensions
- GitLens
- EditorConfig
- vscode-icon
- Spring Boot Tools
- Spring Initializer Java Support
- Language Support for Java(TM) by Red Hat
- Debugger for Java
- Extension Pack for Java