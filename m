Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FEF4D7494
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiCMKzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiCMKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D91220C5;
        Sun, 13 Mar 2022 03:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4045461031;
        Sun, 13 Mar 2022 10:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC304C3410D;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168730;
        bh=dy0YDtB1eEq6JOMk5LjTV+xg4fZL4Zdbgg2XBEFQKJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2sMLhUQshH6DPmjDGfHuzcOnsXaVzoi20Cw/58PiZWiO6TUSXgIAbmJjLZeDp2Q/
         S8oXut3j+gGNhvK4JVQX1L0EMu0QdSwGvWVMcRSzfwTTDt0WtIFiPrbiX+4kwPWVLC
         2WOAuQCBALnsz85rbh9HOkTwWniUR8sXN3AdF3h8/w/v3CEiV1xSsd0g5D9x/624p9
         Syw4215D1ft2mFoPtSf2TgGz9L/UER6O61yRfS5omZ1ng6LYzeqp9BAISw1I5w9ebi
         Q4IDVgowUCuShMTKReyWTzAEh6WwCaCIOsJAWqvxAYbSa4kp0v4lEsLdCkDnRTSrbh
         k5uAT86lO8ILw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I2G-Gd; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Herman <yanshuaijun@yulong.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Ming Qian <ming.qian@nxp.com>,
        Nadezda Lutovinova <lutovinova@ispras.ru>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tuo Li <islituo@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 16/24] media: platform: rename s5p-mfc/ to samsung/s5p-mfc/
