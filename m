Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0204BF638
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiBVKkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiBVKkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:40:05 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4115AF07;
        Tue, 22 Feb 2022 02:39:40 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wdk73wSz9sT7;
        Tue, 22 Feb 2022 11:39:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3VRYSKs3UUlZ; Tue, 22 Feb 2022 11:39:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wdc05MSz9sT8;
        Tue, 22 Feb 2022 11:39:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E754B8B778;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pQyDMfN9EdHD; Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A462B8B776;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MAd7Sc1076226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:39:07 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MAd7TE1076225;
        Tue, 22 Feb 2022 11:39:07 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] module: Rename debug_align() as strict_align()
Date:   Tue, 22 Feb 2022 11:39:00 +0100
Message-Id: <d8ee36c58284baf315e8aa3532a8d97abae8026d.1645526008.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645526008.git.christophe.leroy@csgroup.eu>
References: <cover.1645526008.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645526317; l=4185; s=20211009; h=from:subject:message-id; bh=0qZWa23U1bz9DrTNyd0D7ysxbN+QdZvyKcOSMofY7EE=; b=9+JhamhOvNqqAcKvvuoYpzDhKjAsjo8lr6WfQqxyUPitOQZW3TIafhrbz5IV4SVFgEJKGG8L/d3Z 2Qf+URrRAoc+Ze0F23mCcygJFGVhtf/wtmcc08cdIsjefEnrkbEJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debug_align() was added by commit 84e1c6bb38eb ("x86: Add RO/NX
protection for loadable kernel modules")

At that time the config item was CONFIG_DEBUG_SET_MODULE_RONX.

But nowadays it has changed to CONFIG_STRICT_MODULE_RWX and
debug_align() is confusing because it has nothing to do with
DEBUG.

Rename it strict_align()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/internal.h |  4 ++--
 kernel/module/kallsyms.c |  4 ++--
 kernel/module/main.c     | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 32add08e7895..c66f9da3e03d 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -30,9 +30,9 @@
  * only when CONFIG_STRICT_MODULE_RWX=y
  */
 #ifdef CONFIG_STRICT_MODULE_RWX
-# define debug_align(X) PAGE_ALIGN(X)
+# define strict_align(X) PAGE_ALIGN(X)
 #else
-# define debug_align(X) (X)
+# define strict_align(X) (X)
 #endif
 
 extern struct mutex module_mutex;
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index fe6723c040be..523a6ed8886b 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -139,7 +139,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	mod->data_layout.size += strtab_size;
 	info->core_typeoffs = mod->data_layout.size;
 	mod->data_layout.size += ndst * sizeof(char);
-	mod->data_layout.size = debug_align(mod->data_layout.size);
+	mod->data_layout.size = strict_align(mod->data_layout.size);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
@@ -154,7 +154,7 @@ void layout_symtab(struct module *mod, struct load_info *info)
 	mod->init_layout.size += sizeof(struct mod_kallsyms);
 	info->init_typeoffs = mod->init_layout.size;
 	mod->init_layout.size += nsrc * sizeof(char);
-	mod->init_layout.size = debug_align(mod->init_layout.size);
+	mod->init_layout.size = strict_align(mod->init_layout.size);
 }
 
 /*
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4876e2beb5b6..ce0ef17662c9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1470,19 +1470,19 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 		switch (m) {
 		case 0: /* executable */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->core_layout.size = strict_align(mod->core_layout.size);
 			mod->core_layout.text_size = mod->core_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.size = strict_align(mod->data_layout.size);
 			mod->data_layout.ro_size = mod->data_layout.size;
 			break;
 		case 2: /* RO after init */
-			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.size = strict_align(mod->data_layout.size);
 			mod->data_layout.ro_after_init_size = mod->data_layout.size;
 			break;
 		case 4: /* whole core */
-			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.size = strict_align(mod->data_layout.size);
 			break;
 		}
 	}
@@ -1504,11 +1504,11 @@ static void layout_sections(struct module *mod, struct load_info *info)
 		}
 		switch (m) {
 		case 0: /* executable */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = strict_align(mod->init_layout.size);
 			mod->init_layout.text_size = mod->init_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = strict_align(mod->init_layout.size);
 			mod->init_layout.ro_size = mod->init_layout.size;
 			break;
 		case 2:
@@ -1519,7 +1519,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			mod->init_layout.ro_after_init_size = mod->init_layout.ro_size;
 			break;
 		case 4: /* whole init */
-			mod->init_layout.size = debug_align(mod->init_layout.size);
+			mod->init_layout.size = strict_align(mod->init_layout.size);
 			break;
 		}
 	}
-- 
2.34.1

