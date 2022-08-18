Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F42759857B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiHROPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343489AbiHROOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:14:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB85CA1A6D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660832089; x=1692368089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EW0ARkTrK0sgs3zaXFUnHfDqPW/DNwNAumfLEbrEiZ4=;
  b=NezjoTIYzLP0wkTgCw+bpfJp7FzTp8vS3lFzDomzZaJe5/Ywyz1zqIRG
   zIRsvpcJSuLdn6AjT4SyOpuveheevMdms6IFqC3aJXhUv2n1i4GKNpaDZ
   i1MQiKf8ckX37H6Uz6p5/hH/A0YIXhkVw4txuXNZ9UFSpKF1IxFoovPIy
   PZ/k1fDpWSr1M1nGA3anTT4BbTMJq/59oFBgmr/BwmivTY17FmljbHsRC
   HEGpWJC61aRzZXxFOMKUg+MLoRkVGxcL1TQYXSWsFZPCMS8uqAvk42otS
   AnNMV1p6rWLElcXBUN0trEucD9AxATrweB5DjKSz12XnI1zJXxjKCWeWL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272533272"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="272533272"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 07:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584222252"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 07:14:47 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 3/4] ALSA: hda: Remove unused MAX_PIN_CONFIGS constant
Date:   Thu, 18 Aug 2022 16:15:16 +0200
Message-Id: <20220818141517.109280-4-amadeuszx.slawinski@linux.intel.com>
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

Since it was introduced around v2.6.30 it was never used. Also HDA
specification does not mention any limitation on number of PIN
configurations.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/pci/hda/hda_sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index bf951c10ae61..69ebc37a4d6f 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -375,8 +375,6 @@ static ssize_t user_pin_configs_show(struct device *dev,
 	return pin_configs_show(codec, &codec->user_pins, buf);
 }
 
-#define MAX_PIN_CONFIGS		32
-
 static int parse_user_pin_configs(struct hda_codec *codec, const char *buf)
 {
 	int nid, cfg, err;
-- 
2.25.1

