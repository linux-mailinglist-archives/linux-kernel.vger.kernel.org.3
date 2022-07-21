Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E757C958
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiGUKrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiGUKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:47:47 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA51682FA0;
        Thu, 21 Jul 2022 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0NkQR
        Pn4zjs0M2E/oW9nF063Q8F7n3ehRlORKVixzZM=; b=l6wo2/ZGEyIwW5qNoYb6U
        zjCe6EeblRDQ+bjKkJ7SgN/kJI14c5Chmp9p92xb8kLWupocPuEi/EZZQph/8CZw
        5H2Nbzs+idqFK9jIc8dw6TDcH2T2b/8Z9WQuItFGxtK/u4v/ghzxY1VuJFeaSBBr
        Af2ymNLqcp2a2tbZdDWPMs=
Received: from localhost.localdomain (unknown [223.104.68.234])
        by smtp11 (Coremail) with SMTP id D8CowACXv1vhKtliX0TCAA--.225S2;
        Thu, 21 Jul 2022 18:31:02 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] scsi: lpfc: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 18:30:56 +0800
Message-Id: <20220721103056.53143-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACXv1vhKtliX0TCAA--.225S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryUur47JryDCF1rurW3Wrg_yoW3Gry7pF
        WxGa4UCr1DKF1xtr17Ar4UZFnIyw4rWr9FkanFy345uFyFk3yxtFyrtFWrJr98JF10ywnF
        yrnF934DW3WUXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRTGQhUUUUU=
X-Originating-IP: [223.104.68.234]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwZFZFWB0jBpdQAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' some places in the comment.
Update 'the the' to 'then the' in 1 place.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/scsi/lpfc/lpfc_attr.c    | 10 +++++-----
 drivers/scsi/lpfc/lpfc_els.c     |  2 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c |  2 +-
 drivers/scsi/lpfc/lpfc_init.c    |  4 ++--
 drivers/scsi/lpfc/lpfc_mbox.c    |  4 ++--
 drivers/scsi/lpfc/lpfc_nvmet.c   |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c     |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 09cf2cd0ae60..2d92bb725225 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2438,7 +2438,7 @@ lpfc_sriov_hw_max_virtfn_show(struct device *dev,
 
 /**
  * lpfc_enable_bbcr_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2529,7 +2529,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * takes a default argument, a minimum and maximum argument.
  *
  * lpfc_##attr##_init: Initializes an attribute.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Validates the min and max values then sets the adapter config field
@@ -2562,7 +2562,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
  * into a function with the name lpfc_hba_queue_depth_set
  *
  * lpfc_##attr##_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2691,7 +2691,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * lpfc_##attr##_init: validates the min and max values then sets the
  * adapter config field accordingly, or uses the default if out of range
  * and prints an error message.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Returns:
@@ -2723,7 +2723,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val) \
  * lpfc_##attr##_set: validates the min and max values then sets the
  * adapter config field if in the valid range. prints error message
  * and does not set the parameter if invalid.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val:	integer attribute value.
  *
  * Returns:
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 9e69de9eb992..32aeac0416f1 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -8654,7 +8654,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
  * @rrq: Pointer to the rrq struct.
  *
  * Build a ELS RRQ command and send it to the target. If the issue_iocb is
- * Successful the the completion handler will clear the RRQ.
+ * successful then the completion handler will clear the RRQ.
  *
  * Return codes
  *   0 - Successfully sent rrq els iocb.
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 2645def612e6..70bd3704f131 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -2452,7 +2452,7 @@ static void lpfc_sli4_fcf_pri_list_del(struct lpfc_hba *phba,
  * @phba: pointer to lpfc hba data structure.
  * @fcf_index: the index of the fcf record to update
  * This routine acquires the hbalock and then set the LPFC_FCF_FLOGI_FAILED
- * flag so the the round robin slection for the particular priority level
+ * flag so the round robin slection for the particular priority level
  * will try a different fcf record that does not have this bit set.
  * If the fcf record is re-read for any reason this flag is cleared brfore
  * adding it to the priority list.
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 4a0eadd1c22c..2705c69ecd53 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5497,7 +5497,7 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	bf_set(lpfc_mbx_read_top_link_spd, la,
 	       (bf_get(lpfc_acqe_link_speed, acqe_link)));
 
-	/* Fake the the following irrelvant fields */
+	/* Fake the following irrelvant fields */
 	bf_set(lpfc_mbx_read_top_topology, la, LPFC_TOPOLOGY_PT_PT);
 	bf_set(lpfc_mbx_read_top_alpa_granted, la, 0);
 	bf_set(lpfc_mbx_read_top_il, la, 0);
@@ -12492,7 +12492,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			/* Mark CPU as IRQ not assigned by the kernel */
 			cpup->flag |= LPFC_CPU_MAP_UNASSIGN;
 
-			/* If so, find a new_cpup thats on the the SAME
+			/* If so, find a new_cpup thats on the SAME
 			 * phys_id as cpup. start_cpu will start where we
 			 * left off so all unassigned entries don't get assgined
 			 * the IRQ of the first entry.
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index 9858b1743769..cebb3d7598e5 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -2509,7 +2509,7 @@ lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also is used
  * to indicate where received unsolicited frames from this FCF will be sent. By
  * default this routine will set up the FCF to forward all unsolicited frames
- * the the RQ ID passed in the @phba. This can be overridden by the caller for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
@@ -2577,7 +2577,7 @@ lpfc_reg_fcfi(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also is used
  * to indicate where received unsolicited frames from this FCF will be sent. By
  * default this routine will set up the FCF to forward all unsolicited frames
- * the the RQ ID passed in the @phba. This can be overridden by the caller for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index f7cfac0da9b6..7517dd55fe91 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1469,7 +1469,7 @@ lpfc_nvmet_cleanup_io_context(struct lpfc_hba *phba)
 	if (!infop)
 		return;
 
-	/* Cycle the the entire CPU context list for every MRQ */
+	/* Cycle the entire CPU context list for every MRQ */
 	for (i = 0; i < phba->cfg_nvmet_mrq; i++) {
 		for_each_present_cpu(j) {
 			infop = lpfc_get_ctx_list(phba, j, i);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 608016725db9..c28127b5a975 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20540,7 +20540,7 @@ lpfc_log_fw_write_cmpl(struct lpfc_hba *phba, u32 shdr_status,
  * the offset after the write object mailbox has completed. @size is used to
  * determine the end of the object and whether the eof bit should be set.
  *
- * Return 0 is successful and offset will contain the the new offset to use
+ * Return 0 is successful and offset will contain the new offset to use
  * for the next write.
  * Return negative value for error cases.
  **/
-- 
2.25.1

