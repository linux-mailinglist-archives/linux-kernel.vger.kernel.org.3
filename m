Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0E57B52B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiGTLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202928729
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C76E61CCD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF68C3411E;
        Wed, 20 Jul 2022 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315737;
        bh=79Q0Xh7Yht9YMz1vJqOVE/JW4zcpekOC9wgrcZXMqmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgcXoZVd8QykfnTyN8efytgLYgA1J8P9WgZIAv7lnocZRFepgEPsK0HkcW8AT4IDe
         1/3OkFiCJQzqwKV4GdICkdgQ1RakbNHAGkaRxTK4/BixHW94gKfRu4sZXtYxQDFCd1
         2R7Cj9B852sSjq81FHsDmOHse6fTitAoMLUMd5jFvbX6CCnpvFZu5C+2idPt7POW+P
         Z5OoYNFAzZ4lT/lCniB7o8aMhmiGvFbwkwiIaKAYBFGaIw2Sk5j4M5TZVUQitRqGnX
         qvMOHDaXz8Z9+KHNU/7odjEOnQsxSdeKls9TseeJGiPUJLNmMh/Amv5SkMVyWLXBPM
         /uXpaEMOmghdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 7/9] habanalabs: fix spelling mistakes
Date:   Wed, 20 Jul 2022 14:15:21 +0300
Message-Id: <20220720111523.4069830-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

Cosmetic commit, no logical changes. It just fixes the spelling
mistakes.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c |  8 +++---
 drivers/misc/habanalabs/common/habanalabs.h  | 27 ++++++++++----------
 drivers/misc/habanalabs/common/memory_mgr.c  | 10 ++++----
 include/uapi/misc/habanalabs.h               | 10 ++++----
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 608ca67527a5..58c1eff16df6 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1514,7 +1514,7 @@ int hl_fw_read_preboot_status(struct hl_device *hdev)
 	hdev->asic_funcs->init_firmware_preload_params(hdev);
 
 	/*
-	 * In order to determine boot method (static VS dymanic) we need to
+	 * In order to determine boot method (static VS dynamic) we need to
 	 * read the boot caps register
 	 */
 	rc = hl_fw_read_preboot_caps(hdev);
@@ -1781,7 +1781,7 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
  *
  * @return the CRC32 result
  *
- * NOTE: kernel's CRC32 differ's from standard CRC32 calculation.
+ * NOTE: kernel's CRC32 differs from standard CRC32 calculation.
  *       in order to be aligned we need to flip the bits of both the input
  *       initial CRC and kernel's CRC32 result.
  *       in addition both sides use initial CRC of 0,
@@ -1798,7 +1798,7 @@ static u32 hl_fw_compat_crc32(u8 *data, size_t size)
  *
  * @hdev: pointer to the habanalabs device structure
  * @addr: device address of memory transfer
- * @size: memory transter size
+ * @size: memory transfer size
  * @region: PCI memory region
  *
  * @return 0 on success, otherwise non-zero error code
