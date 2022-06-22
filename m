Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45318554823
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242329AbiFVLCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiFVLCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:02:05 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA9139166;
        Wed, 22 Jun 2022 04:01:58 -0700 (PDT)
X-QQ-mid: bizesmtp89t1655895704tlz2roqm
Received: from ubuntu.localdomain ( [223.104.103.173])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 19:01:39 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000B00A0000000
X-QQ-FEAT: 12WmTNdz4A2AySGFjMf1nLtEWLIUTiBdBK8GGy3alLtapAVa/Z0Vq8r4sVVAP
        ihaj4Ww3x5h7E8Je5xL4n7iyrfePzH9urEmVAqW8B1xA9jqo/FyAPGtQ1flRMUa5Ltweo9F
        ciBf3tJxoWlydWKAULwbHibBCwa30JfIA6vZufICh3QoOBJkYYwV36f8Op39Rse9nqLku0v
        kaSeX0T6ylnGXLts9J/aWREJBZV8IEEiKUfjL0slFNbBSNBBl7L0Vvb/Ho/pfEHpjt+vIhm
        jsw82BsKHmgO0xDS05hlMKu4qmmn3gmyf3FYtqNOO6Rycjk6fU1MiVzGlAM+p/xF/D9PKem
        JL9MNKpLo9fKLHbkpEx7djQU2/rKUQq+twcMqCH
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     jinpu.wang@cloud.ionos.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: pm8001: drop unexpected word "the" in the comments
Date:   Wed, 22 Jun 2022 19:01:37 +0800
Message-Id: <20220622110137.10033-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/scsi/pm8001/pm8001_hwi.c
line: 3141

  * the sas toplogy has formed, please discover the the whole sas domain,

changed to:

  * the sas toplogy has formed, please discover the whole sas domain,

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index a37595621d51..6a3c4c347061 100644
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
2.17.1

