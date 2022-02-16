Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F94B86F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiBPLoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:44:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiBPLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:44:26 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE0C8567A;
        Wed, 16 Feb 2022 03:44:13 -0800 (PST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JzGHS1t6Wz8wl6;
        Wed, 16 Feb 2022 19:40:52 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Feb
 2022 19:44:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <yuehaibing@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crypto: x86/blowfish - Remove unused inline functions
Date:   Wed, 16 Feb 2022 19:44:06 +0800
Message-ID: <20220216114406.22108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

This is unused after commit c0a64926c53e ("crypto: x86/blowfish - drop CTR mode implementation")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/crypto/blowfish_glue.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/x86/crypto/blowfish_glue.c b/arch/x86/crypto/blowfish_glue.c
index a880e0b1c255..fda6066437aa 100644
--- a/arch/x86/crypto/blowfish_glue.c
+++ b/arch/x86/crypto/blowfish_glue.c
@@ -32,24 +32,12 @@ static inline void blowfish_enc_blk(struct bf_ctx *ctx, u8 *dst, const u8 *src)
 	__blowfish_enc_blk(ctx, dst, src, false);
 }
 
-static inline void blowfish_enc_blk_xor(struct bf_ctx *ctx, u8 *dst,
-					const u8 *src)
-{
-	__blowfish_enc_blk(ctx, dst, src, true);
-}
-
 static inline void blowfish_enc_blk_4way(struct bf_ctx *ctx, u8 *dst,
 					 const u8 *src)
 {
 	__blowfish_enc_blk_4way(ctx, dst, src, false);
 }
 
-static inline void blowfish_enc_blk_xor_4way(struct bf_ctx *ctx, u8 *dst,
-				      const u8 *src)
-{
-	__blowfish_enc_blk_4way(ctx, dst, src, true);
-}
-
 static void blowfish_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
 	blowfish_enc_blk(crypto_tfm_ctx(tfm), dst, src);
-- 
2.17.1

