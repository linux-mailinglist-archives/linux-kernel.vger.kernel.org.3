Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA957D835
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiGVB7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGVB7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:59:36 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A32C97480;
        Thu, 21 Jul 2022 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dbBus
        LHp8HDPjiNGQg9/hgfq0xVyqPTOixL0iSVtzKc=; b=H+jY8oDn9YNMOJ/WbfTjU
        NY5pvOBbhnAlEFjv5MvIMO+Rxn05UTy55ecA9iScuh/yxDephkRpTIxbCc3Lqfde
        UNSecMmN0FMCnrOfEYPtEWb6QOF+z6oid8tjz4Bub1mpkOYdqnzJlDM/9OxSsZbO
        Tk88Mf2XC0A2KtsRWmkTes=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp10 (Coremail) with SMTP id DsCowAB3JI1SBNpiSLaDOg--.9426S2;
        Fri, 22 Jul 2022 09:58:45 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     bvanassche@acm.org, martin.petersen@oracle.com, jejb@linux.ibm.com,
        njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH v2] scsi: qla2xxx: Fix typo in comment
Date:   Fri, 22 Jul 2022 09:58:34 +0800
Message-Id: <20220722015834.3219438-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAB3JI1SBNpiSLaDOg--.9426S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1rXFyxJF1kKr4xJrWDurg_yoW7XF1xpr
        Zagw1fArWjyF129r42yFy8ZF1UuanIyryUK3WDWw1UAw40vrWxtrnFy34Fya4kCa4kZa40
        qFnayaySgFsFqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSoGPUUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBAhZG+2B0IpOlTgAAsn
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/scsi/qla2xxx/qla_init.c | 148 ++++++++++++++++----------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3f3417a3e891..3dc083bbac3c 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -19,8 +19,8 @@
 #include "qla_target.h"
 
 /*
-*  QLogic ISP2x00 Hardware Support Function Prototypes.
-*/
+ * QLogic ISP2x00 Hardware Support Function Prototypes.
+ */
 static int qla2x00_isp_firmware(scsi_qla_host_t *);
 static int qla2x00_setup_chip(scsi_qla_host_t *);
 static int qla2x00_fw_ready(scsi_qla_host_t *);
