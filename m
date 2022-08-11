Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CD58FEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbiHKPND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHKPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:13:00 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A980F57
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:12:59 -0700 (PDT)
X-QQ-mid: bizesmtp65t1660230775t5nan1i1
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:12:13 +0800 (CST)
X-QQ-SSF: 0100000000200060B000B00A0000000
X-QQ-FEAT: NNRyD7G6OHgm2RCjDbIQKWsnswC1UXRjY9nQ+7Yf68igFZaxLxuYDZppCEkYg
        J4QVBv+F1icVoRXQkZ1x856PLQTC509ggRuxStkXonMEfrsyafGBnBoW6uYU6kNXi9QEyLI
        Av9vbpFMNQHqr63SY631OVsbdcyPqQgL9FB+QH39RQR25xf0sVnqOp8RDc5N/TKQiqLD3NO
        uQiOqE+MOFKKaduUit27KWC2agZKyQe6Ag1PM65n1/rJM86y+CIR+fVU8WPZ0h4fEYxT6rd
        xMBkk/oU34kDTWLlolwLbWUAq4Tj2tB6zGhlFLe+1e4aX5g++UPBmOWWAsvENgbd8dfc6Zo
        iZ4cIwbdjcvddbi4bDKkInjPF+/mTkV0sYQO4252wKfq17upSye8H6ZCr4sOw==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     talel@amazon.com, tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] irqchip/al-fic: Fix typo in comments
Date:   Thu, 11 Aug 2022 11:12:12 -0400
Message-Id: <20220811151212.8815-1-dengshaomin@cdjrlc.com>
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

Delete the repeated word "to" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/irqchip/irq-al-fic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 886de028a901..8e88a5cbbca2 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -189,7 +189,7 @@ static int al_fic_register(struct device_node *node,
  * @name: name of the fic
  * @parent_irq: interrupt of parent
  *
- * This API will configure the fic hardware to to work in wire mode.
+ * This API will configure the fic hardware to work in wire mode.
  * In wire mode, fic hardware is generating a wire ("wired") interrupt.
  * Interrupt can be generated based on positive edge or level - configuration is
  * to be determined based on connected hardware to this fic.
-- 
2.35.1


