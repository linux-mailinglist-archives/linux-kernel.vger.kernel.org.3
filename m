Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F5564BD9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiGDClR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiGDClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:41:13 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8D1264D8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:41:10 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 155211E80CF0;
        Mon,  4 Jul 2022 10:39:17 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dVp7w4WYapPi; Mon,  4 Jul 2022 10:39:14 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C38CC1E80CDE;
        Mon,  4 Jul 2022 10:39:13 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     lingshan.zhu@intel.com, sgarzare@redhat.com, elic@nvidia.com,
        xieyongji@bytedance.com, gautam.dawar@xilinx.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] vdpa: ifcvf: Fix spelling mistake in comments
Date:   Mon,  4 Jul 2022 10:41:04 +0800
Message-Id: <20220704024104.15535-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo(does't) in comments.
It maybe 'doesn't' instead of 'does't'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 0a5670729412..e2e201885713 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -685,7 +685,7 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
 }
 
 /*
- * IFCVF currently does't have on-chip IOMMU, so not
+ * IFCVF currently doesn't have on-chip IOMMU, so not
  * implemented set_map()/dma_map()/dma_unmap()
  */
 static const struct vdpa_config_ops ifc_vdpa_ops = {
-- 
2.34.1

