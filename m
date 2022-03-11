Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0B4D6339
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349330AbiCKOMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349218AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEA81B3A69;
        Fri, 11 Mar 2022 06:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58ADAB82C24;
        Fri, 11 Mar 2022 14:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501D0C36AE5;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=BvZB+4Vk8sOxxxXq1G3XNsVAl5bFgpWDh9QG48DkQEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4IkM9fkJ/L4RZgf2AOcnXQyE0hiHAAh58LNlDboef2upLirr7VGQ8fb7bs8i9jd+
         71YjLEj23/k3OB+azDw30vzVUAZgLEzFlXzQVw8NGoXE6EO5jyT3nfMFwQbQ6xDSC0
         z1nASvXWmnJCpYduW56PiI7D8bjIx58NAPJa9yY/rZSsHyjdGh2hd2G4LhIa2sipy2
         YtItPwPIGe4nRKkEtgGIV+gdo02h1XlEZ59Sfk7iA9nx29MCTszzQOt31eXrS1ilRB
         Eof/s3NWBUBdrRdWiy2s5reKbMZbWwff9n0uec8tJZPqI/5sQNzCGBKuZxIUAC65My
         1dy7USwN2kY/A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIL-3g; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 31/38] media: platform: ti-vpe: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:44 +0100
Message-Id: <295b76eab3169ce39edff3bc542f34012a6ea187.1647006877.git.mchehab@kernel.org>
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

In order to better organize the platform/Kconfig, place
ti-vpe-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig        | 60 +-------------------------
 drivers/media/platform/ti-vpe/Kconfig | 62 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 59 deletions(-)
 create mode 100644 drivers/media/platform/ti-vpe/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9b8a5f4eaafc..a7db6cee6b07 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -73,6 +73,7 @@ source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
 source "drivers/media/platform/tegra/vde/Kconfig"
+source "drivers/media/platform/ti-vpe/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -114,33 +115,6 @@ source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 source "drivers/media/platform/imx/Kconfig"
 
-config VIDEO_TI_CAL
-	tristate "TI CAL (Camera Adaptation Layer) driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	depends on SOC_DRA7XX || ARCH_K3 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_FWNODE
-	help
-	  Support for the TI CAL (Camera Adaptation Layer) block
-	  found on DRA72X SoC.
-	  In TI Technical Reference Manual this module is referred as
-	  Camera Interface Subsystem (CAMSS).
-
-config VIDEO_TI_CAL_MC
-	bool "Media Controller centric mode by default"
-	depends on VIDEO_TI_CAL
-	default n
-	help
-	  Enables Media Controller centric mode by default.
-
-	  If set, CAL driver will start in Media Controller mode by
-	  default. Note that this behavior can be overridden via
-	  module parameter 'mc_api'.
-
-
 # Mem2mem drivers
 
 source "drivers/media/platform/imx-jpeg/Kconfig"
@@ -222,38 +196,6 @@ config VIDEO_STI_DELTA_DRIVER
 	select V4L2_MEM2MEM_DEV
 	select RPMSG
 
-config VIDEO_TI_VPE
-	tristate "TI VPE (Video Processing Engine) driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on SOC_DRA7XX || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	select VIDEO_TI_VPDMA
-	select VIDEO_TI_SC
-	select VIDEO_TI_CSC
-	help
-	  Support for the TI VPE(Video Processing Engine) block
-	  found on DRA7XX SoC.
-
-config VIDEO_TI_VPE_DEBUG
-	bool "VPE debug messages"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_TI_VPE
-	help
-	  Enable debug messages on VPE driver.
-
-# TI VIDEO PORT Helper Modules
-# These will be selected by VPE and VIP
-config VIDEO_TI_VPDMA
-	tristate
-
-config VIDEO_TI_SC
-	tristate
-
-config VIDEO_TI_CSC
-	tristate
-
 # DVB platform drivers
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
 
diff --git a/drivers/media/platform/ti-vpe/Kconfig b/drivers/media/platform/ti-vpe/Kconfig
new file mode 100644
index 000000000000..a9ee0189f2f2
--- /dev/null
+++ b/drivers/media/platform/ti-vpe/Kconfig
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# TI VIDEO PORT Helper Modules
+# These will be selected by VPE and VIP
+config VIDEO_TI_VPDMA
+	tristate
+
+config VIDEO_TI_SC
+	tristate
+
+config VIDEO_TI_CSC
+	tristate
+
+# V4L drivers
+
+config VIDEO_TI_CAL
+	tristate "TI CAL (Camera Adaptation Layer) driver"
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on V4L_PLATFORM_DRIVERS
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	depends on SOC_DRA7XX || ARCH_K3 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  Support for the TI CAL (Camera Adaptation Layer) block
+	  found on DRA72X SoC.
+	  In TI Technical Reference Manual this module is referred as
+	  Camera Interface Subsystem (CAMSS).
+
+config VIDEO_TI_CAL_MC
+	bool "Media Controller centric mode by default"
+	depends on VIDEO_TI_CAL
+	default n
+	help
+	  Enables Media Controller centric mode by default.
+
+	  If set, CAL driver will start in Media Controller mode by
+	  default. Note that this behavior can be overridden via
+	  module parameter 'mc_api'.
+
+# Mem2mem drivers
+
+config VIDEO_TI_VPE
+	tristate "TI VPE (Video Processing Engine) driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on SOC_DRA7XX || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	select VIDEO_TI_VPDMA
+	select VIDEO_TI_SC
+	select VIDEO_TI_CSC
+	help
+	  Support for the TI VPE(Video Processing Engine) block
+	  found on DRA7XX SoC.
+
+config VIDEO_TI_VPE_DEBUG
+	bool "VPE debug messages"
+	depends on VIDEO_TI_VPE
+	help
+	  Enable debug messages on VPE driver.
-- 
2.35.1

