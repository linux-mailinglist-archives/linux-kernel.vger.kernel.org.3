Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C184B537A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiE3L5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiE3L5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:57:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B577F34;
        Mon, 30 May 2022 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653911821; x=1685447821;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vfqP9FfgJ50SV0QZXWfivY89H9PbTNv9IlpuWiUguhw=;
  b=DnlBVpeas9Mlx+zQPHYDSYLHiNx2CDFwpMCv5fmy6y3wNpufZszivze+
   um3FFL9tgVB+oVhLRcDm/miJFh/0aPvkEisoFrTPxo+Hf7tPkjvUK3wMA
   W3IfoDjb2d96d9FJaPTjbmjob8AU/GchqGTvJ5/BMKdFwATqWjdkePk02
   pzVd3/EWVwZL99MHVNe7Rd6QNWUDB3Ivhz7r3BsEbVyTl2iMPlb3G6Wza
   K0iiqLE3Lum8OxtruhNAbBj0C2zr2pgFybpk85IPDotNp7aCOGtRHzK1/
   FPThRmBADw5zQyP8fVnyMXNaBTvgb35vIhxHlvBPVa6Xi1t1XBx8hL6QL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="257043662"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="257043662"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 04:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="666491858"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2022 04:56:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C27291A7; Mon, 30 May 2022 14:57:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dave.hansen@linux.intel.com
Subject: [PATCH v1 1/1] MAINTAINERS: Update GPIO ACPI library to Supported
Date:   Mon, 30 May 2022 14:56:53 +0300
Message-Id: <20220530115653.70423-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual status of the code is Supported.

Reported-by: dave.hansen@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..629ddf493555 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8343,7 +8343,7 @@ M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
 L:	linux-acpi@vger.kernel.org
-S:	Maintained
+S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
 F:	Documentation/firmware-guide/acpi/gpio-properties.rst
 F:	drivers/gpio/gpiolib-acpi.c
-- 
2.35.1

