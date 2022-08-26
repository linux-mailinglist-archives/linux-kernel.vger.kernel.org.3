Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D932C5A2EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbiHZSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbiHZSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:34:33 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E6E68E7;
        Fri, 26 Aug 2022 11:33:49 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D652AFF806;
        Fri, 26 Aug 2022 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUOeK8NRqYGWG1WB+kPp8ElVE/Y8mU4DpqbqQ8VMyDA=;
        b=eH4Cdq8hwKAta+F76Hzj8gliyUVh1TeQq9brQOWrKXR781WAQO3v5Hcm3W6NqRBW05WNgH
        +kRrVB0HYjRD3lpr7R/izR+Q6IYrbqZUj40JGnI3C/fmcVc0PzmIz7tC1TvBgeayIvLgRb
        onFMvIYfCHD0/Cwqe3nDN2HMBFODShljoL0LXp95hQUdkyrLM0S+1OqOhiv8vveZUjencc
        3kc0usToRn7ta8spuMZivpiRCnmxgjwygsiQwB1pRInLdmETQF3PVwMVi/BwDHAI/f74Lc
        7AtmlpqlIA3NEGTuq2coKLNipH/pGc5d/p99R38hmIEywbu3+QnU+Ktr0P4zQg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 38/43] media: sun6i-csi: Cleanup headers and includes, update copyright lines
Date:   Fri, 26 Aug 2022 20:32:35 +0200
Message-Id: <20220826183240.604834-39-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup includes, update copyright lines and some cosmetic changes.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 15 +++++--------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 10 ++++-----
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  4 ++--
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       | 22 ++++++++++++++-----
 .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  9 ++++----
 5 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 75d9f7edf828..eaf62cab0b64 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -1,18 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
- * All rights reserved.
  * Author: Yong Deng <yong.deng@magewell.com>
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
 #include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/ioctl.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -20,12 +16,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
-#include <linux/sched.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
+#include <media/v4l2-device.h>
 #include <media/v4l2-mc.h>
 
 #include "sun6i_csi.h"
+#include "sun6i_csi_bridge.h"
+#include "sun6i_csi_capture.h"
 #include "sun6i_csi_reg.h"
 
 /* Media */
@@ -375,4 +371,5 @@ module_platform_driver(sun6i_csi_platform_driver);
 
 MODULE_DESCRIPTION("Allwinner A31 Camera Sensor Interface driver");
 MODULE_AUTHOR("Yong Deng <yong.deng@magewell.com>");
+MODULE_AUTHOR("Paul Kocialkowski <paul.kocialkowski@bootlin.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index e3f9c49bb829..fd6e98b66f12 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -1,15 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
- * All rights reserved.
  * Author: Yong Deng <yong.deng@magewell.com>
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#ifndef __SUN6I_CSI_H__
-#define __SUN6I_CSI_H__
+#ifndef _SUN6I_CSI_H_
+#define _SUN6I_CSI_H_
 
 #include <media/v4l2-device.h>
-#include <media/v4l2-fwnode.h>
 #include <media/videobuf2-v4l2.h>
 
 #include "sun6i_csi_bridge.h"
@@ -49,4 +49,4 @@ struct sun6i_csi_variant {
 	unsigned long	clock_mod_rate;
 };
 
-#endif /* __SUN6I_CSI_H__ */
+#endif
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index e5ebe7a50c6f..36ddc190a919 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
- * All rights reserved.
  * Author: Yong Deng <yong.deng@magewell.com>
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
 #include <linux/of.h>
 #include <linux/regmap.h>
-
 #include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-ioctl.h>
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 59c57bcefeec..ceceb030aef6 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -1,15 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
- * All rights reserved.
  * Author: Yong Deng <yong.deng@magewell.com>
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#ifndef __SUN6I_CAPTURE_H__
-#define __SUN6I_CAPTURE_H__
+#ifndef _SUN6I_CAPTURE_H_
+#define _SUN6I_CAPTURE_H_
 
-#include <media/v4l2-dev.h>
-#include <media/videobuf2-core.h>
+#include <media/v4l2-device.h>
 
 #define SUN6I_CSI_CAPTURE_NAME	"sun6i-csi-capture"
 
@@ -57,21 +57,31 @@ struct sun6i_csi_capture {
 	struct v4l2_format		format;
 };
 
+/* Helpers */
+
 void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
 				  unsigned int *width, unsigned int *height);
 void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
 			      u32 *pixelformat, u32 *field);
 
+/* Format */
+
 const
 struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat);
 
+/* Capture */
+
 void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_state_update(struct sun6i_csi_device *csi_dev);
 
+/* State */
+
 void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
 
+/* Capture */
+
 int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev);
 
-#endif /* __SUN6I_CAPTURE_H__ */
+#endif
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
index 1e4a07f26d1d..e01c5b9c2d60 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
@@ -1,12 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
- * All rights reserved.
  * Author: Yong Deng <yong.deng@magewell.com>
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
  */
 
-#ifndef __SUN6I_CSI_REG_H__
-#define __SUN6I_CSI_REG_H__
+#ifndef _SUN6I_CSI_REG_H_
+#define _SUN6I_CSI_REG_H_
 
 #include <linux/kernel.h>
 
@@ -180,4 +181,4 @@
 #define SUN6I_CSI_CH_FIFO_STAT_REG		0x98
 #define SUN6I_CSI_CH_PCLK_STAT_REG		0x9c
 
-#endif /* __SUN6I_CSI_REG_H__ */
+#endif
-- 
2.37.1

