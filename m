Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759CE4F7BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiDGJpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242371AbiDGJp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:45:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D982204290
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:43:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso5275223wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcmZVA3orHoN9CH1Vhr363WxSRr0JXTI0/1EIITcF5A=;
        b=hoXopcE1J4Lu+/5QCJTm9yJNQ8Yb86UCP4CA9gAy2UBbnq8nUx6Ua0rQhteCIqnj2R
         G0Idwm66oA9e8R65t8xOagV6ii5h9McHbgguclDEbJRUm7KlfUNapz8gFEQkuSg3gVY1
         O+2uE9eBMJ9wfg/JTt7L69bS9bIRyRnSee3nqEARRi6MTo2ANU9iguZRal1SSV4Ly4fM
         xulDm8BBByY0XJ+K14q/+woqGr8B4uOXSRwSK4tXK9CTxQmOF+i2vgBqHTITDbd5FXAo
         SiMJXGP7sNZxDBwadlX2KPmaNsFOyr82DA60+ZxOQRc5AAYfADsa6w7lC2C7j4JIqTNL
         eCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcmZVA3orHoN9CH1Vhr363WxSRr0JXTI0/1EIITcF5A=;
        b=rmH0tTlYKZsP6ozc3TmEZy4PAAkNWNmuR7n5jSQIYSthLyariIKGF2H0rtBjEsMzkm
         s7vfdwF2PMdNaiRg0MMx5KBPSnIBjSVuSt/CwdbtO7U1c+NbV9SV29TqNoTpV5WxPwcg
         OoavTALpXhaZ8erW7SyuBNl/34iRr5vIvVpd2SpDHugA55S4f5n1YeNij/ftPi00yEj/
         o95JV9eg1L/1G8DsQ+QwmW0pLlm/+CDKqdYnfmhngMrajYMKVbc7pP7mt9Q3KsbadCf9
         F34Aicm4/c3+cQK0GwnVRGOhfIUqTCJRvYLILThhSGs3MjvFauOGYpqU13hGixRR7UDG
         9QOQ==
X-Gm-Message-State: AOAM532OQXf5dqzWxvqwUeI0BwAdg9RmjYv/gVp1GDWdTJDVrIvTE1oU
        ge4kgIALruOsbTEatI4qEh4xig==
X-Google-Smtp-Source: ABdhPJzCZw9SBdZNrxID/udYi02fbYRoy3fr/3m1eSfHrX75d8jk2uFP+uevMIspFJTM/9uNx2oC4w==
X-Received: by 2002:a7b:c0d0:0:b0:38e:68bb:5ce7 with SMTP id s16-20020a7bc0d0000000b0038e68bb5ce7mr11143555wmh.105.1649324606195;
        Thu, 07 Apr 2022 02:43:26 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm16368002wrv.10.2022.04.07.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:43:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH] ASoC: codecs: wcd934x: do not switch off SIDO Buck when codec is in use
Date:   Thu,  7 Apr 2022 10:43:13 +0100
Message-Id: <20220407094313.2880-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIDO(Single-Inductor Dual-Ouput) Buck powers up both analog and digital
circuits along with internal memory, powering off this is the last thing
that codec should do when going to very low power.

Current code was powering off this Buck if there are no users of sysclk,
which is not correct. Powering off this buck will result in no register access.
This code path was never tested until recently after adding pm support
in SoundWire controller. Fix this by removing the buck poweroff when the
codec is active and also the code that is not used.

Without this patch all the read/write transactions will never complete and
results in SLIMBus Errors like:

qcom,slim-ngd qcom,slim-ngd.1: Tx:MT:0x0, MC:0x60, LA:0xcf failed:-110
wcd934x-codec wcd934x-codec.1.auto: ASoC: error at soc_component_read_no_lock
	on wcd934x-codec.1.auto for register: [0x00000d05] -110
qcom,slim-ngd-ctrl 171c0000.slim: Error Interrupt received 0x82000000

Reported-by: Amit Pundir <amit.pundir@linaro.org>
Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1e75e93cf28f..6298ebe96e94 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1274,29 +1274,7 @@ static int wcd934x_set_sido_input_src(struct wcd934x_codec *wcd, int sido_src)
 	if (sido_src == wcd->sido_input_src)
 		return 0;
 
-	if (sido_src == SIDO_SOURCE_INTERNAL) {
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
-				   WCD934X_ANA_BUCK_HI_ACCU_EN_MASK, 0);
-		usleep_range(100, 110);
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
-				   WCD934X_ANA_BUCK_HI_ACCU_PRE_ENX_MASK, 0x0);
-		usleep_range(100, 110);
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
-				   WCD934X_ANA_RCO_BG_EN_MASK, 0);
-		usleep_range(100, 110);
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
-				   WCD934X_ANA_BUCK_PRE_EN1_MASK,
-				   WCD934X_ANA_BUCK_PRE_EN1_ENABLE);
-		usleep_range(100, 110);
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
-				   WCD934X_ANA_BUCK_PRE_EN2_MASK,
-				   WCD934X_ANA_BUCK_PRE_EN2_ENABLE);
-		usleep_range(100, 110);
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
-				   WCD934X_ANA_BUCK_HI_ACCU_EN_MASK,
-				   WCD934X_ANA_BUCK_HI_ACCU_ENABLE);
-		usleep_range(100, 110);
-	} else if (sido_src == SIDO_SOURCE_RCO_BG) {
+	if (sido_src == SIDO_SOURCE_RCO_BG) {
 		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
 				   WCD934X_ANA_RCO_BG_EN_MASK,
 				   WCD934X_ANA_RCO_BG_ENABLE);
@@ -1382,8 +1360,6 @@ static int wcd934x_disable_ana_bias_and_syclk(struct wcd934x_codec *wcd)
 	regmap_update_bits(wcd->regmap, WCD934X_CLK_SYS_MCLK_PRG,
 			   WCD934X_EXT_CLK_BUF_EN_MASK |
 			   WCD934X_MCLK_EN_MASK, 0x0);
-	wcd934x_set_sido_input_src(wcd, SIDO_SOURCE_INTERNAL);
-
 	regmap_update_bits(wcd->regmap, WCD934X_ANA_BIAS,
 			   WCD934X_ANA_BIAS_EN_MASK, 0);
 	regmap_update_bits(wcd->regmap, WCD934X_ANA_BIAS,
-- 
2.21.0

