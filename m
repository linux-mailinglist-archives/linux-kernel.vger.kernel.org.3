Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3AB511D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiD0PLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiD0PK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A633A2C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qB022428;
        Wed, 27 Apr 2022 10:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0FztkMwWhaFUG87GpYloXgHTKnQqJ27GP8iJ014U1vg=;
 b=K0icGYyx74Hin4yhrSTar7l1dcJfNIgUoDnnhwIL4TBBlh81MSq0T02/N9dQl9Uliz/T
 mQ2WPPlyMpOxdoM2sw4jrbO8o9PXxcUpceDSGtNIoD7plgdT0gQ7d/f+hw30JrDqj08j
 6MI38LR3Vtfg9l6cdKCQIzannZHMI44U1lWY5V/jPBv0ZZ1AjorbBs/sUpMDFrDJtP9B
 1GtP6YMNOleeQp8bFq4+WP8RsvGjwHsSR4QxKCINr6pYSsA16DJLMQexEagEMeevXiX/
 i6FAZuivWDaI7FcoJhL2d+UHd4W4GTNgXSkQuwbuuBnBCQurwEEDqnPtdFTgvOobeyPC Wg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:22 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 77E03B1A;
        Wed, 27 Apr 2022 15:07:22 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 03/26] ALSA: hda: cs35l41: Remove Set Channel Map api from binding
Date:   Wed, 27 Apr 2022 16:06:57 +0100
Message-ID: <20220427150720.9194-4-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: j3LlMB9gY9MvBvpiWpm3r9tagiqmyMFn
X-Proofpoint-ORIG-GUID: j3LlMB9gY9MvBvpiWpm3r9tagiqmyMFn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

This API was required for CLSA0100 laptop, which did not
have correct properties inside ACPI. The required values
are now hardcoded inside the driver so this is no longer
needed.
Without this api, there CLSA0100 can now use the generic
cs35l41 fixup, like the other laptops.
All other laptops will read the Speaker Position from
ACPI and set the channel map from within the driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c   |  1 -
 sound/pci/hda/hda_component.h |  2 --
 sound/pci/hda/patch_realtek.c | 54 +----------------------------------
 3 files changed, 1 insertion(+), 56 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d7e90c0cae51..96c3e541696d 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -92,7 +92,6 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 	comps->dev = dev;
 	strscpy(comps->name, dev_name(dev), sizeof(comps->name));
 	comps->playback_hook = cs35l41_hda_playback_hook;
-	comps->set_channel_map = cs35l41_hda_channel_map;
 
 	return 0;
 }
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index 2e52be6db9c2..e26c896a13f3 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -15,6 +15,4 @@ struct hda_component {
 	struct device *dev;
 	char name[HDA_MAX_NAME_SIZE];
 	void (*playback_hook)(struct device *dev, int action);
-	int (*set_channel_map)(struct device *dev, unsigned int rx_num, unsigned int *rx_slot,
-				unsigned int tx_num, unsigned int *tx_slot);
 };
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 62fbf3772b41..dc1ff4c54291 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6582,18 +6582,6 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 	}
 }
 
-static int find_comp_by_dev_name(struct alc_spec *spec, const char *name)
-{
-	int i;
-
-	for (i = 0; i < HDA_MAX_COMPONENTS; i++) {
-		if (strcmp(spec->comps[i].name, name) == 0)
-			return i;
-	}
-
-	return -ENODEV;
-}
-
 static int comp_bind(struct device *dev)
 {
 	struct hda_codec *cdc = dev_to_hda_codec(dev);
@@ -6668,50 +6656,10 @@ static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fix
 	cs35l41_generic_fixup(codec, action, "spi0", "CSC3551", 4);
 }
 
-static void alc287_legion_16achg6_playback_hook(struct hda_pcm_stream *hinfo, struct hda_codec *cdc,
-						struct snd_pcm_substream *sub, int action)
-{
-	struct alc_spec *spec = cdc->spec;
-	unsigned int rx_slot;
-	int i;
-
-	switch (action) {
-	case HDA_GEN_PCM_ACT_PREPARE:
-		rx_slot = 0;
-		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.0");
-		if (i >= 0)
-			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
-
-		rx_slot = 1;
-		i = find_comp_by_dev_name(spec, "i2c-CLSA0100:00-cs35l41-hda.1");
-		if (i >= 0)
-			spec->comps[i].set_channel_map(spec->comps[i].dev, 0, NULL, 1, &rx_slot);
-		break;
-	}
-
-	comp_generic_playback_hook(hinfo, cdc, sub, action);
-}
-
 static void alc287_fixup_legion_16achg6_speakers(struct hda_codec *cdc, const struct hda_fixup *fix,
 						 int action)
 {
-	struct device *dev = hda_codec_dev(cdc);
-	struct alc_spec *spec = cdc->spec;
-	int ret;
-
-	switch (action) {
-	case HDA_FIXUP_ACT_PRE_PROBE:
-		component_match_add(dev, &spec->match, component_compare_dev_name,
-				    "i2c-CLSA0100:00-cs35l41-hda.0");
-		component_match_add(dev, &spec->match, component_compare_dev_name,
-				    "i2c-CLSA0100:00-cs35l41-hda.1");
-		ret = component_master_add_with_match(dev, &comp_master_ops, spec->match);
-		if (ret)
-			codec_err(cdc, "Fail to register component aggregator %d\n", ret);
-		else
-			spec->gen.pcm_playback_hook = alc287_legion_16achg6_playback_hook;
-		break;
-	}
+	cs35l41_generic_fixup(cdc, action, "i2c", "CLSA0100", 2);
 }
 
 /* for alc295_fixup_hp_top_speakers */
-- 
2.32.0

