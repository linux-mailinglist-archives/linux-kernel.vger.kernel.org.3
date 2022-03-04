Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538494CD732
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiCDPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiCDPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:08:31 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6C49902;
        Fri,  4 Mar 2022 07:07:42 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2248TInG019088;
        Fri, 4 Mar 2022 09:07:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=BSRIu4u7LP/BX+4EuzrjD7JUJiD1RuxHbQLO9l1wmac=;
 b=i9YFzX8RGJ4kTnXqRou/y/cmc4GGzeG2azMBLdR2bJlki298UO/sm+THRqg/c2HgUO3d
 2jvwLtaJkTofrgAH/DWc8K2kNXj7kGKygtKIZ+05zokKOp5zLZXZBW1aa9Dp4Mc1NRpE
 KzQTb62J8HenhSi6viEcg2r2pAz/uI9TQKGczsRdc+hgKt1V2kH945oQLEfcYKr88hSt
 fPCdoqcWQUXqZHtTfGf13YdXciXZx1gKEKZ9SZxoTpCLeLWnVL2vOFLMafmCwX4smMM/
 6FMOHr8Z/yWNcGziDlyBmgT9DRt3AGVPI/Ycm2M8vQJOvJczVPM7UpuxTniJRkG1+Ehl ug== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h413-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:31 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:26 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:26 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6C9B1B06;
        Fri,  4 Mar 2022 15:07:26 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 08/20] hda: cs35l41: Fix I2S params comments
Date:   Fri, 4 Mar 2022 15:07:09 +0000
Message-ID: <20220304150721.3802-9-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qW6odbWBP1rVUrqSs5m2Le3Ly0QmtBER
X-Proofpoint-ORIG-GUID: qW6odbWBP1rVUrqSs5m2Le3Ly0QmtBER
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix clock and slot size comments

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 81cdbd84cf7d..fe6f6a208d29 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -17,11 +17,11 @@
 #include "cs35l41_hda.h"
 
 static const struct reg_sequence cs35l41_hda_config[] = {
-	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3200000Hz, BCLK Input, PLL_REFCLK_EN = 1
+	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
 	{ CS35L41_GLOBAL_CLK_CTRL,	0x00000003 }, // GLOBAL_FS = 48 kHz
 	{ CS35L41_SP_ENABLES,		0x00010000 }, // ASP_RX1_EN = 1
 	{ CS35L41_SP_RATE_CTRL,		0x00000021 }, // ASP_BCLK_FREQ = 3.072 MHz
-	{ CS35L41_SP_FORMAT,		0x20200200 }, // 24 bits, I2S, BCLK Slave, FSYNC Slave
+	{ CS35L41_SP_FORMAT,		0x20200200 }, // 32 bits RX/TX slots, I2S, clk consumer
 	{ CS35L41_DAC_PCM1_SRC,		0x00000008 }, // DACPCM1_SRC = ASPRX1
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x00000000 }, // AMP_VOL_PCM  0.0 dB
 	{ CS35L41_AMP_GAIN_CTRL,	0x00000084 }, // AMP_GAIN_PCM 4.5 dB
-- 
2.35.1

