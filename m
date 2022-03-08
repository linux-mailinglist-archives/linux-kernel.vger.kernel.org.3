Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3D34D19F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiCHOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiCHOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:06:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649CF49F87;
        Tue,  8 Mar 2022 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646748351; x=1678284351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BW0pan9iM+VaZ50WsGuo6fggdgTImD3g+H0n+3pO1Jo=;
  b=T5djVU8NPSFJe/5koHSwC317JMEaVvlTmPNWfMVb3eB19lViUW8enqrj
   ikfXyRi0I8aN5JY/XXXrQz9IRzPeDP2XqfDnZuqNngQ5Jz+hqQkDJ+Ifl
   +XqedHPSxFWck6L3oqv7zPDp9hJZiRNUS4Lja8NNcPSjgIKaaqgpgt78m
   bJJoFW1fUyNLUlHnw9p9RcNZV/msECNX5oyZXzFoSfK+IuaD9PUgOLxXb
   d5QkhlfoMMYgsTxezeBFBtQOOt3O8PumQB/e5GRAdi344m6XZMEsAFFhS
   s1La0ZykBIDq/i2hXPJXz4PhzGh5DBqYqf5MrzAOuKDWboHA1OmuRHboI
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234642024"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="234642024"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 06:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="632237909"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2022 06:05:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1EE536A; Tue,  8 Mar 2022 16:06:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: docs: gpio-properties: Unify ASL style for GPIO examples
Date:   Tue,  8 Mar 2022 16:05:59 +0200
Message-Id: <20220308140559.46932-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO examples of ASL in the board.rst, enumeration.rst and gpio-properties.rst
are not unified. Unify them for better reader experience.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/board.rst       | 21 +++++++--------
 .../firmware-guide/acpi/enumeration.rst       | 22 ++++------------
 .../firmware-guide/acpi/gpio-properties.rst   | 26 ++++++++++---------
 3 files changed, 28 insertions(+), 41 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index 191fa867826a..4e3adf31c8d1 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -71,14 +71,14 @@ with the help of _DSD (Device Specific Data), introduced in ACPI 5.1::
 
 	Device (FOO) {
 		Name (_CRS, ResourceTemplate () {
-			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
-				"\\_SB.GPI0") {15} // red
-			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
-				"\\_SB.GPI0") {16} // green
-			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
-				"\\_SB.GPI0") {17} // blue
-			GpioIo (Exclusive, ..., IoRestrictionOutputOnly,
-				"\\_SB.GPI0") {1} // power
+			GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
+				"\\_SB.GPI0", 0, ResourceConsumer) { 15 } // red
+			GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
+				"\\_SB.GPI0", 0, ResourceConsumer) { 16 } // green
+			GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
+				"\\_SB.GPI0", 0, ResourceConsumer) { 17 } // blue
+			GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly,
+				"\\_SB.GPI0", 0, ResourceConsumer) { 1 } // power
 		})
 
 		Name (_DSD, Package () {
@@ -92,10 +92,7 @@ with the help of _DSD (Device Specific Data), introduced in ACPI 5.1::
 						^FOO, 2, 0, 1,
 					}
 				},
-				Package () {
-					"power-gpios",
-					Package () {^FOO, 3, 0, 0},
-				},
+				Package () { "power-gpios", Package () { ^FOO, 3, 0, 0 } },
 			}
 		})
 	}
diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 8c9e758f6e9b..6b62425ef9cd 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -333,26 +333,13 @@ For example::
 		{
 			Name (SBUF, ResourceTemplate()
 			{
-				...
 				// Used to power on/off the device
-				GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
-					IoRestrictionOutputOnly, "\\_SB.PCI0.GPI0",
-					0x00, ResourceConsumer,,)
-				{
-					// Pin List
-					0x0055
-				}
+				GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionOutputOnly,
+					"\\_SB.PCI0.GPI0", 0, ResourceConsumer) { 85 }
 
 				// Interrupt for the device
-				GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone,
-					0x0000, "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer,,)
-				{
-					// Pin list
-					0x0058
-				}
-
-				...
-
+				GpioInt (Edge, ActiveHigh, ExclusiveAndWake, PullNone, 0,
+					 "\\_SB.PCI0.GPI0", 0, ResourceConsumer) { 88 }
 			}
 
 			Return (SBUF)
@@ -369,6 +356,7 @@ For example::
 			}
 		})
 		...
+	}
 
 These GPIO numbers are controller relative and path "\\_SB.PCI0.GPI0"
 specifies the path to the controller. In order to use these GPIOs in Linux
diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index df4b711053ee..eaec732cc77c 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -21,18 +21,18 @@ index, like the ASL example below shows::
       Name (_CRS, ResourceTemplate ()
       {
           GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
-                  "\\_SB.GPO0", 0, ResourceConsumer) {15}
+                  "\\_SB.GPO0", 0, ResourceConsumer) { 15 }
           GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionOutputOnly,
-                  "\\_SB.GPO0", 0, ResourceConsumer) {27, 31}
+                  "\\_SB.GPO0", 0, ResourceConsumer) { 27, 31 }
       })
 
       Name (_DSD, Package ()
       {
           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
           Package ()
-	  {
-              Package () {"reset-gpios", Package() {^BTH, 1, 1, 0 }},
-              Package () {"shutdown-gpios", Package() {^BTH, 0, 0, 0 }},
+          {
+              Package () { "reset-gpios", Package () { ^BTH, 1, 1, 0 } },
+              Package () { "shutdown-gpios", Package () { ^BTH, 0, 0, 0 } },
           }
       })
   }
@@ -123,17 +123,17 @@ Example::
       // _DSD Hierarchical Properties Extension UUID
       ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
       Package () {
-          Package () {"hog-gpio8", "G8PU"}
+          Package () { "hog-gpio8", "G8PU" }
       }
   })
 
   Name (G8PU, Package () {
       ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
       Package () {
-          Package () {"gpio-hog", 1},
-          Package () {"gpios", Package () {8, 0}},
-          Package () {"output-high", 1},
-          Package () {"line-name", "gpio8-pullup"},
+          Package () { "gpio-hog", 1 },
+          Package () { "gpios", Package () { 8, 0 } },
+          Package () { "output-high", 1 },
+          Package () { "line-name", "gpio8-pullup" },
       }
   })
 
@@ -266,15 +266,17 @@ have a device like below::
 
       Name (_CRS, ResourceTemplate () {
           GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionNone,
-                  "\\_SB.GPO0", 0, ResourceConsumer) {15}
+                  "\\_SB.GPO0", 0, ResourceConsumer) { 15 }
           GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionNone,
-                  "\\_SB.GPO0", 0, ResourceConsumer) {27}
+                  "\\_SB.GPO0", 0, ResourceConsumer) { 27 }
       })
   }
 
 The driver might expect to get the right GPIO when it does::
 
   desc = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+  if (IS_ERR(desc))
+	...error handling...
 
 but since there is no way to know the mapping between "reset" and
 the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
-- 
2.34.1

