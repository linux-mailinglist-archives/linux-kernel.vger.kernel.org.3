Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4B4BDEDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358682AbiBUNLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358623AbiBUNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6924C1EC6A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id q9-20020a1ca709000000b0037fa5c3e5c1so603873wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgNio1ZvxWIjmLiWAXPcv23sMXfkT0s/qjcyQ67ngqM=;
        b=c2g0VovJKiBK1IfUHsT9ZWkD+jMmc5eAnx8gpqpTf1nikF0NGpWBJGc5pznxONHQOi
         6RXneI3djEXJ4phPE59BCMbNwBP2Y1HM9HnKs0x+xTe2HqfJUiaHUR8F4/rqS46q17MJ
         vvBmcjCHtbZwHRMk22pleCopI9rcxUr4SuMpoYqd5Z8bWnSwHCk7zwSIghtHBYyK1SNY
         Bla9OSgaMrMyQSJCOXA8r3aAroRdWcUrKx0/szRrucHrbFf/FEMN8GERHJUPFUN/KaFh
         3nmLWcxKDkpiPC48lKcTC0+sJIBuXf1b5sAo6HNrlMt8e2bcBF9Qr+MC48qohzMVMAJg
         ZT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgNio1ZvxWIjmLiWAXPcv23sMXfkT0s/qjcyQ67ngqM=;
        b=yhZXOSlOYcj7wxIk/3poy9TjPBdWeBBmNLn9Mj9Tk9rmTwu4NlKdscHjMabkHxlx7j
         J+Kz7Fnk3ji7VSLIABZ8FY8kqKZ2do036z41YWquFMCQiQMEB8Edu5OZow18Qn3jip2L
         wg6Y8RnkdRGFQu7Ma4w27OntrKGAnsokhUmgNW2oN1Lc9Iigujv/W7je+Saiu8dQqEZk
         HaOoNqDiy4DHbSuUj0YGvL1jQ/T3Qqv/5GsUBE6iCiNDYKWKYM+IpNMjgv4LJxzuH8xN
         cnAOKOFFti/PaGMPmyE+zQfq9REomEBHZRs//n8fIYJaw8sMqXBwkv/rCg47bDQeZpA7
         3jXw==
X-Gm-Message-State: AOAM533KUEATEGpEOkKmqU8V3eWz7a78xHZDFE5Rg04eJbui51JjDhpk
        +kGquPuMUmplc02IEitiZ62iLg==
X-Google-Smtp-Source: ABdhPJyzeB8CHlxlcGvrBT+0mVWWMBylBQTmHurQddon5V0aVF2Zh2s9fbXV0IfiC6X21JW517eZaQ==
X-Received: by 2002:a1c:7908:0:b0:37b:e93c:10dd with SMTP id l8-20020a1c7908000000b0037be93c10ddmr17877679wme.181.1645449042983;
        Mon, 21 Feb 2022 05:10:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:42 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/10] ASoC: codecs: wsa-macro: add runtime pm support
Date:   Mon, 21 Feb 2022 13:10:29 +0000
Message-Id: <20220221131037.8809-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-wsa-macro.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 21a4b8cc4a0a..a8d30f3b3fdf 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/pm_runtime.h>
 #include <linux/of_platform.h>
 #include <sound/tlv.h>
 #include "lpass-wsa-macro.h"
@@ -2429,6 +2430,12 @@ static int wsa_macro_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	pm_runtime_set_autosuspend_delay(dev, 3000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	return ret;
 err:
 	clk_bulk_disable_unprepare(WSA_NUM_CLKS_MAX, wsa->clks);
@@ -2446,6 +2453,37 @@ static int wsa_macro_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused wsa_macro_runtime_suspend(struct device *dev)
+{
+	struct wsa_macro *wsa = dev_get_drvdata(dev);
+
+	regcache_cache_only(wsa->regmap, true);
+	regcache_mark_dirty(wsa->regmap);
+
+	clk_disable_unprepare(wsa->clks[2].clk);
+	clk_disable_unprepare(wsa->clks[3].clk);
+	clk_disable_unprepare(wsa->clks[4].clk);
+
+	return 0;
+}
+
+static int __maybe_unused wsa_macro_runtime_resume(struct device *dev)
+{
+	struct wsa_macro *wsa = dev_get_drvdata(dev);
+
+	clk_prepare_enable(wsa->clks[2].clk);
+	clk_prepare_enable(wsa->clks[3].clk);
+	clk_prepare_enable(wsa->clks[4].clk);
+	regcache_cache_only(wsa->regmap, false);
+	regcache_sync(wsa->regmap);
+
+	return 0;
+}
+
+static const struct dev_pm_ops wsa_macro_pm_ops = {
+	SET_RUNTIME_PM_OPS(wsa_macro_runtime_suspend, wsa_macro_runtime_resume, NULL)
+};
+
 static const struct of_device_id wsa_macro_dt_match[] = {
 	{.compatible = "qcom,sc7280-lpass-wsa-macro"},
 	{.compatible = "qcom,sm8250-lpass-wsa-macro"},
@@ -2457,6 +2495,7 @@ static struct platform_driver wsa_macro_driver = {
 	.driver = {
 		.name = "wsa_macro",
 		.of_match_table = wsa_macro_dt_match,
+		.pm = &wsa_macro_pm_ops,
 	},
 	.probe = wsa_macro_probe,
 	.remove = wsa_macro_remove,
-- 
2.21.0

