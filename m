Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9865D598589
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbiHROPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiHROPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:15:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DBBB8F18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660832091; x=1692368091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Jw2sCqhFjrjd0ogBdcPM4xUu9vU/3VB2S/clQ7Sul0=;
  b=gGREzXc5NOgkTXttR/HudL+CFZ/TipwmspAs+4SnZyBGRCKW76If/F1R
   Cm2d8F0qiq/zN/v4IqukmVn32uO79UaXP5bsM9SKuFCeMF51ai57j7Oji
   CyjTckh3+/whSxpTZ1KEcbORrxDW59oUqRRIVHys5SHFDdhdqXPmEtP5j
   IVOcJfg886NMQYsxOl7QHMMiXcNr9hDfe7YZknXzq3qSyWfCmp0ElYUMr
   ofndegs2pan+ec9MnBLnP/KOA3A0bCinIK9fzNxuybiGdK5ZIizkBtAv5
   LCt1BSp1yTmH/IoaRPjTkMys3XDH6sn+JX6sIeVompstqvUr1NypFUvmG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272533281"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="272533281"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 07:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584222264"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 07:14:49 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 4/4] ALSA: hda: Remove unused defines
Date:   Thu, 18 Aug 2022 16:15:17 +0200
Message-Id: <20220818141517.109280-5-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to keep unused defines in file.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a77165bd92a9..7720978dc132 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -86,9 +86,6 @@ enum {
 #define INTEL_SCH_HDA_DEVC      0x78
 #define INTEL_SCH_HDA_DEVC_NOSNOOP       (0x1<<11)
 
-/* Define VIA HD Audio Device ID*/
-#define VIA_HDAC_DEVICE_ID		0x3288
-
 /* max number of SDs */
 /* ICH, ATI and VIA have 4 playback and 4 capture */
 #define ICH6_NUM_CAPTURE	4
@@ -102,10 +99,6 @@ enum {
 #define ATIHDMI_NUM_CAPTURE	0
 #define ATIHDMI_NUM_PLAYBACK	8
 
-/* TERA has 4 playback and 3 capture */
-#define TERA_NUM_CAPTURE	3
-#define TERA_NUM_PLAYBACK	4
-
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
-- 
2.25.1

