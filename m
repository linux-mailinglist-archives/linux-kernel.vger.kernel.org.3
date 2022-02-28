Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAC4C7D96
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiB1WkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiB1WkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265291255B5;
        Mon, 28 Feb 2022 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087969; x=1677623969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hNJS2dybVBvsAe13swYPd/L/NI9k6ucKP/1EvDuTvmM=;
  b=C9fqA8UXkrmZn61x/wJBDAg1TpcEx3Q7YAOllSqrXnBJnDhHHoSwOw1k
   QHQbkx/Q3ZKgwc32p5uixReQ3zY0xRY6mUXdw+4oy7OUUvcLxNmExNZmW
   QXWtyO3yvgd4xOE7lGv3wNsNj56eRfshBMj1Oki+2lVn0MIRLFWHhS1sw
   c5XrhcVn5UKftZ/MSIxsojey6+1z4f6s1Pg6iBZ40RtY8Vlup2QdmBZYd
   fgWUc8/Y0DY7jpt2v57KuoZUVfqJ/KBHwDUBlPfoP4HXjanCX5YWvZuTP
   dRQlxB2w+vlkgIX2rYwvm3Kp3AFDbvISQle8Ayqbw3dhFDFpE1qLFRVgY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252736711"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252736711"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="641046919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Feb 2022 14:39:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4584124D; Tue,  1 Mar 2022 00:39:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 7/7] ACPI: enumeration: Drop comma for terminator entry
Date:   Tue,  1 Mar 2022 00:39:36 +0200
Message-Id: <20220228223936.54310-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop comma for terminator entry to avoid copy'n'paste of this pattern.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 2e0cffb88d67..8c9e758f6e9b 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -211,7 +211,7 @@ to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 
 	static const struct acpi_device_id at25_acpi_match[] = {
 		{ "AT25", 0 },
-		{ },
+		{ }
 	};
 	MODULE_DEVICE_TABLE(acpi, at25_acpi_match);
 
@@ -268,7 +268,7 @@ input driver::
 
 	static const struct acpi_device_id mpu3050_acpi_match[] = {
 		{ "MPU3050", 0 },
-		{ },
+		{ }
 	};
 	MODULE_DEVICE_TABLE(acpi, mpu3050_acpi_match);
 
-- 
2.34.1

