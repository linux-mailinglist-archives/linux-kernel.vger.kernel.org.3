Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2764457F3C0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiGXHej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGXHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:34:36 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434F193C0;
        Sun, 24 Jul 2022 00:34:31 -0700 (PDT)
X-QQ-mid: bizesmtp74t1658648066t1s2i30p
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:34:24 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: C2zsvWT0ctUWXDOTcu3pJEc41TwaG0zSWMyQ2km6vLP6PGGCrLxu76vRpP8k3
        rKW+9pIyghwqvmIW9JMXEnOxyeY2cmVeA6md4hK7gdV9mzUMUaG39NSr2p1nJqvZoObldOv
        9UiJZcid/XTQRMmDJmvGZSEVM1KuJ7MJ6aikR9j1G79xmgVvfFC0MkaVxJYNhNMEyHTPFlZ
        WjGGIknZoboSLDQyLbg5dAzGf0mHtvrIL8+53lPOnN41SAlv2OTqCSh16LVsczh/RMA3hA8
        F3fVUtgmzcnZgd7jHw1lz2LhWY4u2AdeV6agL84Bm9S9nSdWLu+omFf0J4N2v2wglwdQKSP
        dX3HtFOsfk9fFq9/+Yhi5L0V3poI4sUce3+i7lBgawii87OTqM=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/remoteproc: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:34:18 +0800
Message-Id: <20220724073418.15793-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..e3e68b5051bb 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -970,7 +970,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
 		return 0;
 	}
 
-	/* Register carveout in in list */
+	/* Register carveout in list */
 	carveout = rproc_mem_entry_init(dev, NULL, 0, rsc->len, rsc->da,
 					rproc_alloc_carveout,
 					rproc_release_carveout, rsc->name);
-- 
2.36.1

