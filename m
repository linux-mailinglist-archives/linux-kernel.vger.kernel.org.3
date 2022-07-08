Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6323156AFA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbiGHA6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbiGHA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:58:44 -0400
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717C186FB;
        Thu,  7 Jul 2022 17:58:43 -0700 (PDT)
Received: by mail-pg1-f195.google.com with SMTP id i190so8469239pge.7;
        Thu, 07 Jul 2022 17:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wqH5lkEcgEYk9IYTlg7iiusMTMJ78GFXYQavtNkHZMw=;
        b=tY1CseSFgf1BX+Xb0hgwKGonuCKpWHRdahzU1iZXdFZCMbdXAkiNd1qvro9i7v7Kkp
         5OO8eCRRMkwFylG9hJHiwbCPomQTVZYff1yknfBrWDDvohYubOMLRJIRHxZCoQI+m9uf
         Zaf33qmSOvlqNxEdraPHvMHxT/sW5vA93ZWnoau5r5SPXT/9EV+gImL7H1kYIdtSN3Kt
         UTK8WN++QGPgcTJUP/UmCp/F94KlqaasJ5QioYeMM3VJaNXXHPqRDmcDmS/ctGgHW63v
         2IPBb40UtUm39wV5iX+kOfkVpdcDuW2F32NR5tnb+rI2BFyDhXzby6RTjhhn8/Z2mTjj
         Zo8g==
X-Gm-Message-State: AJIora9DASxokymVOVJc01ZHbfDVpy5Mh71ogF3/3mN6kzSqqZD/hdD6
        UrP7viq90Fchn91H0869/g==
X-Google-Smtp-Source: AGRyM1vacj7yRlF6w+n1Bho6IKjJtTx/+ZIht2cmpzn70gZgkzg8M8pXSk63aKGy6xj6m/IaJpgGqw==
X-Received: by 2002:a63:ea05:0:b0:411:f94f:b80f with SMTP id c5-20020a63ea05000000b00411f94fb80fmr789435pgi.189.1657241923152;
        Thu, 07 Jul 2022 17:58:43 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id a140-20020a621a92000000b005289fbef7c4sm5034884pfa.140.2022.07.07.17.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 17:58:42 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     christian.koenig@amd.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org
Cc:     freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] drm/msm/dsi: fix the inconsistent indenting
Date:   Fri,  8 Jul 2022 08:58:32 +0800
Message-Id: <20220708005832.439722-1-sunliming@kylinos.cn>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
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

