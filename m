Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0377E56A557
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiGGO1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiGGO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:27:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91482B256
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:27:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LdzJj2k5kz9tGl;
        Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lIQkD5xcE8ZG; Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LdzJj227gz9tGb;
        Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 342598B7A0;
        Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0l7yik7sNIjV; Thu,  7 Jul 2022 16:27:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F02258B768;
        Thu,  7 Jul 2022 16:27:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 267ERNJ1537817
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 16:27:23 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 267ERN5e537814;
        Thu, 7 Jul 2022 16:27:23 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] scsi: cxlflash: Include missing linux/irqdomain.h
Date:   Thu,  7 Jul 2022 16:27:02 +0200
Message-Id: <8359b1bc3a41248774bbf4315e16ee976253da71.1657204012.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <d107b9ed8b4ba5d10d1df7ba6317c36d07f2317e.1657204012.git.christophe.leroy@csgroup.eu>
References: <d107b9ed8b4ba5d10d1df7ba6317c36d07f2317e.1657204012.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657204023; l=1730; s=20211009; h=from:subject:message-id; bh=48X8ZLFinvI6xSHRLAcSqxxzVN1Ahbtv4N3knADh6qU=; b=eAJvsyerAvje7AiQN3MCv3NhddrpdB0+VxBxgWYhX3bfnJOTilfqQ2AmmyKkDdTBGUyzAESYIeZm W4LZVpnRA/nwuefIZACIQDVyMv1hFH0QKqKmccM3lnvAm99QrHoh
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

powerpc's asm/prom.h brings some headers that it doesn't need itself.

Once those headers are removed from asm/prom.h, the following
errors occur:

  CC [M]  drivers/scsi/cxlflash/ocxl_hw.o
drivers/scsi/cxlflash/ocxl_hw.c: In function 'afu_map_irq':
drivers/scsi/cxlflash/ocxl_hw.c:195:16: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
  195 |         virq = irq_create_mapping(NULL, irq->hwirq);
      |                ^~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/ocxl_hw.c:222:9: error: implicit declaration of function 'irq_dispose_mapping' [-Werror=implicit-function-declaration]
  222 |         irq_dispose_mapping(virq);
      |         ^~~~~~~~~~~~~~~~~~~
drivers/scsi/cxlflash/ocxl_hw.c: In function 'afu_unmap_irq':
drivers/scsi/cxlflash/ocxl_hw.c:264:13: error: implicit declaration of function 'irq_find_mapping'; did you mean 'is_cow_mapping'? [-Werror=implicit-function-declaration]
  264 |         if (irq_find_mapping(NULL, irq->hwirq)) {
      |             ^~~~~~~~~~~~~~~~
      |             is_cow_mapping
cc1: some warnings being treated as errors

Fix it by including linux/irqdomain.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/scsi/cxlflash/ocxl_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 244fc27215dc..631eda2d467e 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -16,6 +16,7 @@
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <asm/xive.h>
 #include <misc/ocxl.h>
 
-- 
2.36.1

