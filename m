Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45005AB848
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIBSe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIBSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BAC110D9B;
        Fri,  2 Sep 2022 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143209; x=1693679209;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=3LyWhMqj6glFDb6XAKpJQvL41W8JoiazUOgVOjSZZCE=;
  b=byilvA0UFwwQ8A3HxvtfdHIp7UhFKF6z048Ftww8b+crw3410JiJWJs8
   DAx5lqZvoyzja0MYFxyjlAsWvp1eaSygSyeR0gxZ3A6p1UTttrxY7RbuM
   g1DW/vhq6LAosHF3X1nDflDuqXiOG52qLxmy7uyjgtSdDRqMkk3/S14Os
   cYRXMgu3A2oNguuC5gtLvfe9PRoYjPKFxmrEBKeMMvjbG60toV9k0QaZd
   JuTO0XRR2r3gr64z8Kxj4HO3r5ioNZQvZ0J2KZVaDrJcq8kcQ8BA0guvb
   jJSldSg+WQVUOZfh8Lqo+LusGDe11/56qWTU3+O4kj4/zxOaD6jYGltnB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296832726"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296832726"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="615791659"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3DC2F6B7; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/17] pinctrl: cy8c95x0: Use 'default' in all switch-cases
Date:   Fri,  2 Sep 2022 21:26:44 +0300
Message-Id: <20220902182650.83098-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
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

Move the default values to the 'default' case in the switches.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 55bd48c9d020..6fe442b44cab 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -279,9 +279,9 @@ static bool cy8c95x0_readable_register(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case 0x24 ... 0x27:
 		return false;
+	default:
+		return true;
 	}
-
-	return true;
 }
 
 static bool cy8c95x0_writeable_register(struct device *dev, unsigned int reg)
@@ -293,9 +293,9 @@ static bool cy8c95x0_writeable_register(struct device *dev, unsigned int reg)
 		return false;
 	case 0x24 ... 0x27:
 		return false;
+	default:
+		return true;
 	}
-
-	return true;
 }
 
 static bool cy8c95x0_volatile_register(struct device *dev, unsigned int reg)
@@ -304,9 +304,9 @@ static bool cy8c95x0_volatile_register(struct device *dev, unsigned int reg)
 	case CY8C95X0_INPUT_(0) ... CY8C95X0_INPUT_(7):
 	case CY8C95X0_INTSTATUS_(0) ... CY8C95X0_INTSTATUS_(7):
 		return true;
+	default:
+		return false;
 	}
-
-	return false;
 }
 
 static bool cy8c95x0_precious_register(struct device *dev, unsigned int reg)
@@ -314,9 +314,9 @@ static bool cy8c95x0_precious_register(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CY8C95X0_INTSTATUS_(0) ... CY8C95X0_INTSTATUS_(7):
 		return true;
+	default:
+		return false;
 	}
-
-	return false;
 }
 
 static const struct reg_default cy8c95x0_reg_defaults[] = {
@@ -1244,6 +1244,8 @@ static int cy8c95x0_probe(struct i2c_client *client)
 	case 60:
 		strscpy(chip->name, cy8c95x0_id[2].name, I2C_NAME_SIZE);
 		break;
+	default:
+		return -ENODEV;
 	}
 
 	reg = devm_regulator_get(&client->dev, "vdd");
-- 
2.35.1

