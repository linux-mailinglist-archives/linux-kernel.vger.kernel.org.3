Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6659E4D896C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbiCNQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiCNQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E8212A94;
        Mon, 14 Mar 2022 09:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FDF5B80E84;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC37C36AEB;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=bIYCG8GZGci2kc/UDer3Aw7Lo72P4LXFn6gcLSYc+BI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExeEp+HVTn1DByx19ceGbUwPeuG27nsjIInlCxySY8+PVIc9BAMFR4BjKh51UM3bN
         LYPZ4ot6LLtRHa5CPlWJ6IJEZMPjiovaVuhPKAqR++dX5EXV9U8g7CKzoIIOfIYziy
         tgAHeKznr+aa3D/TMci0za7YqF+uGCi4nmOuSqE9ikgte0MnxByF0eva1UuakoYxwN
         3mLUZLNxdvhRV4ERfjg1cC/y9miM+ArgjXhKsJjpOybTekJ1MoaFpcsMW8DB8YYMoC
         3jSFw2aNYaTC8mYLjAFU4ezp1HpGxkRrkprlY/Sl7k44fDfazMQXMokzjw4k9Ga1Xk
         Mcw4B9uroYqmA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTney-001wwc-L0; Mon, 14 Mar 2022 17:35:04 +0100
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
Subject: [PATCH v2 08/67] media: platform: place Intel drivers on a separate dir
Date:   Mon, 14 Mar 2022 17:34:03 +0100
Message-Id: <95495f2aa9d8df1a7697bab24118544d3568f41d.1647274406.git.mchehab@kernel.org>
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

In order to cleanup the main platform media directory, move Intel
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

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

