Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6E04F005B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354249AbiDBKMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiDBKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:12:42 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE80F844C;
        Sat,  2 Apr 2022 03:10:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KVt8n6rH7z9sSZ;
        Sat,  2 Apr 2022 12:10:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 20Fhx-RxuPP7; Sat,  2 Apr 2022 12:10:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KVt8n66cPz9sSY;
        Sat,  2 Apr 2022 12:10:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF3FE8B76D;
        Sat,  2 Apr 2022 12:10:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YuNuEq1a1R6G; Sat,  2 Apr 2022 12:10:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.136])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 871108B768;
        Sat,  2 Apr 2022 12:10:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 232AAc91684445
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 2 Apr 2022 12:10:38 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 232AAbca684444;
        Sat, 2 Apr 2022 12:10:37 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH net-next] orinoco: Prepare cleanup of powerpc's asm/prom.h
Date:   Sat,  2 Apr 2022 12:10:37 +0200
Message-Id: <4e3bfd4ffe2ed6b713ddd99b69dcc3d96adffe34.1648833427.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648894236; l=776; s=20211009; h=from:subject:message-id; bh=LdsmQKRPWEAAysoEp626OYVhNdJsmIfAeo8UCt9F5iM=; b=XCKWKe6R8LkQNYpXOBP5ovlzq5x5SUs9hqmnP7T1mCg+sZ9tUfLXJ2abcHGM3WzMR9o32Uy4dSgN TqoFkItbAbOEJzzAAY8foJxaNe2LnTRq3V4oSUMjm0cKzbxy1eT2
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

powerpc's asm/prom.h brings some headers that it doesn't
need itself.

In order to clean it up, first add missing headers in
users of asm/prom.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/net/wireless/intersil/orinoco/airport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intersil/orinoco/airport.c b/drivers/net/wireless/intersil/orinoco/airport.c
index 77e6c53040a3..a890bfa0d5cc 100644
--- a/drivers/net/wireless/intersil/orinoco/airport.c
+++ b/drivers/net/wireless/intersil/orinoco/airport.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/of_device.h>
 #include <asm/pmac_feature.h>
 
 #include "orinoco.h"
-- 
2.35.1

