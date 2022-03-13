Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089704D7398
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiCMH0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9431945D0;
        Sat, 12 Mar 2022 23:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3238B60F86;
        Sun, 13 Mar 2022 07:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB2BC341CB;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=smeXUMl3v/aoh19JaifUE7WfFJaaui/ZfZMTF/9sjno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EJ4Sx3bhAqkIUCxK94HeZauYBG/gOWfjIoI0APW0Jz+hKqTo/i5hG5zbl0EwnaXrE
         zZvXLJVlzQ6HWtmn/zsNNd8AkA6UjkUJKbTKADyHH31kh/ow2hGBiFBRBe4Kt30kMI
         Wge+0/1/RX6BXNJI/voSMk8T5lZYPRuIbIYT+Mn5YpEHMDEQOzZ42VjLjwKUsbsOmr
         PzTJfwHrwW1TQppn55oiL8zggK6WzlcSY7gDTDlnT2k0TYPSjm3cIasVfeDc23l+Lf
         k4yR6gYQUchg1CSr4aw2esnpNAeWwC7PeL4JI7+sSF5HHRZc2fTjzdcf2TE1QQ79ag
         CHNIfcW3Dbp6Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xM-9C; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 29/39] media: platform: sun8i-rotate: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:38 +0100
Message-Id: <4df533e0fb82cda3a389a2e6cc72c1a12a7a40ed.1647155572.git.mchehab@kernel.org>
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
sun8i-rotate-specific config stuff on a separate Kconfig file.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                    | 14 +-------------
 drivers/media/platform/sunxi/sun8i-rotate/Kconfig | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 13 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/sun8i-rotate/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 61f8a8fae109..224ebe4f5348 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -64,6 +64,7 @@ source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
+source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -231,19 +232,6 @@ config VIDEO_TI_VPE_DEBUG
 	help
 	  Enable debug messages on VPE driver.
 
-config VIDEO_SUN8I_ROTATE
-	tristate "Allwinner DE2 rotation driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on COMMON_CLK && OF
-	depends on PM
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	   Support for the Allwinner DE2 rotation unit.
-	   To compile this driver as a module choose m here.
-
 config VIDEO_TEGRA_VDE
 	tristate "NVIDIA Tegra Video Decoder Engine driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/sunxi/sun8i-rotate/Kconfig b/drivers/media/platform/sunxi/sun8i-rotate/Kconfig
new file mode 100644
index 000000000000..64a8ea76e917
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-rotate/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_SUN8I_ROTATE
+	tristate "Allwinner DE2 rotation driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK && OF
+	depends on PM
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	   Support for the Allwinner DE2 rotation unit.
+	   To compile this driver as a module choose m here.
-- 
2.35.1

