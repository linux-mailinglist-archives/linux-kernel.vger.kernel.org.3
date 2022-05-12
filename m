Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D695246C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbiELHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbiELHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:19:47 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD1C5E64
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:19:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VCzsZQ9_1652339976;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCzsZQ9_1652339976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 15:19:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: clean up some inconsistent indenting
Date:   Thu, 12 May 2022 15:19:34 +0800
Message-Id: <20220512071934.119922-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9687
amdgpu_dm_atomic_commit_tail() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e2b57cf6506c..a92cfb055c15 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9681,9 +9681,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		dm_enable_per_frame_crtc_master_sync(dc_state);
 		mutex_lock(&dm->dc_lock);
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
-               /* Allow idle optimization when vblank count is 0 for display off */
-               if (dm->active_vblank_irq_count == 0)
-                   dc_allow_idle_optimizations(dm->dc,true);
+
+		/* Allow idle optimization when vblank count is 0 for display off */
+		if (dm->active_vblank_irq_count == 0)
+			dc_allow_idle_optimizations(dm->dc, true);
 		mutex_unlock(&dm->dc_lock);
 	}
 
-- 
2.20.1.7.g153144c

