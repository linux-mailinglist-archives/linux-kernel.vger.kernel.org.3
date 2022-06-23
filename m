Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C45573A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiFWHL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiFWHL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:11:58 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E045534;
        Thu, 23 Jun 2022 00:11:52 -0700 (PDT)
X-QQ-mid: bizesmtp86t1655968289tgkdrmqe
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 15:11:25 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: 2f7wtd3zdH9Lc0K05BMg4D3CHFmxR4b53tBINtYQkGR4k7ShF0BGsokL3XjNy
        2RSNdIIPUdFWcNPUyZ5yGUjqLtW9EgRn3snSEj+JvpYxwpLr0/pXSoHdWHC/4WHr1fph0g3
        6WyxpKQOTmSx3kgZOkmkLLLbaNda3kbIG30QrfIXxGebzeCVYKPeJq+THtZjt+2Y+dqvDcQ
        tJ5HhGuj2ir71SFund6A5ZKFxwhzf7JJfXeM0ZhUy+JKOF/JZCO+tfAOIqexb3HgDk4AYOt
        JpzBMdjfVrcv3lTb3wNQ5qw99Xg3dCNevzjIbnA4ehh7lN9bVdidoI/q/jCASUcAh4aykFT
        HJ5ICw7yScrpaBYugjHJ2orEtHFTA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] crypto: caam - drop unexpected word 'a' in comments
Date:   Thu, 23 Jun 2022 15:11:23 +0800
Message-Id: <20220623071123.12885-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unexpected word 'a' in the comments that need to be dropped

* This is a a cache of buffers, from which the users of CAAM QI driver
-->
* This is a cache of buffers, from which the users of CAAM QI driver

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 2 +-
 drivers/crypto/caam/qi.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 6753f0e6e55d..4b81fb33f199 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -29,7 +29,7 @@
 				 SHA512_DIGEST_SIZE * 2)
 
 /*
- * This is a a cache of buffers, from which the users of CAAM QI driver
+ * This is a cache of buffers, from which the users of CAAM QI driver
  * can allocate short buffers. It's speedier than doing kmalloc on the hotpath.
  * NOTE: A more elegant solution would be to have some headroom in the frames
  *       being processed. This can be added by the dpaa2-eth driver. This would
diff --git a/drivers/crypto/caam/qi.c b/drivers/crypto/caam/qi.c
index 8163f5df8ebf..49439d0d1b3c 100644
--- a/drivers/crypto/caam/qi.c
+++ b/drivers/crypto/caam/qi.c
@@ -75,7 +75,7 @@ bool caam_congested __read_mostly;
 EXPORT_SYMBOL(caam_congested);
 
 /*
- * This is a a cache of buffers, from which the users of CAAM QI driver
+ * This is a cache of buffers, from which the users of CAAM QI driver
  * can allocate short (CAAM_QI_MEMCACHE_SIZE) buffers. It's faster than
  * doing malloc on the hotpath.
  * NOTE: A more elegant solution would be to have some headroom in the frames
-- 
2.17.1

