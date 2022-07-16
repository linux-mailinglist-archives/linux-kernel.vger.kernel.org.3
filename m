Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D825579F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbiGSNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243649AbiGSNOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:14:22 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A86AC06C4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:31:13 -0700 (PDT)
X-QQ-mid: bizesmtp90t1658233841t731ph7i
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:30:38 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000000
X-QQ-FEAT: Hom130/y8pliHFW6ARnu1U0PvZa/t/jTN7WyuojEkuSKiy17//NNpqs05KuKe
        61w1S3S30z1NYxkQlKS8UtwL2DCJsO1rT08BRgTmbJbrD7tt9++ce1rszrNze5E4s8aDdLq
        1LQTE4X7rZBXFEA+kBLs33pnYCRiA5kf3KvhmOLW9SdsqSyH1YGMMuI81NPbMS681p197Vm
        i2y4Y0JmaGgCddTQBtYLksm3E8Vs55Lp/nqNhWNg13lRJdKKg/EbCCpj0C49LzL29e9L1u3
        M8DZbCXq7fwBzdsXzve2A0RX9lsfJZzmsv919jMazws3P1FEASUejN+fkhgGdNH2xe6MrJT
        q1ELOdsFWQRGLO61NXPyt+cVdhWaMukABQHIaRyYJqkg+1nq9FmE5AX31u3+I/Hlmboywlx
        Sto3KYdwP98=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, evan.quan@amd.com,
        mario.limonciello@amd.com, Hawking.Zhang@amd.com,
        andrey.grodzovsky@amd.com, solomon.chiu@amd.com,
        kai.heng.feng@canonical.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/amdgpu: Fix comment typo
Date:   Sat, 16 Jul 2022 12:28:41 +0800
Message-Id: <20220716042841.40555-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3d139708160..b45cd7cbbea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -80,7 +80,7 @@
  * - 3.24.0 - Add high priority compute support for gfx9
  * - 3.25.0 - Add support for sensor query info (stable pstate sclk/mclk).
  * - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE.
- * - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_LIST creation.
+ * - 3.27.0 - Add new chunk to AMDGPU_CS to enable BO_LIST creation.
  * - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
  * - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID
  * - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE.
-- 
2.35.1

