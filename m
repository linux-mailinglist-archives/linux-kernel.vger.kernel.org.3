Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683ED54F507
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381707AbiFQKM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381689AbiFQKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:12:53 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF55F10FD9;
        Fri, 17 Jun 2022 03:12:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 932341E80D72;
        Fri, 17 Jun 2022 18:11:02 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9FD_6Uz1XKnf; Fri, 17 Jun 2022 18:10:59 +0800 (CST)
Received: from localhost.localdomain (unknown [39.144.44.120])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 69D9C1E80D66;
        Fri, 17 Jun 2022 18:10:57 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] scsi: mpt3sas: Fix space and spelling mistake
Date:   Fri, 17 Jun 2022 18:11:03 +0800
Message-Id: <20220617101103.3162-1-jiaming@nfschina.com>
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

There is a splling mistake in _base_sas_ioc_info. Change 'cant' to 'can't'.
There are 3 space mistakes. Remove blank space before ','.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 9a1ae52bb621..565339a0811d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -873,7 +873,7 @@ mpt3sas_base_stop_watchdog(struct MPT3SAS_ADAPTER *ioc)
  * @fault_code: fault code
  */
 void
-mpt3sas_base_fault_info(struct MPT3SAS_ADAPTER *ioc , u16 fault_code)
+mpt3sas_base_fault_info(struct MPT3SAS_ADAPTER *ioc, u16 fault_code)
 {
 	ioc_err(ioc, "fault_state(0x%04x)!\n", fault_code);
 }
@@ -1057,7 +1057,7 @@ _base_sas_ioc_info(struct MPT3SAS_ADAPTER *ioc, MPI2DefaultReply_t *mpi_reply,
 		desc = "config no defaults";
 		break;
 	case MPI2_IOCSTATUS_CONFIG_CANT_COMMIT:
-		desc = "config cant commit";
+		desc = "config can't commit";
 		break;
 
 /****************************************************************************
@@ -1321,7 +1321,7 @@ _base_display_event_data(struct MPT3SAS_ADAPTER *ioc,
  * @log_info: log info
  */
 static void
-_base_sas_log_info(struct MPT3SAS_ADAPTER *ioc , u32 log_info)
+_base_sas_log_info(struct MPT3SAS_ADAPTER *ioc, u32 log_info)
 {
 	union loginfo_type {
 		u32	loginfo;
@@ -1393,7 +1393,7 @@ _base_display_reply_info(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index,
 
 	if ((ioc_status & MPI2_IOCSTATUS_MASK) &&
 	    (ioc->logging_level & MPT_DEBUG_REPLY)) {
-		_base_sas_ioc_info(ioc , mpi_reply,
+		_base_sas_ioc_info(ioc, mpi_reply,
 		   mpt3sas_base_get_msg_frame(ioc, smid));
 	}
 
-- 
2.25.1

