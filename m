Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE20554668
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355603AbiFVIx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355915AbiFVIxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:53:52 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E296B33E89;
        Wed, 22 Jun 2022 01:53:50 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C79321E80CD1;
        Wed, 22 Jun 2022 16:53:40 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vYMZDhLlUPhD; Wed, 22 Jun 2022 16:53:38 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.97])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id BEA741E80C7D;
        Wed, 22 Jun 2022 16:53:37 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] rtc: Fix some spelling mistakes
Date:   Wed, 22 Jun 2022 16:53:44 +0800
Message-Id: <20220622085344.23519-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'modifed' to 'modified'.
Change 'Updata' to 'Update'.
Change 'Initiatlize' to 'Initialize'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/rtc/rtc-rs5c313.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index e98f85f34206..712a08e9e52d 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -2,7 +2,7 @@
  * Ricoh RS5C313 RTC device/driver
  *  Copyright (C) 2007 Nobuhiro Iwamatsu
  *
- *  2005-09-19 modifed by kogiidena
+ *  2005-09-19 modified by kogiidena
  *
  * Based on the old drivers/char/rs5c313_rtc.c  by:
  *  Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
@@ -36,7 +36,7 @@
  *      1.11a   Daniele Bellucci: Audit create_proc_read_entry in rtc_init
  *	1.12	Venkatesh Pallipadi: Hooks for emulating rtc on HPET base-timer
  *		CONFIG_HPET_EMULATE_RTC
- *	1.13	Nobuhiro Iwamatsu: Updata driver.
+ *	1.13	Nobuhiro Iwamatsu: Update driver.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -280,7 +280,7 @@ static int rs5c313_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	while (1) {
 		RS5C313_CEENABLE;	/* CE:H */
 
-		/* Initiatlize control reg. 24 hour */
+		/* Initialize control reg. 24 hour */
 		rs5c313_write_cntreg(0x04);
 
 		if (!(rs5c313_read_cntreg() & RS5C313_CNTREG_ADJ_BSY))
-- 
2.25.1

