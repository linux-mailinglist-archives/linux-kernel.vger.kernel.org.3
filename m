Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5954FB6F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbiDKJKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbiDKJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E182DD7C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EBBD60B28
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B270EC385A5;
        Mon, 11 Apr 2022 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668092;
        bh=7ITM84XSS4rTe6m6AHntJrSgjeFGYBefJrRPYhZleDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAfGQQVUTI+G0rwRthAqwtFsO0Oa5PlPh32aGNTXSzrdpKgIZugs/XqBWsWxLxhcL
         zDDHzKnH99iljHVhs6/uTADQqT8crDekb6TqISVYOHlo1IHyZUvTksrhneaEnryPtV
         oaY8cpKn0K05dmMFmHhaCgdREVNhi8v7KNNkvToi3uY9mXyuEjgVOQ+GfortzQKLRb
         Dwn5lqOzJVIBeIAraxJDmuBvpDQmezxe+qqqquoZVdQCqACiV5ZduB7lszxBwAILfO
         P5L5IgqBlu6tFoLcA4oWZR9Evpu5Tu+Bb4KBk+oNX14WKptss1OJiXnV5F2Si3GeOT
         DN0Cz5tmzN8Xw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 3/7] habanalabs: fix comments according to kernel-doc
Date:   Mon, 11 Apr 2022 12:08:01 +0300
Message-Id: <20220411090805.1617112-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090805.1617112-1-ogabbay@kernel.org>
References: <20220411090805.1617112-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Incorrect/Missing doxygen tag

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c    |  2 +-
 drivers/misc/habanalabs/common/memory_mgr.c        | 14 +++++++-------
 drivers/misc/habanalabs/common/mmu/mmu.c           |  1 +
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 23370aa67bcd..6c13ae3ffa7c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2667,7 +2667,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct multi_cs_completion *mcs_compl;
 	struct hl_device *hdev = hpriv->hdev;
-	struct multi_cs_data mcs_data = {0};
+	struct multi_cs_data mcs_data = {};
 	union hl_wait_cs_args *args = data;
 	struct hl_ctx *ctx = hpriv->ctx;
 	struct hl_fence **fence_arr;
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index a1f499a1519c..1bc23362e61d 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -35,7 +35,7 @@ struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg, u32 handle)
 }
 
 /**
- * @hl_mmap_mem_buf_release - release buffer
+ * hl_mmap_mem_buf_release - release buffer
  *
  * @kref: kref that reached 0.
  *
@@ -58,7 +58,7 @@ static void hl_mmap_mem_buf_release(struct kref *kref)
 }
 
 /**
- * @hl_mmap_mem_buf_put - decrease the reference to the buffer
+ * hl_mmap_mem_buf_put - decrease the reference to the buffer
  *
  * @buf: memory manager buffer descriptor
  *
@@ -71,7 +71,7 @@ int hl_mmap_mem_buf_put(struct hl_mmap_mem_buf *buf)
 }
 
 /**
- * @hl_mmap_mem_buf_alloc - allocate a new mappable buffer
+ * hl_mmap_mem_buf_alloc - allocate a new mappable buffer
  *
  * @mmg: parent unifed memory manager
  * @behavior: behavior object describing this buffer polymorphic behavior
@@ -127,7 +127,7 @@ hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 }
 
 /**
- * @hl_mmap_mem_buf_vm_close - handle mmap close
+ * hl_mmap_mem_buf_vm_close - handle mmap close
  *
  * @vma: the vma object for which mmap was closed.
  *
@@ -156,7 +156,7 @@ static const struct vm_operations_struct hl_mmap_mem_buf_vm_ops = {
 };
 
 /**
- * @hl_mem_mgr_mmap - map the given buffer to the user
+ * hl_mem_mgr_mmap - map the given buffer to the user
  *
  * @mmg: unifed memory manager
  * @vma: the vma object for which mmap was closed.
@@ -240,7 +240,7 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 }
 
 /**
- * @hl_mem_mgr_init - initialize unified memory manager
+ * hl_mem_mgr_init - initialize unified memory manager
  *
  * @dev: owner device pointer
  * @mmg: structure to initialize
@@ -255,7 +255,7 @@ void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg)
 }
 
 /**
- * @hl_mem_mgr_fini - release unified memory manager
+ * hl_mem_mgr_fini - release unified memory manager
  *
  * @mmg: parent unifed memory manager
  *
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index dcd59d76da27..04e53af4c67f 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -684,6 +684,7 @@ u64 hl_mmu_get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
 /**
  * hl_mmu_get_hop_pte_phys_addr() - extract PTE address from HOP
  * @ctx: pointer to the context structure to initialize.
+ * @mmu_prop: MMU properties.
  * @hop_idx: HOP index.
  * @hop_addr: HOP address.
  * @virt_addr: virtual address fro the translation.
-- 
2.25.1

