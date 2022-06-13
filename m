Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8D547F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 08:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiFMGCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiFMGCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:02:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D6718B03;
        Sun, 12 Jun 2022 23:02:31 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LM1F20g3Zz9t84;
        Mon, 13 Jun 2022 08:02:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UO-KPle3HrFb; Mon, 13 Jun 2022 08:02:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LM1F13NcPz9t6t;
        Mon, 13 Jun 2022 08:02:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66A468B767;
        Mon, 13 Jun 2022 08:02:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8hyBN8EFX1NR; Mon, 13 Jun 2022 08:02:29 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49AAB8B764;
        Mon, 13 Jun 2022 08:02:29 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25D62Hue114106
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 08:02:20 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25D6293B114103;
        Mon, 13 Jun 2022 08:02:09 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] module: Increase readability of module_kallsyms_lookup_name()
Date:   Mon, 13 Jun 2022 08:02:02 +0200
Message-Id: <133321ea63ceb4cdd83346e068d1d16b676678f8.1655100096.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <f15dcfd75e064f80eeb75c9baf9e881196039db7.1655100096.git.christophe.leroy@csgroup.eu>
References: <f15dcfd75e064f80eeb75c9baf9e881196039db7.1655100096.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655100120; l=2069; s=20211009; h=from:subject:message-id; bh=UfRo/pGq3a9kCG9vy69xGUCYVC9crc9vfJMw2h/1Hsw=; b=8+EDxn3dcsTW46QRsIl17/VAh4TbNSqjKp2Xo1sHblUJ4vPsU/hO7wEnRckSofHcwZoE8pb5c/C2 3zm7vCo2CN8Sp009iQlwb03OC0LANiFKD78sz6ZenbSad/+iTso0
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

module_kallsyms_lookup_name() has several exit conditions but
can't return immediately due to preempt_disable().

Refactor module_kallsyms_lookup_name() to allow returning from
anywhere, and reduce depth.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/kallsyms.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index fe3636bde605..df0150c467d4 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -448,29 +448,39 @@ unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
 	return 0;
 }
 
-/* Look for this name: can be of form module:name. */
-unsigned long module_kallsyms_lookup_name(const char *name)
+static unsigned long __module_kallsyms_lookup_name(const char *name)
 {
 	struct module *mod;
 	char *colon;
-	unsigned long ret = 0;
 
-	/* Don't lock: we're in enough trouble already. */
-	preempt_disable();
 	colon = strnchr(name, MODULE_NAME_LEN, ':');
 	if (colon) {
 		mod = find_module_all(name, colon - name, false);
 		if (mod)
-			ret = find_kallsyms_symbol_value(mod, colon + 1);
-	} else {
-		list_for_each_entry_rcu(mod, &modules, list) {
-			if (mod->state == MODULE_STATE_UNFORMED)
-				continue;
-			ret = find_kallsyms_symbol_value(mod, name);
-			if (ret)
-				break;
-		}
+			return find_kallsyms_symbol_value(mod, colon + 1);
+		return 0;
 	}
+
+	list_for_each_entry_rcu(mod, &modules, list) {
+		unsigned long ret;
+
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		ret = find_kallsyms_symbol_value(mod, name);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/* Look for this name: can be of form module:name. */
+unsigned long module_kallsyms_lookup_name(const char *name)
+{
+	unsigned long ret;
+
+	/* Don't lock: we're in enough trouble already. */
+	preempt_disable();
+	ret = __module_kallsyms_lookup_name(name);
 	preempt_enable();
 	return ret;
 }
-- 
2.35.3

