Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C6655B0A3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiFZJLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiFZJLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F42512A97;
        Sun, 26 Jun 2022 02:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ECF061189;
        Sun, 26 Jun 2022 09:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB272C341CC;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234670;
        bh=af2SSDCTRDB1nLLjwJFcl/yfjpMMlXOIiMN95A3g9/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9NGGlGXRKcYJ6iguEHa9UrCiHGI3hJZT3hZZsVl6kzLJS4fEMFtLHFN40x6w/EM3
         FrNOkxunmh5MS8KXpc5p6g3HwUTarxEoHBEZ2HDOjWj9sLhLTHd5wF4ezoBot2Mz1C
         FyblBAIhlJEjlixsQ8nDYKjetSZkiv+dVzL8+29uVroyvs+mXfZc8lvvGdafoX8fC+
         ln57WTtLdaiaAmO9HxFosAb0nxb4DDxxtOqMerT2p5bKOE2iJZfpxi34c3p/XgVMyX
         9sjOXCheC603XRMXTwGTswYERl2JRpEbVBArn0Cx2UEvYpee2+F36nfPZrK1BdvuW2
         cAbX4To8fklFw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIO-001coe-1R;
        Sun, 26 Jun 2022 10:11:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Oliver Glitta <glittao@gmail.com>,
        Peter Xu <peterx@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/20] Documentation: update watch_queue.rst references
Date:   Sun, 26 Jun 2022 10:10:56 +0100
Message-Id: <1c220de9c58f35e815a3df9458ac2bea323c8bfb.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset f5461124d59b ("Documentation: move watch_queue to core-api")
renamed: Documentation/watch_queue.rst
to: Documentation/core-api/watch_queue.rst.

Update the cross-references accordingly.

Fixes: f5461124d59b ("Documentation: move watch_queue to core-api")
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/security/keys/core.rst | 2 +-
 include/linux/watch_queue.h          | 2 +-
 init/Kconfig                         | 2 +-
 kernel/watch_queue.c                 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index b3ed5c581034..811b905b56bf 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1046,7 +1046,7 @@ The keyctl syscall functions are:
      "filter" is either NULL to remove a watch or a filter specification to
      indicate what events are required from the key.
 
-     See Documentation/watch_queue.rst for more information.
+     See Documentation/core-api/watch_queue.rst for more information.
 
      Note that only one watch may be emplaced for any particular { key,
      queue_fd } combination.
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 3b9a40ae8bdb..fc6bba20273b 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -4,7 +4,7 @@
  * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * See Documentation/watch_queue.rst
+ * See Documentation/core-api/watch_queue.rst
  */
 
 #ifndef _LINUX_WATCH_QUEUE_H
diff --git a/init/Kconfig b/init/Kconfig
index ac8088850bdd..4dd1ee7358a3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -432,7 +432,7 @@ config WATCH_QUEUE
 	  with watches for key/keyring change notifications and device
 	  notifications.
 
-	  See Documentation/watch_queue.rst
+	  See Documentation/core-api/watch_queue.rst
 
 config CROSS_MEMORY_ATTACH
 	bool "Enable process_vm_readv/writev syscalls"
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 230038d4f908..869fea4fe26b 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
- * See Documentation/watch_queue.rst
+ * See Documentation/core-api/watch_queue.rst
  */
 
 #define pr_fmt(fmt) "watchq: " fmt
-- 
2.36.1

