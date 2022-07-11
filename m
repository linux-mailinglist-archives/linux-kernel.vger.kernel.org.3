Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E154256FF91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGKK4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGKK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:56:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FB1FE516
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657533687; x=1689069687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1oSD9MqauB/qwzh9VWhLPcyk4oTHCUen8yzMNm9SlPE=;
  b=PpcQZLRl6VhSryOzpUaUNwfqU4Um3/3GkO+l9sBqW7ubPFCfuw2cdKTG
   yLizUWFsC1sVtngMbkOmKx5fVqU6ViNbOvUNmO7Gulov3SGBmrb7vRM4C
   HAimoNmE54IN9GTjo5oDB3NL+J/yPNVOqaXpyA5pnlKBOXwf7ORtsezi3
   fK+dXePRL8OPB7vp9Ycts/ulSK9liO2zlMxA28qzeGloKmdIpKlMpsSlQ
   KC5qEQdyoo52JwuDeVUhEEZk9M7l3+OtC+ehYkMBKPdIhh9fYnAJv31sy
   1vC6Lu0ltYYfXPJxPfwa01evW2uXOP/UFHcEmvm7u4C4ENh7+fYQwdTcC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370931585"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="370931585"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 03:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="840955816"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2022 03:01:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DD1561A0; Mon, 11 Jul 2022 13:01:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ALSA: hda: cs35l41: Fix comments wrt serial-multi-instantiate reference
Date:   Mon, 11 Jul 2022 13:01:29 +0300
Message-Id: <20220711100129.37326-1-andriy.shevchenko@linux.intel.com>
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

The comments are inconsistent and point to the wrong driver name.
The initially named i2c-multi-instantiate it was renamed to the
serial-multi-instantiate exactly due to support of the platforms
with multiple CS35L41 codecs.

Fix comments accordingly.

While at it, drop file names from the files.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/cs35l41_hda.c     | 4 ++--
 sound/pci/hda/cs35l41_hda_i2c.c | 7 ++++---
 sound/pci/hda/cs35l41_hda_spi.c | 7 ++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 23a97ada7272..49b25432a9f5 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -415,8 +415,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 no_acpi_dsd:
 	/*
 	 * Device CLSA0100 doesn't have _DSD so a gpiod_get by the label reset won't work.
-	 * And devices created by i2c-multi-instantiate don't have their device struct pointing to
-	 * the correct fwnode, so acpi_dev must be used here.
+	 * And devices created by serial-multi-instantiate don't have their device struct
+	 * pointing to the correct fwnode, so acpi_dev must be used here.
 	 * And devm functions expect that the device requesting the resource has the correct
 	 * fwnode.
 	 */
diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index 5cfb5aac37ac..df39fc76e6be 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// cs35l41.c -- CS35l41 HDA I2C driver
+// CS35l41 HDA I2C driver
 //
 // Copyright 2021 Cirrus Logic, Inc.
 //
@@ -16,8 +16,9 @@ static int cs35l41_hda_i2c_probe(struct i2c_client *clt, const struct i2c_device
 {
 	const char *device_name;
 
-	/* Compare against the device name so it works for I2C, normal ACPI
-	 * and for ACPI by i2c-multi-instantiate matching cases
+	/*
+	 * Compare against the device name so it works for SPI, normal ACPI
+	 * and for ACPI by serial-multi-instantiate matching cases.
 	 */
 	if (strstr(dev_name(&clt->dev), "CLSA0100"))
 		device_name = "CLSA0100";
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index c9a61675c4fd..2f5afad3719e 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// cs35l41.c -- CS35l41 HDA SPI driver
+// CS35l41 HDA SPI driver
 //
 // Copyright 2021 Cirrus Logic, Inc.
 //
@@ -16,8 +16,9 @@ static int cs35l41_hda_spi_probe(struct spi_device *spi)
 {
 	const char *device_name;
 
-	/* Compare against the device name so it works for SPI, normal ACPI
-	 * and for ACPI by spi-multi-instantiate matching cases
+	/*
+	 * Compare against the device name so it works for SPI, normal ACPI
+	 * and for ACPI by serial-multi-instantiate matching cases.
 	 */
 	if (strstr(dev_name(&spi->dev), "CSC3551"))
 		device_name = "CSC3551";
-- 
2.35.1

