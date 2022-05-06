Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40451DCD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443351AbiEFQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443371AbiEFQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:07:45 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E0D6D966
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:03:54 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNT2zcFzMqbNS;
        Fri,  6 May 2022 18:03:53 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNT1BmTzlhSMs;
        Fri,  6 May 2022 18:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853033;
        bh=OofRTyvM3LKuw3LgNesb3ydAcvE5fSAVeJjKzwo64Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpqFBo57jh1eaoQCyxc85DH9onQtXwLHiyPEl/L4kQvS1Qxesa9bmLAqfzIh2BDbf
         5g3Eu5n1eWg05+4Z328/hex+bpLKm+ogGc7mj4h9InxrrbHVwHssFrjs1kTtrrEXrU
         uHkpNfhBO9iw5norFqYLitsohef9ShpcuP59H9Mk=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 7/7] samples/landlock: Format with clang-format
Date:   Fri,  6 May 2022 18:05:13 +0200
Message-Id: <20220506160513.523257-8-mic@digikod.net>
In-Reply-To: <20220506160513.523257-1-mic@digikod.net>
References: <20220506160513.523257-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's follow a consistent and documented coding style.  Everything may
not be to our liking but it is better than tacit knowledge.  Moreover,
this will help maintain style consistency between different developers.

This contains only whitespace changes.

Automatically formatted with:
clang-format-14 -i samples/landlock/*.[ch]

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-8-mic@digikod.net
---
 samples/landlock/sandboxer.c | 96 +++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 5ce961b5bda7..c089e9cdaf32 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -22,9 +22,9 @@
 #include <unistd.h>
 
 #ifndef landlock_create_ruleset
-static inline int landlock_create_ruleset(
-		const struct landlock_ruleset_attr *const attr,
-		const size_t size, const __u32 flags)
+static inline int
+landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
+			const size_t size, const __u32 flags)
 {
 	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
 }
@@ -32,17 +32,18 @@ static inline int landlock_create_ruleset(
 
 #ifndef landlock_add_rule
 static inline int landlock_add_rule(const int ruleset_fd,
-		const enum landlock_rule_type rule_type,
-		const void *const rule_attr, const __u32 flags)
+				    const enum landlock_rule_type rule_type,
+				    const void *const rule_attr,
+				    const __u32 flags)
 {
-	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type,
-			rule_attr, flags);
+	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_attr,
+		       flags);
 }
 #endif
 
 #ifndef landlock_restrict_self
 static inline int landlock_restrict_self(const int ruleset_fd,
-		const __u32 flags)
+					 const __u32 flags)
 {
 	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
 }
@@ -79,9 +80,8 @@ static int parse_path(char *env_path, const char ***const path_list)
 
 /* clang-format on */
 
