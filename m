Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62F552417
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbiFTSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245707AbiFTShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:37:54 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849CD60E2;
        Mon, 20 Jun 2022 11:37:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id i16so11973781ioa.6;
        Mon, 20 Jun 2022 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oH+TPeRhTKU3xFkxsat+dvsRM7MxvHpnqcOtBFJGWE=;
        b=K8c8ZPs4V2dyjx7nJQ3tzGLI8rSprOWvjkiKUGMerOx3lpPm+2zDQg4t7im7qK2gTG
         gFCEHQ/AuvmTg5ZTZtpzafQt2KM7nFVzZpKbc0kh34DER0jNKMPGloQnKGwp6RX+d4NI
         nvf3Ua6f+zz9uzPnp3FhF1O64iw5Elk44BdF0oc1OaCOomK6bviRs1PgzvG/819XGzCw
         30XEQ3dPTsXciUh2uOu53+JytdUlCoUD1VfjiXbFNoDcqZHZA4XQADxZhYkuTC+Hydx5
         YJovyd/LilKxHqXgCAu7n/o04ghnK/CBvP3+yB1JX3jWySIYHYV6yoAdQ5D1GnHPhvRt
         2xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oH+TPeRhTKU3xFkxsat+dvsRM7MxvHpnqcOtBFJGWE=;
        b=yLEEnqXmPYhMiOV/Fst3DbKoq8SBZ4VTVr9FndGe0bYJAkBW249sCZ70e1HJXjF8V5
         vO/9tt5HvjXkmwjyAKZpjuzFtTd/MPlsfzPeRB2GuUm4CM5/j850FaSp+12aiyCTOBWV
         6vj/quM9lmt/L7rrKp30OrD81N5ZJksqKx5al6aD36w8M11FYAtpB3xi20upuLpP20Cr
         bEV1RxU++Qrul2EDEtE8Ccpd88cgKhzgTn/g8DnD5ymLA0D67Vwnufy+FUxZcJ800Lus
         BbU1e6QOcjuDRmCTQVL/ccVyVbCxRJ1ZwGeasjOiTzDN5AHFlGYIvo1DL3BTnC/wkbm7
         FXWg==
X-Gm-Message-State: AJIora8x7LkCJcnK95es60Y8g0PH15P2XPPIId567PJx2FBw/EE5sBKv
        7d3lfyk/L1IWavI8DyrXnzM=
X-Google-Smtp-Source: AGRyM1t5U1hn+TO2QIcNsREgogNYuCoKr0CzZQnzLWSzRcBlsTk9/uFcgmidlislKg1ykuUSuL8woQ==
X-Received: by 2002:a02:6d2b:0:b0:332:1027:a2dc with SMTP id m43-20020a026d2b000000b003321027a2dcmr13722194jac.65.1655750271681;
        Mon, 20 Jun 2022 11:37:51 -0700 (PDT)
Received: from tremont-lap.lan ([2604:2d80:d289:7400:db6b:f24e:bef:c8f8])
        by smtp.gmail.com with ESMTPSA id g4-20020a056e020d0400b002d90c9077a2sm2142588ilj.57.2022.06.20.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:37:50 -0700 (PDT)
From:   David Owens <daowens01@gmail.com>
X-Google-Original-From: David Owens <dowens@precisionplanting.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     David Owens <daowens01@gmail.com>,
        David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] ASoC: ti: omap-mcbsp: duplicate sysfs error
Date:   Mon, 20 Jun 2022 13:37:43 -0500
Message-Id: <20220620183744.3176557-1-dowens@precisionplanting.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Owens <daowens01@gmail.com>

Convert to managed versions of sysfs and clk allocation to simplify
unbinding and error handling in probe.  Managed sysfs node
creation specifically addresses the following error seen the second time
probe is attempted after sdma_pcm_platform_register() previously requsted
probe deferral:

sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'

Signed-off-by: David Owens <dowens@precisionplanting.com>
---

Changes in v4:
 * Reverted change that added use ATTRIBUTE_GROUP and left the attribute
   structs as-is to fix compilation error and lessen the area of impact.

Changes in v3:
 * Whitespace changes only to allow clean apply

Changes in v2:
 * Improved error handling

---
 sound/soc/ti/omap-mcbsp-priv.h |  2 --
 sound/soc/ti/omap-mcbsp-st.c   | 14 ++------------
 sound/soc/ti/omap-mcbsp.c      | 19 ++-----------------
 3 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
index 7865cda4bf0a..da519ea1f303 100644
--- a/sound/soc/ti/omap-mcbsp-priv.h
+++ b/sound/soc/ti/omap-mcbsp-priv.h
@@ -316,8 +316,6 @@ static inline int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg,
 
 /* Sidetone specific API */
 int omap_mcbsp_st_init(struct platform_device *pdev);
-void omap_mcbsp_st_cleanup(struct platform_device *pdev);
-
 int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp);
 int omap_mcbsp_st_stop(struct omap_mcbsp *mcbsp);
 
diff --git a/sound/soc/ti/omap-mcbsp-st.c b/sound/soc/ti/omap-mcbsp-st.c
index 0bc7d26c660a..7e8179cae92e 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -347,7 +347,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
 	if (!st_data)
 		return -ENOMEM;
 
-	st_data->mcbsp_iclk = clk_get(mcbsp->dev, "ick");
+	st_data->mcbsp_iclk = devm_clk_get(mcbsp->dev, "ick");
 	if (IS_ERR(st_data->mcbsp_iclk)) {
 		dev_warn(mcbsp->dev,
 			 "Failed to get ick, sidetone might be broken\n");
@@ -359,7 +359,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
 	if (!st_data->io_base_st)
 		return -ENOMEM;
 
-	ret = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+	ret = devm_device_add_group(mcbsp->dev, &sidetone_attr_group);
 	if (ret)
 		return ret;
 
@@ -368,16 +368,6 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
 	return 0;
 }
 
-void omap_mcbsp_st_cleanup(struct platform_device *pdev)
-{
-	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
-
-	if (mcbsp->st_data) {
-		sysfs_remove_group(&mcbsp->dev->kobj, &sidetone_attr_group);
-		clk_put(mcbsp->st_data->mcbsp_iclk);
-	}
-}
-
 static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_info *uinfo)
 {
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 58d8e200a7b9..9fb7cf0c9f88 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -702,8 +702,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
 		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
 
-		ret = sysfs_create_group(&mcbsp->dev->kobj,
-					 &additional_attr_group);
+		ret = devm_device_add_group(mcbsp->dev, &additional_attr_group);
 		if (ret) {
 			dev_err(mcbsp->dev,
 				"Unable to create additional controls\n");
@@ -711,16 +710,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 		}
 	}
 
-	ret = omap_mcbsp_st_init(pdev);
-	if (ret)
-		goto err_st;
-
-	return 0;
-
-err_st:
-	if (mcbsp->pdata->buffer_size)
-		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
-	return ret;
+	return omap_mcbsp_st_init(pdev);
 }
 
 /*
@@ -1431,11 +1421,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 	if (cpu_latency_qos_request_active(&mcbsp->pm_qos_req))
 		cpu_latency_qos_remove_request(&mcbsp->pm_qos_req);
 
-	if (mcbsp->pdata->buffer_size)
-		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
-
-	omap_mcbsp_st_cleanup(pdev);
-
 	return 0;
 }
 
-- 
2.34.1

