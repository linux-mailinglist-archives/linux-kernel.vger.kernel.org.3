Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274995A10AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiHYMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiHYMhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:37:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D8AF0D6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:37:01 -0700 (PDT)
X-QQ-mid: bizesmtp62t1661431014thbakx3i
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:36:53 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: QityeSR92A277cprjEdE58AmL0aKFx5S4Ev5Sj1v6E8ILwe73gcDUDlfjFYZs
        USbltP7C6HH+wf6J7wKyXKZtehWDxL6esDOAH3oFQ94aTNcYnzZCLPeKqJ//Oj8dKRoJ0Fo
        pChZOJt+l3rh8dT3cjLzT5yLd9NAMM5u7AFQRkZNEkUViqXvNLoYk6DOVgZ6V6fDNjV+2oE
        KFLrbLUoz8yWBrsbpBnSxO5m/CXdWlj1fbKvNpoQeKnTeNLFLWrsqgoEk3/gjahJsvBqCbm
        n+N8qKNX4d209tVkFnRYg7+UZZ22b0B8v49IOtjshXD1e8RdhOttF9zIcVZSTpWrhsron1Y
        qDcA28jvpzJBFxX+g5XBsBIXcv5GGqQyQeWPx/ULHxBJc8F4ikTARe8PZMQ0StLd9BzLAMp
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com, s.shtylyov@omp.r
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/ata: fix repeated words in comments
Date:   Thu, 25 Aug 2022 20:36:44 +0800
Message-Id: <20220825123644.9082-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.
 Delete the redundant word 'to'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/ata/libata-eh.c      | 2 +-
 drivers/ata/pata_macio.c     | 2 +-
 drivers/ata/sata_dwc_460ex.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c128c89b454..ca865a95cf24 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -863,7 +863,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  *
  *	Set ATA_PFLAG_EH_PENDING and activate fast drain if @fastdrain
  *	is non-zero and EH wasn't pending before.  Fast drain ensures
- *	that EH kicks in in timely manner.
+ *	that EH kicks in timely manner.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index bfea2be2959a..076212fdb9d9 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -666,7 +666,7 @@ static u8 pata_macio_bmdma_status(struct ata_port *ap)
 	 * a multi-block transfer.
 	 *
 	 * - The dbdma fifo hasn't yet finished flushing to
-	 * to system memory when the disk interrupt occurs.
+	 * system memory when the disk interrupt occurs.
 	 *
 	 */
 
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e3263e961045..a4c83a6e5631 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1087,7 +1087,7 @@ static struct scsi_host_template sata_dwc_sht = {
 	/*
 	 * test-only: Currently this driver doesn't handle NCQ
 	 * correctly. We enable NCQ but set the queue depth to a
-	 * max of 1. This will get fixed in in a future release.
+	 * max of 1. This will get fixed in a future release.
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	/* .can_queue		= ATA_MAX_QUEUE, */
-- 
2.36.1

