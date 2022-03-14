Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8054D7C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiCNH5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiCNH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083383981D;
        Mon, 14 Mar 2022 00:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 811B06117C;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE90C340FB;
        Mon, 14 Mar 2022 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244560;
        bh=ac25/WJhoyDyFTbiMSLWiuHNdyYFaxWUkp4ZUnCYYMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V93fkfLeV11ew1Qspa8IwKVmnMxlXYxMy2XWvD5o0BBmGh0SGmaqRUKPMLw0c/d2n
         drccz+OGA3GFDnqLBISmvEkx0rQhQtA1IVILOrXnqcXt/fwAMz9Ksthss2txPtMqvU
         itml5gCI8kGPAe4qG2e6y1Gau9o778V/9c0KQrya4ywWVaAlqetiqoxa4bhy8/PPAV
         IfbTBaEfyorwF2vGJnqIFLq/5B1Wvj+N5PqI9ndI1ED6AFmtemhSgRDgWNEDm5Lxfx
         awwJno+XaVP3PhxmXhHjr0kHIFgtxMKnr03CQNnD9gFcN7UZhsBD2WCIzqJnPCe2kM
         I7/HR4fEsK5XQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYc-001kUl-NM; Mon, 14 Mar 2022 08:55:58 +0100
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
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        lijian <lijian@yulong.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 09/64] media: platform: place Via drivers on a separate dir
Date:   Mon, 14 Mar 2022 08:55:01 +0100
Message-Id: <11a35df1e9132ccba324ed9da204b4c018c19001.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

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