@@ -2381,15 +2381,15 @@ qla83xx_nic_core_fw_load(scsi_qla_host_t *vha)
 }
 
 /*
-* qla2x00_initialize_adapter
-*      Initialize board.
-*
-* Input:
-*      ha = adapter block pointer.
-*
-* Returns:
-*      0 = success
-*/
+ * qla2x00_initialize_adapter
+ *      Initialize board.
+ *
+ * Input:
+ *      ha = adapter block pointer.
+ *
+ * Returns:
+ *      0 = success
+ */
 int
 qla2x00_initialize_adapter(scsi_qla_host_t *vha)
 {
@@ -4661,18 +4661,18 @@ qla2x00_fw_ready(scsi_qla_host_t *vha)
 }
 
 /*
-*  qla2x00_configure_hba
-*      Setup adapter context.
-*
-* Input:
-*      ha = adapter state pointer.
-*
-* Returns:
-*      0 = success
-*
-* Context:
-*      Kernel context.
-*/
+ * qla2x00_configure_hba
+ *      Setup adapter context.
+ *
+ * Input:
+ *      ha = adapter state pointer.
+ *
+ * Returns:
+ *      0 = success
+ *
+ * Context:
+ *      Kernel context.
+ */
 static int
 qla2x00_configure_hba(scsi_qla_host_t *vha)
 {
@@ -4861,18 +4861,18 @@ static void qla2xxx_nvram_wwn_from_ofw(scsi_qla_host_t *vha, nvram_t *nv)
 }
 
 /*
-* NVRAM configuration for ISP 2xxx
-*
-* Input:
-*      ha                = adapter block pointer.
-*
-* Output:
-*      initialization control block in response_ring
-*      host adapters parameters in host adapter block
-*
-* Returns:
-*      0 = success.
-*/
+ * NVRAM configuration for ISP 2xxx
+ *
+ * Input:
+ *      ha = adapter block pointer.
+ *
+ * Output:
+ *      initialization control block in response_ring
+ *      host adapters parameters in host adapter block
+ *
+ * Returns:
+ *      0 = success.
+ */
 int
 qla2x00_nvram_config(scsi_qla_host_t *vha)
 {
@@ -5330,7 +5330,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
  *      Updates Fibre Channel Device Database with what is actually on loop.
  *
  * Input:
- *      ha                = adapter block pointer.
+ *      ha = adapter block pointer.
  *
  * Returns:
  *      0 = success.
@@ -6599,7 +6599,7 @@ qla2x00_local_device_login(scsi_qla_host_t *vha, fc_port_t *fcport)
 }
 
 /*
- *  qla2x00_loop_resync
+ * qla2x00_loop_resync
  *      Resync with fibre channel devices.
  *
  * Input:
@@ -6657,12 +6657,12 @@ qla2x00_loop_resync(scsi_qla_host_t *vha)
 }
 
 /*
-* qla2x00_perform_loop_resync
-* Description: This function will set the appropriate flags and call
-*              qla2x00_loop_resync. If successful loop will be resynced
-* Arguments : scsi_qla_host_t pointer
-* returm    : Success or Failure
-*/
+ * qla2x00_perform_loop_resync
+ * Description: This function will set the appropriate flags and call
+ *              qla2x00_loop_resync. If successful loop will be resynced
+ * Arguments : scsi_qla_host_t pointer
+ * return    : Success or Failure
+ */
 
 int qla2x00_perform_loop_resync(scsi_qla_host_t *ha)
 {
@@ -7007,13 +7007,13 @@ qla2xxx_mctp_dump(scsi_qla_host_t *vha)
 }
 
 /*
-* qla2x00_quiesce_io
-* Description: This function will block the new I/Os
-*              Its not aborting any I/Os as context
-*              is not destroyed during quiescence
-* Arguments: scsi_qla_host_t
-* return   : void
-*/
+ * qla2x00_quiesce_io
+ * Description: This function will block the new I/Os
+ *              Its not aborting any I/Os as context
+ *              is not destroyed during quiescence
+ * Arguments: scsi_qla_host_t
+ * return   : void
+ */
 void
 qla2x00_quiesce_io(scsi_qla_host_t *vha)
 {
@@ -7175,15 +7175,15 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 }
 
 /*
-*  qla2x00_abort_isp
-*      Resets ISP and aborts all outstanding commands.
-*
-* Input:
-*      ha           = adapter block pointer.
-*
-* Returns:
-*      0 = success
-*/
+ * qla2x00_abort_isp
+ *      Resets ISP and aborts all outstanding commands.
+ *
+ * Input:
+ *      ha = adapter block pointer.
+ *
+ * Returns:
+ *      0 = success
+ */
 int
 qla2x00_abort_isp(scsi_qla_host_t *vha)
 {
@@ -7376,15 +7376,15 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 }
 
 /*
-*  qla2x00_restart_isp
-*      restarts the ISP after a reset
-*
-* Input:
-*      ha = adapter block pointer.
-*
-* Returns:
-*      0 = success
-*/
+ * qla2x00_restart_isp
+ *      restarts the ISP after a reset
+ *
+ * Input:
+ *      ha = adapter block pointer.
+ *
+ * Returns:
+ *      0 = success
+ */
 static int
 qla2x00_restart_isp(scsi_qla_host_t *vha)
 {
@@ -7469,12 +7469,12 @@ qla25xx_init_queues(struct qla_hw_data *ha)
 }
 
 /*
-* qla2x00_reset_adapter
-*      Reset adapter.
-*
-* Input:
-*      ha = adapter block pointer.
-*/
+ * qla2x00_reset_adapter
+ *      Reset adapter.
+ *
+ * Input:
+ *      ha = adapter block pointer.
+ */
 int
 qla2x00_reset_adapter(scsi_qla_host_t *vha)
 {
-- 
2.25.1

