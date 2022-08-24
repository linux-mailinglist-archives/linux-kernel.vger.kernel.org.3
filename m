Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B423959F6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiHXJvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbiHXJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:50:34 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393143F336;
        Wed, 24 Aug 2022 02:50:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN6xHBx_1661334629;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VN6xHBx_1661334629)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 17:50:29 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     zelin.deng@linux.alibaba.com, guanjun@linux.alibaba.com,
        xuchun.shang@linux.alibaba.com, artie.ding@linux.alibaba.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 9/9] MAINTAINERS: Add Yitian Cryptography Complex (YCC) driver maintainer entry
Date:   Wed, 24 Aug 2022 17:50:21 +0800
Message-Id: <1661334621-44413-10-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
References: <1661334621-44413-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

I will continue to add new feature, optimize the performance,
and handle the issues of Yitian Cryptography Complex (YCC) driver.

Guanjun and Xuchun Shang focus on various algorithms support, add them as
co-maintainers.

Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Acked-by: Guanjun <guanjun@linux.alibaba.com>
Acked-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7..cfd3a9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -942,6 +942,14 @@ S:	Supported
 F:	drivers/crypto/ccp/sev*
 F:	include/uapi/linux/psp-sev.h
 
+ALIBABA YITIAN CRYPTOGRAPHY COMPLEX (YCC) CRYPTO ACCELERATOR DRIVER
+M:	Zelin Deng <zelin.deng@linux.alibaba.com>
+M:	Guanjun <guanjun@linux.alibaba.com>
+M:	Xuchun Shang <xuchun.shang@linux.alibaba.com>
+L:	ali-accel@list.alibaba-inc.com
+S:	Supported
+F:	drivers/crypto/ycc/
+
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-- 
1.8.3.1

