Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E173046F165
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238752AbhLIRRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:17:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:42716 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhLIRRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:17:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225425806"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="225425806"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:11:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="606969396"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2021 09:11:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F2FE329; Thu,  9 Dec 2021 19:11:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] pinctrl: Fix English grammar in help text for AMD
Date:   Thu,  9 Dec 2021 19:11:38 +0200
Message-Id: <20211209171138.76803-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix English grammar in help text for AMD.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 36066d7e1db3..c27c9ee89f0e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -41,9 +41,9 @@ config PINCTRL_AMD
 	select PINCONF
 	select GENERIC_PINCONF
 	help
-	  driver for memory mapped GPIO functionality on AMD platforms
-	  (x86 or arm).Most pins are usually muxed to some other
-	  functionality by firmware,so only a small amount is available
+	  The driver for memory mapped GPIO functionality on AMD platforms
+	  (x86 or arm). Most of the pins are usually muxed to some other
+	  functionality by firmware, so only a small amount is available
 	  for GPIO use.
 
 	  Requires ACPI/FDT device enumeration code to set up a platform
-- 
2.33.0

