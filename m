Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAA4537A44
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiE3L7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiE3L7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:59:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B127CB1C;
        Mon, 30 May 2022 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653911947; x=1685447947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wWmFaPWb31K5+ZT15edTwCGO/BUYphqwWsJKHsVwuco=;
  b=QsSPQ9J6+6L3+h9qblpxOFzq1q7PI91KRVkqS6JUosfCChbBt+VPZ91F
   T8Lmyce8igre4Ku6tYK8iaIGCR5TCXcdGq+Jpi7psu+D+G5Tzqwz1yGea
   cWbrJ7oj628WnPkxF+g1mEiI+InRalqo8tDrPxC81lxHrUZYqmz+0J1dX
   mheXgqDlIl4NFOYcXsU4oDYYaxtHerXrWHaMZdR9C6YtjjcWdUeMmPbi3
   sFtHgi7SL6x1NPEKpLxZC7u5bCLRtlv0/xV9ZOpzp40x6QOrviuRVSShm
   /ie7p+ZEoYC33HyL1oCmU+gbLqTlgVmaM3pRK6ZBk+29ZFS7mDzZyXdlz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="274982187"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="274982187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 04:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="706132874"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 May 2022 04:59:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 689F01A7; Mon, 30 May 2022 14:59:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dave.hansen@linux.intel.com
Subject: [PATCH v1 1/1] MAINTAINERS: Update Intel GPIO (PMIC and PCH) to Supported
Date:   Mon, 30 May 2022 14:59:03 +0300
Message-Id: <20220530115903.70509-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual status of the code is Supported.

Reported-by: dave.hansen@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 629ddf493555..bacb41953679 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9810,7 +9810,7 @@ F:	drivers/video/fbdev/intelfb/
 INTEL GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
 L:	linux-gpio@vger.kernel.org
-S:	Maintained
+S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
 F:	drivers/gpio/gpio-ich.c
 F:	drivers/gpio/gpio-merrifield.c
@@ -10022,7 +10022,7 @@ F:	drivers/platform/x86/intel/pmc/
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
-S:	Maintained
+S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
 F:	drivers/gpio/gpio-*cove.c
 
-- 
2.35.1

