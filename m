Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BD454EB21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378388AbiFPU1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378486AbiFPU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:27:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1575B89B;
        Thu, 16 Jun 2022 13:27:01 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s1so1713733ilj.0;
        Thu, 16 Jun 2022 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsJY7P3jisvIHHNgMnMfhfTU+j7BrzVjUHUb60jK/yY=;
        b=gmVDginzPKhGopFMuxnIaJgoXctH5rT+joAZIaV5r2mT3QTDOWq8ECncyWDHnXL1dC
         oHxC/EYQHWI5/hwcOTcP/96DoHeM83/PhmVTEc3RqdOcCujBPtAIWn+mMDheKN4Wak7m
         qr4gToYI1blM9ThtKQWGJQJZAxjnySq/LdT57Bk1sQkQ6pTNXluZX2CqUKy4uN9f0ZRt
         Pw7Gar5N3qd6NO4VSnFrQEPFZ8gA0YBwRtvfiFwfYwYlip/FhCTDI+uGDxyjYh31+ogs
         DXd7wr2QhMIJ3H5eQD7wZmQRWsoOYGIZMlewoYqcL+MzKUm5F40rJbsbJLT3+arBVeJh
         bAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SsJY7P3jisvIHHNgMnMfhfTU+j7BrzVjUHUb60jK/yY=;
        b=hbiWX+NcItIZTkDztNnkrTsfc+muHPw67JRooVO4ofcGe5ru+p1LpRD1nFn9iEZWm6
         Q6GJPX3UEIo14vyGDDz7R74YZ0nxVz98FcjYnxFPSW7jrtuYZrE/XnyrNT+3tknPyoUc
         cW2h3YNHOH1egpZENASDh4G33iFoqs3a3QhII3zYJBQ/A6/Va3CNTlIXAxyn1P+3ZXYL
         VPS1O1VUniYf5lL0FuNgd2aa9REWTfh0Ke8LyfKiRX4ZacMQb7E/kiAwiJaIR5tjNk4B
         iv6qH2+wSbphNY+rUFp9aR4rUfGIZN7ojckTFc02ie42npddFdGfbpBxAmU4qymeFnxk
         /3FA==
X-Gm-Message-State: AJIora+JwA8ugowvLpwmCPx3OvuwrxQ8pcqXO+IUIWJBclQ/KwiKZihi
        NdVWmvgplOJ6zG2fXHvjbqBub0p4JUlXb8h/
X-Google-Smtp-Source: AGRyM1vvlN1n/ci4DNl2/+810XdfpCysIlotnk/8vNyQ0FNGYJtIclLv00X8l27SSYgIDNEUdtOU/A==
X-Received: by 2002:a05:6e02:1c44:b0:2d7:6bc3:9960 with SMTP id d4-20020a056e021c4400b002d76bc39960mr3935563ilg.194.1655411221180;
        Thu, 16 Jun 2022 13:27:01 -0700 (PDT)
Received: from tremont-lap.lan ([2604:2d80:d289:7400:7af5:ac5e:1454:9e62])
        by smtp.gmail.com with ESMTPSA id n4-20020a02a904000000b0032e583132e4sm1283700jam.123.2022.06.16.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:27:00 -0700 (PDT)
From:   David Owens <daowens01@gmail.com>
X-Google-Original-From: David Owens <dowens@precisionplanting.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     David Owens <dowens@precisionplanting.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: ti: omap-mcbsp: duplicate sysfs error
Date:   Thu, 16 Jun 2022 15:26:45 -0500
Message-Id: <20220616202645.1645972-1-dowens@precisionplanting.com>
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

Convert to managed versions of sysfs and clk allocation to simplify
unbinding and error handling in probe.  Managed sysfs node
creation specifically addresses the following error seen the second time
probe is attempted after sdma_pcm_platform_register() previously requested
probe deferral:

sysfs: cannot create duplicate filename '/devices/platform/68000000.ocp/49022000.mcbsp/max_tx_thres'

Signed-off-by: David Owens <dowens@precisionplanting.com>
---

Changes in v3:
 * Whitespace changes only to allow clean applly

Changes in v2:
 * Improved error handling

---
 sound/soc/ti/omap-mcbsp-priv.h |  2 --
 sound/soc/ti/omap-mcbsp-st.c   | 21 ++++-----------------
 sound/soc/ti/omap-mcbsp.c      | 26 ++++----------------------
 3 files changed, 8 insertions(+), 41 deletions(-)

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
index 0bc7d26c660a..402a57a502e6 100644
--- a/sound/soc/ti/omap-mcbsp-st.c
+++ b/sound/soc/ti/omap-mcbsp-st.c
@@ -292,14 +292,11 @@ static ssize_t st_taps_store(struct device *dev,
 
 static DEVICE_ATTR_RW(st_taps);
 
-static const struct attribute *sidetone_attrs[] = {
+static struct attribute *sidetone_attrs[] = {
 	&dev_attr_st_taps.attr,
 	NULL,
 };
-
-static const struct attribute_group sidetone_attr_group = {
-	.attrs = (struct attribute **)sidetone_attrs,
-};
+ATTRIBUTE_GROUPS(sidetone);
 
 int omap_mcbsp_st_start(struct omap_mcbsp *mcbsp)
 {
@@ -347,7 +344,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
 	if (!st_data)
 		return -ENOMEM;
 
-	st_data->mcbsp_iclk = clk_get(mcbsp->dev, "ick");
+	st_data->mcbsp_iclk = devm_clk_get(mcbsp->dev, "ick");
 	if (IS_ERR(st_data->mcbsp_iclk)) {
 		dev_warn(mcbsp->dev,
 			 "Failed to get ick, sidetone might be broken\n");
@@ -359,7 +356,7 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
 	if (!st_data->io_base_st)
 		return -ENOMEM;
 
-	ret = sysfs_create_group(&mcbsp->dev->kobj, &sidetone_attr_group);
+	ret = devm_device_add_group(mcbsp->dev, &sidetone_group);
 	if (ret)
 		return ret;
 
@@ -368,16 +365,6 @@ int omap_mcbsp_st_init(struct platform_device *pdev)
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
index 4479d74f0a45..395493a2d965 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -595,16 +595,13 @@ static ssize_t dma_op_mode_store(struct device *dev,
 
 static DEVICE_ATTR_RW(dma_op_mode);
 
-static const struct attribute *additional_attrs[] = {
+static struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
 	&dev_attr_dma_op_mode.attr,
 	NULL,
 };
-
-static const struct attribute_group additional_attr_group = {
-	.attrs = (struct attribute **)additional_attrs,
-};
+ATTRIBUTE_GROUPS(additional);
 
 /*
  * McBSP1 and McBSP3 are directly mapped on 1610 and 1510.
@@ -702,8 +699,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
 		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
 
-		ret = sysfs_create_group(&mcbsp->dev->kobj,
-					 &additional_attr_group);
+		ret = devm_device_add_group(mcbsp->dev, &additional_group);
 		if (ret) {
 			dev_err(mcbsp->dev,
 				"Unable to create additional controls\n");
@@ -711,16 +707,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
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
@@ -1431,11 +1418,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
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

