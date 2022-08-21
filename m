Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9CF59B49E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiHUOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:49:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966421E28;
        Sun, 21 Aug 2022 07:49:55 -0700 (PDT)
X-QQ-mid: bizesmtp68t1661093391tec0jidz
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 22:49:49 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: uOISxUm02zZbhxQ3H40WOQdC2cSFSB3X0EuGSVmAhr7EMcn66Xc38zLTQN4G4
        BjONkVl/daDBRysNCtGN8YiZ8/POuzu5iACSqa9hWWglOivsU99ELeMQJ8n+MsmpK10UD0L
        fyHChJCfkNwJFkhxwHKCG9jp8+ZXVwwBDuKtRrk3ZwQqzuiG50GviwtWN4pRNnXMJ9iAIQy
        3PggKXiJzdOruTonil8Or4NZ7Kqgu6qEpMAPQLMns5dBWmql6ynyd2iqVv2DR0nwMcBuT24
        2IzTgyHXp965Seo3xkwfEsR9GL3cSHCnff37s4R78J4oSgqBLhMMT3IaNnpUC4DA2+RchIe
        LMFCCbr9trxEUXhQLTMFcCVJcHQU8tW0HqQi+op
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] power/supply: fix repeated words in comments
Date:   Sun, 21 Aug 2022 22:49:42 +0800
Message-Id: <20220821144942.48960-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'on'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 60e0ce105a29..be9764541d52 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
  *
  * Rewritten for Linux power framework with some parts based on
- * on earlier driver found in the Motorola Linux kernel:
+ * earlier driver found in the Motorola Linux kernel:
  *
  * Copyright (C) 2009-2010 Motorola, Inc.
  */
-- 
2.36.1

