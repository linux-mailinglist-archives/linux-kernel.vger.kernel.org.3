Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B995C547F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiFMGCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiFMGCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:02:25 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DA3BD;
        Sun, 12 Jun 2022 23:02:22 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LM1Dr3xQhz9t6t;
        Mon, 13 Jun 2022 08:02:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RENglcqvxu-k; Mon, 13 Jun 2022 08:02:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LM1Dr2x6Cz9t6l;
        Mon, 13 Jun 2022 08:02:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F83F8B767;
        Mon, 13 Jun 2022 08:02:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4ryYPEiv2I16; Mon, 13 Jun 2022 08:02:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3203D8B764;
        Mon, 13 Jun 2022 08:02:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25D6297c114100
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 08:02:09 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25D629iQ114091;
        Mon, 13 Jun 2022 08:02:09 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] module: Fix ERRORs reported by checkpatch.pl
Date:   Mon, 13 Jun 2022 08:02:01 +0200
Message-Id: <f15dcfd75e064f80eeb75c9baf9e881196039db7.1655100096.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655100120; l=2298; s=20211009; h=from:subject:message-id; bh=uZbj8bc6dmN89ZYgLfM/2xs0A9U117SIFFHv4zihVzA=; b=1cD4huF9TrQbyGEzmw5hJ3wALB3uXOUWL267rxXUtD+S+885vRnr/ROz17jKA0Hk/SrRg1ql0ktm znXqMKqkDcweLYcl1ZX8RQLEvrpaXbUNn+K8uW514sh/zpYvLdyQ
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

Checkpatch reports following errors:

ERROR: do not use assignment in if condition
+	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {

ERROR: do not use assignment in if condition
+		if ((mod = find_module_all(name, colon - name, false)) != NULL)

ERROR: do not use assignment in if condition
+			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)

ERROR: do not initialise globals to 0
+int modules_disabled = 0;

Fix them.

The following one has to remain, because the condition has to be evaluated
multiple times by the macro wait_event_interruptible_timeout().

ERROR: do not use assignment in if condition
+	if (wait_event_interruptible_timeout(module_wq,

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Drop the last change
---
 kernel/module/kallsyms.c | 9 ++++++---
 kernel/module/main.c     | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index 3e11523bc6f6..fe3636bde605 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -457,14 +457,17 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 
 	/* Don't lock: we're in enough trouble already. */
 	preempt_disable();
-	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
-		if ((mod = find_module_all(name, colon - name, false)) != NULL)
+	colon = strnchr(name, MODULE_NAME_LEN, ':');
+	if (colon) {
+		mod = find_module_all(name, colon - name, false);
+		if (mod)
 			ret = find_kallsyms_symbol_value(mod, colon + 1);
 	} else {
 		list_for_each_entry_rcu(mod, &modules, list) {
 			if (mod->state == MODULE_STATE_UNFORMED)
 				continue;
-			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)
+			ret = find_kallsyms_symbol_value(mod, name);
+			if (ret)
 				break;
 		}
 	}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 0548151dd933..b37e25676615 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -119,7 +119,7 @@ static void mod_update_bounds(struct module *mod)
 }
 
 /* Block module loading/unloading? */
-int modules_disabled = 0;
+int modules_disabled;
 core_param(nomodule, modules_disabled, bint, 0);
 
 /* Waiting for a module to finish initializing? */
-- 
2.35.3

