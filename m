Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D3B55A329
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiFXU6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiFXU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B720185;
        Fri, 24 Jun 2022 13:58:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o10so5117748edi.1;
        Fri, 24 Jun 2022 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nuVDWaOZ6NkJEKam3xrthOWih01cI/lNrQhgyeguo7A=;
        b=jlKrbqf7cUITfhUldL3YN2GV2B9Q1OIQxdAEn7dRGdZqHEBcTWnCceGtm70chPEIpn
         JEMb+hnzetpmSlIWmduQsWFKA9wdlc68E6yjcA3C7NV7Q4wi3OlXS7qD//ZpWwbQk9SQ
         LUiiHIuuf92MC+3YACGrZVdKiOEKEwLicWa95jMCIq2Ej3XxQTs1hl7oZv3a15sz+NWU
         zcOc2dth7+Cbztdrv6sjhxb8CvVO9cUsCuMrAj70PCCD0kqTdc9qkS9VYTuzOsBZYVWH
         A+X3D2blNl5qmlTJ2oKbpmqGNNbDg/I7yPQ8zSIeOjlvl+EGowiMtocWmiTroesbZ5z7
         Dbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nuVDWaOZ6NkJEKam3xrthOWih01cI/lNrQhgyeguo7A=;
        b=w0NgwJ0i7sG0IfZZym84QxlGEqb8UCeIof+/nVzd1ekfnu0WPSqpcIlap5VNflMdH1
         69BSYxSCSDXPTcl5vxui/dWNoPwPu6beGmRO6tvIpiaYAiUEbO4K3751WiRSHcvjYXBk
         1rAhsTNUILlVd/7JX5hyArVqlLaGEnsp3umKZPixKSGxwq64KgBb2pAKu/Ay+EvZjQuu
         9kWAIeVVjcZ8MGCGPf53Jh3J1AHFbJwVInkk+inXVDnPmEsCTrxq2WP0AjmWft1wGl+H
         Bt0s6Faaz3SLEPKo3k3VKw32ObZaiSYRo6S8eC0NJDnnD5DlI8UfltJ9p9GWHBzDtQen
         6PYQ==
X-Gm-Message-State: AJIora8JmD6B+cGyPKmaajTqvZhi8LCS4pBZCd97SzXaSkbtFB70Cj1+
        r9MBPj/RR67anlTyJT023m8=
X-Google-Smtp-Source: AGRyM1vkYI3jvIhj5H9q4x9ckfd6kTPSTLA8ahdIJZ4wtW4+QMVx8jTg8Q6e9XHiG/5QTSSXyBNCzg==
X-Received: by 2002:a05:6402:d0a:b0:437:66ca:c211 with SMTP id eb10-20020a0564020d0a00b0043766cac211mr1269055edb.29.1656104291749;
        Fri, 24 Jun 2022 13:58:11 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709061e4500b006feb6dee4absm1672666ejj.137.2022.06.24.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 13:58:11 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 3/3] platform/surface: Update copyright year of various drivers
Date:   Fri, 24 Jun 2022 22:58:00 +0200
Message-Id: <20220624205800.1355621-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220624205800.1355621-1-luzmaximilian@gmail.com>
References: <20220624205800.1355621-1-luzmaximilian@gmail.com>
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

Update the copyright of various Surface drivers to the current year.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/Kconfig             | 2 +-
 drivers/platform/surface/aggregator/Makefile            | 2 +-
 drivers/platform/surface/aggregator/bus.c               | 2 +-
 drivers/platform/surface/aggregator/bus.h               | 2 +-
 drivers/platform/surface/aggregator/controller.c        | 2 +-
 drivers/platform/surface/aggregator/controller.h        | 2 +-
 drivers/platform/surface/aggregator/core.c              | 2 +-
 drivers/platform/surface/aggregator/ssh_msgb.h          | 2 +-
 drivers/platform/surface/aggregator/ssh_packet_layer.c  | 2 +-
 drivers/platform/surface/aggregator/ssh_packet_layer.h  | 2 +-
 drivers/platform/surface/aggregator/ssh_parser.c        | 2 +-
 drivers/platform/surface/aggregator/ssh_parser.h        | 2 +-
 drivers/platform/surface/aggregator/ssh_request_layer.c | 2 +-
 drivers/platform/surface/aggregator/ssh_request_layer.h | 2 +-
 drivers/platform/surface/aggregator/trace.h             | 2 +-
 drivers/platform/surface/surface_acpi_notify.c          | 2 +-
 drivers/platform/surface/surface_aggregator_cdev.c      | 2 +-
 drivers/platform/surface/surface_aggregator_registry.c  | 2 +-
 drivers/platform/surface/surface_dtx.c                  | 2 +-
 drivers/platform/surface/surface_gpe.c                  | 2 +-
 drivers/platform/surface/surface_hotplug.c              | 2 +-
 drivers/platform/surface/surface_platform_profile.c     | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index cab020324256..c114f9dd5fe1 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+# Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
 
 menuconfig SURFACE_AGGREGATOR
 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
index c0d550eda5cd..fdf664a217f9 100644
--- a/drivers/platform/surface/aggregator/Makefile
+++ b/drivers/platform/surface/aggregator/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+# Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
 
 # For include/trace/define_trace.h to include trace.h
 CFLAGS_core.o = -I$(src)
diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index e0b0381a2834..de539938896e 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -2,7 +2,7 @@
 /*
  * Surface System Aggregator Module bus and device integration.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/device.h>
diff --git a/drivers/platform/surface/aggregator/bus.h b/drivers/platform/surface/aggregator/bus.h
index 6964ee84e79c..5b4dbf21906c 100644
--- a/drivers/platform/surface/aggregator/bus.h
+++ b/drivers/platform/surface/aggregator/bus.h
@@ -2,7 +2,7 @@
 /*
  * Surface System Aggregator Module bus and device integration.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_BUS_H
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 6de834b52b63..43e765199137 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2,7 +2,7 @@
 /*
  * Main SSAM/SSH controller structure and functionality.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/platform/surface/aggregator/controller.h b/drivers/platform/surface/aggregator/controller.h
index a0963c3562ff..f0d987abc51e 100644
--- a/drivers/platform/surface/aggregator/controller.h
+++ b/drivers/platform/surface/aggregator/controller.h
@@ -2,7 +2,7 @@
 /*
  * Main SSAM/SSH controller structure and functionality.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_CONTROLLER_H
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index a62c5dfe42d6..1a6373dea109 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -7,7 +7,7 @@
  * Handles communication via requests as well as enabling, disabling, and
  * relaying of events.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/platform/surface/aggregator/ssh_msgb.h b/drivers/platform/surface/aggregator/ssh_msgb.h
index e562958ffdf0..f3ecad92eefd 100644
--- a/drivers/platform/surface/aggregator/ssh_msgb.h
+++ b/drivers/platform/surface/aggregator/ssh_msgb.h
@@ -2,7 +2,7 @@
 /*
  * SSH message builder functions.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_MSGB_H
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 8a4451c1ffe5..6748fe4ac5d5 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -2,7 +2,7 @@
 /*
  * SSH packet transport layer.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.h b/drivers/platform/surface/aggregator/ssh_packet_layer.h
index 2eb329f0b91a..64633522f971 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.h
@@ -2,7 +2,7 @@
 /*
  * SSH packet transport layer.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H
diff --git a/drivers/platform/surface/aggregator/ssh_parser.c b/drivers/platform/surface/aggregator/ssh_parser.c
index b77912f8f13b..a6f668694365 100644
--- a/drivers/platform/surface/aggregator/ssh_parser.c
+++ b/drivers/platform/surface/aggregator/ssh_parser.c
@@ -2,7 +2,7 @@
 /*
  * SSH message parser.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/aggregator/ssh_parser.h b/drivers/platform/surface/aggregator/ssh_parser.h
index 3bd6e180fd16..801d8fa69fb5 100644
--- a/drivers/platform/surface/aggregator/ssh_parser.h
+++ b/drivers/platform/surface/aggregator/ssh_parser.h
@@ -2,7 +2,7 @@
 /*
  * SSH message parser.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_PARSER_H
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index 790f7f0eee98..f5565570f16c 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -2,7 +2,7 @@
 /*
  * SSH request transport layer.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.h b/drivers/platform/surface/aggregator/ssh_request_layer.h
index 9c3cbae2d4bd..4e387a031351 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.h
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.h
@@ -2,7 +2,7 @@
 /*
  * SSH request transport layer.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #ifndef _SURFACE_AGGREGATOR_SSH_REQUEST_LAYER_H
diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
index cc9e73fbc18e..2a2c17771d01 100644
--- a/drivers/platform/surface/aggregator/trace.h
+++ b/drivers/platform/surface/aggregator/trace.h
@@ -2,7 +2,7 @@
 /*
  * Trace points for SSAM/SSH.
  *
- * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #undef TRACE_SYSTEM
diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
index c0e12f0b9b79..44e317970557 100644
--- a/drivers/platform/surface/surface_acpi_notify.c
+++ b/drivers/platform/surface/surface_acpi_notify.c
@@ -8,7 +8,7 @@
  * notifications sent from ACPI via the SAN interface by providing them to any
  * registered external driver.
  *
- * Copyright (C) 2019-2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
diff --git a/drivers/platform/surface/surface_aggregator_cdev.c b/drivers/platform/surface/surface_aggregator_cdev.c
index 30fb50fde450..492c82e69182 100644
--- a/drivers/platform/surface/surface_aggregator_cdev.c
+++ b/drivers/platform/surface/surface_aggregator_cdev.c
@@ -3,7 +3,7 @@
  * Provides user-space access to the SSAM EC via the /dev/surface/aggregator
  * misc device. Intended for debugging and development.
  *
- * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/fs.h>
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 0cbb7f3a6b2d..d5655f6a4a41 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -6,7 +6,7 @@
  * cannot be auto-detected. Provides device-hubs and performs instantiation
  * for these devices.
  *
- * Copyright (C) 2020-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index 1203b9a82993..ed36944467f9 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -8,7 +8,7 @@
  * acknowledge (to speed things up), abort (e.g. in case the dGPU is still in
  * use), or request detachment via user-space.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/fs.h>
diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index ec66fde28e75..27365cbe1ee9 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -4,7 +4,7 @@
  * properly configuring the respective GPEs. Required for wakeup via lid on
  * newer Intel-based Microsoft Surface devices.
  *
- * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2020-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/platform/surface/surface_hotplug.c b/drivers/platform/surface/surface_hotplug.c
index cfcc15cfbacb..f004a2495201 100644
--- a/drivers/platform/surface/surface_hotplug.c
+++ b/drivers/platform/surface/surface_hotplug.c
@@ -10,7 +10,7 @@
  * Event signaling is handled via ACPI, which will generate the appropriate
  * device-check notifications to be picked up by the PCIe hot-plug driver.
  *
- * Copyright (C) 2019-2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2019-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
index 6373d3b5eb7f..fbf2e11fd6ce 100644
--- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -3,7 +3,7 @@
  * Surface Platform Profile / Performance Mode driver for Surface System
  * Aggregator Module (thermal subsystem).
  *
- * Copyright (C) 2021 Maximilian Luz <luzmaximilian@gmail.com>
+ * Copyright (C) 2021-2022 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
 #include <asm/unaligned.h>
-- 
2.36.1

