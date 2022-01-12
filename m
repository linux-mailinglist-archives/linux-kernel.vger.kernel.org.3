Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5E48CD67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiALVFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:05:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:64760 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbiALVEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642021491; x=1673557491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkjECNbSTjX/KrfO+kBf5SXgsG44C9iiZ1r0ReJlwcM=;
  b=bQhJj5m5svsHrCWKlAUUisrfIWrqO5qcWOHkXPPDjrB1UNed3mbfvezk
   Q9DpfxvijbmM+8k/yqqMmbnogoG35Cl4fg89oh+l72KH2ex5KMC8tz+5o
   fNDFmRLgQ2OxfAB81mDbiKLvqL0jkuO2rFooPNKVBKIYVcTkE/3a9BkRD
   H1CIZFg52x9mg3ulhWUe6wegUw+uQxCz96Y5ofgqKhkc19oyZSQ8sLaWX
   t/Bii4iAHqoQaGposWMX9a5V9JZmmmDYcD/ZlKzAxJSQ9k5pDg8jqcTby
   gx/H3u88FiIqwm743JKHL7wmBNcEfWv7le5yy/YMvqXOi4/b2b3/fI8Wv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243807729"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243807729"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="613716665"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2022 13:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10984120; Wed, 12 Jan 2022 23:04:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1 1/1] pinctrl: Place correctly CONFIG_PINCTRL_STMFX in the Makefile
Date:   Wed, 12 Jan 2022 23:04:56 +0200
Message-Id: <20220112210456.29375-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep Makefile entries ordered in the same way as Kconfig ones.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 91665076e013..f64d29f614ec 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -42,9 +42,9 @@ obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
 obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
-obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STARFIVE)	+= pinctrl-starfive.o
+obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_THUNDERBAY) += pinctrl-thunderbay.o
-- 
2.34.1

