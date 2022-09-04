Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4F5AC62C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiIDTcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiIDTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:32:11 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29DAE2F002
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=L6daq
        wHVQLkLiNfq8TDmxWwToy3Ef+On7jVkCO/wFL8=; b=JhMkxVCpy5sMBx4wkvAPw
        1i9+1KpKAhB/7BIKyoWfnEdXZiFkxhNobCYp8drXdmVJZ+mUVpxgMoY9x7JeTuDe
        PqdOL5sb5/uqX1TKNASl9opU0jQLDKtKsT65dYnUWV97dSv43eliBmXyEdOvQHMi
        dKSViBRDy2b9N5YE2pX4EI=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp12 (Coremail) with SMTP id EMCowADHKqkX_RRjiCK7Jg--.38130S4;
        Mon, 05 Sep 2022 03:31:48 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, ray.huang@amd.com, Jack.Xiao@amd.com,
        guchun.chen@amd.com, Likun.Gao@amd.com, en.brown@intel.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_fence.c
Date:   Mon,  5 Sep 2022 03:31:32 +0800
Message-Id: <20220904193132.15446-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADHKqkX_RRjiCK7Jg--.38130S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr17KFyDAr15tr17AFy5Jwb_yoW5CFW7pF
        4fK345KrWDZF1UWrW8AF1vvFnxKw1IqF1IgrW7A34Sgwn8CF15K3WIyrWjqryDCF4kuF4a
        kFW2v3y5ZF1jqF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEs2-OUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/1tbisgRyF1UMWQSWNAAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix everything checkpatch.pl complained about in amdgpu_fence.c

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8adeb7469f1e..ae9daf653ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2009 Jerome Glisse.
  * All Rights Reserved.
@@ -42,7 +43,6 @@
 #include "amdgpu_reset.h"
 
 /*
- * Fences
  * Fences mark an event in the GPUs pipeline and are used
  * for GPU/CPU synchronization.  When the fence is written,
  * it is expected that all buffers associated with that fence
@@ -139,7 +139,7 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
  * Returns 0 on success, -ENOMEM on failure.
  */
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
-		      unsigned flags)
+		      unsigned int flags)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence;
@@ -173,8 +173,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 				       adev->fence_context + ring->idx, seq);
 			/* Against remove in amdgpu_job_{free, free_cb} */
 			dma_fence_get(fence);
-		}
-		else
+		} else
 			dma_fence_init(fence, &amdgpu_fence_ops,
 				       &ring->fence_drv.lock,
 				       adev->fence_context + ring->idx, seq);
@@ -393,7 +392,7 @@ signed long amdgpu_fence_wait_polling(struct amdgpu_ring *ring,
  * Returns the number of emitted fences on the ring.  Used by the
  * dynpm code to ring track activity.
  */
-unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
+unsigned int amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
 {
 	uint64_t emitted;
 
@@ -422,7 +421,7 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
  */
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 				   struct amdgpu_irq_src *irq_src,
-				   unsigned irq_type)
+				   unsigned int irq_type)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint64_t index;
@@ -594,6 +593,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
@@ -772,6 +772,7 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (!ring || !ring->fence_drv.initialized)
 			continue;
 
@@ -845,6 +846,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
 						  reset_work);
 
 	struct amdgpu_reset_context reset_context;
+
 	memset(&reset_context, 0, sizeof(reset_context));
 
 	reset_context.method = AMD_RESET_METHOD_NONE;

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
prerequisite-patch-id: f039528bc88876d6e0f64e843da089e85f6d3f58
-- 
2.34.1

