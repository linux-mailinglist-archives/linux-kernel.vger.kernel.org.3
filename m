Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66B458FBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiHKMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHKMOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:14:14 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1D97533;
        Thu, 11 Aug 2022 05:14:12 -0700 (PDT)
X-QQ-mid: bizesmtp81t1660220041txqcuqc3
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:13:59 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: ER/kQ8ZVJ2VQgSlYjLSErwvCfK8vm0r7x2Q2K3KJG9yoehowF7jJu3gxC+l6a
        VrwdNFmlKufIQQJWSByBMgaP3eAlnOv/Ld3Eqk//T/UVisJVIjKMUAOrEIfB2pI5e4RbYmP
        BqUeSGPLuhOgwxvNxYQY7k+dv79cas3debBHASqNoZVGrZQjf/hwASIho/sHvA7KVT15fgp
        NvM9lMQ4L9roUr3gUPWQaJEq0EMmKjRbe6UWldcqiFJzu5Q5rYYJ47Jytt05R1san7YaUWo
        vpUwclCXD6ULfKFZtcMjL9dBBLjWCP3gIKJYWtzO+rNT/9BeKu+HZpx0sU6uqLBOGtV64yH
        gDl4H/spMgMqdG4wZjHs857+rK09re/QUOMqUd2sWxMefEk+VqrCic8Pebo2RUyspm8Krxb
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] crypto: api - Fix comment typo
Date:   Thu, 11 Aug 2022 20:13:49 +0800
Message-Id: <20220811121349.22734-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 crypto/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.36.1

