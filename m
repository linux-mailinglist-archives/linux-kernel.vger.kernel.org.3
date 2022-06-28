Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7182355EE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiF1Tpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiF1Tp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:45:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D6393C8;
        Tue, 28 Jun 2022 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656445144; x=1687981144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+1EpxwGS9Cq1c0vv29dIM1+KCfkLYVP7Y5EIdg4E8Uo=;
  b=IEnBJc3qECYCzWlsJcpWZeWYFy1ceTP2KFtw2BD1cRaP4GFzds+UC0Li
   Ik7ubh9R7cGyNhG8htLKLbfrVzP6Ny+pSmwYIP/Ps9ANkKGmRAq6YBC65
   9+Nm4WB0xj8NwYir1XGju51iw894T2kzQLaDp///WSsYNc2TYe9Mtqibr
   Ail/zA3QrEsyrUA+PGsS80rsE/ea2XKUz0m7l3HVrqVPMjbzZ35UvLr3F
   waQ/spYWG2kPyq7TimCQ0ZdrtjlWDo5i+mDZmnsx0SQTOQsOZSsdTk6a2
   +Ko0Cad7QXfu8AutYU+xmrlkW29iOASgLwHiyNZTBYm5OVoWPGj5DXDiF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="368145176"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="368145176"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="767286192"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2022 12:39:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4BF8314F; Tue, 28 Jun 2022 22:39:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/3] gpio: adp5588: sort header inclusion alphabetically
Date:   Tue, 28 Jun 2022 22:39:05 +0300
Message-Id: <20220628193906.36350-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
References: <20220628193906.36350-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort header inclusion alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-adp5588.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index d6a229a67044..d49f12560cde 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -6,15 +6,15 @@
  * Copyright 2009-2010 Analog Devices Inc.
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
 #include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #include <linux/platform_data/adp5588.h>
 
-- 
2.35.1

