Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57335587F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiHBPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbiHBPwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:52:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98F41994;
        Tue,  2 Aug 2022 08:51:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 206so9189625pgb.0;
        Tue, 02 Aug 2022 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kFWCPQ026Vm0ssc92OEIjelADHl+en2PNRs5WLmvYxM=;
        b=HGAytMNkJs+PiiKRsOJYl2t2RyafEOOCiFkupWytHV4W5pAS7xMTpuBmg9rUW0doOs
         /Wc2NE6YVKDMDzRyeQ79uCUX/Ekjc/fX/iBIEXUUPRBDiDwiWpT+kZjUGVQtnagRGr4i
         Y3K+C6zKq/Xc91RBy1xoRqInViCWUIHFsJDV5vhxPF8ERPmbBPiluEdbV3dlcovz6M1/
         wBa3GqELCIJrSohEvvak1Vd+AbcXUYYdVnvpStDfltQ798w+ZWS7kVKG3KwpvAuDkEG6
         Zvu8zd0fM72HoPm01yo9PzxO9cuOEyCasreaRaCJOLPielxARS/nQ8Jwovze9OUYhmqZ
         jBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kFWCPQ026Vm0ssc92OEIjelADHl+en2PNRs5WLmvYxM=;
        b=H+9m7Ri9OXZ6b3DmcjzSce5S3sNG2+VoVZMypsJkhP9liXADIjc5v6cBx3Y3Eo3yOj
         MQ9PUzgRvvxmKYZ7Ac8X+7rbCfSoEalerN0zNgvRzVZqFNAGpq3vJ9nlmAE7nstcBzsQ
         edi/eUVoEqX/hoajCKiZXtgCNUXC2/lhhVrJnn066Mc9x9ZYmp6JeUWJRNgWebV7BfrR
         szaEFCtw7FG20oQNxZnw8ngbrMU4E0YhRBT7rM3r8D/HSAP8TwDx/TpeWK7osKfgTdDY
         IBlU2IVXPmXWojMR6L2AgyrveRvu3Ypiui1aFJLZaBoOPhhVsZU0D9UEkFSJQSV/O1Dj
         Z2GA==
X-Gm-Message-State: AJIora+EroxNBcxuOfZViYaoawy+/hefiGhNXEw5CqNens0mSoh0zGL7
        W7/3P+2Uffxzrn5HCWoWWLE=
X-Google-Smtp-Source: AA6agR4oR61wZ7xUWIXU+CtyFCFQdPK1uessy7b6wLzzRXgX42+hXqT1mT3T3t6+pmHAjUr/Z/oCgA==
X-Received: by 2002:a05:6a00:8c8:b0:52c:887d:fa25 with SMTP id s8-20020a056a0008c800b0052c887dfa25mr21443316pfu.86.1659455512059;
        Tue, 02 Aug 2022 08:51:52 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902e14900b0016be9fa6807sm11739322pla.284.2022.08.02.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:51 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 13/15] drm/msm/gem: Evict active GEM objects when necessary
Date:   Tue,  2 Aug 2022 08:51:46 -0700
Message-Id: <20220802155152.1727594-14-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If we are under enough memory pressure, we should stall waiting for
active buffers to become idle in order to evict.

v2: Check for __GFP_ATOMIC before blocking

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 70 +++++++++++++++++++++-----
 drivers/gpu/drm/msm/msm_gpu_trace.h    | 16 +++---
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 5cc05d669a08..f31054d25314 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -24,6 +24,13 @@ static bool can_swap(void)
 	return enable_eviction && get_nr_swap_pages() > 0;
 }
 
+static bool can_block(struct shrink_control *sc)
+{
+	if (sc->gfp_mask & __GFP_ATOMIC)
+		return false;
+	return current_is_kswapd() || (sc->gfp_mask & __GFP_RECLAIM);
+}
+
 static unsigned long
 msm_gem_shrinker_count(struct shrinker *shrinker, struct shrink_control *sc)
 {
@@ -65,26 +72,65 @@ evict(struct drm_gem_object *obj)
 	return true;
 }
 
