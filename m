Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11B578407
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGRNn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiGRNnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:43:25 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B706417A8D;
        Mon, 18 Jul 2022 06:43:20 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658151789tul9v6c1
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:43:07 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: p3zaYvzvzBNRRsiyRhrp/xWxTKsJjab6qKy9Vku0u828MrQr/fuWkMMDqCDRg
        YXGwStzN7E1tTBqQPeW3NJV2/EsryL6E103udyaR5Pfe7yayC7gV1UBduFR0Oxz0SPcs/+D
        jCT6RcUI2hk4h/9kuV5kactGckZdSBVbBS30fq59xfhMwhY0y4lYTCbB3LM8cjuQyifMnRn
        Bo7hdm4t6q3hV/8EMux+1g0UayGWnO7zunHlESZbt32BW4ZlN9KFY/owe4A9gNaf90g0IPx
        c1MfwQLoGv16TGRFHhl/fzlLXDMSRpuJUpw0l/fU2v3pa7BA6fnbDrIOykWTV2WjHI23cYg
        /2KfMTRK8xXw8QSClwTN1XYZ2WTXYFq7317SpGGexd/PUtD5EV9Eee1EtALMwpxe9LGgeCZ
        blPvuUCOoVY=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     herbert@gondor.apana.org.au
Cc:     olivia@selenic.com, rdunlap@infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] hwrng: Fix comment typo
Date:   Fri, 15 Jul 2022 13:40:50 +0800
Message-Id: <20220715054050.5613-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `close' is duplicated in line 148, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/char/hw_random/via-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index 7444cc146e86..a9a0a3b09c8b 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -145,7 +145,7 @@ static int via_rng_init(struct hwrng *rng)
 	}
 
 	/* Control the RNG via MSR.  Tread lightly and pay very close
-	 * close attention to values written, as the reserved fields
+	 * attention to values written, as the reserved fields
 	 * are documented to be "undefined and unpredictable"; but it
 	 * does not say to write them as zero, so I make a guess that
 	 * we restore the values we find in the register.
-- 
2.35.1

