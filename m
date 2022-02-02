Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD64A79C7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347250AbiBBUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:53:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:53758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbiBBUxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643835203; x=1675371203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DFQ4plrckwcPbqKarF0oD4WWk3MZHNwx+lzqaeuH6XA=;
  b=N9awgWeq0g/SOGDG49OHUzic9XFVpo/ZpE1ImsqVYAJbgpacNy16+ah+
   GzUkx9houyZ9dr2D9qy87tYHz27lY9eek7nMfGIzLeVera5N0pdz31Ysl
   q9nhQhFuE1AYsDA1ambE/w3mb5Wf/YNXOfsKdjaP6botebI0pjt8LJ8pt
   Xz6vP791rjRYL1amSKhhJPYF17U/WNA9gw79sZvtzVSBdMFQm0GeznJVr
   TZMiuWHSrmAwF5SLbGBd293gEWnfxwz3GP7wtFHx9LN+OxB/IMhUeoHBX
   JENB3Osr/faIb9y68WPx9eVVGQ75QhW8GC1lpwvaEhr2qGwd4HY6KXjSh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="308746542"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="308746542"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:53:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="566156587"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2022 12:53:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84C6B3B7; Wed,  2 Feb 2022 22:53:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: temperature: maxim_thermocouple: Switch from of headers to mod_devicetable.h
Date:   Wed,  2 Feb 2022 22:53:28 +0200
Message-Id: <20220202205328.57837-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 0297e215b61a..98c41cddc6f0 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -6,12 +6,11 @@
  * Author: <matt.ranostay@konsulko.com>
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.34.1

