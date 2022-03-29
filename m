Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B25C4EB46F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiC2UKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiC2UKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:10:50 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0537D205F4;
        Tue, 29 Mar 2022 13:09:03 -0700 (PDT)
Received: from 1nZI9D-000AzV-W6 by out3d.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nZI9F-000B2y-TT; Tue, 29 Mar 2022 13:09:01 -0700
Received: by emcmailer; Tue, 29 Mar 2022 13:09:01 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3d.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nZI9D-000AzV-W6; Tue, 29 Mar 2022 13:09:00 -0700
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 3179C1A4A6;
        Tue, 29 Mar 2022 13:08:59 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH 1/2] can: Fix Links to Technologic Systems web resources
Date:   Tue, 29 Mar 2022 13:08:44 -0700
Message-Id: <20220329200844.16073-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=JNdbgRoUfWZLQJBtZuhC+ncgaaoQIfxSElXYcdEKvd0=;b=FUdhajRHHjeiHlt1lD4lDFI4YIzg70BFuuBk/XXpcUD4UDElcaNCWPDiFxlvTnch0KvtQN59Dxg4H4/Z2AsHG9eEFuiFjpaSgwMVUVGH5FoIvtjf7mPvlaudY/+NXpLfg2u9U9WrUkP8LPRmnUFRd5PxAavRJ+1pCNp/dCU7uOyIiItTEfs1ArqAlsPszeeQYLBTCL5dFxPNOHcSFQKizOjF2JN+2JBbkaAkMXVXH+HLplYpPXZ1X0yP0eIgQ+nil1ooMXFtNYfjcxZS5Js0bm1dP+0jIgYxQaopIJgYghm6vVE1ZNlI1VcYfn+m9Zibvv8OoLkIMNyjg+YakGqvSg==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Technologic Systems has rebranded as embeddedTS with the current
domain eventually going offline. Update web/doc URLs to correct
resource locations.

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/net/can/sja1000/Kconfig  | 2 +-
 drivers/net/can/sja1000/tscan1.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 110071b26921..4b2f9cb17fc3 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -107,7 +107,7 @@ config CAN_TSCAN1
 	depends on ISA
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
-	  http://www.embeddedarm.com/products/board-detail.php?product=TS-CAN1
+	  https://www.embeddedts.com/products/TS-CAN1
 	  The driver supports multiple boards and automatically configures them:
 	  PLD IO base addresses are read from jumpers JP1 and JP2,
 	  IRQ numbers are read from jumpers JP4 and JP5,
diff --git a/drivers/net/can/sja1000/tscan1.c b/drivers/net/can/sja1000/tscan1.c
index 3dbba8d61afb..f3862bed3d40 100644
--- a/drivers/net/can/sja1000/tscan1.c
+++ b/drivers/net/can/sja1000/tscan1.c
@@ -5,10 +5,9 @@
  * Copyright 2010 Andre B. Oliveira
  */
 
-/*
- * References:
- * - Getting started with TS-CAN1, Technologic Systems, Jun 2009
- *	http://www.embeddedarm.com/documentation/ts-can1-manual.pdf
+/* References:
+ * - Getting started with TS-CAN1, Technologic Systems, Feb 2022
+ *	https://docs.embeddedts.com/TS-CAN1
  */
 
 #include <linux/init.h>
-- 
2.11.0

