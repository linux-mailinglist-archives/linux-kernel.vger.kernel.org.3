Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8835A2385
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiHZItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbiHZIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:49:30 -0400
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DAD5DD6;
        Fri, 26 Aug 2022 01:49:29 -0700 (PDT)
Received: by mail-pg1-f193.google.com with SMTP id d71so803985pgc.13;
        Fri, 26 Aug 2022 01:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/a4FiR7aLndGxzWuyiR1P2igj/4sxawq1FoYvUVjoOA=;
        b=s/HzyrpJN1xREwLCuZxx4dWhsZ6utmDVNo7O+Ov2ekmGCfzLTeZ1L0LbQYZ2b6Oai+
         wcRo/ymC3TEM3ApbUqxFFkDAmmNoRNxnvuYX1NDzfqkQ7/JNM7Nx0wP18JyTZIpOop0g
         nj4fnSKYr4GV7HjyeySYf4L9C2pZDg+doedzW4q2EiYhrFWtR8d54Swjdg/csi6UmDMg
         jdT5nN50xJKI+4xq3fLiBnniWoj3LPKly+dktpy0ukCP3wDLSW/P1tArQZmbV0wnIYg3
         VeUmqi0yRGnUYe0E2uPUKysow0FD6Asu783sAZ//k+uD6d1rY0FSkhuAG8zB46bX/Kms
         37EA==
X-Gm-Message-State: ACgBeo0tcCIBIU1Ue0ny5US59AjXbPd7I4npggpKmPqotArXmkbqEnqU
        wqyclJUz8UMVT4DYN3/A0w==
X-Google-Smtp-Source: AA6agR5D+/X+OTlMDgze+3xQO1o0WOIn/bmV+6/bYyku0SHDYfHOfHcKkK95XjZvp4wXhdW1V8vMzA==
X-Received: by 2002:a63:1857:0:b0:41c:4217:426e with SMTP id 23-20020a631857000000b0041c4217426emr2460335pgy.285.1661503768953;
        Fri, 26 Aug 2022 01:49:28 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090b051200b001f8c532b93dsm1118128pjz.15.2022.08.26.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:49:28 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     christian.koenig@amd.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org
Cc:     freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        inux-arm-msm@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] drm/msm/dsi: fix the inconsistent indenting
Date:   Fri, 26 Aug 2022 16:49:17 +0800
Message-Id: <20220826084917.95409-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the inconsistent indenting in function msm_dsi_dphy_timing_calc_v3().

Fix the following smatch warnings:

drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:350 msm_dsi_dphy_timing_calc_v3() warn: inconsistent indenting

Fixes: f1fa7ff44056 ("drm/msm/dsi: implement auto PHY timing calculator for 10nm PHY")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index a39de3bdc7fa..56dfa2d24be1 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -347,7 +347,7 @@ int msm_dsi_dphy_timing_calc_v3(struct msm_dsi_dphy_timing *timing,
 	} else {
 		timing->shared_timings.clk_pre =
 			linear_inter(tmax, tmin, pcnt2, 0, false);
-			timing->shared_timings.clk_pre_inc_by_2 = 0;
+		timing->shared_timings.clk_pre_inc_by_2 = 0;
 	}
 
 	timing->ta_go = 3;
-- 
2.25.1

