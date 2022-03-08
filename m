Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC90A4D115C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344609AbiCHH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbiCHH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:56:44 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6719E3CFD7;
        Mon,  7 Mar 2022 23:55:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V6dWmkn_1646726139;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V6dWmkn_1646726139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 15:55:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] crypto: dh - Remove the unused function dh_safe_prime_dh_alg()
Date:   Tue,  8 Mar 2022 15:55:37 +0800
Message-Id: <20220308075537.36374-1-jiapeng.chong@linux.alibaba.com>
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

Fix the following W=1 kernel warnings:

crypto/dh.c:311:31: warning: unused function 'dh_safe_prime_dh_alg'
[-Wunused-function]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 crypto/dh.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/crypto/dh.c b/crypto/dh.c
index cca289477485..4406aeb1ff61 100644
--- a/crypto/dh.c
+++ b/crypto/dh.c
@@ -308,12 +308,6 @@ static inline struct dh_safe_prime_instance_ctx *dh_safe_prime_instance_ctx(
 	return kpp_instance_ctx(kpp_alg_instance(tfm));
 }
 
-static inline struct kpp_alg *dh_safe_prime_dh_alg(
-	struct dh_safe_prime_tfm_ctx *ctx)
-{
-	return crypto_kpp_alg(ctx->dh_tfm);
-}
-
 static int dh_safe_prime_init_tfm(struct crypto_kpp *tfm)
 {
 	struct dh_safe_prime_instance_ctx *inst_ctx =
-- 
2.20.1.7.g153144c

