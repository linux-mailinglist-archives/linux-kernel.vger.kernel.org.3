Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A93A557774
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiFWKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFWKJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:09:04 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961D47066
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:09:02 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LTGDr5885z9t7p;
        Thu, 23 Jun 2022 12:09:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vntViZZ-_Zqc; Thu, 23 Jun 2022 12:09:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LTGDq4HsQz9t7Z;
        Thu, 23 Jun 2022 12:08:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8446B8B786;
        Thu, 23 Jun 2022 12:08:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id K2dNwoA-VKlO; Thu, 23 Jun 2022 12:08:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.34])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A9D68B763;
        Thu, 23 Jun 2022 12:08:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25NA8ivA1209344
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 23 Jun 2022 12:08:44 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25NA8ggc1209341;
        Thu, 23 Jun 2022 12:08:42 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] powerpc/powermac: Remove empty function note_scsi_host()
Date:   Thu, 23 Jun 2022 12:08:36 +0200
Message-Id: <26f8b72a4276c0bd8ed63860c7316f6361c351b4.1655978907.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655978915; l=2083; s=20211009; h=from:subject:message-id; bh=PdnNcP7zieVTyswgbCfJHTxp8O+UOgulPpTHBsScjg0=; b=vUQkW6U5O2rm42ZnOAxvu0c7tzgjshQbKHb0OWQFayobFQkndBCQhqYuFHiE+mY7rP+PGfGmxrNn 8OGjcF0GBuOstmuGAYhjG2Zl8ggAEPw12EshB0V168Tk03o+BK89
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

note_scsi_host() has been an empty function since
commit 6ee0d9f744d4 ("[POWERPC] Remove unused old code
from powermac setup code").

Remove it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/setup.h        | 1 -
 arch/powerpc/platforms/powermac/setup.c | 7 -------
 drivers/scsi/mesh.c                     | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8fa37ef5da4d..07b487896c27 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -12,7 +12,6 @@ extern unsigned long long memory_limit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 struct device_node;
-extern void note_scsi_host(struct device_node *, void *);
 
 /* Used in very early kernel initialization. */
 extern unsigned long reloc_offset(void);
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index f71735ec449f..04daa7f0a03c 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -320,13 +320,6 @@ static void __init pmac_setup_arch(void)
 #endif /* CONFIG_ADB */
 }
 
-#ifdef CONFIG_SCSI
-void note_scsi_host(struct device_node *node, void *host)
-{
-}
-EXPORT_SYMBOL(note_scsi_host);
-#endif
-
 static int initializing = 1;
 
 static int pmac_late_init(void)
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 322d3ad38159..1f8e240592a9 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1882,11 +1882,6 @@ static int mesh_probe(struct macio_dev *mdev, const struct of_device_id *match)
 		goto out_release;
 	}
 	
-	/* Old junk for root discovery, that will die ultimately */
-#if !defined(MODULE)
-       	note_scsi_host(mesh, mesh_host);
-#endif
-
 	mesh_host->base = macio_resource_start(mdev, 0);
 	mesh_host->irq = macio_irq(mdev, 0);
        	ms = (struct mesh_state *) mesh_host->hostdata;
-- 
2.36.1

