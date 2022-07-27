Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1E25826F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiG0MsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiG0Mr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:47:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561C22523
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:47:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bn9so13127631wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbIXmqIjdkMi2JSciZ0bPMUrJ9m41pWmErdo7Yp7XLI=;
        b=ASvzG8Gogpot3oN8wT5STKfQTyFMb/mSVeq6Q5nSqyg5mfmI6rJMduP+YYpYKgdRFk
         Jc0adbLOucoOl90q+2gOcollCJYDz2Ii3cSbRW5FIiAhj2rIg+QLU3p/NrOvD2UlsOUm
         mcEHMZj4ZLuOab+BeDzbbeeHUHJKZ/n3bCL8kG03mb9MaYTdTtRrEUcrkPcXKv5CH6fg
         mkzDlRfO/ZyKypfvjvL9OX+PYD9PKcOGCAbaVr0/1YxzTzkjy2ViLV02dZWigtIVqABP
         kFvI7p9UFFatzuk0XpqA3urAJKKhUXHmR3Y6SzM58/SdrKJoHqVOrgGCOdFQexIY774j
         Sjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IbIXmqIjdkMi2JSciZ0bPMUrJ9m41pWmErdo7Yp7XLI=;
        b=IHvnrhfXPFoz4/n6CQJPI4juvYCn72wo+EGJMVCmLT5E8GCBSGFrWl4OJr1DvOEY2C
         iTd+PBkRZXGf7sPNiWksk87vMdsR0OVyOxaqRSP3HzMv7w1jcZjtLH4bS1y6/DRw4xrQ
         acuFt9T5C6/bWFwPHJDCW7UJ3o9x1F5tTASiVrUHTE8oO0PfTmiOWIZgvD48LZyF3F/y
         amh/817ZJ3VFkHgE5pT6/71dzxAXX0Q6M6eJs3sRHxL9CjNQcC4vtMGb/J1jhaoFDyEv
         TzRn16EFlVRKYJelzdM719+Vh5CIvpWnjiblOq+N7Ep9KAD+MoOuP72LfRtkNBW9xHGb
         9JvQ==
X-Gm-Message-State: AJIora+uKhIQ8ApsEZeAMvE0mRqcaX0xjg7eilFFToY7jVuElJSid9+c
        vhtl3/tJMAWM7/1qj8LkxSHAsaH4jEn8Lg==
X-Google-Smtp-Source: AGRyM1s64lTTZ728IL9ytTtfwVIyDnGmVDjh6LGF9RFAtf7d7cwiHHV6yYwE/uUmhVFkFnJ24zoCxA==
X-Received: by 2002:a5d:58c9:0:b0:21d:9374:1373 with SMTP id o9-20020a5d58c9000000b0021d93741373mr13987359wrf.20.1658926074695;
        Wed, 27 Jul 2022 05:47:54 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b003a2ed2a40e4sm2459559wms.17.2022.07.27.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 05:47:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] ASoC: codecs: va-macro: use fsgen as clock
Date:   Wed, 27 Jul 2022 13:47:49 +0100
Message-Id: <20220727124749.4604-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VA Macro fsgen clock is supplied to other LPASS Macros using proper
clock apis, however the internal user uses the registers directly without
clk apis. This approch has race condition where in external users of
the clock might cut the clock while VA macro is actively using this.

Moving the internal usage to clk apis would provide a proper refcounting
and avoid such race conditions.

This issue was noticed while headset was pulled out while recording is
in progress and shifting record patch to DMIC.

Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index d18b56e60433..1ea10dc70748 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -199,6 +199,7 @@ struct va_macro {
 	struct clk *mclk;
 	struct clk *macro;
 	struct clk *dcodec;
+	struct clk *fsgen;
 	struct clk_hw hw;
 	struct lpass_macro *pds;
 
@@ -467,9 +468,9 @@ static int va_macro_mclk_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		return va_macro_mclk_enable(va, true);
+		return clk_prepare_enable(va->fsgen);
 	case SND_SOC_DAPM_POST_PMD:
-		return va_macro_mclk_enable(va, false);
+		clk_disable_unprepare(va->fsgen);
 	}
 
 	return 0;
@@ -1473,6 +1474,12 @@ static int va_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clkout;
 
+	va->fsgen = clk_hw_get_clk(&va->hw, "fsgen");
+	if (IS_ERR(va->fsgen)) {
+		ret = PTR_ERR(va->fsgen);
+		goto err_clkout;
+	}
+
 	ret = devm_snd_soc_register_component(dev, &va_macro_component_drv,
 					      va_macro_dais,
 					      ARRAY_SIZE(va_macro_dais));
-- 
2.25.1

