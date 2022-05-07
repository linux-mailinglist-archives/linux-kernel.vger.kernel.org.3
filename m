Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46751E5F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383830AbiEGJT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiEGJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:19:54 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6AE396BC;
        Sat,  7 May 2022 02:16:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCWBL74_1651914953;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCWBL74_1651914953)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 17:16:03 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tim@cyberelk.net
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] paride: clean up some inconsistent indenting
Date:   Sat,  7 May 2022 17:15:35 +0800
Message-Id: <20220507091536.32211-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/block/paride/fit3.c:75 fit3_read_regr() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/paride/fit3.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/fit3.c b/drivers/block/paride/fit3.c
index 275d269458eb..05bc664829fb 100644
--- a/drivers/block/paride/fit3.c
+++ b/drivers/block/paride/fit3.c
@@ -60,12 +60,13 @@ static void  fit3_write_regr( PIA *pi, int cont, int regr, int val)
 }
 
 static int fit3_read_regr( PIA *pi, int cont, int regr )
-
-{	int  a, b;
+{
+	int a, b;
 
 	if (cont) {
-	  if (regr != 6) return 0xff;
-	  regr = 7;
+		if (regr != 6)
+			return 0xff;
+		regr = 7;
 	} 
 
 	switch (pi->mode) {
@@ -88,8 +89,8 @@ static int fit3_read_regr( PIA *pi, int cont, int regr )
 		return a;
 
 	}
-	return -1; 
 
+	return -1;
 }
 
 static void fit3_read_block( PIA *pi, char * buf, int count )
-- 
2.20.1.7.g153144c

