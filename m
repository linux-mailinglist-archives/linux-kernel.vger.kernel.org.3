Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC3D4D7C58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiCNH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiCNH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53014131F;
        Mon, 14 Mar 2022 00:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F10EB80CD7;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD868C340FA;
        Mon, 14 Mar 2022 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244560;
        bh=9DGItyRqo5/TWrsCFxegH0TQiWspharIIrhV3x3Mb5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFdpmQvnRvMuJyA+ym0T7a8yeLcIb0fc/hdwJE+xcgYzlV8QqLAa+/UzK+GQ/+Jfm
         Ud23qEzvUjMbaC9eGypCXo4IDg2KxJdyekrugyv+rYFmNlmzkCrh0HlpzNXr2IFov8
         L6go9twm0cZunQiv20qTXbFoKHDZkJW6IMuARe5ObcOgOeWQemnyIcASe2IU8MhN1x
         nD1dFlvjiV5OOXEGzF+5w/jfNeYqGIDprXy/Dwjv6cpqVZnS7O4XuWmp1QBM29Jm25
         cyPNC9BKl0r/bvTxuGB8KgB9gqlgY5OCV4PZDwSHUC9RXCH6xX32xf7LbP0AXp9lfK
         3yARTdDzW39Kw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYc-001kUh-M9; Mon, 14 Mar 2022 08:55:58 +0100
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
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 08/64] media: platform: place Intel drivers on a separate dir
Date:   Mon, 14 Mar 2022 08:55:00 +0100
Message-Id: <ca0756f7d11db77857559cf3d3465a45dc181a7c.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
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

In order to cleanup the main platform media directory, move Intel
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                  | 11 +----------
 drivers/media/platform/Makefile                 |  2 +-
 drivers/media/platform/intel/Kconfig            | 11 +++++++++++
 drivers/media/platform/intel/Makefile           |  2 ++
 drivers/media/platform/{ => intel}/pxa_camera.c |  0
 5 files changed, 15 insertions(+), 11 deletions(-)
 create mode 100644 drivers/media/platform/intel/Kconfig
 create mode 100644 drivers/media/platform/intel/Makefile
 rename drivers/media/platform/{ => intel}/pxa_camera.c (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 711b6ab9370b..0cfbc0c2aa7a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -96,16 +96,7 @@ config VIDEO_OMAP3_DEBUG
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
index 4458690c1965..78ac0fa4dd57 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -15,6 +15,7 @@ obj-y += coda/
 obj-y += davinci/
 obj-y += exynos-gsc/
 obj-y += exynos4-is/
+obj-y += intel/
 obj-y += marvell-ccic/
 obj-y += meson/ge2d/
 obj-y += mtk-jpeg/
@@ -49,7 +50,6 @@ obj-y += xilinx/
 # (e. g. LC_ALL=C sort Makefile)
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
index 000000000000..7e8889cbd2df
--- /dev/null
+++ b/drivers/media/platform/intel/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_VIDEO_PXA27x) += pxa_camera.o
diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/intel/pxa_camera.c
similarity index 100%
rename from drivers/media/platform/pxa_camera.c
rename to drivers/media/platform/intel/pxa_camera.c
-- 
2.35.1

