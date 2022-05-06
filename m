Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632451DCCC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443360AbiEFQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384445AbiEFQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:07:34 -0400
X-Greylist: delayed 236 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 09:03:51 PDT
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF56D953
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:03:50 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNP2L4HzMqSH2;
        Fri,  6 May 2022 18:03:49 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNP0FRbzlhSM0;
        Fri,  6 May 2022 18:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853029;
        bh=2veP5bWGbu1OB5oKhmId8tqgXWxsbldg5sHbsFv/KbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhiblkshZPT5lJRExjl8Z/rmFEKFtxfvaH75euruVDd8A2Et186cQRHTdkfmpSuZ/
         igcL9jj8q5LDMPC26/OIdGkwoBPYzNXvvjYb5cB80B8zmgSAajAmjWfdF6/Ip/hIMP
         E43NXMpdy0yb3V5DPD4PEk1FHTXvTpYUqxvlPJSo=
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
Subject: [PATCH v1 1/7] landlock: Add clang-format exceptions
Date:   Fri,  6 May 2022 18:05:07 +0200
Message-Id: <20220506160513.523257-2-mic@digikod.net>
In-Reply-To: <20220506160513.523257-1-mic@digikod.net>
References: <20220506160513.523257-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to a following commit, add clang-format on and
clang-format off stanzas around constant definitions.  This enables to
keep aligned values, which is much more readable than packed
definitions.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-2-mic@digikod.net
---
 include/uapi/linux/landlock.h | 4 ++++
 security/landlock/fs.c        | 2 ++
 security/landlock/limits.h    | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b3d952067f59..15c31abb0d76 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -33,7 +33,9 @@ struct landlock_ruleset_attr {
  * - %LANDLOCK_CREATE_RULESET_VERSION: Get the highest supported Landlock ABI
  *   version.
  */
+/* clang-format off */
 #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
+/* clang-format on */
 
 /**
  * enum landlock_rule_type - Landlock rule type
@@ -120,6 +122,7 @@ struct landlock_path_beneath_attr {
  *   :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
+/* clang-format off */
 #define LANDLOCK_ACCESS_FS_EXECUTE			(1ULL << 0)
 #define LANDLOCK_ACCESS_FS_WRITE_FILE			(1ULL << 1)
 #define LANDLOCK_ACCESS_FS_READ_FILE			(1ULL << 2)
@@ -133,5 +136,6 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_FIFO			(1ULL << 10)
 #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
+/* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97b8e421f617..4195a6be60b2 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -141,10 +141,12 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 }
 
 /* All access rights that can be tied to files. */
+/* clang-format off */
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE)
+/* clang-format on */
 
 /*
  * @path: Should have been checked by get_path_from_fd().
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 2a0a1095ee27..a274ae6b5570 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -12,10 +12,14 @@
 #include <linux/limits.h>
 #include <uapi/linux/landlock.h>
 
+/* clang-format off */
+
 #define LANDLOCK_MAX_NUM_LAYERS		64
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
 #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_SYM
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 
+/* clang-format on */
+
 #endif /* _SECURITY_LANDLOCK_LIMITS_H */
-- 
2.35.1

