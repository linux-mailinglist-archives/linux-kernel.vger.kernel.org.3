Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6452FBF1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357123AbiEULYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355032AbiEULOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:14:07 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDF334647;
        Sat, 21 May 2022 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TN/j615y2tkYA0srFihzWLP+GjLIX6UQauDVbNDVzTk=;
  b=HZcq6RDsXGGZgT2GMpbx+k0znTTWtUngBgdaZC+QskSN2Mo78eDk0kGO
   bkLsh+chX0bb5x1S6AR0MleYwDGq8paFjnemsLRis0U5lCyJq+eC98XBV
   zDuWjdQuy4SUH/YHEP4DBN/CVsahWllvWTFuVN0V9DFPmrCY1phwl9JK1
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727996"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:08 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: messaging: fix typos in comments
Date:   Sat, 21 May 2022 13:11:38 +0200
Message-Id: <20220521111145.81697-88-Julia.Lawall@inria.fr>
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

Spelling mistakes (triple letters) in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/slimbus/messaging.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index e5ae26227bdb..4ce0cb61e481 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -79,7 +79,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 EXPORT_SYMBOL_GPL(slim_alloc_txn_tid);
 
 /**
- * slim_free_txn_tid() - Freee tid of txn
+ * slim_free_txn_tid() - Free tid of txn
  *
  * @ctrl: Controller handle
  * @txn: transaction whose tid should be freed
@@ -101,7 +101,7 @@ EXPORT_SYMBOL_GPL(slim_free_txn_tid);
  * @txn: Transaction to be sent over SLIMbus
  *
  * Called by controller to transmit messaging transactions not dealing with
- * Interface/Value elements. (e.g. transmittting a message to assign logical
+ * Interface/Value elements. (e.g. transmitting a message to assign logical
  * address to a slave device
  *
  * Return: -ETIMEDOUT: If transmission of this message timed out

