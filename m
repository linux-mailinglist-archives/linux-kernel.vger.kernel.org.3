Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E404D7CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbiCNIBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiCNH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8941616;
        Mon, 14 Mar 2022 00:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAE74CE10B5;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897AFC36B10;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244562;
        bh=33ldIk/ewmr/NLPVYHWMIqcESTNcBpKoTPzPwzIe0n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XA9YRlHdAwQnPWO3cemaUAjYKpm6af7Q57P7N4xFVl/yBhBODn0m/GuG5p6F3LPSV
         kLchSoeNMmHRk+XUzUIl5jer+UmfdohY3AyAEwd3zMD4wX+diplO4TepBICnuzAGSj
         cMzXVv0ArKMGZZui+QwygCM0A8BitMnrarWO+aULibP+s0AcoDV3+UZ5PNWR0fg6G4
         v7H9TIh+ECc7qZiVJlKuATN3nx8ZQEOynDlKU/Ruy4Dc6rjboh+aV6xRG+KsllKu8D
         tXuDySoq21tXuhsYp5ZBUJe2RB+7TCywyfJoKU8okR7LjEsYnY0FLvRJ7dcPxLwzqk
         Qkg/FAw2/48Dw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kXL-CA; Mon, 14 Mar 2022 08:56:00 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 49/64] media: platform: rename amphion/ to nxp/amphion/
Date:   Mon, 14 Mar 2022 08:55:41 +0100
Message-Id: <bb359b4709ceb1112813965237d153cd366cae2d.1647242579.git.mchehab@kernel.org>
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

