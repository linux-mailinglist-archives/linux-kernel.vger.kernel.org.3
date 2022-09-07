Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5910A5B032A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIGLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIGLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:35:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E597DB9FB0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:34:20 -0700 (PDT)
X-QQ-mid: bizesmtp70t1662550448t7p0sw9z
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Sep 2022 19:34:06 +0800 (CST)
X-QQ-SSF: 01000000002000D0F000B00A0000000
X-QQ-FEAT: tyV+f0f3wWf3mzAF6yuQD2XFCuVrWLDfbXKR9+7cPP3XEZkE/o20yVe8bxTU6
        weyb0VEV+AoU5qA3QVTolXruJk+6Jjrv7a4skhXx55wFjqrY0CqBGa19yWmoznLSwpdBvFP
        ld2ZLW7zrewWopwIAn4v7RcgE07fI3/TxxeqnuIabTORAVM42cM24jI6n0Yzask+RdpuQeY
        7UQBwDVjrZoQgJ1YGu1cP3QuHHLyaFhiFqdSO/VNkZ4SnIz+VAvMyYJartdonSezEvZHw4N
        YT5x62FDG6Z8A6Det6SPGWM+e0tt98mPguxzV16oJsQZjDhT7nf9rW+JOcHZcG8Sq/PAaYt
        VjTToQVece6xD1m5VKKsEul0H/9wN/eENneqoeuO+COQ+SAuUgaKsWtPg+uQw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch, shaoyun.liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/amdgpu: fix repeated words in comments
Date:   Wed,  7 Sep 2022 19:34:00 +0800
Message-Id: <20220907113400.30590-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'and'.
Delete the redundant word 'in'.
Delete the redundant word 'the'.
Delete the redundant word 'are'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index afaa1056e039..71367b9dd590 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -958,7 +958,7 @@ static void amdgpu_device_vram_scratch_fini(struct amdgpu_device *adev)
  * @registers: pointer to the register array
  * @array_size: size of the register array
  *
- * Programs an array or registers with and and or masks.
+ * Programs an array or registers with and or masks.
  * This is a helper for setting golden registers.
  */
 void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
@@ -1569,7 +1569,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
  * @state: vga_switcheroo state
  *
  * Callback for the switcheroo driver.  Suspends or resumes the
- * the asics before or after it is powered up using ACPI methods.
+ * asics before or after it is powered up using ACPI methods.
  */
 static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 					enum vga_switcheroo_state state)
@@ -3203,7 +3203,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
  *
  * Main resume function for hardware IPs.  The hardware IPs
  * are split into two resume functions because they are
- * are also used in in recovering from a GPU reset and some additional
+ * also used in recovering from a GPU reset and some additional
  * steps need to be take between them.  In this case (S3/S4) they are
  * run sequentially.
  * Returns 0 on success, negative error code on failure.
-- 
2.36.1