-static int populate_ruleset(
-		const char *const env_var, const int ruleset_fd,
-		const __u64 allowed_access)
+static int populate_ruleset(const char *const env_var, const int ruleset_fd,
+			    const __u64 allowed_access)
 {
 	int num_paths, i, ret = 1;
 	char *env_path_name;
@@ -111,12 +111,10 @@ static int populate_ruleset(
 	for (i = 0; i < num_paths; i++) {
 		struct stat statbuf;
 
-		path_beneath.parent_fd = open(path_list[i], O_PATH |
-				O_CLOEXEC);
+		path_beneath.parent_fd = open(path_list[i], O_PATH | O_CLOEXEC);
 		if (path_beneath.parent_fd < 0) {
 			fprintf(stderr, "Failed to open \"%s\": %s\n",
-					path_list[i],
-					strerror(errno));
+				path_list[i], strerror(errno));
 			goto out_free_name;
 		}
 		if (fstat(path_beneath.parent_fd, &statbuf)) {
@@ -127,9 +125,10 @@ static int populate_ruleset(
 		if (!S_ISDIR(statbuf.st_mode))
 			path_beneath.allowed_access &= ACCESS_FILE;
 		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-					&path_beneath, 0)) {
-			fprintf(stderr, "Failed to update the ruleset with \"%s\": %s\n",
-					path_list[i], strerror(errno));
+				      &path_beneath, 0)) {
+			fprintf(stderr,
+				"Failed to update the ruleset with \"%s\": %s\n",
+				path_list[i], strerror(errno));
 			close(path_beneath.parent_fd);
 			goto out_free_name;
 		}
@@ -171,55 +170,64 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	int ruleset_fd;
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = ACCESS_FS_ROUGHLY_READ |
-			ACCESS_FS_ROUGHLY_WRITE,
+				     ACCESS_FS_ROUGHLY_WRITE,
 	};
 
 	if (argc < 2) {
-		fprintf(stderr, "usage: %s=\"...\" %s=\"...\" %s <cmd> [args]...\n\n",
-				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
-		fprintf(stderr, "Launch a command in a restricted environment.\n\n");
+		fprintf(stderr,
+			"usage: %s=\"...\" %s=\"...\" %s <cmd> [args]...\n\n",
+			ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		fprintf(stderr,
+			"Launch a command in a restricted environment.\n\n");
 		fprintf(stderr, "Environment variables containing paths, "
 				"each separated by a colon:\n");
-		fprintf(stderr, "* %s: list of paths allowed to be used in a read-only way.\n",
-				ENV_FS_RO_NAME);
-		fprintf(stderr, "* %s: list of paths allowed to be used in a read-write way.\n",
-				ENV_FS_RW_NAME);
-		fprintf(stderr, "\nexample:\n"
-				"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
-				"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
-				"%s bash -i\n",
-				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
+		fprintf(stderr,
+			"* %s: list of paths allowed to be used in a read-only way.\n",
+			ENV_FS_RO_NAME);
+		fprintf(stderr,
+			"* %s: list of paths allowed to be used in a read-write way.\n",
+			ENV_FS_RW_NAME);
+		fprintf(stderr,
+			"\nexample:\n"
+			"%s=\"/bin:/lib:/usr:/proc:/etc:/dev/urandom\" "
+			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
+			"%s bash -i\n",
+			ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
 		return 1;
 	}
 
-	ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
 		const int err = errno;
 
 		perror("Failed to create a ruleset");
 		switch (err) {
 		case ENOSYS:
-			fprintf(stderr, "Hint: Landlock is not supported by the current kernel. "
-					"To support it, build the kernel with "
-					"CONFIG_SECURITY_LANDLOCK=y and prepend "
-					"\"landlock,\" to the content of CONFIG_LSM.\n");
+			fprintf(stderr,
+				"Hint: Landlock is not supported by the current kernel. "
+				"To support it, build the kernel with "
+				"CONFIG_SECURITY_LANDLOCK=y and prepend "
+				"\"landlock,\" to the content of CONFIG_LSM.\n");
 			break;
 		case EOPNOTSUPP:
-			fprintf(stderr, "Hint: Landlock is currently disabled. "
-					"It can be enabled in the kernel configuration by "
-					"prepending \"landlock,\" to the content of CONFIG_LSM, "
-					"or at boot time by setting the same content to the "
-					"\"lsm\" kernel parameter.\n");
+			fprintf(stderr,
+				"Hint: Landlock is currently disabled. "
+				"It can be enabled in the kernel configuration by "
+				"prepending \"landlock,\" to the content of CONFIG_LSM, "
+				"or at boot time by setting the same content to the "
+				"\"lsm\" kernel parameter.\n");
 			break;
 		}
 		return 1;
 	}
 	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd,
-				ACCESS_FS_ROUGHLY_READ)) {
+			     ACCESS_FS_ROUGHLY_READ)) {
 		goto err_close_ruleset;
 	}
 	if (populate_ruleset(ENV_FS_RW_NAME, ruleset_fd,
-				ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE)) {
+			     ACCESS_FS_ROUGHLY_READ |
+				     ACCESS_FS_ROUGHLY_WRITE)) {
 		goto err_close_ruleset;
 	}
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
@@ -236,7 +244,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	cmd_argv = argv + 1;
 	execvpe(cmd_path, cmd_argv, envp);
 	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
-			strerror(errno));
+		strerror(errno));
 	fprintf(stderr, "Hint: access to the binary, the interpreter or "
 			"shared libraries may be denied.\n");
 	return 1;
-- 
2.35.1

