Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933205397C6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347666AbiEaUIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiEaUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:08:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7497299;
        Tue, 31 May 2022 13:08:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so3329924pjs.1;
        Tue, 31 May 2022 13:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIlTvNQCOLyj5QYBgLjFuJKAi3jXSDwMPRUpJqRAlyI=;
        b=V47/nwt1rg0trFoHkq1rcjJntJUe53RkSjuHjspR9T338P3kjd1OIeyyLjqMMUuo3Q
         iPzDz6rIP1uHRlbwK6q2C4Faj4tCr7BmFFc5zJFq6Ihp87BiZ7TCfgL6NUpaYCnz5mBC
         FfbI/rm0VTDhHVfBHCDOyqgEnUetYgsW320wmS621UQ7IjegQhqSzzv0t0ody3l4/RCc
         +2G8wYqR9UAsB6J8TGIoGcHvui7lLaLiChc1DyqKtNtYDCOsGao1iI7Ja5UrzHXCPZR3
         DqL25Zn+axwwRSC/eJCH7IQu3sTWz4rPgUIMas5x39g3DbYY5MGt8pAvZBV2VCryM4Bb
         yNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIlTvNQCOLyj5QYBgLjFuJKAi3jXSDwMPRUpJqRAlyI=;
        b=iGFrNgENDRySwbg54Xy/R76nlSLmLejjn0M0GqY03oJi7DDrYrKivg/C7+NQfij9go
         T2mdSFN2vZHetXXu2nnYeuJYYBsTxjoOngMHLH/hd89+Vl14vIV3POuki3EB6fxKkKGm
         WVcLO+gZTTanYyvN4LjAN/14LdBQjCJERI1ef2tGViFpuESWb3U2V/C5P1AiMppjNtiJ
         FEBa9uZ2PFPxUfLhYv+ICXfjmzGDnbobA1GxuzjDoewNCos8p2idEnteM1w1iP+KmnW7
         nvptadI5qbk4e/cA1p9b79yclgxjwXug84vN4sdNHogxnyQyEYW4fXFqeliwJ9VfvPG6
         AtBA==
X-Gm-Message-State: AOAM533F2f23sgpVWNlB0xr0QkHbhTYEIzrVlqafIIHLZqejhiS5B9av
        VbB270kwJ41D8soSQ/LellJPX40jfV0=
X-Google-Smtp-Source: ABdhPJzstetsR+Bwh6vbo+RGs7C4Ljt6yWFL0Fym5keJ831UNf5WjeyP55xY+H/RquR5Wk7AiL/zdg==
X-Received: by 2002:a17:902:f789:b0:163:935d:aa69 with SMTP id q9-20020a170902f78900b00163935daa69mr22475063pln.165.1654027729564;
        Tue, 31 May 2022 13:08:49 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b005184c9c46dbsm11162319pfn.81.2022.05.31.13.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:08:48 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Ensure mmap offset is initialized
Date:   Tue, 31 May 2022 13:08:56 -0700
Message-Id: <20220531200857.136547-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If a GEM object is allocated, and then exported as a dma-buf fd which is
mmap'd before or without the GEM buffer being directly mmap'd, the
vma_node could be unitialized.  This leads to a situation where the CPU
mapping is not correctly torn down in drm_vma_node_unmap().

Fixes: e5516553999f ("drm: call drm_gem_object_funcs.mmap with fake offset")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c       |  2 +-
 drivers/gpu/drm/msm/msm_drv.h       |  1 +
 drivers/gpu/drm/msm/msm_gem_prime.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 44485363f37a..14ab9a627d8b 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -964,7 +964,7 @@ static const struct drm_driver msm_driver = {
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
-	.gem_prime_mmap     = drm_gem_prime_mmap,
+	.gem_prime_mmap     = msm_gem_prime_mmap,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = msm_debugfs_init,
 #endif
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index bb052071b16d..090b8074fec7 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -275,6 +275,7 @@ unsigned long msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_t
 void msm_gem_shrinker_init(struct drm_device *dev);
 void msm_gem_shrinker_cleanup(struct drm_device *dev);
 
+int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj);
 int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index 94ab705e9b8a..dcc8a573bc76 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -11,6 +11,21 @@
 #include "msm_drv.h"
 #include "msm_gem.h"
 
+int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
+{
+	int ret;
+
+	/* Ensure the mmap offset is initialized.  We lazily initialize it,
+	 * so if it has not been first mmap'd directly as a GEM object, the
+	 * mmap offset will not be already initialized.
+	 */
+	ret = drm_gem_create_mmap_offset(obj);
+	if (ret)
+		return ret;
+
+	return drm_gem_prime_mmap(obj, vma);
+}
+
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-- 
2.36.1

