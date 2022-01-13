Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC548D016
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiAMBWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:22:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55633 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229838AbiAMBV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:21:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V1hGH.A_1642036915;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1hGH.A_1642036915)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 09:21:56 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] drm/amdgpu: clean up some inconsistent indenting
Date:   Thu, 13 Jan 2022 09:21:50 +0800
Message-Id: <20220113012150.87399-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220113012150.87399-1-yang.lee@linux.alibaba.com>
References: <20220113012150.87399-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3504 amdgpu_device_init()
warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1716
amdgpu_ras_error_status_query() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:2724 amdgpu_ras_set_context()
warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1058 amdgpu_ras_error_inject()
warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 33388041c354..64d6c0af4c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3499,7 +3499,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->notifier_lock);
 	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 
-	 amdgpu_device_init_apu_flags(adev);
+	amdgpu_device_init_apu_flags(adev);
 
 	r = amdgpu_device_check_arguments(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7d9d99e581da..6d84749698c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1055,8 +1055,10 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 		.address = info->address,
 		.value = info->value,
 	};
-    int ret = -EINVAL;
-    struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);
+	int ret = -EINVAL;
+	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev,
+							info->head.block,
+							info->head.sub_block_index);
 
 	if (!obj)
 		return -EINVAL;
@@ -1714,7 +1716,7 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	}
 
 	if (block_obj->hw_ops->query_ras_error_status)
-	block_obj->hw_ops->query_ras_error_status(adev);
+		block_obj->hw_ops->query_ras_error_status(adev);
 
 }
 
@@ -2722,7 +2724,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras* ras_con)
 {
 	if (!adev)
-	return -EINVAL;
+		return -EINVAL;
 
 	adev->psp.ras_context.ras = ras_con;
 	return 0;
-- 
2.20.1.7.g153144c

