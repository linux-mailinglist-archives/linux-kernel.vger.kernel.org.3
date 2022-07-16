Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2870A577033
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiGPQ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 12:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiGPQ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:57:42 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712F01EEF6;
        Sat, 16 Jul 2022 09:57:36 -0700 (PDT)
X-QQ-mid: bizesmtp65t1657990605t8bp26sw
Received: from dengVM.. ( [117.176.186.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 17 Jul 2022 00:56:34 +0800 (CST)
X-QQ-SSF: 01000000002000305000B00A0000000
X-QQ-FEAT: BYUemv+qiN3/9/vLY1i02sXWgxukErvdo4j5XnjFneZ0Pjwt1A9kwMxja9+il
        SPkFx/dYqCecn6eKrcemypcEuoZGvBRJijdCzyJNwb/Zfv8ir9OskP2L6kxPM5fsdDmBmpQ
        tOvBoYXhBJKZbghdUlKtyRZaFtrBpraYLedQD6Hp9YkB12bYOrQJXnExWD0WUFdKiRhgSZJ
        JsBSZOWGBmmgdzz7orlJ8m+4EI/T9CTXhrsc5M53uhcm4uIMQF61U/HO5IzRoH2IJSe4OOk
        VkoZV/9GT6JZwhR8nBxB0ZXxFcQ9OY0hv0AQX436mrTCB/DUcl3eKyxIMvbNEyMNe3oxoYn
        FDYclbUmhyTFPrkgbEQ5Hm7wxvIr0ppbnxNbh4tO6QNo5VoqU4=
X-QQ-GoodBg: 0
From:   shaom Deng <dengshaomin@cdjrlc.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     paulus@samba.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        shaom Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] cyrpto:delete the rebundant word "block" in comments
Date:   Sun, 17 Jul 2022 00:56:33 +0800
Message-Id: <20220716165633.17822-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is rebundant word "block" in comments, so remove it

Signed-off-by: shaom Deng <dengshaomin@cdjrlc.com>
---
 arch/powerpc/crypto/aes-spe-glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/aes-spe-glue.c b/arch/powerpc/crypto/aes-spe-glue.c
index e8dfe9fb0266..efab78a3a8f6 100644
--- a/arch/powerpc/crypto/aes-spe-glue.c
+++ b/arch/powerpc/crypto/aes-spe-glue.c
@@ -28,7 +28,7 @@
  * instructions per clock cycle using one 32/64 bit unit (SU1) and one 32
  * bit unit (SU2). One of these can be a memory access that is executed via
  * a single load and store unit (LSU). XTS-AES-256 takes ~780 operations per
- * 16 byte block block or 25 cycles per byte. Thus 768 bytes of input data
+ * 16 byte block or 25 cycles per byte. Thus 768 bytes of input data
  * will need an estimated maximum of 20,000 cycles. Headroom for cache misses
  * included. Even with the low end model clocked at 667 MHz this equals to a
  * critical time window of less than 30us. The value has been chosen to
-- 
2.34.1

