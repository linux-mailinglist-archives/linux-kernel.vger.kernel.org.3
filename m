Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD695A108C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiHYMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241767AbiHYMbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:31:45 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D7832CE;
        Thu, 25 Aug 2022 05:31:43 -0700 (PDT)
X-QQ-mid: bizesmtp73t1661430696t36rbmc5
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:31:35 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: rZJGTgY0+YNrCKbMQbGRmuxa20/awuKdg3yy4ACmHJB6CGTbP4uRYC0dQDR9c
        ld+XeEBFwX4lrsTYq+ZvVCY1rQtsmUmlOgbdWaWmyplDrR7go0BUDstZNThRO0Lm9jc6j4Q
        zwLkAPxH4cWgQjw9dORO9Zvow35TuwRwxdncwAOTx+RwKvfl/dd5q1igSyWYOTrcodvin90
        dYN38oZkNnnnSvu6d8oCwznlb9yaTszjTrypsIpv75rJpkaFk7a7Vp4gHZkDMOiI5KYFDQR
        L8TybUdY+DcqvlnS3fm01XPjdP1QhEP/mj0ckVUcFIVlVljn1pmX0P8YS1/udIQL/jMCpj0
        Ys/1sSB2CLg7s2lMxhFtwosIW6DSG6Mc2DfM9cWwF7eEnIcrwB456hrLYxtax/v4J4u7zTZ
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] atomisp/pci: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:31:29 +0800
Message-Id: <20220825123129.20823-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'from'.
 Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 2 +-
 drivers/staging/media/atomisp/pci/ia_css_irq.h  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index c932f340068f..507c0404d736 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4525,7 +4525,7 @@ int atomisp_fixed_pattern(struct atomisp_sub_device *asd, int flag,
 		return 0;
 	}
 
-	/* Add function to get black from from sensor with shutter off */
+	/* Add function to get black from sensor with shutter off */
 	return 0;
 }
 
diff --git a/drivers/staging/media/atomisp/pci/ia_css_irq.h b/drivers/staging/media/atomisp/pci/ia_css_irq.h
index 26b1b3c8ba62..8f2e876a0b2b 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_irq.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_irq.h
@@ -84,11 +84,11 @@ enum ia_css_irq_info {
 	IA_CSS_IRQ_INFO_ISP_BINARY_STATISTICS_READY   = BIT(17),
 	/** ISP binary statistics are ready */
 	IA_CSS_IRQ_INFO_INPUT_SYSTEM_ERROR            = BIT(18),
-	/** the input system in in error */
+	/** the input system in error */
 	IA_CSS_IRQ_INFO_IF_ERROR                      = BIT(19),
-	/** the input formatter in in error */
+	/** the input formatter in error */
 	IA_CSS_IRQ_INFO_DMA_ERROR                     = BIT(20),
-	/** the dma in in error */
+	/** the dma in error */
 	IA_CSS_IRQ_INFO_ISYS_EVENTS_READY             = BIT(21),
 	/** end-of-frame events are ready in the isys_event queue */
 };
-- 
2.36.1

