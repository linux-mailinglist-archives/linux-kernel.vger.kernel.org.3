Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3BD51A510
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353140AbiEDQQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiEDQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:16:47 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97226AF8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:13:10 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446CVn4001835;
        Wed, 4 May 2022 11:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=rmDQ80H8UgzKqeTmjUp8vjljMwiUY/Rjk9BEERWFm4g=;
 b=qzaBr6NypVZRdWV6lSXs0+6DbpnBT9DiR94Tejejrd/POfzEbJUb0f9zDfjk/l7QTTPo
 Nc2gK3u5TadnqtKaiY0XN/MiocqLabJMskGAz1p26CrhTiFW9rrbLIkzylu9OUnKvYY/
 xdIQkfRqOe0lKvdyRnoGwPH8n1hirvUA7bN0fR6d5/BH2oXRUaRMVzFu8SrMbWwue9hK
 BC8per0iMcyp6MU19IpqUQ+gpoEisxYRF2/OYZNwYVQpNfWG68jUHubEcPH2/XHcK+xd
 vgWvP8rtaF4d8hfcDb9abaFAn5n/w+Cy2WmqiS0BZcmH4rb3SFE3PFBryPQm3BpKqvc9 UQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fs2h2d6b6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 May 2022 11:12:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 17:12:47 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 4 May 2022 17:12:47 +0100
Received: from sbinding-cirrus-dsktp.ad.cirrus.com (unknown [198.90.238.73])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A3169B10;
        Wed,  4 May 2022 16:12:46 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/3] ALSA: hda/cs8409: Use general cs42l42 include in cs8409 hda driver
