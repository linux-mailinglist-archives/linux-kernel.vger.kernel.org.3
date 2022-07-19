Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81B857902F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiGSB4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiGSB4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:56:36 -0400
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D0F26AE1;
        Mon, 18 Jul 2022 18:56:36 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id g126so12250609pfb.3;
        Mon, 18 Jul 2022 18:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/a4FiR7aLndGxzWuyiR1P2igj/4sxawq1FoYvUVjoOA=;
        b=VBle6VZIhc8nqy3eWxt4KS6oovOKtlU4eHll+zYEMGMvMVIZa7V3CfGmfk1maPHeGb
         SveWvakASCXhb6FgV1/MgwPsBz8PgckwJ0tK+sdErX+689CW80P5StGuT0o5JLFis5oY
         fwggUeBbl53Qck54KzHIU9CdAeRqXHiH5difxZvuVF/enWhd8kAEVugF3KqCuPCYx6I/
         m88Eo//wbuEUKXmb0dkvt6xi3ZKeMl5W3nTGQZynkJeEwSWnUGQIQQkrOG1tfIIi3qSV
         uId/UpiuRSNIGTUyVSVNQYtxHU5GrBQNf6eiA+6xH6LHuyenamN/INFuxj3CBuQmBDXS
         NwzA==
X-Gm-Message-State: AJIora/P5GFHj9AEawrjGRPoEzBRfi3LjUdns5z/ORV8Euy6Ec4gtZhW
        e/UNS9C55qeiHeRBiE9Vbg==
X-Google-Smtp-Source: AGRyM1sC9k4aPblFgOso28rTleM2SsyhMxxgJNyGcr1cBKdOSZu0+rwvpzTCFaSpg2Zl+X8eVVVajA==
X-Received: by 2002:a63:6846:0:b0:415:bb65:d6f0 with SMTP id d67-20020a636846000000b00415bb65d6f0mr26989951pgc.238.1658195795563;
        Mon, 18 Jul 2022 18:56:35 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b0015f2b3bc97asm10067405plh.13.2022.07.18.18.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 18:56:35 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     christian.koenig@amd.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org
Cc:     freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kelulanainsley@gmail.com,
        sunliming <sunliming@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] drm/msm/dsi: fix the inconsistent indenting
Date:   Tue, 19 Jul 2022 09:56:22 +0800
Message-Id: <20220719015622.646718-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

