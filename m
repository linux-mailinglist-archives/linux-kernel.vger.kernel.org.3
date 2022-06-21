Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A22552FBC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349019AbiFUK3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348964AbiFUK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:28:51 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7852F28706;
        Tue, 21 Jun 2022 03:28:47 -0700 (PDT)
X-QQ-mid: bizesmtp83t1655807260t088i07k
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 18:27:36 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: YBQGNezXUiwIqjxaWcZ7SUz+aJX8MC3LAZMxrfwx1SwdXzk/7fTg3ChCOUkAJ
        m3oykKjZs0+5/bYtl+zA5bcbFVSw05V4WPN81w2ysTJMCV68vglZLefu7yrJYkNiyDPIjsR
        KrImtoLgIy/blkQQcJv1lHpibda2kL+wPibfiaZpGsP314b3vNwJ2OrZGG4vbEbEMOJV2Ej
        4DI9qTWEnt5+qz+nMCqM9A6Mj6K0jMDKRO0UD0q/Cm+vNLvPxc1fz4F/2rvUOFYb5owXJUm
        CpKi3h4Yyhlfy49I2mSDgt+qQt6BmQBeLiIEX4I2F+Gr58A+LlHhGHxvyRC0TDkrbfEAkAe
        Vb86h7bvduVSsSe+krwQfnMKcxb9A==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Julia.Lawall@inria.fr, jiangjian@cdjrlc.com, hanyihao@vivo.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ux500/hash - drop unexpected word "the"
Date:   Tue, 21 Jun 2022 18:27:33 +0800
Message-Id: <20220621102733.88445-1-jiangjian@cdjrlc.com>
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

there is an unexpected word "the" in the comments that need to be dropped

>-  * specified in the the hw design spec. Either due to incorrect info in the
>+  * specified in the hw design spec. Either due to incorrect info in the

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/ux500/hash/hash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 265ef3e96fdd..f104e8a43036 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -421,7 +421,7 @@ static int hash_get_device_data(struct hash_ctx *ctx,
  * @keylen:		The lengt of the key.
  *
  * Note! This function DOES NOT write to the NBLW registry, even though
- * specified in the the hw design spec. Either due to incorrect info in the
+ * specified in the hw design spec. Either due to incorrect info in the
  * spec or due to a bug in the hw.
  */
 static void hash_hw_write_key(struct hash_device_data *device_data,
-- 
2.17.1

