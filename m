Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E244D62FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349261AbiCKOLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbiCKOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:10:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FB1B308A;
        Fri, 11 Mar 2022 06:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EC6161EDF;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F5C340FE;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=5pNSVC2k+UBixAbxknJRdEeJ0oFeLWbdCm7nfipWXJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjOQnSDlLYpABlnqrLi4D7j2QZ0A7c3UfJYeb1ePMrI4r8bxPG/Q/NdRw52RrM99g
         zwPN0wmAhTlUFRfT3lY4ur6VdqB4TsrX6uBSvITwLUFSq53JrVNfkjXaoX8ByFgBXW
         y++CbeNH+t8XB1e1H/c4CIL8kKexPijd7ETDk3z0FiUFwFouo+9rDt9I9edREnmb5P
         /JEVYejZAXIsgkkmJfXVl7sL0WDXQs1/sDHGQeMZxHGsjcpfiRj8rxGGNECxQgl0rI
         dIb8g+ekxuUODn+a+KUbaK/7HfZZ45bRrHqOi3Xthgd3kZ7Wc8krDDAl8O2omhCfrq
         /C2QbFnGvbyFg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHd-E4; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 20/38] media: platform: omap3isp: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:33 +0100
Message-Id: <23ec04fc9e3ac6ce6cd9fa21f4b7b42c9ae7eaf5.1647006877.git.mchehab@kernel.org>
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
omap3isp-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 23 +----------------------
 drivers/media/platform/omap3isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)
 create mode 100644 drivers/media/platform/omap3isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 1c6358d6fa89..f65eefa15dda 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -59,6 +59,7 @@ source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
+source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -75,28 +76,6 @@ config VIDEO_MUX
 	help
 	  This driver provides support for N:1 video bus multiplexers.
 
-config VIDEO_OMAP3
-	tristate "OMAP 3 Camera support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && I2C
-	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
-	depends on COMMON_CLK && OF
-	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	select MFD_SYSCON
-	select V4L2_FWNODE
-	help
-	  Driver for an OMAP 3 camera controller.
-
-config VIDEO_OMAP3_DEBUG
-	bool "OMAP 3 Camera debug messages"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_OMAP3
-	help
-	  Enable debug messages on OMAP 3 camera controller driver.
-
 source "drivers/media/platform/intel/Kconfig"
 
 config VIDEO_QCOM_CAMSS
diff --git a/drivers/media/platform/omap3isp/Kconfig b/drivers/media/platform/omap3isp/Kconfig
new file mode 100644
index 000000000000..85f0cf063153
--- /dev/null
+++ b/drivers/media/platform/omap3isp/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_OMAP3
+	tristate "OMAP 3 Camera support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && I2C
+	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
+	depends on COMMON_CLK && OF
+	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select MFD_SYSCON
+	select V4L2_FWNODE
+	help
+	  Driver for an OMAP 3 camera controller.
+
+config VIDEO_OMAP3_DEBUG
+	bool "OMAP 3 Camera debug messages"
+	depends on VIDEO_OMAP3
+	help
+	  Enable debug messages on OMAP 3 camera controller driver.
-- 
2.35.1

