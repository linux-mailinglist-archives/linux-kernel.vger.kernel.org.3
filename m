Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC65AA8BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiIBHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIBHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:31:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2D11A2D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:31:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 199so1116242pfz.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=P0R9Y+4dB3fRcttMdLXdxOe5yLYU2jvdRFUhiOX93Zg=;
        b=k5q1QbmCXfOYOV8VpYKWG61L3L9sU/bLkPdBZgWYlNidsibXAya40hV9tS883X2ZZN
         3kA0r8itsawEx8lVa1Yiq+AF03dd8RXpnVKL+OJMnGX/67GF0t2vrbMc4NDTU9LsIe3K
         7KV+hHa58XkhAOveOujHuYCOW2xIuToJkIWYY01/e9e/cFNsHRbz+GwDRcBVwKM49oA5
         k0Gt9mkOplHQyvGc3Syua+gD3nu0tb1xo8D4g73HuOTigBgdCnoVHCPQ5hKaDQk57Wjq
         vzrlDO4b6bIH5qSFT+SvcY6HasUNeGeiGxhYOxo5eYIYS0kyMjt+3JwhbBBPGjdxtRQe
         ShZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=P0R9Y+4dB3fRcttMdLXdxOe5yLYU2jvdRFUhiOX93Zg=;
        b=lISHx+rAKJdxo7/87maMUdDaiIeazWgeONGHrhNId/kAIOJ0ymvzj2LokPMVvNZ2bR
         UvA7SDBwGi057pztIvxLuQ+0XqwVOM4MUEdCu8PtdCc+DMEMDfnJjXaXvtH7J2VuXR6l
         9Eh+jTdGWHuc1XYWq2tA4kpLg1mug9bCbpu1PXsnORw+C4KDnG1cADI9NHFTfFFg24ZH
         PFOnAszy/5NfVkVUklTEm2lcHgOilcHhWDq+5bKyX7D18dCd4BEGaJ0FImnMM2kEYVmm
         SpT87toucnEbwVmP/oipFzKIFUO5PXTkoKCUATdBoxhBNoZLuCOiEmvcUTNCkKdhatmC
         gSew==
X-Gm-Message-State: ACgBeo3WvkGceoUkmQWymUFc4HewLAVsgy8/93ZFXGxHj++vNnDFCV4R
        KjGQwxXZE9Fx7BsJfr719G0g7VUgNII=
X-Google-Smtp-Source: AA6agR4kjmE6UsN8xdYrbeqJT8QfxOodjebOdNs9GfnxcZXzmeDl2dIJ56PNgzA65XAn+2GX2uuwcg==
X-Received: by 2002:a05:6a00:3406:b0:535:f76f:c971 with SMTP id cn6-20020a056a00340600b00535f76fc971mr35291353pfb.5.1662103913057;
        Fri, 02 Sep 2022 00:31:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e18-20020a656892000000b0041d6cda2d60sm738183pgt.66.2022.09.02.00.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:31:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/radeon/ci_dpm: Remove the unneeded result variable
Date:   Fri,  2 Sep 2022 07:31:48 +0000
Message-Id: <20220902073148.319536-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value ci_load_smc_ucode() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index ac006bed4743..8ef25ab305ae 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -2056,7 +2056,7 @@ static void ci_clear_vc(struct radeon_device *rdev)
 static int ci_upload_firmware(struct radeon_device *rdev)
 {
 	struct ci_power_info *pi = ci_get_pi(rdev);
-	int i, ret;
+	int i;
 
 	for (i = 0; i < rdev->usec_timeout; i++) {
 		if (RREG32_SMC(RCU_UC_EVENTS) & BOOT_SEQ_DONE)
@@ -2067,9 +2067,7 @@ static int ci_upload_firmware(struct radeon_device *rdev)
 	ci_stop_smc_clock(rdev);
 	ci_reset_smc(rdev);
 
-	ret = ci_load_smc_ucode(rdev, pi->sram_end);
-
-	return ret;
+	return ci_load_smc_ucode(rdev, pi->sram_end);
 
 }
 
-- 
2.25.1
