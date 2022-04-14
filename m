Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92589501B85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbiDNTFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345051AbiDNTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:05:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC8EA346;
        Thu, 14 Apr 2022 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649962971; x=1681498971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgXmB1hmlgyBRyTbiaI44zoA0d0R4GjmhsIVDP1LpQo=;
  b=JpGPTotcyL8yfzrROC3JDJYBZAoBArJYhFmDMmTaVMQPTD9dr49c60qs
   s6EuR3ijqSxpgQQx2jAm1ZdM7z102hgk75aohnn8EgBK9T7dbfffNSjQy
   KRVEdnTFsU/TsIyJoNP8U8uzv/CO1CYlKjiN4FweB6vvr8xk2HEI+6INV
   XM3XlWwjtiQDcfhIgNdbOfrTDzrvevx6cShWtCzHvRu5d6ocgkh7DnMU2
   F0dSr4CV6o0GCzQhrch61294OVXOTwz0lAZjXtt0O2dauToDN0CpMABn+
   c93+8Kc2+Y/BrFwbjCkY8Nv2MuMeFBzQRgBNQ2vJg5noNoiFRyPbRKCzF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250308397"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="250308397"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 12:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="573947631"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2022 12:02:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F6ED2B0; Thu, 14 Apr 2022 22:02:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 5/6] pinctrl: meson: Enable COMPILE_TEST
Date:   Thu, 14 Apr 2022 22:02:41 +0300
Message-Id: <20220414190242.22178-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
References: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable COMPILE_TEST for a better test coverage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index d1955c65b4b6..64fb9e074ac6 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig PINCTRL_MESON
 	tristate "Amlogic SoC pinctrl drivers"
-	depends on ARCH_MESON
+	depends on ARCH_MESON || COMPILE_TEST
 	depends on OF
 	default y
 	select PINMUX
-- 
2.35.1

