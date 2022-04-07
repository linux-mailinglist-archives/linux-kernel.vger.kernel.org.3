Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4E4F875E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346069AbiDGSwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346970AbiDGSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:52:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A511070AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7412B82963
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8807BC385A6;
        Thu,  7 Apr 2022 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357402;
        bh=ZkRgfsBTkJKYOXWQU1Yx7NUe1llVqY2CJfV8cJxy5hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQwvMG4bnO9I9mon1TTu/bEySbqNqa6/U1URz50JcuTDSxjwhvPvLQXngdOK1PufF
         9xd7+cbpSgwlvT9GpKFYmkwCx73MVF7N7oH9Pf3tKm/Y65WbMSPCeQHaCUba9n/WhG
         wk+qdvz+RMZxbhpzC8vpVcvlu6KOFONEb+T48ALxNwjUVcbkq0wK0G+UY7vekzCri8
         KDT5SjpfGWSKKk8t3lAfr3tVhIEjmyur91qtCauHJcS+bANUPMz1EYlsH7GRGVL/t6
         Nz9bkrhrAHv+l+vu10f+rYX+RIXdUAh+MsEW/sCNPEDXeRJSPbSH8NTjMpvZYFEo8q
         T8SeJ4QQge/QA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ncXCi-000Ruk-6R; Thu, 07 Apr 2022 20:50:00 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] ASoC: Intel: sof_es8336: simplify speaker gpio naming
Date:   Thu,  7 Apr 2022 20:49:56 +0200
Message-Id: <3008c576ca45d5cc99ad4a18d1d30de45a0aff80.1649357263.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649357263.git.mchehab@kernel.org>
References: <cover.1649357263.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In preparation for the support of an additional gpio for headphone
control, rename GPIOs to make explicit references to speakers and
gpio0 or gpio1.

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v5 0/4] at: https://lore.kernel.org/all/cover.1649357263.git.mchehab@kernel.org/

 sound/soc/intel/boards/sof_es8336.c | 42 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 5e0529aa4f1d..e4829a376b79 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -27,7 +27,7 @@
 #define SOF_ES8336_SSP_CODEC(quirk)		((quirk) & GENMASK(3, 0))
 #define SOF_ES8336_SSP_CODEC_MASK		(GENMASK(3, 0))
 
-#define SOF_ES8336_TGL_GPIO_QUIRK		BIT(4)
+#define SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK	BIT(4)
 #define SOF_ES8336_ENABLE_DMIC			BIT(5)
 #define SOF_ES8336_JD_INVERTED			BIT(6)
 
@@ -39,7 +39,7 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 struct sof_es8336_private {
 	struct device *codec_dev;
-	struct gpio_desc *gpio_pa;
+	struct gpio_desc *gpio_speakers;
 	struct snd_soc_jack jack;
 	struct list_head hdmi_pcm_list;
 	bool speaker_en;
@@ -51,19 +51,19 @@ struct sof_hdmi_pcm {
 	int device;
 };
 
-static const struct acpi_gpio_params pa_enable_gpio = { 0, 0, true };
-static const struct acpi_gpio_mapping acpi_es8336_gpios[] = {
-	{ "pa-enable-gpios", &pa_enable_gpio, 1 },
+static const struct acpi_gpio_params speakers_enable_gpio0 = { 0, 0, true };
+static const struct acpi_gpio_mapping acpi_speakers_enable_gpio0[] = {
+	{ "speakers-enable-gpios", &speakers_enable_gpio0, 1 },
 	{ }
 };
 
-static const struct acpi_gpio_params quirk_pa_enable_gpio = { 1, 0, true };
-static const struct acpi_gpio_mapping quirk_acpi_es8336_gpios[] = {
-	{ "pa-enable-gpios", &quirk_pa_enable_gpio, 1 },
+static const struct acpi_gpio_params speakers_enable_gpio1 = { 1, 0, true };
+static const struct acpi_gpio_mapping acpi_speakers_enable_gpio1[] = {
+	{ "speakers-enable-gpios", &speakers_enable_gpio1, 1 },
 	{ }
 };
 
-static const struct acpi_gpio_mapping *gpio_mapping = acpi_es8336_gpios;
+static const struct acpi_gpio_mapping *gpio_mapping = acpi_speakers_enable_gpio0;
 
 static void log_quirks(struct device *dev)
 {
@@ -71,8 +71,8 @@ static void log_quirks(struct device *dev)
 	dev_info(dev, "quirk SSP%ld\n",  SOF_ES8336_SSP_CODEC(quirk));
 	if (quirk & SOF_ES8336_ENABLE_DMIC)
 		dev_info(dev, "quirk DMIC enabled\n");
-	if (quirk & SOF_ES8336_TGL_GPIO_QUIRK)
-		dev_info(dev, "quirk TGL GPIO enabled\n");
+	if (quirk & SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
+		dev_info(dev, "Speakers GPIO1 quirk enabled\n");
 	if (quirk & SOF_ES8336_JD_INVERTED)
 		dev_info(dev, "quirk JD inverted enabled\n");
 }
@@ -88,7 +88,7 @@ static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
 	else
 		priv->speaker_en = true;
 
-	gpiod_set_value_cansleep(priv->gpio_pa, priv->speaker_en);
+	gpiod_set_value_cansleep(priv->gpio_speakers, priv->speaker_en);
 
 	return 0;
 }
@@ -233,8 +233,8 @@ static int sof_es8336_quirk_cb(const struct dmi_system_id *id)
 {
 	quirk = (unsigned long)id->driver_data;
 
-	if (quirk & SOF_ES8336_TGL_GPIO_QUIRK)
-		gpio_mapping = quirk_acpi_es8336_gpios;
+	if (quirk & SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
+		gpio_mapping = acpi_speakers_enable_gpio1;
 
 	return 1;
 }
@@ -257,7 +257,7 @@ static const struct dmi_system_id sof_es8336_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "IP3 tech"),
 			DMI_MATCH(DMI_BOARD_NAME, "WN1"),
 		},
-		.driver_data = (void *)(SOF_ES8336_TGL_GPIO_QUIRK)
+		.driver_data = (void *)(SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK)
 	},
 	{}
 };
@@ -585,10 +585,10 @@ static int sof_es8336_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(codec_dev, "unable to add GPIO mapping table\n");
 
-	priv->gpio_pa = gpiod_get_optional(codec_dev, "pa-enable", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->gpio_pa)) {
-		ret = dev_err_probe(dev, PTR_ERR(priv->gpio_pa),
-				    "could not get pa-enable GPIO\n");
+	priv->gpio_speakers = gpiod_get_optional(codec_dev, "speakers-enable", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->gpio_speakers)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->gpio_speakers),
+				    "could not get speakers-enable GPIO\n");
 		goto err_put_codec;
 	}
 
@@ -604,7 +604,7 @@ static int sof_es8336_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret) {
-		gpiod_put(priv->gpio_pa);
+		gpiod_put(priv->gpio_speakers);
 		dev_err(dev, "snd_soc_register_card failed: %d\n", ret);
 		goto err_put_codec;
 	}
@@ -622,7 +622,7 @@ static int sof_es8336_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct sof_es8336_private *priv = snd_soc_card_get_drvdata(card);
 
-	gpiod_put(priv->gpio_pa);
+	gpiod_put(priv->gpio_speakers);
 	device_remove_software_node(priv->codec_dev);
 	put_device(priv->codec_dev);
 
-- 
2.35.1

