Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4670152B0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiERDTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiERDSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 23:18:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619963BD1;
        Tue, 17 May 2022 20:18:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f10so722227pjs.3;
        Tue, 17 May 2022 20:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GhbuveanyRCzxWkR8znTWcVITUWPUYSOEXxCGyzgGi0=;
        b=eEd3WrWV4twn/XINGMN7XWIbpMNgWoNmsXMXUxkAsTFMcRV+2CbDBgyoVScZJzkpx5
         UYeprmgxUuUFbaf8rMZB0F/ID5SHHpw2K3OHSBMn0zb1ipypGtGZMX/ETIEQtoiUUJ3x
         Dey5oNSmmWKzdt0+igRNZO9PUDBjUgu1aqBb25WDMuvTSTzD804GYk2DftuUY7NpElaK
         r3lg0hgvBsghOvJGLy+Fk2W85p7v6D+sWU1BtCvhr5gbIW0o/obkeuPOyQfnAwuslwn/
         6+PyQvAY22UjSAavu+ljUVZtXpQJSoHpEibE2FzcK17emqg4uPe+97JjCRXnbEOddGwj
         xnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhbuveanyRCzxWkR8znTWcVITUWPUYSOEXxCGyzgGi0=;
        b=rkgSEPa5mkTBP7t5zEzPSKe+YtdybyFi21b+YuPdSCQk7727WcJqQ2hrimj6oGtVvI
         QAb+Ygx8DqXmrGxGxDjIeTPAD2k3HVxpanhDeDUSrLb5SS9FRwatXDXLduLPuwRy/WqC
         LpSFLqGtRLXgNBUTAvAGSF2CPuTJhnD6qLUZZkXWZZUjLL1arIOahcxQm4ZeHnGwC+Oe
         GTjZU4xlXscZ5sjJ/3kA8xNCWfi89BP+Mmfeg8lHqWbMVmLRkWauzjdwjCvbNiTGaWpv
         KPFUqXl37HCmInCeM3evfZTZaUrfirGDMUq1VaS1PmjGaoRjUnwdeIfYxjwPL1CGYNjk
         Zudw==
X-Gm-Message-State: AOAM531SMuGWxJ3KP8WtpMhIBCdV2X+6KXMP8YZqglXWwX4X7qqMuRFa
        Fj21ObyhouSeU9eGqm1THKLyGETdMtc=
X-Google-Smtp-Source: ABdhPJzZ/rwhxHy9cgRHqEL6Ahi4emkIuCTrrtUApOBAh8NlEWRpsjptP4//HxK8O03vB/7bzzGsgA==
X-Received: by 2002:a17:902:b083:b0:161:955e:f16e with SMTP id p3-20020a170902b08300b00161955ef16emr9271746plr.73.1652843931666;
        Tue, 17 May 2022 20:18:51 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-63.three.co.id. [116.206.12.63])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b00161ac982b9esm343771plk.185.2022.05.17.20.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 20:18:50 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH 1/2] platform/chrome: Use tables for values lists of ChromeOS ACPI sysfs ABI
Date:   Wed, 18 May 2022 10:17:50 +0700
Message-Id: <20220518031750.21923-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220518031750.21923-1-bagasdotme@gmail.com>
References: <20220518031750.21923-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warning when merging chrome-platform
tree:

Documentation/ABI/testing/sysfs-driver-chromeos-acpi:2: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:11: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:22: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:56: WARNING: Unexpected indentation.

The warning is due to missing blank line separator surrounding values
lists.

Instead of using lists, use tables to be consistent with rest of sysfs
ABI documentation.

Link: https://lore.kernel.org/linux-next/20220516213832.19127535@canb.auug.org.au/
Fixes: 0a4cad9c11ad46 ("platform/chrome: Add ChromeOS ACPI device
driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benson Leung <bleung@google.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../ABI/testing/sysfs-driver-chromeos-acpi    | 52 ++++++++++++-------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
index 5b59ef9d7b371c..cb9201548f38be 100644
--- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
+++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
@@ -4,8 +4,11 @@ KernelVersion:	5.19
 Description:
 		This file shows information about the current boot of
 		the active EC firmware.
-		  * 0 - Read only (recovery) firmware.
-		  * 1 - Rewritable firmware.
+
+		== ===============================
+		0  Read only (recovery) firmware.
+		1  Rewritable firmware.
+		== ===============================
 
 What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
 Date:		May 2022
@@ -13,23 +16,28 @@ KernelVersion:	5.19
 Description:
 		This file shows information about the current boot of
 		the active main	firmware type.
-		  * 0 - Recovery.
-		  * 1 - Normal.
-		  * 2 - Developer.
-		  * 3 - Netboot (factory installation only).
+
+		== =====================================
+		0  Recovery.
+		1  Normal.
+		2  Developer.
+		3  Netboot (factory installation only).
+		== =====================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/CHSW
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		This file shows the switch position for the Chrome OS specific
-		hardware switches.
-		  * 0   - No changes.
-		  * 2   - Recovery button was pressed when firmware booted.
-		  * 4   - Recovery button was pressed when EC firmware booted.
-		  * 32  - Developer switch was enabled when firmware booted.
-		  * 512 - Firmware write protection was disabled when firmware
-			  booted.
+		hardware switches when the firmare is booted.
+
+		==== ===========================================
+		0    No changes.
+		2    Recovery button was pressed.
+		4    Recovery button was pressed (EC firmware).
+		32   Developer switch was enabled.
+		512  Firmware write protection was disabled.
+		==== ===========================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/FMAP
 Date:		May 2022
@@ -58,18 +66,24 @@ KernelVersion:	5.19
 Description:
 		This file shows the type of the GPIO signal for the Chrome OS
 		specific GPIO assignments.
-		  * 1   - Recovery button.
-		  * 2   - Developer mode switch.
-		  * 3   - Firmware write protection switch.
-		  * 256 to 511 - Debug header GPIO 0 to GPIO 255.
+
+		=========== ==================================
+		1           Recovery button.
+		2           Developer mode switch.
+		3           Firmware write protection switch.
+		256 to 511  Debug header GPIO 0 to GPIO 255.
+		=========== ==================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		This file shows the signal attributes of the GPIO signal.
-		  * 0 - Signal is active low.
-		  * 1 - Signal is active high.
+
+		== =======================
+		0  Signal is active low.
+		1  Signal is active high.
+		== =======================
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
 Date:		May 2022
-- 
An old man doll... just what I always wanted! - Clara

