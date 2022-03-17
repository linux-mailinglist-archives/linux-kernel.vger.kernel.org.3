Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E34DBC8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349253AbiCQBjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbiCQBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:39:05 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC095B8D;
        Wed, 16 Mar 2022 18:37:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7PI2DK_1647481060;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V7PI2DK_1647481060)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:37:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     patrice.chotard@foss.st.com
Cc:     mchehab@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] media: platform: Remove unused including <linux/version.h>
Date:   Thu, 17 Mar 2022 09:37:38 +0800
Message-Id: <20220317013738.122877-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow versioncheck warning:

./drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h: 16
linux/version.h not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
index 5ab7ca448cf9..f8d97841f366 100644
--- a/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
+++ b/drivers/media/platform/stm/sti/c8sectpfe/c8sectpfe-common.h
@@ -13,7 +13,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/dvb/frontend.h>
 #include <linux/gpio.h>
-#include <linux/version.h>
 
 #include <media/dmxdev.h>
 #include <media/dvb_demux.h>
-- 
2.20.1.7.g153144c

