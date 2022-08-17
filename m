Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E171596F62
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiHQNLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiHQNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:11:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328ADF5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741874; x=1692277874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNvx66hWZqGva6cBOQUF79aywA0lLqhY5wC4GeSrizQ=;
  b=N6AWxz8lyVWf1/qYpZn9Xq0IZnHTVr/K1x80pdq7GArrXeWxH+ppPZd6
   Klx+SWF0q8wr/BOMt8WG0jt68gNimko4ynve6ZMd9OQkJnTTR6tRO9esd
   k+rqhL9ic69sxENnrx5FT8x7WqFnVrPIy0vvPs/mQ+fuyyyhz5YBVZPwM
   VjsxiQTYuYy7WKyIppenj6x8mjjQ5f3IVA7UNb/jbTYsj5P4GYWhIst2r
   WJPc2s5edeqJr6S3wBDgHH1n6ZZefek2KAEJD3tdotelXOU4jiTfBj/5I
   srKiK7BccifD41RJnR7jRBz6Vhj3BHEveCclZZndAmsX47r3cpAs9IKGL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378779143"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378779143"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="667609971"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 06:11:12 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 3/4] ALSA: hda: Remove unused MAX_PIN_CONFIGS constant
Date:   Wed, 17 Aug 2022 15:11:36 +0200
Message-Id: <20220817131137.3978523-4-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
References: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

