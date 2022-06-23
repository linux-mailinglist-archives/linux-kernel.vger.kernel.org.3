Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAD5577DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiFWK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiFWK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:27:12 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC7A49FAD;
        Thu, 23 Jun 2022 03:27:06 -0700 (PDT)
X-QQ-mid: bizesmtp79t1655979943tq27ujrs
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:25:38 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: qpGeUh0uYB9cZuxKc99p87X2ZPLIBdasbfL+MjzLDqUpq285mcDyh3wBxLqv0
        RzNT7N1Am/u9LWEG04LnGuU1pO0FipsxkQjE2y49QuSLbwUVpLjZONV8wVPaGZcd3hbGAmd
        Y+0PAYGQXGxxTgp2oWvjmMQ9y1/Z7Iaq7CuTz9aUiq+Zfuy2eNORH/ymE6rmVbroNywRGZA
        30jUj8dvCXfnHxKyWuy0LmmoKZAyUPrxBTY4RvKNBpEKVnVBMPT+mju7WAACbBbuxMfDORn
        u2EDKfuIsar3B1EuRAlWitBqeSomNefap/pCOoNV5f7kRf2JSqHbySkPrw5p78uwFtFDnQq
        pC+Xg5hX59XMwSIwR6wsQjiAyL0CaPKHWP989XE
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     +horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] crypto: caam - drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:25:36 +0800
Message-Id: <20220623102536.34573-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/crypto/caam/caamhash_desc.c
line - 25

*              must be false for for ahash first and digest

changed to:

*              must be false for ahash first and digest

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/caam/caamhash_desc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/caamhash_desc.c b/drivers/crypto/caam/caamhash_desc.c
index 78383d77da99..619564509936 100644
--- a/drivers/crypto/caam/caamhash_desc.c
+++ b/drivers/crypto/caam/caamhash_desc.c
@@ -22,7 +22,7 @@
  * @ctx_len: size of Context Register
  * @import_ctx: true if previous Context Register needs to be restored
  *              must be true for ahash update and final
- *              must be false for for ahash first and digest
+ *              must be false for ahash first and digest
  * @era: SEC Era
  */
 void cnstr_shdsc_ahash(u32 * const desc, struct alginfo *adata, u32 state,
-- 
2.17.1

