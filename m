Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B114D7CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiCNH6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbiCNH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D141334;
        Mon, 14 Mar 2022 00:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A649961196;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A407C3411B;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=Fu2QaYR91UhyudmnrN7Kp1OM9hZzw1QcW9qki18sK0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rgnk9YXnvq5Pbffy1mwD1epu/L6GmmSWTy7r7euwSbQEeSp5jBwWI2p65DMRloli1
         PJpo1T/S3GGQja8q1Hi83GvK10hpzClJVLAQ9koCYwpJ3i37LQF/ODC7DE2NzRLCAK
         75Q9aiJ/nGlgDg+9CKMPEoku/6nRu6qD4X1YJGV0WVPSuOaorvpSbGfx/UKS1YH74O
         /bP7TsU2eIZ8an4LI2FNxGVxTFOiiwooth5dORFgjvEbTOdwTuM5ql/a019qS8cEc3
         2AIbdNkzgRBpUswfP8GwpbnzFxnlBYdqHXNWxUVMn4T1nj1tG/Yuwr+aHmZNtNskMf
         IY2LK5WbzYbmA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kVT-5V; Mon, 14 Mar 2022 08:55:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 20/64] media: platform: omap3isp: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:12 +0100
Message-Id: <dee924414a341973eb335c6b56b68872d2d70d76.1647242579.git.mchehab@kernel.org>
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

In order to better organize the platform/Kconfig, place
omap3isp-specific config stuff on a separate Kconfig file.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 22 +---------------------
 drivers/media/platform/omap3isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 drivers/media/platform/omap3isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 39bf4c57e044..1dac7a5b53eb 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -52,6 +52,7 @@ source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
+source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -68,27 +69,6 @@ config VIDEO_MUX
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

