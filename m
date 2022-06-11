Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7354769A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiFKQvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiFKQvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:51:36 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7302644C7;
        Sat, 11 Jun 2022 09:51:35 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LL3kn4DpVz9tPh;
        Sat, 11 Jun 2022 18:51:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fZmSyoeufRsD; Sat, 11 Jun 2022 18:51:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LL3kl4bbKz9tS8;
        Sat, 11 Jun 2022 18:51:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BF088B786;
        Sat, 11 Jun 2022 18:51:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6RyqmtK_anYO; Sat, 11 Jun 2022 18:51:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.192])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F12838B768;
        Sat, 11 Jun 2022 18:51:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25BGpDEV741168
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Jun 2022 18:51:13 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25BGpAHU741166;
        Sat, 11 Jun 2022 18:51:10 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, deller@gmx.de,
        manoj@linux.ibm.com, mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, tzimmermann@suse.de
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/4] video: fbdev: offb: Include missing linux/platform_device.h
Date:   Sat, 11 Jun 2022 18:50:57 +0200
Message-Id: <a1dfa936043eeed715e8cda7f8690fe553ba7c1a.1654966253.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654966257; l=957; s=20211009; h=from:subject:message-id; bh=T6NVp7fEwPexn717Nzonz1ep4rzZQtqWxBPTvd3ir20=; b=Oj51NVu8ORXq5WpFgj1HFWg1KgltBKUwV8TCjR1ehJhxCUxXTBe1gtpInYtR0Th3lqzwdicwP4FU pzaDMvbHDHuQYQD0rbuSc07vqQBQfDmAKQgKPESOa6llFiN5EDmQ
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

A lot of drivers were getting platform and of headers
indirectly via headers like asm/pci.h or asm/prom.h

Most of them were fixed during 5.19 cycle but a newissue was
introduced by commit 52b1b46c39ae ("of: Create platform devices
for OF framebuffers")

Include missing platform_device.h to allow cleaning asm/pci.h

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/video/fbdev/offb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index b1acb1ebebe9..91001990e351 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -26,6 +26,7 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
 
 #ifdef CONFIG_PPC32
-- 
2.35.3

