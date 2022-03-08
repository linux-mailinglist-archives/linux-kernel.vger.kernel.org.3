Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AB4D1B65
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbiCHPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiCHPNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:13:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B16338D9D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646752343; x=1678288343;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZiFeukyTAIqoiR8U5EKVaCERc87+rnVtlgGCTocjP3Q=;
  b=XQDCwPEz7PVAd5d5ifja3wyeAYO+VvErI05VQLAaCeCmoXgGNdqYpF2f
   uhbe6QU7lLRg6NEPsK+leRPoNin2GW4KStuXB4Uh68DcZdr8VbhrD62KJ
   SJYBzhbGWm/Uq+UrjuJQFEnXeFxoJD6aC746j5328NpNLbOh0Cu1r289w
   qO0b9pZ+/S/j/jo26XNOjo6gbnOs6YbnEr7/hYy5ip5YvZFNYR1CTSed/
   aZSF9c8lS59hKOW/umNr8G6ZPscx/8s7JPMVLokMscOJLjBFtzJ+Y27V+
   OXCTnnfxCRMOhCdb2ql//ZOQdpeBJey0f5Y4iuScXtiiuECOdiuJPAx+I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254895598"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254895598"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="495479425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 07:12:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7BAC22AF; Tue,  8 Mar 2022 17:12:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] auxdisplay: lcd2s: Fix multi-line comment style
Date:   Tue,  8 Mar 2022 17:12:33 +0200
Message-Id: <20220308151233.48475-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multi-line comment style:
 - start sentences with Capital letter
 - use non-networking style of the first line

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 97c4bbf98cf9..5e778f279a70 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  console driver for LCD2S 4x20 character displays connected through i2c.
- *  The display also has a spi interface, but the driver does not support
+ *  Console driver for LCD2S 4x20 character displays connected through i2c.
+ *  The display also has a SPI interface, but the driver does not support
  *  this yet.
  *
- *  This is a driver allowing you to use a LCD2S 4x20 from modtronix
+ *  This is a driver allowing you to use a LCD2S 4x20 from Modtronix
  *  engineering as auxdisplay character device.
  *
  *  (C) 2019 by Lemonage Software GmbH
@@ -219,16 +219,15 @@ static int lcd2s_lines(struct charlcd *lcd, enum charlcd_lines lines)
 	return 0;
 }
 
+/*
+ * Generator: LGcxxxxx...xx; must have <c> between '0' and '7',
+ * representing the numerical ASCII code of the redefined character,
+ * and <xx...xx> a sequence of 16 hex digits representing 8 bytes
+ * for each character. Most LCDs will only use 5 lower bits of
+ * the 7 first bytes.
+ */
 static int lcd2s_redefine_char(struct charlcd *lcd, char *esc)
 {
-	/* Generator : LGcxxxxx...xx; must have <c> between '0'
-	 * and '7', representing the numerical ASCII code of the
-	 * redefined character, and <xx...xx> a sequence of 16
-	 * hex digits representing 8 bytes for each character.
-	 * Most LCDs will only use 5 lower bits of the 7 first
-	 * bytes.
-	 */
-
 	struct lcd2s_data *lcd2s = lcd->drvdata;
 	u8 buf[LCD2S_CHARACTER_SIZE + 2] = { LCD2S_CMD_DEF_CUSTOM_CHAR };
 	u8 value;
-- 
2.34.1

