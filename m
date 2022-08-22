Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8978759C6E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiHVSqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiHVSow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:44:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122723BCA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661193790; x=1692729790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LXeq1g0rOoidK7Ljzxcs+75UbaovvOPztMME8H2Yn5I=;
  b=WwqPnJxTHsChpKc0oGU/xKpWXCLY/KrQ4wJqIGcRtTZbawtlCn2C6M5S
   NHfkTuB6GEb9w+h4JDKpnT9451A1RJRToG4tjOMH5hlyHJEquWqfsfBvP
   IBaZ48gxzuuKj/E6cEZcOnVwXys7RARYKhS7KFEJD9uyQOwWWRroEzMtq
   C2hEyD8TvLieQyHvjmyvjYUK+7e0bS2/Wzf831iJJfd1KKNzqpM+W2XNB
   PX0XDHMbE3RhWWnjYzJJQ9hoUYeLPP1wTi5wM/kF66wXRJbyvPZGxKzk9
   ZitPTVeHhQlubwd10uVPqS0VXGZ9nPniY6mgFIquktYrLER0jCa6Z5mHd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280464688"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280464688"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="669671087"
Received: from apascali-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home) ([10.252.42.21])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:06 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Chao Song <chao.song@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] ASoC: wcd-mbhc-v2: remove always-true condition
Date:   Mon, 22 Aug 2022 20:42:36 +0200
Message-Id: <20220822184239.169757-3-pierre-louis.bossart@linux.intel.com>
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

sound/soc/codecs/wcd-mbhc-v2.c:1192:26: style: Condition
'cross_conn<0' is always true [knownConditionTrueFalse]
   } else if (cross_conn < 0) /* Error */
                         ^
sound/soc/codecs/wcd-mbhc-v2.c:1188:15: note: Assuming that condition
'!cross_conn' is not redundant
   } else if (!cross_conn) { /* no cross connection */
              ^
sound/soc/codecs/wcd-mbhc-v2.c:1192:26: note: Condition 'cross_conn<0'
is always true
   } else if (cross_conn < 0) /* Error */
                         ^
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 98baef594bf31..b16a18dbfe7af 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -1189,7 +1189,7 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 				pt_gnd_mic_swap_cnt = 0;
 				plug_type = wcd_mbhc_get_plug_from_adc(mbhc, output_mv);
 				continue;
-			} else if (cross_conn < 0) /* Error */
+			} else /* Error if (cross_conn < 0) */
 				continue;
 
 			if (pt_gnd_mic_swap_cnt == GND_MIC_SWAP_THRESHOLD) {
-- 
2.34.1

