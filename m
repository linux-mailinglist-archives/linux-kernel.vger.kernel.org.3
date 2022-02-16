Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771DB4B86FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiBPLqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:46:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiBPLqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:46:06 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8ED205D;
        Wed, 16 Feb 2022 03:45:54 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JzGKP1qvcz8wZP;
        Wed, 16 Feb 2022 19:42:33 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 19:45:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <colin.king@intel.com>, <yuehaibing@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crypto: x86/des3 - Remove unused inline function des3_ede_enc_blk_3way()
Date:   Wed, 16 Feb 2022 19:45:21 +0800
Message-ID: <20220216114521.20092-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unused after commit 768db5fee3bb ("crypto: x86/des - drop CTR mode implementation")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/crypto/des3_ede_glue.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index 787c234d2469..abb8b1fe123b 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -45,14 +45,6 @@ static inline void des3_ede_dec_blk(struct des3_ede_x86_ctx *ctx, u8 *dst,
 	des3_ede_x86_64_crypt_blk(dec_ctx, dst, src);
 }
 
-static inline void des3_ede_enc_blk_3way(struct des3_ede_x86_ctx *ctx, u8 *dst,
-					 const u8 *src)
-{
-	u32 *enc_ctx = ctx->enc.expkey;
-
-	des3_ede_x86_64_crypt_blk_3way(enc_ctx, dst, src);
-}
-
 static inline void des3_ede_dec_blk_3way(struct des3_ede_x86_ctx *ctx, u8 *dst,
 					 const u8 *src)
 {
-- 
2.17.1

