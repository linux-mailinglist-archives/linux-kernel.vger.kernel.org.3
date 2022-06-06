Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428D453E6F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiFFP1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiFFPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EA71CD344;
        Mon,  6 Jun 2022 08:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE306152A;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FD3C341C8;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=TK27ZksS59czNCTJuBqs/Ki0RFxKcxiZ2+25z7n1bNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbPt1/HBBBLqQgrL+OMpzyBN18Q0aNTof/1pP6EaxyGzSsKl0mBYjwJO0+yDQ2NUY
         q3W3bHVkmnGiZQXwcPOFZRApswpwitZVZKqHOKoqMLDgz0V9CdtOSf2gIg9TuDq9Gz
         WnLKnmu1+zRn9tUAVGNonANOT0VQdn/bBB+4/st002Zk9T8Ogd8OUrWJ9p2tPSNuss
         wscVxDkhmd2X4J6JxKOvzhAlfDHezVYIJ6RD8cLR/y5zykToxtvX/f1BcN7KuofXdE
         ezYv7mdlcophDVDsHkA4XBfi8Hr8hRX8Q2iWpXlh8kP1gJQX6aO925YJvAT7yV45Ox
         47bZ+uPGRn+UA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012PF-73;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Xu <peterx@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/23] Documentation: update watch_queue.rst references
Date:   Mon,  6 Jun 2022 16:25:31 +0100
Message-Id: <6fc832114fac77b56b9e47aa300654bf30cc0fad.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

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
index c984afc489de..c84ceb2b2b9f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -414,7 +414,7 @@ config WATCH_QUEUE
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