@@ -2547,7 +2547,7 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	/*
 	 * when testing FW load (without Linux) on PLDM we don't want to
 	 * wait until boot fit is active as it may take several hours.
-	 * instead, we load the bootfit and let it do all initializations in
+	 * instead, we load the bootfit and let it do all initialization in
 	 * the background.
 	 */
 	if (hdev->pldm && !(hdev->fw_components & FW_TYPE_LINUX))
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8c2c94fb1322..350bc5b9f174 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -94,7 +94,7 @@ struct hl_fpriv;
 #define MMU_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
 /**
- * enum hl_mmu_page_table_locaion - mmu page table location
+ * enum hl_mmu_page_table_location - mmu page table location
  * @MMU_DR_PGT: page-table is located on device DRAM.
  * @MMU_HR_PGT: page-table is located on host memory.
  * @MMU_NUM_PGT_LOCATIONS: number of page-table locations currently supported.
@@ -800,7 +800,7 @@ struct hl_fence {
  * @lock: spinlock to protect fence.
  * @hdev: habanalabs device structure.
  * @hw_sob: the H/W SOB used in this signal/wait CS.
- * @encaps_sig_hdl: encaps signals hanlder.
+ * @encaps_sig_hdl: encaps signals handler.
  * @cs_seq: command submission sequence number.
  * @type: type of the CS - signal/wait.
  * @sob_val: the SOB value that is used in this signal/wait CS.
@@ -908,7 +908,7 @@ struct hl_mmap_mem_buf {
  * @size: holds the CB's size.
  * @cs_cnt: holds number of CS that this CB participates in.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
- * @is_internal: internaly allocated
+ * @is_internal: internally allocated
  * @is_mmu_mapped: true if the CB is mapped to the device's MMU.
  */
 struct hl_cb {
@@ -1116,7 +1116,7 @@ struct timestamp_reg_info {
  * @fence: hl fence object for interrupt completion
  * @cq_target_value: CQ target value
  * @cq_kernel_addr: CQ kernel address, to be used in the cq interrupt
- *                  handler for taget value comparison
+ *                  handler for target value comparison
  */
 struct hl_user_pending_interrupt {
 	struct timestamp_reg_info	ts_reg_info;
@@ -1742,10 +1742,10 @@ struct hl_cs_outcome {
 
 /**
  * struct hl_cs_outcome_store - represents a limited store of completed CS outcomes
- * @outcome_map: index of completed CS searcheable by sequence number
+ * @outcome_map: index of completed CS searchable by sequence number
  * @used_list: list of outcome objects currently in use
  * @free_list: list of outcome objects currently not in use
- * @nodes_pool: a static pool of preallocated outcome objects
+ * @nodes_pool: a static pool of pre-allocated outcome objects
  * @db_lock: any operation on the store must take this lock
  */
 struct hl_cs_outcome_store {
@@ -1769,7 +1769,7 @@ struct hl_cs_outcome_store {
  * @refcount: reference counter for the context. Context is released only when
  *		this hits 0l. It is incremented on CS and CS_WAIT.
  * @cs_pending: array of hl fence objects representing pending CS.
- * @outcome_store: storage data structure used to remember ouitcomes of completed
+ * @outcome_store: storage data structure used to remember outcomes of completed
  *                 command submissions for a long time after CS id wraparound.
  * @va_range: holds available virtual addresses for host and dram mappings.
  * @mem_hash_lock: protects the mem_hash.
@@ -1838,7 +1838,6 @@ struct hl_ctx_mgr {
 };
 
 
-
 /*
  * COMMAND SUBMISSIONS
  */
@@ -1904,7 +1903,7 @@ struct hl_userptr {
  * @tdr_active: true if TDR was activated for this CS (to prevent
  *		double TDR activation).
  * @aborted: true if CS was aborted due to some device error.
- * @timestamp: true if a timestmap must be captured upon completion.
+ * @timestamp: true if a timestamp must be captured upon completion.
  * @staged_last: true if this is the last staged CS and needs completion.
  * @staged_first: true if this is the first staged CS and we need to receive
  *                timeout for this CS.
@@ -2229,7 +2228,7 @@ struct hl_info_list {
 
 /**
  * struct hl_debugfs_entry - debugfs dentry wrapper.
- * @info_ent: dentry realted ops.
+ * @info_ent: dentry related ops.
  * @dev_entry: ASIC specific debugfs manager.
  */
 struct hl_debugfs_entry {
@@ -2934,7 +2933,7 @@ struct razwi_info {
  * struct undefined_opcode_info - info about last undefined opcode error
  * @timestamp: timestamp of the undefined opcode error
  * @cb_addr_streams: CB addresses (per stream) that are currently exists in the PQ
- *                   entiers. In case all streams array entries are
+ *                   entries. In case all streams array entries are
  *                   filled with values, it means the execution was in Lower-CP.
  * @cq_addr: the address of the current handled command buffer
  * @cq_size: the size of the current handled command buffer
@@ -2975,7 +2974,7 @@ struct last_error_session_info {
 /**
  * struct hl_reset_info - holds current device reset information.
  * @lock: lock to protect critical reset flows.
- * @compute_reset_cnt: number of compte resets since the driver was loaded.
+ * @compute_reset_cnt: number of compute resets since the driver was loaded.
  * @hard_reset_cnt: number of hard resets since the driver was loaded.
  * @hard_reset_schedule_flags: hard reset is scheduled to after current compute reset,
  *                             here we hold the hard reset flags.
@@ -2986,7 +2985,7 @@ struct last_error_session_info {
  * @hard_reset_pending: is there a hard reset work pending.
  * @curr_reset_cause: saves an enumerated reset cause when a hard reset is
  *                    triggered, and cleared after it is shared with preboot.
- * @prev_reset_trigger: saves the previous trigger which caused a reset, overidden
+ * @prev_reset_trigger: saves the previous trigger which caused a reset, overridden
  *                      with a new value on next reset
  * @reset_trigger_repeated: set if device reset is triggered more than once with
  *                          same cause.
@@ -3064,7 +3063,7 @@ struct hl_reset_info {
  * @hl_chip_info: ASIC's sensors information.
  * @device_status_description: device status description.
  * @hl_debugfs: device's debugfs manager.
- * @cb_pool: list of preallocated CBs.
+ * @cb_pool: list of pre allocated CBs.
  * @cb_pool_lock: protects the CB pool.
  * @internal_cb_pool_virt_addr: internal command buffer pool virtual address.
  * @internal_cb_pool_dma_addr: internal command buffer pool dma address.
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 56df962d2f3c..1936d653699e 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -11,7 +11,7 @@
  * hl_mmap_mem_buf_get - increase the buffer refcount and return a pointer to
  *                        the buffer descriptor.
  *
- * @mmg: parent unifed memory manager
+ * @mmg: parent unified memory manager
  * @handle: requested buffer handle
  *
  * Find the buffer in the store and return a pointer to its descriptor.
@@ -104,7 +104,7 @@ int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf)
  * hl_mmap_mem_buf_put_handle - decrease the reference to the buffer with the
  *                              given handle.
  *
- * @mmg: parent unifed memory manager
+ * @mmg: parent unified memory manager
  * @handle: requested buffer handle
  *
  * Decrease the reference to the buffer, and release it if it was the last one.
@@ -137,7 +137,7 @@ int hl_mmap_mem_buf_put_handle(struct hl_mem_mgr *mmg, u64 handle)
 /**
  * hl_mmap_mem_buf_alloc - allocate a new mappable buffer
  *
- * @mmg: parent unifed memory manager
+ * @mmg: parent unified memory manager
  * @behavior: behavior object describing this buffer polymorphic behavior
  * @gfp: gfp flags to use for the memory allocations
  * @args: additional args passed to behavior->alloc
@@ -222,7 +222,7 @@ static const struct vm_operations_struct hl_mmap_mem_buf_vm_ops = {
 /**
  * hl_mem_mgr_mmap - map the given buffer to the user
  *
- * @mmg: unifed memory manager
+ * @mmg: unified memory manager
  * @vma: the vma object for which mmap was closed.
  * @args: additional args passed to behavior->mmap
  *
@@ -322,7 +322,7 @@ void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg)
 /**
  * hl_mem_mgr_fini - release unified memory manager
  *
- * @mmg: parent unifed memory manager
+ * @mmg: parent unified memory manager
  *
  * Release the unified memory manager. Shall be called from an interrupt context.
  */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 5d06d5c74dd1..be06b1307c44 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -876,13 +876,13 @@ struct hl_info_hw_idle {
 	__u32 is_idle;
 	/*
 	 * Bitmask of busy engines.
-	 * Bits definition is according to `enum <chip>_enging_id'.
+	 * Bits definition is according to `enum <chip>_engine_id'.
 	 */
 	__u32 busy_engines_mask;
 
 	/*
 	 * Extended Bitmask of busy engines.
-	 * Bits definition is according to `enum <chip>_enging_id'.
+	 * Bits definition is according to `enum <chip>_engine_id'.
 	 */
 	__u64 busy_engines_mask_ext[HL_BUSY_ENGINES_MASK_EXT_SIZE];
 };
@@ -1078,12 +1078,12 @@ struct hl_info_razwi_event {
  * struct hl_info_undefined_opcode_event - info about last undefined opcode error
  * @timestamp: timestamp of the undefined opcode error
  * @cb_addr_streams: CB addresses (per stream) that are currently exists in the PQ
- *                   entiers. In case all streams array entries are
+ *                   entries. In case all streams array entries are
  *                   filled with values, it means the execution was in Lower-CP.
  * @cq_addr: the address of the current handled command buffer
  * @cq_size: the size of the current handled command buffer
  * @cb_addr_streams_len: num of streams - actual len of cb_addr_streams array.
- *                       should be equal to 1 incase of undefined opcode
+ *                       should be equal to 1 in case of undefined opcode
  *                       in Upper-CP (specific stream) and equal to 4 incase
  *                       of undefined opcode in Lower-CP.
  * @engine_id: engine-id that the error occurred on
@@ -1412,7 +1412,7 @@ struct hl_cs_out {
 
 		/* Valid only when HL_CS_FLAGS_RESERVE_SIGNALS_ONLY is set */
 		struct {
-			/* This is the resereved signal handle id */
+			/* This is the reserved signal handle id */
 			__u32 handle_id;
 
 			/* This is the signals count */
-- 
2.25.1

