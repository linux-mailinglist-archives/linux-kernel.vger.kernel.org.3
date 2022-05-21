Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B752FBBE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346236AbiEULSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354871AbiEULMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:45 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907A5521D;
        Sat, 21 May 2022 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jXfNNVnqv8/J/5t2QBjyt8m9VHzb0SlMFyA8fk+rE2g=;
  b=iFdiC6ErTRgN1x5mVj3C3KtMOlNEJMxX3yQLK3jaAzGVHHF8wVID1uW2
   4Qc5sDhGmrhNqxKmlZXwoANd8gTrVtr0be4yqg0jOcGS/qtCsX/HcaxQd
   pGvQJ/HnldJYuNgTsq4+yholSdvKYTmMX8Q2naBtXRc7ksvWEf3Rf+VxM
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727968"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:03 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     kernel-janitors@vger.kernel.org,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: fix typo in comment
Date:   Sat, 21 May 2022 13:11:13 +0200
Message-Id: <20220521111145.81697-63-Julia.Lawall@inria.fr>
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
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd58c0be9ce2..4721b76e61a1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -651,7 +651,7 @@ void wait_for_kprobe_optimizer(void)
 	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
 		mutex_unlock(&kprobe_mutex);
 
-		/* This will also make 'optimizing_work' execute immmediately */
+		/* This will also make 'optimizing_work' execute immediately */
 		flush_delayed_work(&optimizing_work);
 		/* 'optimizing_work' might not have been queued yet, relax */
 		cpu_relax();

