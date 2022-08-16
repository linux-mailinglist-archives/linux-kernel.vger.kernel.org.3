Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA777595BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbiHPMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiHPMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:18:08 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25832DDF;
        Tue, 16 Aug 2022 05:15:45 -0700 (PDT)
X-QQ-mid: bizesmtp88t1660652127tpwbmw4y
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:15:26 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: 7jw2iSiCazqtwYDcJ+Li+DJ0HCwyu976NBVI15SXSx7Z0guy6XmDoekTOuxkJ
        TAvnZJfUWdaNsE4TtrzsAZD2/ixAPKRrlj4c0FqCxfo6nzb+KsF6gvGU0ych4MUPw4zJ1Qy
        aDuJZ/dNfO3SpoFTpCFM1LZEcELB6fsJGC+TzC24MguFehtbOsD2Rd9WxpvUKxrOK9aNqBI
        OtWMuKFAn2ER3vlcjEsypv1eJtT1H4Ah9tDg2IGE/IUIAlOpeKq1jYAHOmpTYVL99l+rXsJ
        5Qo2crIaycaAB9gHXqiGXh4Ekk6kuqvvnVw+/zLqW42Hw6nBEVlUaxwLWHBBMtWTBDKLmMe
        tpku9OR35WzGk8g/JeK8YbfH69K+wAcli9fflQowS63Sf3B6lL4puD2YeiCfP2tLeNBF3LC
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] crypto: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:15:19 +0800
Message-Id: <20220816121519.60351-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'that'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 crypto/api.c            | 2 +-
 crypto/twofish_common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index 69508ae9345e..ab4b5e2b0756 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -321,7 +321,7 @@ struct crypto_alg *crypto_alg_mod_lookup(const char *name, u32 type, u32 mask)
 
 	/*
 	 * If the internal flag is set for a cipher, require a caller to
-	 * to invoke the cipher with the internal flag to use that cipher.
+	 * invoke the cipher with the internal flag to use that cipher.
 	 * Also, if a caller wants to allocate a cipher that may or may
 	 * not be an internal cipher, use type | CRYPTO_ALG_INTERNAL and
 	 * !(mask & CRYPTO_ALG_INTERNAL).
diff --git a/crypto/twofish_common.c b/crypto/twofish_common.c
index d23fa531b91f..f921f30334f4 100644
--- a/crypto/twofish_common.c
+++ b/crypto/twofish_common.c
@@ -298,7 +298,7 @@ static const u32 mds[4][256] = {
  * multiplication is inefficient without hardware support.  To multiply
  * faster, I make use of the fact x is a generator for the nonzero elements,
  * so that every element p of GF(2)[x]/w(x) is either 0 or equal to (x)^n for
- * some n in 0..254.  Note that that caret is exponentiation in GF(2^8),
+ * some n in 0..254.  Note that caret is exponentiation in GF(2^8),
  * *not* polynomial notation.  So if I want to compute pq where p and q are
  * in GF(2^8), I can just say:
  *    1. if p=0 or q=0 then pq=0
-- 
2.36.1

