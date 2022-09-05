Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0225ACE05
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbiIEIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiIEIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:39:10 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0D46FCE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=n8jim
        TPIu9UZqmJ995DXsFwWDfsZzJcQTg3Vl6nj2zY=; b=YlwtPGXQv/fCjAYEgE3qn
        urPQTVYmWyEt5HtUOdQD0y3rOzZpf35gQaJckJlw8xhrht87fpDqc8tL1kkQYIpx
        WVBFsBvA13MGslON0XvwmZ+tAgP3o7sPPHLWb3au9QbWLp9ru/peDRXAmgAjOFce
        FxI59KcN9owrcxsj3zUDjY=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp11 (Coremail) with SMTP id D8CowAB3RIGEtRVjxaMXAA--.4936S4;
        Mon, 05 Sep 2022 16:38:48 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_amdkfd_gpuvm.c
Date:   Mon,  5 Sep 2022 16:38:25 +0800
Message-Id: <20220905083825.23429-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAB3RIGEtRVjxaMXAA--.4936S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4UZr1kGry5GF4DArWrXwb_yoW8GF1xpF
        4fAr12gFWUZr12y347Ca95Xa4YyayxW3WUGrW7Wrya9345JF95Aa4rtrWUCr97XF4DCFs7
        ta9rt3yUZFyI9r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEsXonUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBaRpzF1Xly1cDCgAAsy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix everything checkpatch.pl complained about in amdgpu_amdkfd_gpuvm.c

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cbd593f7d553..eff596c60c89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2014-2018 Advanced Micro Devices, Inc.
  *
@@ -1612,6 +1613,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 	uint64_t reserved_for_pt =
 		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
 	size_t available;
+
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 	available = adev->gmc.real_vram_size
 		- adev->kfd.vram_used_aligned
@@ -2216,7 +2218,7 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device *adev,
 {
 	if (atomic_read(&adev->gmc.vm_fault_info_updated) == 1) {
 		*mem = *adev->gmc.vm_fault_info;
-		mb();
+		mb(); /* make sure read happened */
 		atomic_set(&adev->gmc.vm_fault_info_updated, 0);
 	}
 	return 0;

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
-- 
2.34.1

