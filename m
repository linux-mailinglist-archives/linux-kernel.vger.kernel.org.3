Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED24CB4A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiCCCDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiCCCC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:02:56 -0500
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C882DAA0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:02:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V64nQbZ_1646272927;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V64nQbZ_1646272927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 10:02:08 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] misc: rtsx: clean up one inconsistent indenting
Date:   Thu,  3 Mar 2022 10:02:06 +0800
Message-Id: <20220303020206.98911-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/misc/cardreader/rts5228.c:494 rts5228_extra_init_hw() warn:
inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/cardreader/rts5228.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index af581f4f74d1..cfebad51d1d8 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -491,7 +491,7 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 
 	if (pcr->rtd3_en) {
 		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x01);
-	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
+		rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
 				FORCE_PM_CONTROL | FORCE_PM_VALUE,
 				FORCE_PM_CONTROL | FORCE_PM_VALUE);
 	} else {
-- 
2.20.1.7.g153144c