+static bool
+wait_for_idle(struct drm_gem_object *obj)
+{
+	enum dma_resv_usage usage = dma_resv_usage_rw(true);
+	return dma_resv_wait_timeout(obj->resv, usage, false, 1000) > 0;
+}
+
+static bool
+active_purge(struct drm_gem_object *obj)
+{
+	if (!wait_for_idle(obj))
+		return false;
+
+	return purge(obj);
+}
+
+static bool
+active_evict(struct drm_gem_object *obj)
+{
+	if (!wait_for_idle(obj))
+		return false;
+
+	return evict(obj);
+}
+
 static unsigned long
 msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
 {
 	struct msm_drm_private *priv =
 		container_of(shrinker, struct msm_drm_private, shrinker);
+	struct {
+		struct drm_gem_lru *lru;
+		bool (*shrink)(struct drm_gem_object *obj);
+		bool cond;
+		unsigned long freed;
+	} stages[] = {
+		/* Stages of progressively more aggressive/expensive reclaim: */
+		{ &priv->lru.dontneed, purge,        true },
+		{ &priv->lru.willneed, evict,        can_swap() },
+		{ &priv->lru.dontneed, active_purge, can_block(sc) },
+		{ &priv->lru.willneed, active_evict, can_swap() && can_block(sc) },
+	};
 	long nr = sc->nr_to_scan;
-	unsigned long freed, purged, evicted = 0;
-
-	purged = drm_gem_lru_scan(&priv->lru.dontneed, nr, purge);
-	nr -= purged;
-
-	if (can_swap() && nr > 0) {
-		evicted = drm_gem_lru_scan(&priv->lru.willneed, nr, evict);
-		nr -= evicted;
+	unsigned long freed = 0;
+
+	for (unsigned i = 0; (nr > 0) && (i < ARRAY_SIZE(stages)); i++) {
+		if (!stages[i].cond)
+			continue;
+		stages[i].freed =
+			drm_gem_lru_scan(stages[i].lru, nr, stages[i].shrink);
+		nr -= stages[i].freed;
+		freed += stages[i].freed;
 	}
 
-	freed = purged + evicted;
-
-	if (freed)
-		trace_msm_gem_shrink(sc->nr_to_scan, purged, evicted);
+	if (freed) {
+		trace_msm_gem_shrink(sc->nr_to_scan, stages[0].freed,
+				     stages[1].freed, stages[2].freed,
+				     stages[3].freed);
+	}
 
 	return (freed > 0) ? freed : SHRINK_STOP;
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu_trace.h b/drivers/gpu/drm/msm/msm_gpu_trace.h
index 8867fa0a0306..ac40d857bc45 100644
--- a/drivers/gpu/drm/msm/msm_gpu_trace.h
+++ b/drivers/gpu/drm/msm/msm_gpu_trace.h
@@ -116,22 +116,26 @@ TRACE_EVENT(msm_gmu_freq_change,
 
 
 TRACE_EVENT(msm_gem_shrink,
-		TP_PROTO(u32 nr_to_scan, u32 purged, u32 evicted),
-		TP_ARGS(nr_to_scan, purged, evicted),
+		TP_PROTO(u32 nr_to_scan, u32 purged, u32 evicted,
+			 u32 active_purged, u32 active_evicted),
+		TP_ARGS(nr_to_scan, purged, evicted, active_purged, active_evicted),
 		TP_STRUCT__entry(
 			__field(u32, nr_to_scan)
 			__field(u32, purged)
 			__field(u32, evicted)
+			__field(u32, active_purged)
+			__field(u32, active_evicted)
 			),
 		TP_fast_assign(
 			__entry->nr_to_scan = nr_to_scan;
 			__entry->purged = purged;
 			__entry->evicted = evicted;
+			__entry->active_purged = active_purged;
+			__entry->active_evicted = active_evicted;
 			),
-		TP_printk("nr_to_scan=%u pages, purged=%u pages, evicted=%u pages",
-			  __entry->nr_to_scan,
-			  __entry->purged,
-			  __entry->evicted)
+		TP_printk("nr_to_scan=%u pg, purged=%u pg, evicted=%u pg, active_purged=%u pg, active_evicted=%u pg",
+			  __entry->nr_to_scan, __entry->purged, __entry->evicted,
+			  __entry->active_purged, __entry->active_evicted)
 );
 
 
-- 
2.36.1

