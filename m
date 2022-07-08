Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8051456B7ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiGHLDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiGHLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:03:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B370888F12
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657278188; x=1688814188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HttklPYMVqCkBKla4Z5JeQC9Wp5Ab2UuWXTG+/ppt9Q=;
  b=NeMel/fK/VdTkEQgiKHDrrU3PipHNDJcLokARx1YtT6NJD3OdYXBnR5H
   yTB3r4nQx1vehsRTu0Z5PkC7N8CeiPZaiK06nRBBc3Pr9Z+9zcNpIrxt7
   IALF5QibMp/xSCSu4pN4OrNbu7iNV2OMcoK124Z3N3S/xvpql5eJSQ0Du
   mHGXsAu5ohbYL/s6ccYPceA/LFx6V+7dfrEKcR4K3mrsSqeBv/WIhtoAc
   z0HIOUUzoS0jTbEJfL5rwsk3pYwqhxJfg9XlDnBinfOnDG0POR0UUdsVC
   pDEMDp+rlikgELb1voYsZFS8hxF2P67oGQ3QVDaj6l39MJViAF2KMsyWf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="267286813"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="267286813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 04:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="651526186"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2022 04:02:55 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        David Lin <CTLIN0@nuvoton.com>
Subject: [PATCH v8 2/2] ASoC: Intel: sof_cs42l42: add adl_mx98360a_cs4242 board config
Date:   Fri,  8 Jul 2022 19:00:30 +0800
Message-Id: <20220708110030.658468-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708110030.658468-1-brent.lu@intel.com>
References: <20220708110030.658468-1-brent.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds driver data for adl_mx98360a_cs4242 which supports
two max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec
on SSP0 running on ADL platform.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_cs42l42.c              | 11 +++++++++++
 sound/soc/intel/common/soc-acpi-intel-adl-match.c |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
index 3d53bb420c66..85ffd065895d 100644
--- a/sound/soc/intel/boards/sof_cs42l42.c
+++ b/sound/soc/intel/boards/sof_cs42l42.c
@@ -700,6 +700,17 @@ static const struct platform_device_id board_ids[] = {
 					SOF_CS42L42_SSP_AMP(1)) |
 					SOF_CS42L42_DAILINK(LINK_HP, LINK_DMIC, LINK_HDMI, LINK_SPK, LINK_NONE),
 	},
+	{
+		.name = "adl_mx98360a_cs4242",
+		.driver_data = (kernel_ulong_t)(SOF_CS42L42_SSP_CODEC(0) |
+				SOF_SPEAKER_AMP_PRESENT |
+				SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+				SOF_CS42L42_SSP_AMP(1) |
+				SOF_CS42L42_NUM_HDMIDEV(4) |
+				SOF_BT_OFFLOAD_PRESENT |
+				SOF_CS42L42_SSP_BT(2) |
+				SOF_CS42L42_DAILINK(LINK_HP, LINK_DMIC, LINK_HDMI, LINK_SPK, LINK_BT)),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index c1385161cdc8..fea087d3fa15 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -479,6 +479,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.drv_name = "adl_rt5682",
 		.sof_tplg_filename = "sof-adl-rt5682.tplg",
 	},
+	{
+		.id = "10134242",
+		.drv_name = "adl_mx98360a_cs4242",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98360a_amp,
+		.sof_tplg_filename = "sof-adl-max98360a-cs42l42.tplg",
+	},
 	/* place amp-only boards in the end of table */
 	{
 		.id = "CSC3541",
-- 
2.25.1

