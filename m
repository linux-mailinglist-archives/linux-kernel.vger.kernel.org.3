Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002DB4822CC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 09:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhLaIX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 03:23:56 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60934 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242809AbhLaIXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:23:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V0QG-AX_1640939032;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V0QG-AX_1640939032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Dec 2021 16:23:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, sreekanth.reddy@broadcom.com,
        jejb@linux.ibm.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] scsi: mpi3mr: Fix formatting problems in some kernel-doc comments
Date:   Fri, 31 Dec 2021 16:23:50 +0800
Message-Id: <20211231082350.19315-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
drivers/scsi/mpi3mr/mpi3mr_fw.c:2188: warning: Function parameter or
member 'reason_code' not described in 'mpi3mr_check_rh_fault_ioc'
drivers/scsi/mpi3mr/mpi3mr_fw.c:3650: warning: Excess function parameter
'init_type' description in 'mpi3mr_init_ioc'
drivers/scsi/mpi3mr/mpi3mr_fw.c:4177: warning: bad line

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index c39dd4978c9d..7fe714c5158b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -2174,7 +2174,7 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
  * mpi3mr_check_rh_fault_ioc - check reset history and fault
  * controller
  * @mrioc: Adapter instance reference
- * @reason_code, reason code for the fault.
+ * @reason_code: reason code for the fault.
  *
  * This routine will save snapdump and fault the controller with
  * the given reason code if it is not already in the fault or
@@ -3633,7 +3633,6 @@ static int mpi3mr_enable_events(struct mpi3mr_ioc *mrioc)
 /**
  * mpi3mr_init_ioc - Initialize the controller
  * @mrioc: Adapter instance reference
- * @init_type: Flag to indicate is the init_type
  *
  * This the controller initialization routine, executed either
  * after soft reset or from pci probe callback.
@@ -4174,7 +4173,7 @@ static void mpi3mr_issue_ioc_shutdown(struct mpi3mr_ioc *mrioc)
 /**
  * mpi3mr_cleanup_ioc - Cleanup controller
  * @mrioc: Adapter instance reference
-
+ *
  * controller cleanup handler, Message unit reset or soft reset
  * and shutdown notification is issued to the controller.
  *
-- 
2.20.1.7.g153144c