Date:   Wed, 4 May 2022 17:12:35 +0100
Message-ID: <20220504161236.2490532-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504161236.2490532-1-sbinding@opensource.cirrus.com>
References: <20220504161236.2490532-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rg-CD_wgcy0zNgti6kGuFd5FNGidej2O
X-Proofpoint-GUID: Rg-CD_wgcy0zNgti6kGuFd5FNGidej2O
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to improve maintainability of the driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c | 324 ++++++++++++++--------------
 sound/pci/hda/patch_cs8409.c        | 128 +++++------
 sound/pci/hda/patch_cs8409.h        |   8 +-
 3 files changed, 229 insertions(+), 231 deletions(-)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index 74c50ec040d9..a7ee489e6aec 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -78,65 +78,65 @@ const struct hda_pintbl cs8409_cs42l42_pincfgs[] = {
 
 /* Vendor specific HW configuration for CS42L42 */
 static const struct cs8409_i2c_param cs42l42_init_reg_seq[] = {
-	{ 0x1010, 0xB0 },
-	{ 0x1D01, 0x00 },
+	{ CS42L42_I2C_TIMEOUT, 0xB0 },
+	{ CS42L42_ADC_CTL, 0x00 },
 	{ 0x1D02, 0x06 },
-	{ 0x1D03, 0x9F },
-	{ 0x1107, 0x01 },
-	{ 0x1009, 0x02 },
-	{ 0x1007, 0x03 },
-	{ 0x1201, 0x00 },
-	{ 0x1208, 0x13 },
-	{ 0x1205, 0xFF },
-	{ 0x1206, 0x00 },
-	{ 0x1207, 0x20 },
-	{ 0x1202, 0x0D },
-	{ 0x2A02, 0x02 },
-	{ 0x2A03, 0x00 },
-	{ 0x2A04, 0x00 },
-	{ 0x2A05, 0x02 },
-	{ 0x2A06, 0x00 },
-	{ 0x2A07, 0x20 },
-	{ 0x2A08, 0x02 },
-	{ 0x2A09, 0x00 },
-	{ 0x2A0A, 0x80 },
-	{ 0x2A0B, 0x02 },
-	{ 0x2A0C, 0x00 },
-	{ 0x2A0D, 0xA0 },
-	{ 0x2A01, 0x0C },
-	{ 0x2902, 0x01 },
-	{ 0x2903, 0x02 },
-	{ 0x2904, 0x00 },
-	{ 0x2905, 0x00 },
-	{ 0x2901, 0x01 },
-	{ 0x1101, 0x0A },
-	{ 0x1102, 0x84 },
-	{ 0x2301, 0x3F },
-	{ 0x2303, 0x3F },
-	{ 0x2302, 0x3f },
-	{ 0x2001, 0x03 },
-	{ 0x1B75, 0xB6 },
-	{ 0x1B73, 0xC2 },
-	{ 0x1129, 0x01 },
-	{ 0x1121, 0xF3 },
-	{ 0x1103, 0x20 },
-	{ 0x1105, 0x00 },
-	{ 0x1112, 0x00 },
-	{ 0x1113, 0x80 },
-	{ 0x1C03, 0xC0 },
-	{ 0x1101, 0x02 },
-	{ 0x1316, 0xff },
-	{ 0x1317, 0xff },
-	{ 0x1318, 0xff },
-	{ 0x1319, 0xff },
-	{ 0x131a, 0xff },
-	{ 0x131b, 0xff },
-	{ 0x131c, 0xff },
-	{ 0x131e, 0xff },
-	{ 0x131f, 0xff },
-	{ 0x1320, 0xff },
-	{ 0x1b79, 0xff },
-	{ 0x1b7a, 0xff },
+	{ CS42L42_ADC_VOLUME, 0x9F },
+	{ CS42L42_OSC_SWITCH, 0x01 },
+	{ CS42L42_MCLK_CTL, 0x02 },
+	{ CS42L42_SRC_CTL, 0x03 },
+	{ CS42L42_MCLK_SRC_SEL, 0x00 },
+	{ CS42L42_ASP_FRM_CFG, 0x13 },
+	{ CS42L42_FSYNC_P_LOWER, 0xFF },
+	{ CS42L42_FSYNC_P_UPPER, 0x00 },
+	{ CS42L42_ASP_CLK_CFG, 0x20 },
+	{ CS42L42_SPDIF_CLK_CFG, 0x0D },
+	{ CS42L42_ASP_RX_DAI0_CH1_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_LSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_LSB, 0x20 },
+	{ CS42L42_ASP_RX_DAI0_CH3_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH3_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH3_BIT_LSB, 0x80 },
+	{ CS42L42_ASP_RX_DAI0_CH4_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH4_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH4_BIT_LSB, 0xA0 },
+	{ CS42L42_ASP_RX_DAI0_EN, 0x0C },
+	{ CS42L42_ASP_TX_CH_EN, 0x01 },
+	{ CS42L42_ASP_TX_CH_AP_RES, 0x02 },
+	{ CS42L42_ASP_TX_CH1_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_TX_CH1_BIT_LSB, 0x00 },
+	{ CS42L42_ASP_TX_SZ_EN, 0x01 },
+	{ CS42L42_PWR_CTL1, 0x0A },
+	{ CS42L42_PWR_CTL2, 0x84 },
+	{ CS42L42_MIXER_CHA_VOL, 0x3F },
+	{ CS42L42_MIXER_CHB_VOL, 0x3F },
+	{ CS42L42_MIXER_ADC_VOL, 0x3f },
+	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_MIC_DET_CTL1, 0xB6 },
+	{ CS42L42_TIPSENSE_CTL, 0xC2 },
+	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
+	{ CS42L42_HS_SWITCH_CTL, 0xF3 },
+	{ CS42L42_PWR_CTL3, 0x20 },
+	{ CS42L42_RSENSE_CTL2, 0x00 },
+	{ CS42L42_RSENSE_CTL3, 0x00 },
+	{ CS42L42_TSENSE_CTL, 0x80 },
+	{ CS42L42_HS_BIAS_CTL, 0xC0 },
+	{ CS42L42_PWR_CTL1, 0x02 },
+	{ CS42L42_ADC_OVFL_INT_MASK, 0xff },
+	{ CS42L42_MIXER_INT_MASK, 0xff },
+	{ CS42L42_SRC_INT_MASK, 0xff },
+	{ CS42L42_ASP_RX_INT_MASK, 0xff },
+	{ CS42L42_ASP_TX_INT_MASK, 0xff },
+	{ CS42L42_CODEC_INT_MASK, 0xff },
+	{ CS42L42_SRCPL_INT_MASK, 0xff },
+	{ CS42L42_VPMON_INT_MASK, 0xff },
+	{ CS42L42_PLL_LOCK_INT_MASK, 0xff },
+	{ CS42L42_TSRS_PLUG_INT_MASK, 0xff },
+	{ CS42L42_DET_INT1_MASK, 0xff },
+	{ CS42L42_DET_INT2_MASK, 0xff },
 };
 
 /* Vendor specific hw configuration for CS8409 */
