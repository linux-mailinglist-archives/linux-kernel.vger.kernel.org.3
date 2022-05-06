Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C1151DCD9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbiEFQIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443354AbiEFQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:07:37 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B46D95C;
        Fri,  6 May 2022 09:03:52 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNQ4mGTzMqNVS;
        Fri,  6 May 2022 18:03:50 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNQ2st6zlhSMs;
        Fri,  6 May 2022 18:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853030;
        bh=AMts2j4j9H2jG/4yc8/Ah/p5IdZWST0LDCcHoK5s8hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fta0H0mcBM/s/F63xPcvjzGmP3iwfzYTv4/6a+pkG8zLAhiduZn2vcYGqTBLACm+I
         Mn2p3pCWpiGcE5s3bFVSq5mqennJL0GKHa0RBueY82htZS0oA28CfygfTtsc6Ugttp
         zzOaGodC8n0LbqjpCvbWwpOWpLU5uZ9e2UkfFS4A=
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
Subject: [PATCH v1 3/7] selftests/landlock: Add clang-format exceptions
Date:   Fri,  6 May 2022 18:05:09 +0200
Message-Id: <20220506160513.523257-4-mic@digikod.net>
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

In preparation to a following commit, add clang-format on and
clang-format off stanzas around constant definitions and the TEST_F_FORK
macro.  This enables to keep aligned values, which is much more readable
than packed definitions.

Add other clang-format exceptions for FIXTURE() and
FIXTURE_VARIANT_ADD() declarations to force space before open brace,
which is reported by checkpatch.pl .

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-4-mic@digikod.net
---
 tools/testing/selftests/landlock/common.h     |  2 ++
 tools/testing/selftests/landlock/fs_test.c    | 23 ++++++++++++++-----
 .../testing/selftests/landlock/ptrace_test.c  | 20 +++++++++++++++-
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 183b7e8e1b95..435ba6963756 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -25,6 +25,7 @@
  * this to be possible, we must not call abort() but instead exit smoothly
  * (hence the step print).
  */
+/* clang-format off */
 #define TEST_F_FORK(fixture_name, test_name) \
 	static void fixture_name##_##test_name##_child( \
 		struct __test_metadata *_metadata, \
@@ -71,6 +72,7 @@
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
 			__attribute__((unused)) *variant)
+/* clang-format on */
 
 #ifndef landlock_create_ruleset
 static inline int landlock_create_ruleset(
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 10c9a1e4ebd9..aef2eb3d07cd 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -221,8 +221,9 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(dir_s3d2));
 }
 
-FIXTURE(layout1) {
-};
+/* clang-format off */
+FIXTURE(layout1) {};
+/* clang-format on */
 
 FIXTURE_SETUP(layout1)
 {
@@ -376,6 +377,8 @@ TEST_F_FORK(layout1, inval)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+/* clang-format off */
+
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
@@ -396,6 +399,8 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	ACCESS_LAST)
 
+/* clang-format on */
+
 TEST_F_FORK(layout1, file_access_rights)
 {
 	__u64 access;
@@ -452,6 +457,8 @@ struct rule {
 	__u64 access;
 };
 
+/* clang-format off */
+
 #define ACCESS_RO ( \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
 	LANDLOCK_ACCESS_FS_READ_DIR)
@@ -460,6 +467,8 @@ struct rule {
 	ACCESS_RO | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE)
 
+/* clang-format on */
+
 static int create_ruleset(struct __test_metadata *const _metadata,
 		const __u64 handled_access_fs, const struct rule rules[])
 {
@@ -2070,8 +2079,9 @@ TEST_F_FORK(layout1, proc_pipe)
 	ASSERT_EQ(0, close(pipe_fds[1]));
 }
 
-FIXTURE(layout1_bind) {
-};
+/* clang-format off */
+FIXTURE(layout1_bind) {};
+/* clang-format on */
 
 FIXTURE_SETUP(layout1_bind)
 {
@@ -2411,8 +2421,9 @@ static const char (*merge_sub_files[])[] = {
  *         └── work
  */
 
-FIXTURE(layout2_overlay) {
-};
+/* clang-format off */
+FIXTURE(layout2_overlay) {};
+/* clang-format on */
 
 FIXTURE_SETUP(layout2_overlay)
 {
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 15fbef9cc849..090adadfe2dc 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -59,7 +59,9 @@ static int test_ptrace_read(const pid_t pid)
 	return 0;
 }
 
-FIXTURE(hierarchy) { };
+/* clang-format off */
+FIXTURE(hierarchy) {};
+/* clang-format on */
 
 FIXTURE_VARIANT(hierarchy) {
 	const bool domain_both;
@@ -83,7 +85,9 @@ FIXTURE_VARIANT(hierarchy) {
  *       \              P2 -> P1 : allow
  *        'P2
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
+	/* clang-format on */
 	.domain_both = false,
 	.domain_parent = false,
 	.domain_child = false,
@@ -98,7 +102,9 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
  *        |  P2  |
  *        '------'
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
+	/* clang-format on */
 	.domain_both = false,
 	.domain_parent = false,
 	.domain_child = true,
@@ -112,7 +118,9 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
  *            '
  *            P2
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
+	/* clang-format on */
 	.domain_both = false,
 	.domain_parent = true,
 	.domain_child = false,
@@ -127,7 +135,9 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
  *         |  P2  |
  *         '------'
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
+	/* clang-format on */
 	.domain_both = false,
 	.domain_parent = true,
 	.domain_child = true,
@@ -142,7 +152,9 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
  * |         P2  |
  * '-------------'
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
+	/* clang-format on */
 	.domain_both = true,
 	.domain_parent = false,
 	.domain_child = false,
@@ -158,7 +170,9 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
  * |        '------' |
  * '-----------------'
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
+	/* clang-format on */
 	.domain_both = true,
 	.domain_parent = false,
 	.domain_child = true,
@@ -174,7 +188,9 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
  * |             P2  |
  * '-----------------'
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
+	/* clang-format on */
 	.domain_both = true,
 	.domain_parent = true,
 	.domain_child = false,
@@ -192,7 +208,9 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
  * |        '------' |
  * '-----------------'
  */
+/* clang-format off */
 FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
+	/* clang-format on */
 	.domain_both = true,
 	.domain_parent = true,
 	.domain_child = true,
-- 
2.35.1

