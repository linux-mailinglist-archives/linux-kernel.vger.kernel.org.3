Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7A4D62E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbiCKOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349062AbiCKOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:09:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93665D30;
        Fri, 11 Mar 2022 06:07:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D86661EAD;
        Fri, 11 Mar 2022 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B51EC340FC;
        Fri, 11 Mar 2022 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007676;
        bh=Ci2cMRoQM2vfLEi7tc5+ZXAoUt5SKYq/j4w3Npc0+2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pShPafaYZc6TgrlsRluOkmRND5kBGhOgwC7f5LA/HrhBs3BYXYLvasPY5vkElIBKM
         MIYsOHpTS1zGnVs578vCCgOt6cI8pV9gosG/8WVwn9EREcfAKhmbvgaxa4cs6J3wOK
         aVG3+PDHqG8gliej5fWFdgu4QdzxFCc0wk89d8Fzn+XxYf0ggPv8ruGNmw708jmuq6
         /7JBIBg6Q+r+UmT4MbDEL1D2l71Xu1BQkR830Sa+wVL7AQfOgTLr9ZkliMsje2U2eG
         qJufqkkt7crGvlT3+pQWKi8TIfeT7hnaKKEFFi3UNqsETHwK13jdLft4KdfV0mHsQJ
         BnaxB6uhSB9mw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfvu-000lB6-1U; Fri, 11 Mar 2022 15:07:54 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        lijian <lijian@yulong.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 09/38] media: platform: place Via drivers on a separate dir
Date:   Fri, 11 Mar 2022 15:07:22 +0100
Message-Id: <449ba01cb0ada1d0a5129a740cb44bd41e9ab2ba.1647006877.git.mchehab@kernel.org>
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

In order to cleanup the main platform media directory, move Via
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                | 11 +----------
 drivers/media/platform/Makefile               |  2 +-
 drivers/media/platform/via/Kconfig            | 11 +++++++++++
 drivers/media/platform/via/Makefile           |  1 +
 drivers/media/platform/{ => via}/via-camera.c |  0
 drivers/media/platform/{ => via}/via-camera.h |  0
 6 files changed, 14 insertions(+), 11 deletions(-)
 create mode 100644 drivers/media/platform/via/Kconfig
 create mode 100644 drivers/media/platform/via/Makefile
 rename drivers/media/platform/{ => via}/via-camera.c (100%)
 rename drivers/media/platform/{ => via}/via-camera.h (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index efdb5fe592c6..d6751282087a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -42,16 +42,7 @@ source "drivers/media/platform/nxp/Kconfig"
 
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
index c290835885de..6783b374dc80 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -43,6 +43,7 @@ obj-y += stm32/
 obj-y += sunxi/
 obj-y += tegra/vde/
 obj-y += ti-vpe/
+obj-y += via/
 obj-y += vsp1/
 obj-y += xilinx/
 
@@ -56,4 +57,3 @@ obj-$(CONFIG_VIDEO_RENESAS_FCP)		+= rcar-fcp.o
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
index 000000000000..e5cd95d27523
--- /dev/null
+++ b/drivers/media/platform/via/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_VIDEO_VIA_CAMERA)		+= via-camera.o
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

