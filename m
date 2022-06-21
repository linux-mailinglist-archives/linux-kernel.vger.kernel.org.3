Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59350552BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbiFUHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiFUHYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:24:39 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A419FB3;
        Tue, 21 Jun 2022 00:24:33 -0700 (PDT)
X-QQ-mid: bizesmtp70t1655796261th7gvsn9
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 15:24:07 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: FCUjxTjsuSIbhoALcgPlqmFKLwSQeShLqrw7une5wOgn2fiyfbUrMxl4ompzA
        O7EE75Dq/2p1CTybtiDJo+a4wSjxGlKWRdZJy42dA7adtWzB4J3zhAKOxEkwlsSYTpoOUvS
        yDGpn/sAWUblz67j8qoPx5TvqZIemvfZJ3mZzN7Z82gnebP5UzifbjbFSzPM6ZBVXZ/Ow30
        yohVW8rzt/7Z0ysf5B7lGmbpaopqQeS3MGxs9N1fErje3b0+WG0fqKJt4zJLV5z98R0leNi
        XkLAUtPAggCEleJwij2W6ZxK3Jf37ZZxq1WiLt0/kknEFafgKfozEXT9FQtVuBYGGm0wCvI
        jmyhw26QyUum/dNK4A=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     john.garry@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] scsi: hisi_sas: aligned "*" each line
Date:   Tue, 21 Jun 2022 15:24:05 +0800
Message-Id: <20220621072405.34394-1-jiangjian@cdjrlc.com>
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

Consider * alignment in comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 455d49299ddf..18297ab5a32b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -805,8 +805,8 @@ slot_index_alloc_quirk_v2_hw(struct hisi_hba *hisi_hba,
 			return -SAS_QUEUE_FULL;
 		}
 		/*
-		  * SAS IPTT bit0 should be 1, and SATA IPTT bit0 should be 0.
-		  */
+		 * SAS IPTT bit0 should be 1, and SATA IPTT bit0 should be 0.
+		 */
 		if (sata_dev ^ (start & 1))
 			break;
 		start++;
-- 
2.17.1

