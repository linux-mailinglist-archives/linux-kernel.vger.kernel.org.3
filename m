Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CB4D8A12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiCNQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239619AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889182E686;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1A5361480;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49363C340F6;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=cT/vXjenoBPKI/Hl1lNbu660CQn8eXNAAX/gaT9yC74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHi9+mkgDAuaWVinfOr+4m5XVpkyvxoH705k6fsi66/AkAKSo+ZsfTR+xQ+zLQO8K
         74VEfdi7VZR+FWa30hd5JX/cI+uuvWdxkDFQIq+qHy8kiuhLfYZj4IPjbBADk09K2Q
         m20sucw27q/KCk2a8eWrG3DKHQVPReRgoh7mtruMY0xz4gAs9eTzhl+z5ykWYmkmCq
         bzhVn+/fRz1vH8m7B4ocP6awJLywC/5i4PjGNDir+xrzt8wDk8dBv9txIqBPdm9p7q
         9ZsA7GMwtFaE8M/tpWkkqY4m5MfsNhL5SM/UUjxKjbHgUdTMfU8yMnLSpp+U2z0HNH
         ATZem0Z18WA9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001wzY-2L; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 53/67] media: platform: rename s5p-jpeg/ to samsung/s5p-jpeg/
Date:   Mon, 14 Mar 2022 17:34:48 +0100
Message-Id: <4242d32300816e24c5990245b2950a5f058d61ab.1647274407.git.mchehab@kernel.org>
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

As the end goal is to have platform drivers split by vendor,
rename s5p-jpeg/ to samsung/s5p-jpeg/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                                     | 2 +-
 drivers/media/platform/Kconfig                                  | 2 +-
 drivers/media/platform/Makefile                                 | 2 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                  | 2 +-
 drivers/media/platform/renesas/rcar_jpu.c                       | 2 +-
 drivers/media/platform/{ => samsung}/s5p-jpeg/Kconfig           | 0
 drivers/media/platform/{ => samsung}/s5p-jpeg/Makefile          | 0
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.c       | 2 +-
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.h       | 2 +-
 .../media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.c  | 0
 .../media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.h  | 2 +-
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.c | 0
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.h | 0
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.c     | 2 +-
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.h     | 2 +-
 drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-regs.h       | 2 +-
 16 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/Kconfig (100%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/Makefile (100%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.c (99%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.h (99%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.h (97%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.c (100%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.h (100%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.c (99%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.h (97%)
 rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-regs.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b03db9ee31e..e01013c68fc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2633,7 +2633,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	drivers/media/platform/s5p-jpeg/
+F:	drivers/media/platform/samsung/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 8dd178e1a359..df67690c8f3a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -88,12 +88,12 @@ source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
-source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/s5p-mfc/Kconfig"
 source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
 source "drivers/media/platform/samsung/exynos4-is/Kconfig"
 source "drivers/media/platform/samsung/s3c-camif/Kconfig"
 source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
+source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index aa822365d8d0..9c6c272797cd 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -30,12 +30,12 @@ obj-y += qcom/venus/
 obj-y += renesas/
 obj-y += rockchip/rga/
 obj-y += rockchip/rkisp1/
-obj-y += s5p-jpeg/
 obj-y += s5p-mfc/
 obj-y += samsung/exynos-gsc/
 obj-y += samsung/exynos4-is/
 obj-y += samsung/s3c-camif/
 obj-y += samsung/s5p-g2d/
+obj-y += samsung/s5p-jpeg/
 obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 3b892c5792b4..d1ec1f4b506b 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -35,7 +35,7 @@
  * it, enable dynamic debug for this module and:
  * echo 1 > /sys/module/mxc_jpeg_encdec/parameters/jpeg_tracing
  *
- * This is inspired by the drivers/media/platform/s5p-jpeg driver
+ * This is inspired by the drivers/media/platform/samsung/s5p-jpeg driver
  *
  * Copyright 2018-2019 NXP
  */
diff --git a/drivers/media/platform/renesas/rcar_jpu.c b/drivers/media/platform/renesas/rcar_jpu.c
index 56bb464629ed..293beba131e2 100644
--- a/drivers/media/platform/renesas/rcar_jpu.c
+++ b/drivers/media/platform/renesas/rcar_jpu.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2014-2015 Cogent Embedded, Inc.  <source@cogentembedded.com>
  * Copyright (C) 2014-2015 Renesas Electronics Corporation
  *
- * This is based on the drivers/media/platform/s5p-jpeg driver by
+ * This is based on the drivers/media/platform/samsung/s5p-jpeg driver by
  * Andrzej Pietrasiewicz and Jacek Anaszewski.
  * Some portions of code inspired by VSP1 driver by Laurent Pinchart.
  *
diff --git a/drivers/media/platform/s5p-jpeg/Kconfig b/drivers/media/platform/samsung/s5p-jpeg/Kconfig
similarity index 100%
rename from drivers/media/platform/s5p-jpeg/Kconfig
rename to drivers/media/platform/samsung/s5p-jpeg/Kconfig
diff --git a/drivers/media/platform/s5p-jpeg/Makefile b/drivers/media/platform/samsung/s5p-jpeg/Makefile
similarity index 100%
rename from drivers/media/platform/s5p-jpeg/Makefile
rename to drivers/media/platform/samsung/s5p-jpeg/Makefile
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
similarity index 99%
rename from drivers/media/platform/s5p-jpeg/jpeg-core.c
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
index a8d9159d5ed8..5479bc8d474d 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* linux/drivers/media/platform/s5p-jpeg/jpeg-core.c
+/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
  *
  * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
similarity index 99%
rename from drivers/media/platform/s5p-jpeg/jpeg-core.h
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
index 4a5fb1b15455..5570c79f122f 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-core.h
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* linux/drivers/media/platform/s5p-jpeg/jpeg-core.h
+/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.c
similarity index 100%
rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.c
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.c
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
similarity index 97%
rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
index 68160befce39..15af928fad76 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* linux/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h
+/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.c
similarity index 100%
rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.c
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.h
similarity index 100%
rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.h
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
similarity index 99%
rename from drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.c
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
index 491e9248286c..01b47b3df1e7 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.c
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* linux/drivers/media/platform/s5p-jpeg/jpeg-hw.h
+/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw.h
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.h
similarity index 97%
rename from drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.h
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.h
index 98ddf7097562..f068d52c66b7 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.h
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* linux/drivers/media/platform/s5p-jpeg/jpeg-hw.h
+/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw.h
  *
  * Copyright (c) 2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/drivers/media/platform/s5p-jpeg/jpeg-regs.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
similarity index 99%
rename from drivers/media/platform/s5p-jpeg/jpeg-regs.h
rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
index 86f376b50581..c2298b680022 100644
--- a/drivers/media/platform/s5p-jpeg/jpeg-regs.h
+++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/* linux/drivers/media/platform/s5p-jpeg/jpeg-regs.h
+/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
  *
  * Register definition file for Samsung JPEG codec driver
  *
-- 
2.35.1