@@ -282,115 +282,115 @@ const struct hda_pintbl dolphin_pincfgs[] = {
 
 /* Vendor specific HW configuration for CS42L42 */
 static const struct cs8409_i2c_param dolphin_c0_init_reg_seq[] = {
-	{ 0x1010, 0xB0 },
-	{ 0x1D01, 0x00 },
+	{ CS42L42_I2C_TIMEOUT, 0xB0 },
+	{ CS42L42_ADC_CTL, 0x00 },
 	{ 0x1D02, 0x06 },
-	{ 0x1D03, 0x9F },
-	{ 0x1107, 0x01 },
-	{ 0x1009, 0x02 },
-	{ 0x1007, 0x03 },
-	{ 0x1201, 0x00 },
-	{ 0x1208, 0x13 },
-	{ 0x1205, 0xFF },
-	{ 0x1206, 0x00 },
-	{ 0x1207, 0x20 },
-	{ 0x1202, 0x0D },
-	{ 0x2A02, 0x02 },
-	{ 0x2A03, 0x00 },
-	{ 0x2A04, 0x00 },
-	{ 0x2A05, 0x02 },
-	{ 0x2A06, 0x00 },
-	{ 0x2A07, 0x20 },
-	{ 0x2A01, 0x0C },
-	{ 0x2902, 0x01 },
-	{ 0x2903, 0x02 },
-	{ 0x2904, 0x00 },
-	{ 0x2905, 0x00 },
-	{ 0x2901, 0x01 },
-	{ 0x1101, 0x0A },
-	{ 0x1102, 0x84 },
-	{ 0x2001, 0x03 },
-	{ 0x2301, 0x3F },
-	{ 0x2303, 0x3F },
-	{ 0x2302, 0x3f },
-	{ 0x1B75, 0xB6 },
-	{ 0x1B73, 0xC2 },
-	{ 0x1129, 0x01 },
-	{ 0x1121, 0xF3 },
-	{ 0x1103, 0x20 },
-	{ 0x1105, 0x00 },
-	{ 0x1112, 0x00 },
-	{ 0x1113, 0x80 },
-	{ 0x1C03, 0xC0 },
-	{ 0x1101, 0x02 },
-	{ 0x1316, 0xff },
-	{ 0x1317, 0xff },
-	{ 0x1318, 0xff },
-	{ 0x1319, 0xff },
-	{ 0x131a, 0xff },
-	{ 0x131b, 0xff },
-	{ 0x131c, 0xff },
-	{ 0x131e, 0xff },
-	{ 0x131f, 0xff },
-	{ 0x1320, 0xff },
-	{ 0x1b79, 0xff },
-	{ 0x1b7a, 0xff }
+	{ CS42L42_ADC_VOLUME, 0x9F },
+	{ CS42L42_OSC_SWITCH, 0x01 },
+	{ CS42L42_MCLK_CTL, 0x02 },
+	{ CS42L42_SRC_CTL, 0x03 },
+	{ CS42L42_MCLK_SRC_SEL, 0x00 },
+	{ CS42L42_ASP_FRM_CFG, 0x13 },
+	{ CS42L42_FSYNC_P_LOWER, 0xFF },
+	{ CS42L42_FSYNC_P_UPPER, 0x00 },
+	{ CS42L42_ASP_CLK_CFG, 0x20 },
+	{ CS42L42_SPDIF_CLK_CFG, 0x0D },
+	{ CS42L42_ASP_RX_DAI0_CH1_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_LSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_LSB, 0x20 },
+	{ CS42L42_ASP_RX_DAI0_EN, 0x0C },
+	{ CS42L42_ASP_TX_CH_EN, 0x01 },
+	{ CS42L42_ASP_TX_CH_AP_RES, 0x02 },
+	{ CS42L42_ASP_TX_CH1_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_TX_CH1_BIT_LSB, 0x00 },
+	{ CS42L42_ASP_TX_SZ_EN, 0x01 },
+	{ CS42L42_PWR_CTL1, 0x0A },
+	{ CS42L42_PWR_CTL2, 0x84 },
+	{ CS42L42_HP_CTL, 0x03 },
+	{ CS42L42_MIXER_CHA_VOL, 0x3F },
+	{ CS42L42_MIXER_CHB_VOL, 0x3F },
+	{ CS42L42_MIXER_ADC_VOL, 0x3f },
+	{ CS42L42_MIC_DET_CTL1, 0xB6 },
+	{ CS42L42_TIPSENSE_CTL, 0xC2 },
+	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
+	{ CS42L42_HS_SWITCH_CTL, 0xF3 },
+	{ CS42L42_PWR_CTL3, 0x20 },
+	{ CS42L42_RSENSE_CTL2, 0x00 },
+	{ CS42L42_RSENSE_CTL3, 0x00 },
+	{ CS42L42_TSENSE_CTL, 0x80 },
+	{ CS42L42_HS_BIAS_CTL, 0xC0 },
+	{ CS42L42_PWR_CTL1, 0x02 },
+	{ CS42L42_ADC_OVFL_INT_MASK, 0xff },
+	{ CS42L42_MIXER_INT_MASK, 0xff },
+	{ CS42L42_SRC_INT_MASK, 0xff },
+	{ CS42L42_ASP_RX_INT_MASK, 0xff },
+	{ CS42L42_ASP_TX_INT_MASK, 0xff },
+	{ CS42L42_CODEC_INT_MASK, 0xff },
+	{ CS42L42_SRCPL_INT_MASK, 0xff },
+	{ CS42L42_VPMON_INT_MASK, 0xff },
+	{ CS42L42_PLL_LOCK_INT_MASK, 0xff },
+	{ CS42L42_TSRS_PLUG_INT_MASK, 0xff },
+	{ CS42L42_DET_INT1_MASK, 0xff },
+	{ CS42L42_DET_INT2_MASK, 0xff }
 };
 
 static const struct cs8409_i2c_param dolphin_c1_init_reg_seq[] = {
-	{ 0x1010, 0xB0 },
-	{ 0x1D01, 0x00 },
+	{ CS42L42_I2C_TIMEOUT, 0xB0 },
+	{ CS42L42_ADC_CTL, 0x00 },
 	{ 0x1D02, 0x06 },
-	{ 0x1D03, 0x9F },
-	{ 0x1107, 0x01 },
-	{ 0x1009, 0x02 },
-	{ 0x1007, 0x03 },
-	{ 0x1201, 0x00 },
-	{ 0x1208, 0x13 },
-	{ 0x1205, 0xFF },
-	{ 0x1206, 0x00 },
-	{ 0x1207, 0x20 },
-	{ 0x1202, 0x0D },
-	{ 0x2A02, 0x02 },
-	{ 0x2A03, 0x00 },
-	{ 0x2A04, 0x80 },
-	{ 0x2A05, 0x02 },
-	{ 0x2A06, 0x00 },
-	{ 0x2A07, 0xA0 },
-	{ 0x2A01, 0x0C },
-	{ 0x2902, 0x00 },
-	{ 0x2903, 0x02 },
-	{ 0x2904, 0x00 },
-	{ 0x2905, 0x00 },
-	{ 0x2901, 0x00 },
-	{ 0x1101, 0x0E },
-	{ 0x1102, 0x84 },
-	{ 0x2001, 0x01 },
-	{ 0x2301, 0x3F },
-	{ 0x2303, 0x3F },
-	{ 0x2302, 0x3f },
-	{ 0x1B75, 0xB6 },
-	{ 0x1B73, 0xC2 },
-	{ 0x1129, 0x01 },
-	{ 0x1121, 0xF3 },
-	{ 0x1103, 0x20 },
-	{ 0x1105, 0x00 },
-	{ 0x1112, 0x00 },
-	{ 0x1113, 0x80 },
-	{ 0x1C03, 0xC0 },
-	{ 0x1101, 0x06 },
-	{ 0x1316, 0xff },
-	{ 0x1317, 0xff },
-	{ 0x1318, 0xff },
-	{ 0x1319, 0xff },
-	{ 0x131a, 0xff },
-	{ 0x131b, 0xff },
-	{ 0x131c, 0xff },
-	{ 0x131e, 0xff },
-	{ 0x131f, 0xff },
-	{ 0x1320, 0xff },
-	{ 0x1b79, 0xff },
-	{ 0x1b7a, 0xff }
+	{ CS42L42_ADC_VOLUME, 0x9F },
+	{ CS42L42_OSC_SWITCH, 0x01 },
+	{ CS42L42_MCLK_CTL, 0x02 },
+	{ CS42L42_SRC_CTL, 0x03 },
+	{ CS42L42_MCLK_SRC_SEL, 0x00 },
+	{ CS42L42_ASP_FRM_CFG, 0x13 },
+	{ CS42L42_FSYNC_P_LOWER, 0xFF },
+	{ CS42L42_FSYNC_P_UPPER, 0x00 },
+	{ CS42L42_ASP_CLK_CFG, 0x20 },
+	{ CS42L42_SPDIF_CLK_CFG, 0x0D },
+	{ CS42L42_ASP_RX_DAI0_CH1_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH1_BIT_LSB, 0x80 },
+	{ CS42L42_ASP_RX_DAI0_CH2_AP_RES, 0x02 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_RX_DAI0_CH2_BIT_LSB, 0xA0 },
+	{ CS42L42_ASP_RX_DAI0_EN, 0x0C },
+	{ CS42L42_ASP_TX_CH_EN, 0x00 },
+	{ CS42L42_ASP_TX_CH_AP_RES, 0x02 },
+	{ CS42L42_ASP_TX_CH1_BIT_MSB, 0x00 },
+	{ CS42L42_ASP_TX_CH1_BIT_LSB, 0x00 },
+	{ CS42L42_ASP_TX_SZ_EN, 0x00 },
+	{ CS42L42_PWR_CTL1, 0x0E },
+	{ CS42L42_PWR_CTL2, 0x84 },
+	{ CS42L42_HP_CTL, 0x01 },
+	{ CS42L42_MIXER_CHA_VOL, 0x3F },
+	{ CS42L42_MIXER_CHB_VOL, 0x3F },
+	{ CS42L42_MIXER_ADC_VOL, 0x3f },
+	{ CS42L42_MIC_DET_CTL1, 0xB6 },
+	{ CS42L42_TIPSENSE_CTL, 0xC2 },
+	{ CS42L42_HS_CLAMP_DISABLE, 0x01 },
+	{ CS42L42_HS_SWITCH_CTL, 0xF3 },
+	{ CS42L42_PWR_CTL3, 0x20 },
+	{ CS42L42_RSENSE_CTL2, 0x00 },
+	{ CS42L42_RSENSE_CTL3, 0x00 },
+	{ CS42L42_TSENSE_CTL, 0x80 },
+	{ CS42L42_HS_BIAS_CTL, 0xC0 },
+	{ CS42L42_PWR_CTL1, 0x06 },
+	{ CS42L42_ADC_OVFL_INT_MASK, 0xff },
+	{ CS42L42_MIXER_INT_MASK, 0xff },
+	{ CS42L42_SRC_INT_MASK, 0xff },
+	{ CS42L42_ASP_RX_INT_MASK, 0xff },
+	{ CS42L42_ASP_TX_INT_MASK, 0xff },
+	{ CS42L42_CODEC_INT_MASK, 0xff },
+	{ CS42L42_SRCPL_INT_MASK, 0xff },
+	{ CS42L42_VPMON_INT_MASK, 0xff },
+	{ CS42L42_PLL_LOCK_INT_MASK, 0xff },
+	{ CS42L42_TSRS_PLUG_INT_MASK, 0xff },
+	{ CS42L42_DET_INT1_MASK, 0xff },
+	{ CS42L42_DET_INT2_MASK, 0xff }
 };
 
 /* Vendor specific hw configuration for CS8409 */
diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 343fabc4387d..d35d124bf3dc 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -481,26 +481,26 @@ static void cs42l42_mute(struct sub_codec *cs42l42, int vol_type,
 	if (mute) {
 		if (vol_type == CS42L42_VOL_DAC) {
 			if (chs & BIT(0))
-				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHA, 0x3f);
+				cs8409_i2c_write(cs42l42, CS42L42_MIXER_CHA_VOL, 0x3f);
 			if (chs & BIT(1))
-				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHB, 0x3f);
+				cs8409_i2c_write(cs42l42, CS42L42_MIXER_CHB_VOL, 0x3f);
 		} else if (vol_type == CS42L42_VOL_ADC) {
 			if (chs & BIT(0))
-				cs8409_i2c_write(cs42l42, CS42L42_REG_AMIC_VOL, 0x9f);
+				cs8409_i2c_write(cs42l42, CS42L42_ADC_VOLUME, 0x9f);
 		}
 	} else {
 		if (vol_type == CS42L42_VOL_DAC) {
 			if (chs & BIT(0))
-				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHA,
+				cs8409_i2c_write(cs42l42, CS42L42_MIXER_CHA_VOL,
 					-(cs42l42->vol[CS42L42_DAC_CH0_VOL_OFFSET])
-					& CS42L42_REG_HS_VOL_MASK);
+					& CS42L42_MIXER_CH_VOL_MASK);
 			if (chs & BIT(1))
-				cs8409_i2c_write(cs42l42, CS42L42_REG_HS_VOL_CHB,
+				cs8409_i2c_write(cs42l42, CS42L42_MIXER_CHB_VOL,
 					-(cs42l42->vol[CS42L42_DAC_CH1_VOL_OFFSET])
-					& CS42L42_REG_HS_VOL_MASK);
+					& CS42L42_MIXER_CH_VOL_MASK);
 		} else if (vol_type == CS42L42_VOL_ADC) {
 			if (chs & BIT(0))
-				cs8409_i2c_write(cs42l42, CS42L42_REG_AMIC_VOL,
+				cs8409_i2c_write(cs42l42, CS42L42_ADC_VOLUME,
 					cs42l42->vol[CS42L42_ADC_VOL_OFFSET]
 					& CS42L42_REG_AMIC_VOL_MASK);
 		}
@@ -601,37 +601,37 @@ static void cs42l42_capture_pcm_hook(struct hda_pcm_stream *hinfo,
 /* Configure CS42L42 slave codec for jack autodetect */
 static void cs42l42_enable_jack_detect(struct sub_codec *cs42l42)
 {
-	cs8409_i2c_write(cs42l42, 0x1b70, cs42l42->hsbias_hiz);
+	cs8409_i2c_write(cs42l42, CS42L42_HSBIAS_SC_AUTOCTL, cs42l42->hsbias_hiz);
 	/* Clear WAKE# */
-	cs8409_i2c_write(cs42l42, 0x1b71, 0x00C1);
+	cs8409_i2c_write(cs42l42, CS42L42_WAKE_CTL, 0x00C1);
 	/* Wait ~2.5ms */
 	usleep_range(2500, 3000);
 	/* Set mode WAKE# output follows the combination logic directly */
-	cs8409_i2c_write(cs42l42, 0x1b71, 0x00C0);
+	cs8409_i2c_write(cs42l42, CS42L42_WAKE_CTL, 0x00C0);
 	/* Clear interrupts status */
-	cs8409_i2c_read(cs42l42, 0x130f);
+	cs8409_i2c_read(cs42l42, CS42L42_TSRS_PLUG_STATUS);
 	/* Enable interrupt */
-	cs8409_i2c_write(cs42l42, 0x1320, 0xF3);
+	cs8409_i2c_write(cs42l42, CS42L42_TSRS_PLUG_INT_MASK, 0xF3);
 }
 
 /* Enable and run CS42L42 slave codec jack auto detect */
 static void cs42l42_run_jack_detect(struct sub_codec *cs42l42)
 {
 	/* Clear interrupts */
-	cs8409_i2c_read(cs42l42, 0x1308);
-	cs8409_i2c_read(cs42l42, 0x1b77);
-	cs8409_i2c_write(cs42l42, 0x1320, 0xFF);
-	cs8409_i2c_read(cs42l42, 0x130f);
-
-	cs8409_i2c_write(cs42l42, 0x1102, 0x87);
-	cs8409_i2c_write(cs42l42, 0x1f06, 0x86);
-	cs8409_i2c_write(cs42l42, 0x1b74, 0x07);
-	cs8409_i2c_write(cs42l42, 0x131b, 0xFD);
-	cs8409_i2c_write(cs42l42, 0x1120, 0x80);
+	cs8409_i2c_read(cs42l42, CS42L42_CODEC_STATUS);
+	cs8409_i2c_read(cs42l42, CS42L42_DET_STATUS1);
+	cs8409_i2c_write(cs42l42, CS42L42_TSRS_PLUG_INT_MASK, 0xFF);
+	cs8409_i2c_read(cs42l42, CS42L42_TSRS_PLUG_STATUS);
+
+	cs8409_i2c_write(cs42l42, CS42L42_PWR_CTL2, 0x87);
+	cs8409_i2c_write(cs42l42, CS42L42_DAC_CTL2, 0x86);
+	cs8409_i2c_write(cs42l42, CS42L42_MISC_DET_CTL, 0x07);
+	cs8409_i2c_write(cs42l42, CS42L42_CODEC_INT_MASK, 0xFD);
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2, 0x80);
 	/* Wait ~20ms*/
 	usleep_range(20000, 25000);
-	cs8409_i2c_write(cs42l42, 0x111f, 0x77);
-	cs8409_i2c_write(cs42l42, 0x1120, 0xc0);
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL1, 0x77);
+	cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2, 0xc0);
 }
 
 static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_ts_status)
