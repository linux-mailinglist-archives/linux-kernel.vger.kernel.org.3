Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11D64D736B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiCMHX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiCMHXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3E194564;
        Sat, 12 Mar 2022 23:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 218D7B80B98;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7140C340FD;
        Sun, 13 Mar 2022 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156113;
        bh=pcqNQNTnTjSkyZImZs6a2FSRQpiRmaFi0GEFdHFK6Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsKR/E4YGKWRm4Jn0Up0fPu62Z0e+bpPLU2mnC4rfG3plhPR/ox7Dntl1YjGOJCrF
         QWl0zjVtJkaA1Kr2ozmehc8AnxDbnIl8fC+112V+6z9pyjojbhN208ZHCq4KgBE8Xp
         OANuS8zmQiPoTrTJHo5O5JDwnzskO43byTGVgPNwqHAzyjpiEzrtHqdgSpzTs/V+C8
         3Rbol9i0ELL+LvWE9hY1ndHjRGRKUSg3/mzOXCA+zu3CXlFG58+MbpN0oCCzm7G7IR
         2gfpuBDZ+Yq5AtW1eE6ZnfnN9MfP1OzI06VmBxeSYNeUe6rx117rwGsn67qvr4zqqu
         hbLGEFS/mGOEg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012w4-Cn; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dillon Min <dillon.minfei@gmail.com>,
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
Subject: [PATCH v3 09/39] media: platform: place Via drivers on a separate dir
Date:   Sun, 13 Mar 2022 08:21:18 +0100
Message-Id: <9bfdc1f71893da1d57dd13ad30358d1e99e15a0a.1647155572.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647155572.git.mchehab@kernel.org>
References: <cover.1647155572.git.mchehab@kernel.org>
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
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

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
index 000000000000..a5c04c825840
--- /dev/null
+++ b/drivers/media/platform/via/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
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

