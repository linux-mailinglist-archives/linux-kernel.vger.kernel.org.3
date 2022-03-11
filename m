Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBABB4D62E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349077AbiCKOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349061AbiCKOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:09:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37B665D0F;
        Fri, 11 Mar 2022 06:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60D0E61EAC;
        Fri, 11 Mar 2022 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582E2C340FD;
        Fri, 11 Mar 2022 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007676;
        bh=KjziZ2+PieiVuoXr/SfYM8vrgsmWGDJXSuX1iIwh8Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J26x+inYaw9GAkNQUdNEOOxGteNl6Mv5gNxuZeRmBqJzb6d3+V6/f+UQ1nwMgwdty
         51eBJFySMYY6Dn9JZD+3r4aQjAomH+mvjwkOujVnvPqNbetenquqhB85EuaQ32sLwa
         EQacnMyZMEChYIJnASr8Q642IzDFeY7bCLHsGFchAv63yJtD76rsgWz+Ln9p8V2HY8
         fV4gMtdVUP/cd0sMTQ/13/wO+dphj3QeCKnvVYabEr2S5zXVY+EE5XI9dBgPukkequ
         9kVx6zaNDREl5XFz26FRKHCMx+drwZQJErD2ZgoEj0e2F8Fe71fwL7d1Xh1U4bPHM1
         87XT8Iap1mPpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfvu-000lB2-01; Fri, 11 Mar 2022 15:07:54 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 08/38] media: platform: place Intel drivers on a separate dir
Date:   Fri, 11 Mar 2022 15:07:21 +0100
Message-Id: <c61baf3edc3d002cdcb3a223e15169ac39b2a227.1647006877.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cleanup the main platform media directory, move Intel
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                  | 11 +----------
 drivers/media/platform/Makefile                 |  2 +-
 drivers/media/platform/intel/Kconfig            | 11 +++++++++++
 drivers/media/platform/intel/Makefile           |  1 +
 drivers/media/platform/{ => intel}/pxa_camera.c |  0
 5 files changed, 14 insertions(+), 11 deletions(-)
 create mode 100644 drivers/media/platform/intel/Kconfig
 create mode 100644 drivers/media/platform/intel/Makefile
 rename drivers/media/platform/{ => intel}/pxa_camera.c (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f5ef28d3e53c..efdb5fe592c6 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -104,16 +104,7 @@ config VIDEO_OMAP3_DEBUG
 	help
 	  Enable debug messages on OMAP 3 camera controller driver.
 
-config VIDEO_PXA27x
-	tristate "PXA27x Quick Capture Interface driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on PXA27x || COMPILE_TEST
-	select VIDEOBUF2_DMA_SG
-	select SG_SPLIT
-	select V4L2_FWNODE
-	help
-	  This is a v4l2 driver for the PXA27x Quick Capture Interface
+source "drivers/media/platform/intel/Kconfig"
 
 config VIDEO_QCOM_CAMSS
 	tristate "Qualcomm V4L2 Camera Subsystem driver"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index e9f982eb034b..c290835885de 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -16,6 +16,7 @@ obj-y += exynos4-is/
 obj-y += exynos-gsc/
 obj-y += imx/
 obj-y += imx-jpeg/
+obj-y += intel/
 obj-y += marvell-ccic/
 obj-y += meson/ge2d/
 obj-y += mtk-jpeg/
@@ -48,7 +49,6 @@ obj-y += xilinx/
 # Please place here only ancillary drivers that aren't SoC-specific
 obj-$(CONFIG_VIDEO_MEM2MEM_DEINTERLACE)	+= m2m-deinterlace.o
 obj-$(CONFIG_VIDEO_MUX)			+= video-mux.o
-obj-$(CONFIG_VIDEO_PXA27x)		+= pxa_camera.o
 obj-$(CONFIG_VIDEO_RCAR_DRIF)		+= rcar_drif.o
 obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
 obj-$(CONFIG_VIDEO_RENESAS_CEU)		+= renesas-ceu.o
diff --git a/drivers/media/platform/intel/Kconfig b/drivers/media/platform/intel/Kconfig
new file mode 100644
index 000000000000..aeda421f7248
--- /dev/null
+++ b/drivers/media/platform/intel/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_PXA27x
+	tristate "PXA27x Quick Capture Interface driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on PXA27x || COMPILE_TEST
+	select VIDEOBUF2_DMA_SG
+	select SG_SPLIT
+	select V4L2_FWNODE
+	help
+	  This is a v4l2 driver for the PXA27x Quick Capture Interface
diff --git a/drivers/media/platform/intel/Makefile b/drivers/media/platform/intel/Makefile
new file mode 100644
index 000000000000..10ea23fb2bcc
--- /dev/null
+++ b/drivers/media/platform/intel/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_VIDEO_PXA27x)		+= pxa_camera.o
diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/intel/pxa_camera.c
similarity index 100%
rename from drivers/media/platform/pxa_camera.c
rename to drivers/media/platform/intel/pxa_camera.c
-- 
2.35.1