Date:   Sun, 13 Mar 2022 11:51:57 +0100
Message-Id: <bbf0fc03c1c4742979add3ca26da87f2c066bbed.1647167750.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647167750.git.mchehab@kernel.org>
References: <cover.1647167750.git.mchehab@kernel.org>
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
rename s5p-mfc/ to samsung/s5p-mfc/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 MAINTAINERS                                                   | 2 +-
 drivers/media/platform/Kconfig                                | 2 +-
 drivers/media/platform/Makefile                               | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/Kconfig          | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/Makefile         | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v10.h   | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v6.h    | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v7.h    | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v8.h    | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc.h       | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc.c        | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd.c    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd.h    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v5.c | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v5.h | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v6.c | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v6.h | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_common.h | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_ctrl.c   | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_ctrl.h   | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_debug.h  | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_dec.c    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_dec.h    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_enc.c    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_enc.h    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_intr.c   | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_intr.h   | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_iommu.h  | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr.c    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr.h    | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v5.c | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v5.h | 0
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v6.c | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v6.h | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_pm.c     | 2 +-
 drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_pm.h     | 2 +-
 36 files changed, 22 insertions(+), 22 deletions(-)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/Kconfig (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/Makefile (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v10.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v6.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v7.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc-v8.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/regs-mfc.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd.c (89%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd.h (92%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v5.c (98%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v5.h (82%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v6.c (98%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_cmd_v6.h (82%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_common.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_ctrl.c (99%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_ctrl.h (92%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_debug.h (95%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_dec.c (99%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_dec.h (90%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_enc.c (99%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_enc.h (90%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_intr.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_intr.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_iommu.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr.c (98%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr.h (99%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v5.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v5.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v6.c (99%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_opr_v6.h (96%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_pm.c (97%)
 rename drivers/media/platform/{ => samsung}/s5p-mfc/s5p_mfc_pm.h (87%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfd490369d48..7711a5ea125e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2641,7 +2641,7 @@ M:	Andrzej Hajda <andrzej.hajda@intel.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	drivers/media/platform/s5p-mfc/
+F:	drivers/media/platform/samsung/s5p-mfc/
 
 ARM/SHMOBILE ARM ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0af01626c008..c3594807f8d7 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -88,12 +88,12 @@ source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
-source "drivers/media/platform/s5p-mfc/Kconfig"
 source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
 source "drivers/media/platform/samsung/exynos4-is/Kconfig"
 source "drivers/media/platform/samsung/s3c-camif/Kconfig"
 source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
 source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
+source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 94bdd5d94bb2..6a766acfbe37 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -30,12 +30,12 @@ obj-y += qcom/venus/
 obj-y += renesas/
 obj-y += rockchip/rga/
 obj-y += rockchip/rkisp1/
-obj-y += s5p-mfc/
 obj-y += samsung/exynos-gsc/
 obj-y += samsung/exynos4-is/
 obj-y += samsung/s3c-camif/
 obj-y += samsung/s5p-g2d/
 obj-y += samsung/s5p-jpeg/
+obj-y += samsung/s5p-mfc/
 obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
diff --git a/drivers/media/platform/s5p-mfc/Kconfig b/drivers/media/platform/samsung/s5p-mfc/Kconfig
similarity index 100%
rename from drivers/media/platform/s5p-mfc/Kconfig
rename to drivers/media/platform/samsung/s5p-mfc/Kconfig
diff --git a/drivers/media/platform/s5p-mfc/Makefile b/drivers/media/platform/samsung/s5p-mfc/Makefile
similarity index 100%
rename from drivers/media/platform/s5p-mfc/Makefile
rename to drivers/media/platform/samsung/s5p-mfc/Makefile
diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v10.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v10.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/regs-mfc-v10.h
rename to drivers/media/platform/samsung/s5p-mfc/regs-mfc-v10.h
diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v6.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v6.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/regs-mfc-v6.h
rename to drivers/media/platform/samsung/s5p-mfc/regs-mfc-v6.h
diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v7.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/regs-mfc-v7.h
rename to drivers/media/platform/samsung/s5p-mfc/regs-mfc-v7.h
diff --git a/drivers/media/platform/s5p-mfc/regs-mfc-v8.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/regs-mfc-v8.h
rename to drivers/media/platform/samsung/s5p-mfc/regs-mfc-v8.h
diff --git a/drivers/media/platform/s5p-mfc/regs-mfc.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/regs-mfc.h
rename to drivers/media/platform/samsung/s5p-mfc/regs-mfc.h
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
similarity index 89%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_cmd.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
index 0e88c28f4ad3..774c573dc075 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_cmd.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.c
  *
  * Copyright (C) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
similarity index 92%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_cmd.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
index ed4e32a12552..945d12fdceb7 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_cmd.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
  *
  * Copyright (C) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
similarity index 98%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
index 1ea4eda9c8e0..327e54e70611 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
similarity index 82%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
index 917854bffe9f..6eafa514aebc 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v5.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
similarity index 98%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index 1f42130cc865..f8588e52dfc8 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
similarity index 82%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
index c19884ea2bfc..9dc44460cc38 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_cmd_v6.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_common.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
similarity index 99%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index da138c314963..72d70984e99a 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.h
similarity index 92%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.h
index 7f32ef8a6b61..653ba5f3d048 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_ctrl.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.h
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_debug.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_debug.h
similarity index 95%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_debug.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_debug.h
index 752bbe4fe48e..bba5dad6dbff 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_debug.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_debug.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * drivers/media/platform/s5p-mfc/s5p_mfc_debug.h
+ * drivers/media/platform/samsung/s5p-mfc/s5p_mfc_debug.h
  *
  * Header file for Samsung MFC (Multi Function Codec - FIMV) driver
  * This file contains debug macros
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
similarity index 99%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index c0798811755c..4b89df8bfd18 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
similarity index 90%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_dec.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
index 0e9a0e3bbbe7..0c52ab46cff7 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_dec.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.h
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
similarity index 99%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 1fad99edb091..a8877d805b29 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_enc.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
  *
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
similarity index 90%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_enc.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
index cacd1ca43e19..3f1b1a037a4f 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_enc.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.h
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_intr.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_intr.c
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_intr.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_intr.c
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_intr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_intr.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_intr.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_intr.h
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_iommu.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_iommu.h
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
similarity index 98%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
index bb65671eea91..673962301173 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * drivers/media/platform/s5p-mfc/s5p_mfc_opr.c
+ * drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.c
  *
  * Samsung MFC (Multi Function Codec - FIMV) driver
  * This file contains hw related functions.
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
similarity index 99%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_opr.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
index 1c5d2d4c0543..b9831275f3ab 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * drivers/media/platform/s5p-mfc/s5p_mfc_opr.h
+ * drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
  *
  * Header file for Samsung MFC (Multi Function Codec - FIMV) driver
  * Contains declarations of hw related functions.
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.c
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.h
similarity index 100%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_opr_v5.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v5.h
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
similarity index 99%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index a1453053e31a..8227004f6746 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.c
+ * drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
  *
  * Samsung MFC (Multi Function Codec - FIMV) driver
  * This file contains hw related functions.
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
similarity index 96%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index 8ca514bf5e37..e4dd03c5454c 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * drivers/media/platform/s5p-mfc/s5p_mfc_opr_v6.h
+ * drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
  *
  * Header file for Samsung MFC (Multi Function Codec - FIMV) driver
  * Contains declarations of hw related functions.
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
similarity index 97%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
index 88b7d33c9197..72a901e99450 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c
  *
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
similarity index 87%
rename from drivers/media/platform/s5p-mfc/s5p_mfc_pm.h
rename to drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
index 3d26443189a2..4159d2364e87 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * linux/drivers/media/platform/s5p-mfc/s5p_mfc_pm.h
+ * linux/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.h
  *
  * Copyright (C) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
-- 
2.35.1

