Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FF05AB860
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiIBSgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIBSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:36:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7FED31DC;
        Fri,  2 Sep 2022 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143772; x=1693679772;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=u/e/eIbdBJutq5AbGgNzaebhsZM9EByb+sMUL/rPFWU=;
  b=jPo2tPZ2zbUGRaSjfTTSpypfnhcZm0/hT/eD5EbeRjEdRM42ma2tuhlV
   hI2vFE1ZLiQiqAgXy/zc09rFSr//441PnC9QadN1TqZIhlcsLFPQIOuFR
   16S0zhFRzXp93ENRPJxVDIn6DuOU8EL36ewds6AVTGCM1A/4yuX6yQPf9
   h254oq4FNDkrGNaO2Y8onSrtqamwdy3Fhb88SnCK/kAwdhNTRHcLunerf
   pDKxAur/ym33Yiqc2ws7ooRU8WuxL1GE85U3TAOIU6cJRavwwp7NgstzL
   g0MtsBRjnPYOYAnjFsFcMMl0LVZuY2MBNcSx0lSBIqUvwx4vTJCXluI3k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382351237"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382351237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674457530"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 18B3B2E7; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/17] pinctrl: cy8c95x0: Drop unneeded npins assignment
Date:   Fri,  2 Sep 2022 21:26:39 +0300
Message-Id: <20220902182650.83098-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The npins field is assigned twice. Remove the first occurrence.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index a05fbf818bf2..eac8b073e19f 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1187,7 +1187,6 @@ static int cy8c95x0_setup_pinctrl(struct cy8c95x0_pinctrl *chip)
 	pd->pctlops = &cy8c95x0_pinctrl_ops;
 	pd->confops = &cy8c95x0_pinconf_ops;
 	pd->pmxops = &cy8c95x0_pmxops;
-	pd->npins = chip->gpio_chip.ngpio;
 	pd->name = dev_name(chip->dev);
 	pd->pins = cy8c9560_pins;
 	pd->npins = chip->tpin;
-- 
2.35.1

