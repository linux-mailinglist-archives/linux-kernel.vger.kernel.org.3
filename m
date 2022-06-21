Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD92552FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348468AbiFUKYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346796AbiFUKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:24:00 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468128738;
        Tue, 21 Jun 2022 03:23:54 -0700 (PDT)
X-QQ-mid: bizesmtp72t1655806980tsdrbdum
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 18:22:56 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: nWwLie5Ka5lB/u0LCrQrgJeQdsW8NP4RQxcdy0y8Udl7q0tr+9AbePEJhmRFI
        bpPpoSOi2yBxTrPH2CBFtFVM3fEnvzJu20ebWGDm3yQxfa5ZfSn6uQyp/ipNZJpagpG7G+f
        DlU7qXGvvlYtcIsafpU3U5g8kJF04h4fST+yqfKK9zqEew1FUtlCkCMrWEAVXDq8NHtnyTF
        HqOiV5ff+axaMIvNpe3eZS/z6Ec5R/V+Tnk+2STg1AJCxzbcKAgpHjAE8+Ch5Zah1gSNVD6
        yLc8cymt8x1agNDi6Hn3LqH85MX5ORfJMSPlUCEb6iR17X6FVLL5qKguehzB2GWkbG5Gpqp
        IgioDTpuYm5GxCKZ5mLuSTZPgQ6Ew==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] crypto: nx - drop unexpected word "the"
Date:   Tue, 21 Jun 2022 18:22:54 +0800
Message-Id: <20220621102254.86591-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

>- * The DDE is setup with the the DDE count, byte count, and address of
>+ * The DDE is setup with the DDE count, byte count, and address of

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/crypto/nx/nx-common-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
index f418817c0f43..f34c75a862f2 100644
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -75,7 +75,7 @@ static int (*nx842_powernv_exec)(const unsigned char *in,
 /**
  * setup_indirect_dde - Setup an indirect DDE
  *
- * The DDE is setup with the the DDE count, byte count, and address of
+ * The DDE is setup with the DDE count, byte count, and address of
  * first direct DDE in the list.
  */
 static void setup_indirect_dde(struct data_descriptor_entry *dde,
-- 
2.17.1

