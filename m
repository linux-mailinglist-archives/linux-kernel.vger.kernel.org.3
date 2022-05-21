Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8F52FBDF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355320AbiEULVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351385AbiEULMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:16 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A992FFED;
        Sat, 21 May 2022 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3zTGiDbDEMFPQZmDzPg9+Yz+H6Zd2NeXXh0kjduK7/k=;
  b=U7SMdbSkz7+xTWxeJUtS9LZwBCU/DWL4eDgcA3g8v81HVMTTPnnBTl9p
   aT0icCptg3Yg7m9JMsdxjLPK2GPZvrv/wSv5wYHjxaOe2D5Nl8bQJKaBt
   KUaGpzzhtTm6Cdr1jOJ7IVP+fcgdghJ4/3Dyja6luwxQDuY9YWdrf7F2K
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727930"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Kai Ye <yekai13@huawei.com>
Cc:     kernel-janitors@vger.kernel.org,
        Longfang Liu <liulongfang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: hisilicon/sec - fix typos in comment
Date:   Sat, 21 May 2022 13:10:45 +0200
Message-Id: <20220521111145.81697-35-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/crypto/hisilicon/sec2/sec.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index c2e9b01187a7..42bb486f3b6d 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -143,10 +143,10 @@ struct sec_ctx {
 	/* Threshold for fake busy, trigger to return -EBUSY to user */
 	u32 fake_req_limit;
 
-	/* Currrent cyclic index to select a queue for encipher */
+	/* Current cyclic index to select a queue for encipher */
 	atomic_t enc_qcyclic;
 
-	 /* Currrent cyclic index to select a queue for decipher */
+	 /* Current cyclic index to select a queue for decipher */
 	atomic_t dec_qcyclic;
 
 	enum sec_alg_type alg_type;

