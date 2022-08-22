Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2535C59C6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiHVSrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiHVSoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:44:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E822B3885;
        Mon, 22 Aug 2022 11:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661193803; x=1692729803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysLY52QIaymnVb5gk/TwZwHIvVe0JIPygRIZPu439/o=;
  b=Gly/p7hJDDv3as0HTekGjSHoJVbVrcZwJ9GSbSDtmzxrESoDTQv5NLfE
   vmAfj2j4BHkm53YbJfUaxmI0f1Ov3Df943pxiIP8Nh3Iv8UcY5BUY23IU
   ZkikiE1PINqi8XO1lkwAqmfG/vbAd98joKHXnpgifTvtnu7al0PFmMng2
   M2bzJamnP9+kntwCnn/M/p5/D+8CZfZggadOea2JhPZwc4yB/T7Rya3HR
   aoWZatAoyxOW17c8TqMm9ddS1AfMgWv0xD5uk9fQ8uhOQlJD/w5ZWsjpr
   kKmIPx4cq0ftNySBolgrqNkNMemKgklWrGRMZvhkZZQWnvCTwUHrwYVx6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280464728"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="280464728"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="669671123"
Received: from apascali-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home) ([10.252.42.21])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 11:43:19 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Chao Song <chao.song@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-omap@vger.kernel.org (open list:OMAP AUDIO SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] ASoC: ti: omap-mcbsp: remove useless assignment
Date:   Mon, 22 Aug 2022 20:42:39 +0200
Message-Id: <20220822184239.169757-6-pierre-louis.bossart@linux.intel.com>
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

sound/soc/ti/omap-mcbsp.c:617:10: style: Variable 'ret' is assigned a
value that is never used. [unreadVariable]
 int ret = 0;
         ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
---
 sound/soc/ti/omap-mcbsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 0b377bb7737fd..7c539a41a6a34 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -614,7 +614,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 {
 	struct omap_mcbsp *mcbsp = platform_get_drvdata(pdev);
 	struct resource *res;
-	int ret = 0;
+	int ret;
 
 	spin_lock_init(&mcbsp->lock);
 	mcbsp->free = true;
-- 
2.34.1

