Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB557DF59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiGVJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiGVJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:49:06 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 683B6AFB62;
        Fri, 22 Jul 2022 02:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZoaVv
        ty61oVOiUBEGpTVCP6qI73nQTJjPR5+2w5YZhs=; b=SapaBDIHbimHx0kyftjMg
        GZMQOeTaw2MIaTtimBHwjcRv1vaSpXT7WeimYSJ0y8BtRSZQhmV9Mfh/6Tk7Xda4
        4rYK/jeEYfWKrLMn91O3/LTOQhQ6oWD+rB1ZvNyBhwMnt6BlNGEO+ioWeskdL2Qi
        pqOp7pAu5xVGFQgJr5VAM8=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgDH+pblcdpi0jorPw--.3321S2;
        Fri, 22 Jul 2022 17:46:15 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] scsi: pm8001: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:46:12 +0800
Message-Id: <20220722094612.78583-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDH+pblcdpi0jorPw--.3321S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr4UJF45tFyrtw17trb_yoWDJrb_Z3
        y7XFn3Kw1jyFZag34xCr1avrWjvFW8ZrsFvr42gr95uayfWw4DXF4kZFyxJFWrWayxG347
        Xw1Fq3W0vw43CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtxRh3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAx9GZGB0LoSzzgABs8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 4acaff479916..91d78d0a38fe 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3138,7 +3138,7 @@ int pm8001_mpi_local_phy_ctl(struct pm8001_hba_info *pm8001_ha, void *piomb)
  *
  * when HBA driver received the identify done event or initiate FIS received
  * event(for SATA), it will invoke this function to notify the sas layer that
- * the sas toplogy has formed, please discover the the whole sas domain,
+ * the sas toplogy has formed, please discover the whole sas domain,
  * while receive a broadcast(change) primitive just tell the sas
  * layer to discover the changed domain rather than the whole domain.
  */
-- 
2.25.1

