Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20E56319E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiGAKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiGAKll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:41:41 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA477C1BE;
        Fri,  1 Jul 2022 03:41:38 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 224261E80D21;
        Fri,  1 Jul 2022 18:40:08 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hv84oYwLqjm3; Fri,  1 Jul 2022 18:40:05 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 054E11E80D09;
        Fri,  1 Jul 2022 18:40:03 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bvanassche@acm.org, johannes.thumshirn@wdc.com,
        himanshu.madhani@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] scsi: csiostor: Fix some typos in comments
Date:   Fri,  1 Jul 2022 18:41:30 +0800
Message-Id: <20220701104130.24644-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
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

There are some typos in /drivers/scsi/csiostor/csio_scsi.c.
Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/scsi/csiostor/csio_scsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 9aafe0002ab1..a3dc6cc33136 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -153,7 +153,7 @@ csio_scsi_itnexus_loss_error(uint16_t error)
 }
 
 /*
- * csio_scsi_fcp_cmnd - Frame the SCSI FCP command paylod.
+ * csio_scsi_fcp_cmnd - Frame the SCSI FCP command payload.
  * @req: IO req structure.
  * @addr: DMA location to place the payload.
  *
@@ -782,7 +782,7 @@ csio_scsis_io_active(struct csio_ioreq *req, enum csio_scsi_ev evt)
 		list_del_init(&req->sm.sm_list);
 		csio_set_state(&req->sm, csio_scsis_uninit);
 		/*
-		 * In MSIX mode, with multiple queues, the SCSI compeltions
+		 * In MSIX mode, with multiple queues, the SCSI completions
 		 * could reach us sooner than the FW events sent to indicate
 		 * I-T nexus loss (link down, remote device logo etc). We
 		 * dont want to be returning such I/Os to the upper layer
@@ -943,7 +943,7 @@ csio_scsis_aborting(struct csio_ioreq *req, enum csio_scsi_ev evt)
 		 * 5. FW couldn't genuinely abort the request for some reason,
 		 *    and sent us an error.
 		 *
-		 * The first 3 scenarios are treated as  succesful abort
+		 * The first 3 scenarios are treated as  successful abort
 		 * operations by the host, while the last 2 are failed attempts
 		 * to abort. Manipulate the return value of the request
 		 * appropriately, so that host can convey these results
@@ -1018,7 +1018,7 @@ csio_scsis_closing(struct csio_ioreq *req, enum csio_scsi_ev evt)
 
 		/*
 		 * Either close succeeded, or we issued close to FW at the
-		 * same time FW compelted it to us. Either way, the I/O
+		 * same time FW completed it to us. Either way, the I/O
 		 * is closed.
 		 */
 		CSIO_DB_ASSERT((req->wr_status == FW_SUCCESS) ||
@@ -2010,7 +2010,7 @@ csio_eh_abort_handler(struct scsi_cmnd *cmnd)
  * @req: IO request.
  *
  * Cache the result in 'cmnd', since ioreq will be freed soon
- * after we return from here, and the waiting thread shouldnt trust
+ * after we return from here, and the waiting thread shouldn't trust
  * the ioreq contents.
  */
 static void
-- 
2.25.1

