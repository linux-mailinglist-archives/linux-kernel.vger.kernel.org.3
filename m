Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33DF51600B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbiD3TPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244413AbiD3TO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:14:58 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6724FC4E;
        Sat, 30 Apr 2022 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fYtqvH+CNmFHALCqzjRLdILBJr7Kyi4NBxpAgQMbfZM=;
  b=k3SUovbc8w+0BR+MOXnzqR+HsyBdRhldyqclpia4TqvSuBw7ffBOjBXh
   08m0wt5B5kw7a3zfbyDb6pvkA9HVXVC0vr0SFgl/wFp+rx0Txok4Y+1BZ
   La44KQVw1wpYEXcYR7cYX8d9ucRdyL+w2c6yVehjg24yT9WI+/2P2/BJ3
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084615"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:32 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390/crypto: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:16 +0200
Message-Id: <20220430191122.8667-2-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/s390/crypto/des_s390.c |    2 +-
 arch/s390/crypto/prng.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index bfbafd35bcbd..e013088b5115 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -194,7 +194,7 @@ static struct skcipher_alg cbc_des_alg = {
  *   same as DES.  Implementers MUST reject keys that exhibit this
  *   property.
  *
- *   In fips mode additinally check for all 3 keys are unique.
+ *   In fips mode additionally check for all 3 keys are unique.
  *
  */
 static int des3_setkey(struct crypto_tfm *tfm, const u8 *key,
diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 234d791ca59d..ae382bafc772 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -528,7 +528,7 @@ static ssize_t prng_tdes_read(struct file *file, char __user *ubuf,
 			/* give mutex free before calling schedule() */
 			mutex_unlock(&prng_data->mutex);
 			schedule();
-			/* occopy mutex again */
+			/* occupy mutex again */
 			if (mutex_lock_interruptible(&prng_data->mutex)) {
 				if (ret == 0)
 					ret = -ERESTARTSYS;