@@ -642,7 +642,7 @@ static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_
 
 	/* TIP_SENSE INSERT/REMOVE */
 	switch (reg_ts_status) {
-	case CS42L42_JACK_INSERTED:
+	case CS42L42_TS_PLUG:
 		if (!cs42l42->hp_jack_in) {
 			if (cs42l42->no_type_dect) {
 				status_changed = 1;
@@ -654,7 +654,7 @@ static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_
 		}
 		break;
 
-	case CS42L42_JACK_REMOVED:
+	case CS42L42_TS_UNPLUG:
 		if (cs42l42->hp_jack_in || cs42l42->mic_jack_in) {
 			status_changed = 1;
 			cs42l42->hp_jack_in = 0;
@@ -671,6 +671,7 @@ static int cs42l42_handle_tip_sense(struct sub_codec *cs42l42, unsigned int reg_
 
 static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 {
+	int current_plug_status;
 	int status_changed = 0;
 	int reg_cdc_status;
 	int reg_hs_status;
@@ -678,46 +679,49 @@ static int cs42l42_jack_unsol_event(struct sub_codec *cs42l42)
 	int type;
 
 	/* Read jack detect status registers */
-	reg_cdc_status = cs8409_i2c_read(cs42l42, 0x1308);
-	reg_hs_status = cs8409_i2c_read(cs42l42, 0x1124);
-	reg_ts_status = cs8409_i2c_read(cs42l42, 0x130f);
+	reg_cdc_status = cs8409_i2c_read(cs42l42, CS42L42_CODEC_STATUS);
+	reg_hs_status = cs8409_i2c_read(cs42l42, CS42L42_HS_DET_STATUS);
+	reg_ts_status = cs8409_i2c_read(cs42l42, CS42L42_TSRS_PLUG_STATUS);
 
 	/* If status values are < 0, read error has occurred. */
 	if (reg_cdc_status < 0 || reg_hs_status < 0 || reg_ts_status < 0)
 		return -EIO;
 
+	current_plug_status = (reg_ts_status & (CS42L42_TS_PLUG_MASK | CS42L42_TS_UNPLUG_MASK))
+				>> CS42L42_TS_PLUG_SHIFT;
+
 	/* HSDET_AUTO_DONE */
-	if (reg_cdc_status & CS42L42_HSDET_AUTO_DONE) {
+	if (reg_cdc_status & CS42L42_HSDET_AUTO_DONE_MASK) {
 
 		/* Disable HSDET_AUTO_DONE */
-		cs8409_i2c_write(cs42l42, 0x131b, 0xFF);
+		cs8409_i2c_write(cs42l42, CS42L42_CODEC_INT_MASK, 0xFF);
 
-		type = ((reg_hs_status & CS42L42_HSTYPE_MASK) + 1);
+		type = (reg_hs_status & CS42L42_HSDET_TYPE_MASK) >> CS42L42_HSDET_TYPE_SHIFT;
 
 		if (cs42l42->no_type_dect) {
-			status_changed = cs42l42_handle_tip_sense(cs42l42, reg_ts_status);
-		} else if (type == 4) {
-			/* Type 4 not supported	*/
-			status_changed = cs42l42_handle_tip_sense(cs42l42, CS42L42_JACK_REMOVED);
+			status_changed = cs42l42_handle_tip_sense(cs42l42, current_plug_status);
+		} else if (type == CS42L42_PLUG_INVALID) {
+			/* Type CS42L42_PLUG_INVALID not supported	*/
+			status_changed = cs42l42_handle_tip_sense(cs42l42, CS42L42_TS_UNPLUG);
 		} else {
 			if (!cs42l42->hp_jack_in) {
 				status_changed = 1;
 				cs42l42->hp_jack_in = 1;
 			}
-			/* type = 3 has no mic */
-			if ((!cs42l42->mic_jack_in) && (type != 3)) {
+			/* type = CS42L42_PLUG_HEADPHONE has no mic */
+			if ((!cs42l42->mic_jack_in) && (type != CS42L42_PLUG_HEADPHONE)) {
 				status_changed = 1;
 				cs42l42->mic_jack_in = 1;
 			}
 		}
 		/* Configure the HSDET mode. */
-		cs8409_i2c_write(cs42l42, 0x1120, 0x80);
+		cs8409_i2c_write(cs42l42, CS42L42_HSDET_CTL2, 0x80);
 		/* Enable the HPOUT ground clamp and configure the HP pull-down */
-		cs8409_i2c_write(cs42l42, 0x1F06, 0x02);
+		cs8409_i2c_write(cs42l42, CS42L42_DAC_CTL2, 0x02);
 		/* Re-Enable Tip Sense Interrupt */
-		cs8409_i2c_write(cs42l42, 0x1320, 0xF3);
+		cs8409_i2c_write(cs42l42, CS42L42_TSRS_PLUG_INT_MASK, 0xF3);
 	} else {
-		status_changed = cs42l42_handle_tip_sense(cs42l42, reg_ts_status);
+		status_changed = cs42l42_handle_tip_sense(cs42l42, current_plug_status);
 	}
 
 	return status_changed;
@@ -728,10 +732,10 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	struct hda_codec *codec = cs42l42->codec;
 	unsigned int gpio_data;
 	struct cs8409_i2c_param irq_regs[] = {
-		{ 0x1308, 0x00 },
-		{ 0x1309, 0x00 },
-		{ 0x130A, 0x00 },
-		{ 0x130F, 0x00 },
+		{ CS42L42_CODEC_STATUS, 0x00 },
+		{ CS42L42_DET_INT_STATUS1, 0x00 },
+		{ CS42L42_DET_INT_STATUS2, 0x00 },
+		{ CS42L42_TSRS_PLUG_STATUS, 0x00 },
 	};
 	int fsv_old, fsv_new;
 
@@ -750,13 +754,13 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
 
-	fsv_old = cs8409_i2c_read(cs42l42, 0x2001);
+	fsv_old = cs8409_i2c_read(cs42l42, CS42L42_HP_CTL);
 	if (cs42l42->full_scale_vol == CS42L42_FULL_SCALE_VOL_0DB)
 		fsv_new = fsv_old & ~CS42L42_FULL_SCALE_VOL_MASK;
 	else
 		fsv_new = fsv_old & CS42L42_FULL_SCALE_VOL_MASK;
 	if (fsv_new != fsv_old)
-		cs8409_i2c_write(cs42l42, 0x2001, fsv_new);
+		cs8409_i2c_write(cs42l42, CS42L42_HP_CTL, fsv_new);
 
 	/* we have to explicitly allow unsol event handling even during the
 	 * resume phase so that the jack event is processed properly
@@ -773,28 +777,28 @@ static void cs42l42_suspend(struct sub_codec *cs42l42)
 	unsigned int gpio_data;
 	int reg_cdc_status = 0;
 	const struct cs8409_i2c_param cs42l42_pwr_down_seq[] = {
-		{ 0x1F06, 0x02 },
-		{ 0x1129, 0x00 },
-		{ 0x2301, 0x3F },
-		{ 0x2302, 0x3F },
-		{ 0x2303, 0x3F },
-		{ 0x2001, 0x0F },
-		{ 0x2A01, 0x00 },
-		{ 0x1207, 0x00 },
-		{ 0x1101, 0xFE },
-		{ 0x1102, 0x8C },
-		{ 0x1101, 0xFF },
+		{ CS42L42_DAC_CTL2, 0x02 },
+		{ CS42L42_HS_CLAMP_DISABLE, 0x00 },
+		{ CS42L42_MIXER_CHA_VOL, 0x3F },
+		{ CS42L42_MIXER_ADC_VOL, 0x3F },
+		{ CS42L42_MIXER_CHB_VOL, 0x3F },
+		{ CS42L42_HP_CTL, 0x0F },
+		{ CS42L42_ASP_RX_DAI0_EN, 0x00 },
+		{ CS42L42_ASP_CLK_CFG, 0x00 },
+		{ CS42L42_PWR_CTL1, 0xFE },
+		{ CS42L42_PWR_CTL2, 0x8C },
+		{ CS42L42_PWR_CTL1, 0xFF },
 	};
 
 	cs8409_i2c_bulk_write(cs42l42, cs42l42_pwr_down_seq, ARRAY_SIZE(cs42l42_pwr_down_seq));
 
 	if (read_poll_timeout(cs8409_i2c_read, reg_cdc_status,
 			(reg_cdc_status & 0x1), CS42L42_PDN_SLEEP_US, CS42L42_PDN_TIMEOUT_US,
-			true, cs42l42, 0x1308) < 0)
+			true, cs42l42, CS42L42_CODEC_STATUS) < 0)
 		codec_warn(codec, "Timeout waiting for PDN_DONE for CS42L42\n");
 
 	/* Power down CS42L42 ASP/EQ/MIX/HP */
-	cs8409_i2c_write(cs42l42, 0x1102, 0x9C);
+	cs8409_i2c_write(cs42l42, CS42L42_PWR_CTL2, 0x9C);
 	cs42l42->suspended = 1;
 	cs42l42->last_page = 0;
 	cs42l42->hp_jack_in = 0;
diff --git a/sound/pci/hda/patch_cs8409.h b/sound/pci/hda/patch_cs8409.h
index 7df46bd8d2da..988259f8a940 100644
--- a/sound/pci/hda/patch_cs8409.h
+++ b/sound/pci/hda/patch_cs8409.h
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <sound/tlv.h>
 #include <linux/workqueue.h>
+#include <sound/cs42l42.h>
 #include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -222,15 +223,8 @@ enum cs8409_coefficient_index_registers {
 #define CS42L42_HP_VOL_REAL_MAX			(0)
 #define CS42L42_AMIC_VOL_REAL_MIN		(-97)
 #define CS42L42_AMIC_VOL_REAL_MAX		(12)
-#define CS42L42_REG_HS_VOL_CHA			(0x2301)
-#define CS42L42_REG_HS_VOL_CHB			(0x2303)
-#define CS42L42_REG_HS_VOL_MASK			(0x003F)
-#define CS42L42_REG_AMIC_VOL			(0x1D03)
 #define CS42L42_REG_AMIC_VOL_MASK		(0x00FF)
-#define CS42L42_HSDET_AUTO_DONE			(0x02)
 #define CS42L42_HSTYPE_MASK			(0x03)
-#define CS42L42_JACK_INSERTED			(0x0C)
-#define CS42L42_JACK_REMOVED			(0x00)
 #define CS42L42_I2C_TIMEOUT_US			(20000)
 #define CS42L42_I2C_SLEEP_US			(2000)
 #define CS42L42_PDN_TIMEOUT_US			(250000)
-- 
2.25.1