As the end goal is to have platform drivers split by vendor,
rename amphion/ to nxp/amphion/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 MAINTAINERS                                            | 2 +-
 drivers/media/platform/Kconfig                         | 2 +-
 drivers/media/platform/Makefile                        | 2 +-
 drivers/media/platform/{ => nxp}/amphion/Kconfig       | 0
 drivers/media/platform/{ => nxp}/amphion/Makefile      | 0
 drivers/media/platform/{ => nxp}/amphion/vdec.c        | 0
 drivers/media/platform/{ => nxp}/amphion/venc.c        | 0
 drivers/media/platform/{ => nxp}/amphion/vpu.h         | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_cmds.c    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_cmds.h    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_codec.h   | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_color.c   | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_core.c    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_core.h    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_dbg.c     | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_defs.h    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_drv.c     | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_helpers.c | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_helpers.h | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.c   | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.h   | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_malone.c  | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_malone.h  | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_mbox.c    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_mbox.h    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_msgs.c    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_msgs.h    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_rpc.c     | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_rpc.h     | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.c    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.h    | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_windsor.c | 0
 drivers/media/platform/{ => nxp}/amphion/vpu_windsor.h | 0
 33 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => nxp}/amphion/Kconfig (100%)
 rename drivers/media/platform/{ => nxp}/amphion/Makefile (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vdec.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/venc.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_cmds.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_cmds.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_codec.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_color.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_core.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_core.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_dbg.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_defs.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_drv.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_helpers.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_helpers.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_malone.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_malone.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_mbox.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_mbox.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_msgs.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_msgs.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_rpc.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_rpc.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.h (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_windsor.c (100%)
 rename drivers/media/platform/{ => nxp}/amphion/vpu_windsor.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9333d46047e..74901acf8f06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1037,7 +1037,7 @@ M:	Zhou Peng <eagle.zhou@nxp.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
-F:	drivers/media/platform/amphion/
+F:	drivers/media/platform/nxp/amphion/
 
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 13d8f3e59116..7b88ef15f8c8 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -69,7 +69,6 @@ source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/allwinner/Kconfig"
 source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
-source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
@@ -85,6 +84,7 @@ source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
 source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
+source "drivers/media/platform/nxp/amphion/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index ce9909534218..7a28b60dbbe6 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -9,7 +9,6 @@ obj-y += allegro-dvt/
 obj-y += allwinner/
 obj-y += am437x/
 obj-y += amlogic/meson-ge2d/
-obj-y += amphion/
 obj-y += aspeed/
 obj-y += atmel/
 obj-y += cadence/
@@ -25,6 +24,7 @@ obj-y += mediatek/mtk-vcodec/
 obj-y += mediatek/mtk-vpu/
 obj-y += nvidia/tegra-vde/
 obj-y += nxp/
+obj-y += nxp/amphion/
 obj-y += omap/
 obj-y += omap3isp/
 obj-y += qcom/camss/
diff --git a/drivers/media/platform/amphion/Kconfig b/drivers/media/platform/nxp/amphion/Kconfig
similarity index 100%
rename from drivers/media/platform/amphion/Kconfig
rename to drivers/media/platform/nxp/amphion/Kconfig
diff --git a/drivers/media/platform/amphion/Makefile b/drivers/media/platform/nxp/amphion/Makefile
similarity index 100%
rename from drivers/media/platform/amphion/Makefile
rename to drivers/media/platform/nxp/amphion/Makefile
diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/nxp/amphion/vdec.c
similarity index 100%
rename from drivers/media/platform/amphion/vdec.c
rename to drivers/media/platform/nxp/amphion/vdec.c
diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/nxp/amphion/venc.c
similarity index 100%
rename from drivers/media/platform/amphion/venc.c
rename to drivers/media/platform/nxp/amphion/venc.c
diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/nxp/amphion/vpu.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu.h
rename to drivers/media/platform/nxp/amphion/vpu.h
diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/nxp/amphion/vpu_cmds.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_cmds.c
rename to drivers/media/platform/nxp/amphion/vpu_cmds.c
diff --git a/drivers/media/platform/amphion/vpu_cmds.h b/drivers/media/platform/nxp/amphion/vpu_cmds.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_cmds.h
rename to drivers/media/platform/nxp/amphion/vpu_cmds.h
diff --git a/drivers/media/platform/amphion/vpu_codec.h b/drivers/media/platform/nxp/amphion/vpu_codec.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_codec.h
rename to drivers/media/platform/nxp/amphion/vpu_codec.h
diff --git a/drivers/media/platform/amphion/vpu_color.c b/drivers/media/platform/nxp/amphion/vpu_color.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_color.c
rename to drivers/media/platform/nxp/amphion/vpu_color.c
diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/nxp/amphion/vpu_core.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_core.c
rename to drivers/media/platform/nxp/amphion/vpu_core.c
diff --git a/drivers/media/platform/amphion/vpu_core.h b/drivers/media/platform/nxp/amphion/vpu_core.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_core.h
rename to drivers/media/platform/nxp/amphion/vpu_core.h
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/nxp/amphion/vpu_dbg.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_dbg.c
rename to drivers/media/platform/nxp/amphion/vpu_dbg.c
diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/nxp/amphion/vpu_defs.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_defs.h
rename to drivers/media/platform/nxp/amphion/vpu_defs.h
diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/nxp/amphion/vpu_drv.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_drv.c
rename to drivers/media/platform/nxp/amphion/vpu_drv.c
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/nxp/amphion/vpu_helpers.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_helpers.c
rename to drivers/media/platform/nxp/amphion/vpu_helpers.c
diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/nxp/amphion/vpu_helpers.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_helpers.h
rename to drivers/media/platform/nxp/amphion/vpu_helpers.h
diff --git a/drivers/media/platform/amphion/vpu_imx8q.c b/drivers/media/platform/nxp/amphion/vpu_imx8q.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_imx8q.c
rename to drivers/media/platform/nxp/amphion/vpu_imx8q.c
diff --git a/drivers/media/platform/amphion/vpu_imx8q.h b/drivers/media/platform/nxp/amphion/vpu_imx8q.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_imx8q.h
rename to drivers/media/platform/nxp/amphion/vpu_imx8q.h
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/nxp/amphion/vpu_malone.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_malone.c
rename to drivers/media/platform/nxp/amphion/vpu_malone.c
diff --git a/drivers/media/platform/amphion/vpu_malone.h b/drivers/media/platform/nxp/amphion/vpu_malone.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_malone.h
rename to drivers/media/platform/nxp/amphion/vpu_malone.h
diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/platform/nxp/amphion/vpu_mbox.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_mbox.c
rename to drivers/media/platform/nxp/amphion/vpu_mbox.c
diff --git a/drivers/media/platform/amphion/vpu_mbox.h b/drivers/media/platform/nxp/amphion/vpu_mbox.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_mbox.h
rename to drivers/media/platform/nxp/amphion/vpu_mbox.h
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/nxp/amphion/vpu_msgs.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_msgs.c
rename to drivers/media/platform/nxp/amphion/vpu_msgs.c
diff --git a/drivers/media/platform/amphion/vpu_msgs.h b/drivers/media/platform/nxp/amphion/vpu_msgs.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_msgs.h
rename to drivers/media/platform/nxp/amphion/vpu_msgs.h
diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/nxp/amphion/vpu_rpc.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_rpc.c
rename to drivers/media/platform/nxp/amphion/vpu_rpc.c
diff --git a/drivers/media/platform/amphion/vpu_rpc.h b/drivers/media/platform/nxp/amphion/vpu_rpc.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_rpc.h
rename to drivers/media/platform/nxp/amphion/vpu_rpc.h
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/nxp/amphion/vpu_v4l2.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_v4l2.c
rename to drivers/media/platform/nxp/amphion/vpu_v4l2.c
diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/nxp/amphion/vpu_v4l2.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_v4l2.h
rename to drivers/media/platform/nxp/amphion/vpu_v4l2.h
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/nxp/amphion/vpu_windsor.c
similarity index 100%
rename from drivers/media/platform/amphion/vpu_windsor.c
rename to drivers/media/platform/nxp/amphion/vpu_windsor.c
diff --git a/drivers/media/platform/amphion/vpu_windsor.h b/drivers/media/platform/nxp/amphion/vpu_windsor.h
similarity index 100%
rename from drivers/media/platform/amphion/vpu_windsor.h
rename to drivers/media/platform/nxp/amphion/vpu_windsor.h
-- 
2.35.1

