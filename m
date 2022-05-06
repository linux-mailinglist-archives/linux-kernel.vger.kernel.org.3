Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173AD51DCD4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443389AbiEFQHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443362AbiEFQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:07:44 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E967C6D95F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:03:53 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNS5RXBzMqK2B;
        Fri,  6 May 2022 18:03:52 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNS3GG4zljsTZ;
        Fri,  6 May 2022 18:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853032;
        bh=6hAnHaatU+IsGyN1oUOhibXEVpIk8PFeXK1wgedN6G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxXoEevllYRsTJ700k/HQMwRwM2G+Z67GP2/rbRGLLDeq/YBfPbFxoShZj7XMcJuQ
         5+gUP7hLDI3YpcChxOgCerT0q/bO/V4BcKy2k49lDynFLeOR04oqLkTavG2QgTPMVs
         3+usG+gCHlfEoG4DUMlSucLnJo3RV9lX+JL6IZ5c=
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
Subject: [PATCH v1 6/7] samples/landlock: Add clang-format exceptions
Date:   Fri,  6 May 2022 18:05:12 +0200
Message-Id: <20220506160513.523257-7-mic@digikod.net>
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
clang-format off stanzas around constant definitions.  This enables to
keep aligned values, which is much more readable than packed
definitions.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160513.523257-7-mic@digikod.net
---
 samples/landlock/sandboxer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 8859fc193542..5ce961b5bda7 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -70,11 +70,15 @@ static int parse_path(char *env_path, const char ***const path_list)
 	return num_paths;
 }
 
+/* clang-format off */
+
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE)
 
+/* clang-format on */
+
 static int populate_ruleset(
 		const char *const env_var, const int ruleset_fd,
 		const __u64 allowed_access)
@@ -139,6 +143,8 @@ static int populate_ruleset(
 	return ret;
 }
 
+/* clang-format off */
+
 #define ACCESS_FS_ROUGHLY_READ ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
@@ -156,6 +162,8 @@ static int populate_ruleset(
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM)
 
+/* clang-format on */
+
 int main(const int argc, char *const argv[], char *const *const envp)
 {
 	const char *cmd_path;
-- 
2.35.1

