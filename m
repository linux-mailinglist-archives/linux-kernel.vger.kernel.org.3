Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4224D4D8972
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbiCNQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiCNQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3B12AEB;
        Mon, 14 Mar 2022 09:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AD0FCCE1316;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09183C36AEA;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=5foHnESL7uVkLT0L1ipjL68Atf7hQWsuAXs7ioZj8ZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JbBU49hbPgY5/xUAwX6tGfJsyyBGXw5KP+RuR2+elkTTcsCdQsvYG3WAzVLeKS34k
         xznbsrbTMLRCLMo6wvIgKAvlCD8NMyqnCY85iykzTAcuyjTqCWG/vDuhC7eF0/dbtN
         nhHt3+er/5n+Hwq87xxr/lpK4JBvzYoOiE75U3tcq23HI9pf3ayw4/9F4FO5tcW3HQ
         ci7ND/R0o4AiBL6QJajOcZf5GyCiBf2yx29MS1MehE3wEDoqpzi7CqtGJb4v8Pcm1M
         2kUvhYCg+fuW7hnKs/vpDU1peyUGNwc8CPbx9hR9o+ioCC7YgEK33Yzkc1qLKcOeNA
         aA46skrHazg2A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTney-001wwg-MR; Mon, 14 Mar 2022 17:35:04 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        lijian <lijian@yulong.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 09/67] media: platform: place Via drivers on a separate dir
Date:   Mon, 14 Mar 2022 17:34:04 +0100
Message-Id: <81acf39488cfe99319b0a25f2b9a0e2e3bb40b6d.1647274406.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cleanup the main platform media directory, move Via
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                | 11 +----------
 drivers/media/platform/Makefile               |  2 +-
 drivers/media/platform/via/Kconfig            | 11 +++++++++++
 drivers/media/platform/via/Makefile           |  2 ++
 drivers/media/platform/{ => via}/via-camera.c |  0
 drivers/media/platform/{ => via}/via-camera.h |  0
 6 files changed, 15 insertions(+), 11 deletions(-)
 create mode 100644 drivers/media/platform/via/Kconfig
 create mode 100644 drivers/media/platform/via/Makefile
 rename drivers/media/platform/{ => via}/via-camera.c (100%)
 rename drivers/media/platform/{ => via}/via-camera.h (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0cfbc0c2aa7a..83a496327325 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -35,16 +35,7 @@ source "drivers/media/platform/nxp/Kconfig"
 
 source "drivers/media/platform/marvell-ccic/Kconfig"
 
-config VIDEO_VIA_CAMERA
-	tristate "VIAFB camera controller support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on FB_VIA && VIDEO_V4L2
-	select VIDEOBUF2_DMA_SG
-	select VIDEO_OV7670
-	help
-	   Driver support for the integrated camera controller in VIA
-	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
-	   with ov7670 sensors.
+source "drivers/media/platform/via/Kconfig"
 
 source "drivers/media/platform/cadence/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 78ac0fa4dd57..4742b18fd8d8 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -42,6 +42,7 @@ obj-y += stm32/
 obj-y += sunxi/
 obj-y += tegra/vde/
 obj-y += ti-vpe/
+obj-y += via/
 obj-y += vsp1/
 obj-y += xilinx/
 
@@ -57,4 +58,3 @@ obj-$(CONFIG_VIDEO_RENESAS_FCP)		+= rcar-fcp.o
 obj-$(CONFIG_VIDEO_RENESAS_FDP1)	+= rcar_fdp1.o
 obj-$(CONFIG_VIDEO_RENESAS_JPU)		+= rcar_jpu.o
 obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
-obj-$(CONFIG_VIDEO_VIA_CAMERA)		+= via-camera.o
diff --git a/drivers/media/platform/via/Kconfig b/drivers/media/platform/via/Kconfig
new file mode 100644
index 000000000000..1dcf789dce96
--- /dev/null
+++ b/drivers/media/platform/via/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_VIA_CAMERA
+	tristate "VIAFB camera controller support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on FB_VIA && VIDEO_V4L2
+	select VIDEOBUF2_DMA_SG
+	select VIDEO_OV7670
+	help
+	   Driver support for the integrated camera controller in VIA
+	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
+	   with ov7670 sensors.
diff --git a/drivers/media/platform/via/Makefile b/drivers/media/platform/via/Makefile
new file mode 100644
index 000000000000..80f747f3fffc
--- /dev/null
+++ b/drivers/media/platform/via/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_VIDEO_VIA_CAMERA) += via-camera.o
diff --git a/drivers/media/platform/via-camera.c b/drivers/media/platform/via/via-camera.c
similarity index 100%
rename from drivers/media/platform/via-camera.c
rename to drivers/media/platform/via/via-camera.c
diff --git a/drivers/media/platform/via-camera.h b/drivers/media/platform/via/via-camera.h
similarity index 100%
rename from drivers/media/platform/via-camera.h
rename to drivers/media/platform/via/via-camera.h
-- 
2.35.1

