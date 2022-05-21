Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63B52FB8D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351409AbiEULQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbiEULML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:11 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22B2B26F;
        Sat, 21 May 2022 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8kYNFUV9Zcxq+xozkt4bW19kyeKPdHmTSaJ76s0D2PY=;
  b=rBnQigwpigXvemnKVHRMnppReKpXFazeFf/5iX9yAfpVBPclg5jRlHRr
   WFW5ZPV27eLCogs7SoZZv3mGlrGQZnY65EM0jit46xwR13WNcgT60XFjs
   WyB+dW77pjMeJ5ajTnp6Uqhp0DI6e0TOVUkSk2hDkBFUQTqyqtB6aAqLv
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727924"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:57 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: fix typo in comment
Date:   Sat, 21 May 2022 13:10:39 +0200
Message-Id: <20220521111145.81697-29-Julia.Lawall@inria.fr>
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

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 block/blk-mq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed1869a305c4..ae116b755648 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1083,7 +1083,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
-	 * For a polled request, always complete locallly, it's pointless
+	 * For a polled request, always complete locally, it's pointless
 	 * to redirect the completion.
 	 */
 	if (rq->cmd_flags & REQ_POLLED)

