Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242894D7394
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiCMHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E21C1945D6;
        Sat, 12 Mar 2022 23:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ED25B80C0A;
        Sun, 13 Mar 2022 07:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A9C3410C;
        Sun, 13 Mar 2022 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156113;
        bh=j4t5zqRuPkle69BHOq9RAKv7BRMQhfQ823erGktcJLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbDj7mZPuwgFGbjHzeUThQePVIqO8U8WL2e2ElFkuDJbynmN3TOkWM6q6+63YhZop
         eojkh4zl9F0XZ9wMShlEZApLv/wkmZoArHOZJhlOp3MdTNvjNPETuX56MXIZO7itV9
         JOWZA49lM2PSOiJTrs6Fc2YbpzLwB20qR2k/cd0xD0WIldJi6PY5fL/rU6+7FzAGd0
         A97qSyKdzaXPpCvoquq8qxYgRm2qgEn6DUpsrqcYAQYwHO5cSFKIytlqSrMQTgweyf
         SKRcRwAxSVU+mDd4P31kbi6OzIpjMZoeA16+TjFC+WwUELBh4gypjQYTcOizJYMNLB
         XawjnbAFAy09A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wS-L6; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 15/39] media: platform: ge2d: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:24 +0100
Message-Id: <36acbf0188acbfb8c644e9561b0eb4a134dee47b.1647155572.git.mchehab@kernel.org>
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

In order to better organize the platform/Kconfig, place
ge2d-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 15 +--------------
 drivers/media/platform/meson/ge2d/Kconfig | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 drivers/media/platform/meson/ge2d/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 57ca2426a83b..d3b7bef19237 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -47,6 +47,7 @@ source "drivers/media/platform/coda/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/exynos-gsc/Kconfig"
+source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -273,20 +274,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
 	help
 	    Generic deinterlacing V4L2 driver.
 
-config VIDEO_MESON_GE2D
-	tristate "Amlogic 2D Graphic Acceleration Unit"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_MESON || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a v4l2 driver for Amlogic GE2D 2D graphics accelerator.
-	  GE2D is a standalone 2D graphic acceleration unit, with color converter,
-	  image scaling, BitBLT & alpha blending operations.
-
-	  To compile this driver as a module choose m here.
-
 config VIDEO_SAMSUNG_S5P_G2D
 	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/meson/ge2d/Kconfig b/drivers/media/platform/meson/ge2d/Kconfig
new file mode 100644
index 000000000000..8c3f3b1b6b05
--- /dev/null
+++ b/drivers/media/platform/meson/ge2d/Kconfig
@@ -0,0 +1,14 @@
+config VIDEO_MESON_GE2D
+	tristate "Amlogic 2D Graphic Acceleration Unit"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_MESON || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Amlogic GE2D 2D graphics accelerator.
+	  GE2D is a standalone 2D graphic acceleration unit, with color converter,
+	  image scaling, BitBLT & alpha blending operations.
+
+	  To compile this driver as a module choose m here.
+
-- 
2.35.1

