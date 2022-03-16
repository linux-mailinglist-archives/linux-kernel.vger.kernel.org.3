Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63E4DA72C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352891AbiCPBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352888AbiCPBEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:04:21 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CE5E36;
        Tue, 15 Mar 2022 18:03:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V7JXSGt_1647392583;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7JXSGt_1647392583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 09:03:04 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     herbert@gondor.apana.org.au
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] crypto: engine: Add parameter description in crypto_transfer_request() kernel-doc comment
Date:   Wed, 16 Mar 2022 09:03:01 +0800
Message-Id: <20220316010301.3166-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @need_pump in crypto_transfer_request() kernel-doc
comment to remove warning found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

crypto/crypto_engine.c:260: warning: Function parameter or member
'need_pump' not described in 'crypto_transfer_request'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 crypto/crypto_engine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/crypto_engine.c b/crypto/crypto_engine.c
index 6056a990c9f2..bb8e77077f02 100644
--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -253,6 +253,7 @@ static void crypto_pump_work(struct kthread_work *work)
  * crypto_transfer_request - transfer the new request into the engine queue
  * @engine: the hardware engine
  * @req: the request need to be listed into the engine queue
+ * @need_pump: indicates whether queue the pump of request to kthread_work
  */
 static int crypto_transfer_request(struct crypto_engine *engine,
 				   struct crypto_async_request *req,
-- 
2.20.1.7.g153144c

