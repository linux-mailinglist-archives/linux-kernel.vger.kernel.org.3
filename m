Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A634BE5E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358712AbiBUNLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358653AbiBUNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451271EECD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:50 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d27so27034423wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyVwZE5kS8xGdR91o+WjovvMprsI53ZLyaYZnmErV2U=;
        b=T5M6rVpQg5CiNr0ALeXidXgJ27NA+ORiCY2Lluwps+MNSbQ6BG7XRz9qUUmz9jpiAk
         lO8F5HA6p6nn2XwUZ2QXVPvwzILoFklTOwYzQ8dj7F5STNqv3ZWHXR6BK/iyTsyfx/q1
         qtH7bL/pdBvtx40noEamhS+8PkOAm1+FOXNWMGzCUXt4ls3KcE8E6sEKlbKgoXHS2ygq
         fZFtH8gyBLWxsUoMTZ4g9ekdM4Lwxip+0iYdGeSZCqcdm867uR2YqICwSm9R/ih6nvvk
         E9h2iZT2/iZyOQjcSTxyVGT7WHaZaH6Bf7vvtdF/t0PBj4wTAFens0KXhPeOFwqL9/fB
         fz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyVwZE5kS8xGdR91o+WjovvMprsI53ZLyaYZnmErV2U=;
        b=fz+1Zw0bMMxo1MCMr0FL2Wg4ylgmJ9ZPn/Q8WK+me2WDC3qAaLllLY3NJ5TwiS+Sw9
         QGd+nyrK/W/sI8fzSaqhLVRFdQvtB+T+DIV53/xUuEDuhWeUaKL1TFIgQT8vRMcowP9f
         7mUPaA9eZQeol82rZKkk7BiT41uaXK80CdimvJcqA0mGUH/qxPaUUXpBUgCa9mmrJ0c1
         FPqJTxZb9j5iP4r/LobVtbCfh75+2nQmkp15QOVeJ1PdSMW8uGjQyA9W74ej2ejF+SzI
         CNQGN0Rjbl2fgakdWh3Ivs5deAnUYlhUuRaQUbDvji+nPcy8yjMRrlglUcbZTkgAlB6N
         wovA==
X-Gm-Message-State: AOAM5325bCMiPDIdMIr2k4csVukecra06TCEjaS1Ky7/lS63ObTHnkvr
        cnuwITzzMwj8jukoKzE6Gwsj8Q==
X-Google-Smtp-Source: ABdhPJzoGZPyDMK/rd4UpWIt18POgV1l3Mt9/on0ljpwn4kVUcoE59SuHBLlq6qeR6BQ5cDdBUGS3A==
X-Received: by 2002:a5d:6488:0:b0:1ea:7bfa:41e1 with SMTP id o8-20020a5d6488000000b001ea7bfa41e1mr394408wri.563.1645449048801;
        Mon, 21 Feb 2022 05:10:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:48 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/10] ASoC: codecs: wcd-mbhc: add runtime pm support
Date:   Mon, 21 Feb 2022 13:10:34 +0000
Message-Id: <20220221131037.8809-8-srinivas.kandagatla@linaro.org>
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

under low power state a SoundWire Wake IRQ could trigger MBHC interrupts
so make sure that codec is not in suspended state when this happens.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 7488a150a138..c53c2ef33e1a 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -5,6 +5,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
@@ -711,6 +712,16 @@ static irqreturn_t wcd_mbhc_hphr_ocp_irq(int irq, void *data)
 static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 {
 	struct snd_soc_component *component = mbhc->component;
+	int ret;
+
+	ret = pm_runtime_get_sync(component->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(component->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(component->dev);
+		return ret;
+	}
 
 	mutex_lock(&mbhc->lock);
 
@@ -751,6 +762,9 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 
 	mutex_unlock(&mbhc->lock);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -1078,10 +1092,19 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	int output_mv, cross_conn, hs_threshold, try = 0, micbias_mv;
 	bool is_spl_hs = false;
 	bool is_pa_on;
+	int ret;
 
 	mbhc = container_of(work, struct wcd_mbhc, correct_plug_swch);
 	component = mbhc->component;
 
+	ret = pm_runtime_get_sync(component->dev);
+	if (ret < 0 && ret != -EACCES) {
+		dev_err_ratelimited(component->dev,
+				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    __func__, ret);
+		pm_runtime_put_noidle(component->dev);
+		return;
+	}
 	micbias_mv = wcd_mbhc_get_micbias(mbhc);
 	hs_threshold = wcd_mbhc_adc_get_hs_thres(mbhc);
 
@@ -1232,6 +1255,9 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 
 	if (mbhc->mbhc_cb->hph_pull_down_ctrl)
 		mbhc->mbhc_cb->hph_pull_down_ctrl(component, true);
+
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
 }
 
 static irqreturn_t wcd_mbhc_adc_hs_rem_irq(int irq, void *data)
-- 
2.21.0

