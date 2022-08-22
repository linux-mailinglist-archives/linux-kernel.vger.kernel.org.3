Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177859C6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiHVSql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiHVSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:44:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9219C18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661193786; x=1692729786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vFptHFTQvMLLc8fNOk6m0lzbZBBJ5nP10P1cIx99YyU=;
  b=RPKn6WiigOyrtaCKfvtUgAPyfsfjzBJ+hCwU82YXnTW+/WYuB8sccUxC
   ra+pC74++RVfTn1L7oHy9v71TdttDlsMcaK+gIOTAIAGqwwd+xJrNYO3f
   ogBR/S+Kw4541tFZ9xUTEokE83kXPtynaKw2vSCTcKT/AGe7qUAIR2flx
   m2EWgqtz4aM3VZ6AmRdnvpQLp/YRnGPmj39EWrc09+hMbqE1z7CP/L0Ew
   dR5S6Oswkr1mlVUwJqx4iEdta4cCTrLWjHsZ88QbDgxQDRiUzxMooO+Nq
   eYd0GpyajWXSe4GP4HJKdn8xtDNmk08/4IIjQZP5yePw+5T5LM8TXFtya
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280464678"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280464678"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="669671063"
Received: from apascali-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home) ([10.252.42.21])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:02 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Chao Song <chao.song@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] ASoC: hdmi-codec: remove unused definitions
Date:   Mon, 22 Aug 2022 20:42:35 +0200
Message-Id: <20220822184239.169757-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822184239.169757-1-pierre-louis.bossart@linux.intel.com>
References: <20220822184239.169757-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck warning:

sound/soc/codecs/hdmi-codec.c:24:16: style: struct member
'hdmi_codec_channel_ma`p_table::map' is never used. [unusedStructMember]
 unsigned char map; /* ALSA API channel map position */
               ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
---
 sound/soc/codecs/hdmi-codec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 5679102de91f8..863e679d2ac11 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -20,10 +20,6 @@
 
 #define HDMI_CODEC_CHMAP_IDX_UNKNOWN  -1
 
-struct hdmi_codec_channel_map_table {
-	unsigned char map;	/* ALSA API channel map position */
-};
-
 /*
  * CEA speaker placement for HDMI 1.4:
  *
-- 
2.34.1

