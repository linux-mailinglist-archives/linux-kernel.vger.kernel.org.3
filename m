Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F358FF17
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiHKPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiHKPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:17:12 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8036C77E;
        Thu, 11 Aug 2022 08:17:10 -0700 (PDT)
X-QQ-mid: bizesmtp73t1660231024tdqmp302
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:16:58 +0800 (CST)
X-QQ-SSF: 0100000000200060B000B00A0000000
X-QQ-FEAT: DQ0OCu3gog2eOmEpaf8QGin20v4gGmEUz8olgI0mRAcxGwAu/n33q7qhY8LYE
        mGHAhMudK1Cwv8TASQaE06DNPHIWLJXytsEOoiY2exfwCq9xy+yHn75uqQSI0BEHGM/LfpT
        7pAh/wbprPEkv3sqsqgjwZUIby6lHyUmphLfqucOMqJeepxhufKYepJZ8EHfVKan6Ry9YJz
        w4eIitePaoHIoRFG3f17lWQ5+aFJnP1c3jA+7y8CKRszS+NjH4r5MRbGlWUWz0Se9vbAoJS
        KlxtGTHu1N421cFunxKyoOIDzcBka2rfw5niLWT63ASsbaQ2lr4YDkPGShSJUXGsOB2/fkg
        j6rsf5/uq+GFdiAzIyR5IrmJs9hfcUiXNV16pCTP6sTxnzBopaKsIznzwWf/8W8MCIN9Ftw
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     fancer.lancer@gmail.com, tglx@linutronix.de, maz@kernel.org
Cc:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] irqchip/mips-gic: Fix typo in irq-mips-gic.c
Date:   Thu, 11 Aug 2022 11:16:57 -0400
Message-Id: <20220811151657.10242-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rebundant word "the" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..53daac318ccd 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -490,7 +490,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
 	/*
-	 * If adding support for more per-cpu interrupts, keep the the
+	 * If adding support for more per-cpu interrupts, keep the
 	 * array in gic_all_vpes_irq_cpu_online() in sync.
 	 */
 	switch (intr) {
-- 
2.35.1

