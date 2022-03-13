Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381B54D74AD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiCMKzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiCMKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964423BCB;
        Sun, 13 Mar 2022 03:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66B4D61037;
        Sun, 13 Mar 2022 10:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2041C34115;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168730;
        bh=xAtCxypNEmLvPO79tMDAEnMLEOhUNBww/nRs40l10rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4DAwjNp/irxZnXQA3xSRVgB5ShsYFm8iCejZnUY+WkquTNx4soBFYWRFLGZAdXpM
         gzYO+ZHv8XXGu24YZ6Zrj+j8RLbQcrrV4sGy1gSx0KaARycf1MeGbzpajZIjT7jBy6
         XUdSFp6LuEPftv5N/95Hf9WifPr/5fvSTQQqse7r54V43jC1KMBEGOfYKN4Yoohjks
         NhKnIZYLQEI55fhiYQYcLjnj5qJ1RH7boMmluXVhF898lUFXCLNnOw4H7DOLaet9l1
         BFXswf7cD+iyvmgS/oxIjSZ8nhwTL+bmtFKlT22d9yMXtvHDZb9sJHIztT1flqF5EE
         kyim/zq+dV6PQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I2W-My; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 20/24] media: platform: rename omap3isp/ to ti/omap3isp/
Date:   Sun, 13 Mar 2022 11:52:01 +0100
Message-Id: <b42734a86452b713fdfd3910160dd342aceff9b8.1647167750.git.mchehab@kernel.org>
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
rename omap3isp/ to ti/omap3isp/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 Documentation/admin-guide/media/omap3isp.rst                  | 2 +-
 Documentation/admin-guide/media/omap4_camera.rst              | 2 +-
 Documentation/driver-api/media/v4l2-event.rst                 | 2 +-
 MAINTAINERS                                                   | 2 +-
 drivers/media/platform/Kconfig                                | 2 +-
 drivers/media/platform/Makefile                               | 2 +-
 drivers/media/platform/{ => ti}/omap3isp/Kconfig              | 0
 drivers/media/platform/{ => ti}/omap3isp/Makefile             | 0
 drivers/media/platform/{ => ti}/omap3isp/cfa_coef_table.h     | 0
 drivers/media/platform/{ => ti}/omap3isp/gamma_table.h        | 0
 drivers/media/platform/{ => ti}/omap3isp/isp.c                | 0
 drivers/media/platform/{ => ti}/omap3isp/isp.h                | 0
 drivers/media/platform/{ => ti}/omap3isp/ispccdc.c            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispccdc.h            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispccp2.c            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispccp2.h            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispcsi2.c            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispcsi2.h            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispcsiphy.c          | 0
 drivers/media/platform/{ => ti}/omap3isp/ispcsiphy.h          | 0
 drivers/media/platform/{ => ti}/omap3isp/isph3a.h             | 0
 drivers/media/platform/{ => ti}/omap3isp/isph3a_aewb.c        | 0
 drivers/media/platform/{ => ti}/omap3isp/isph3a_af.c          | 0
 drivers/media/platform/{ => ti}/omap3isp/isphist.c            | 0
 drivers/media/platform/{ => ti}/omap3isp/isphist.h            | 0
 drivers/media/platform/{ => ti}/omap3isp/isppreview.c         | 0
 drivers/media/platform/{ => ti}/omap3isp/isppreview.h         | 0
 drivers/media/platform/{ => ti}/omap3isp/ispreg.h             | 0
 drivers/media/platform/{ => ti}/omap3isp/ispresizer.c         | 0
 drivers/media/platform/{ => ti}/omap3isp/ispresizer.h         | 0
 drivers/media/platform/{ => ti}/omap3isp/ispstat.c            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispstat.h            | 0
 drivers/media/platform/{ => ti}/omap3isp/ispvideo.c           | 0
 drivers/media/platform/{ => ti}/omap3isp/ispvideo.h           | 0
 drivers/media/platform/{ => ti}/omap3isp/luma_enhance_table.h | 0
 drivers/media/platform/{ => ti}/omap3isp/noise_filter_table.h | 0
 drivers/media/platform/{ => ti}/omap3isp/omap3isp.h           | 0
 37 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/media/platform/{ => ti}/omap3isp/Kconfig (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/Makefile (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/cfa_coef_table.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/gamma_table.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isp.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isp.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispccdc.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispccdc.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispccp2.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispccp2.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispcsi2.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispcsi2.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispcsiphy.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispcsiphy.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isph3a.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isph3a_aewb.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isph3a_af.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isphist.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isphist.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isppreview.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/isppreview.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispreg.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispresizer.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispresizer.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispstat.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispstat.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispvideo.c (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/ispvideo.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/luma_enhance_table.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/noise_filter_table.h (100%)
 rename drivers/media/platform/{ => ti}/omap3isp/omap3isp.h (100%)

diff --git a/Documentation/admin-guide/media/omap3isp.rst b/Documentation/admin-guide/media/omap3isp.rst
index bc447bbec7ce..f32e7375a1a2 100644
--- a/Documentation/admin-guide/media/omap3isp.rst
+++ b/Documentation/admin-guide/media/omap3isp.rst
@@ -17,7 +17,7 @@ Introduction
 ------------
 
 This file documents the Texas Instruments OMAP 3 Image Signal Processor (ISP)
-driver located under drivers/media/platform/omap3isp. The original driver was
+driver located under drivers/media/platform/ti/omap3isp. The original driver was
 written by Texas Instruments but since that it has been rewritten (twice) at
 Nokia.
 
diff --git a/Documentation/admin-guide/media/omap4_camera.rst b/Documentation/admin-guide/media/omap4_camera.rst
index 24db4222d36d..2ada9b1e6897 100644
--- a/Documentation/admin-guide/media/omap4_camera.rst
+++ b/Documentation/admin-guide/media/omap4_camera.rst
@@ -25,7 +25,7 @@ As of Revision AB, the ISS is described in detail in section 8.
 This driver is supporting **only** the CSI2-A/B interfaces for now.
 
 It makes use of the Media Controller framework [#f2]_, and inherited most of the
-code from OMAP3 ISP driver (found under drivers/media/platform/omap3isp/\*),
+code from OMAP3 ISP driver (found under drivers/media/platform/ti/omap3isp/\*),
 except that it doesn't need an IOMMU now for ISS buffers memory mapping.
 
 Supports usage of MMAP buffers only (for now).
diff --git a/Documentation/driver-api/media/v4l2-event.rst b/Documentation/driver-api/media/v4l2-event.rst
index 5b8254eba7da..52d4fbc5d819 100644
--- a/Documentation/driver-api/media/v4l2-event.rst
+++ b/Documentation/driver-api/media/v4l2-event.rst
@@ -167,7 +167,7 @@ The first event type in the class is reserved for future use, so the first
 available event type is 'class base + 1'.
 
 An example on how the V4L2 events may be used can be found in the OMAP
-3 ISP driver (``drivers/media/platform/omap3isp``).
+3 ISP driver (``drivers/media/platform/ti/omap3isp``).
 
 A subdev can directly send an event to the :c:type:`v4l2_device` notify
 function with ``V4L2_DEVICE_NOTIFY_EVENT``. This allows the bridge to map
diff --git a/MAINTAINERS b/MAINTAINERS
index 801391246c87..2a85c98a77e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14094,7 +14094,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/ti,omap3isp.txt
-F:	drivers/media/platform/omap3isp/
+F:	drivers/media/platform/ti/omap3isp/
 F:	drivers/staging/media/omap4iss/
 
 OMAP MMC SUPPORT
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 4d4d8e120731..7763bd455f21 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -82,7 +82,6 @@ source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/nxp/amphion/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
-source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
@@ -97,6 +96,7 @@ source "drivers/media/platform/sti/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/ti/am437x/Kconfig"
 source "drivers/media/platform/ti/davinci/Kconfig"
+source "drivers/media/platform/ti/omap3isp/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 4e063935f061..ef6c00b2ed64 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -22,7 +22,6 @@ obj-y += nvidia/tegra-vde/
 obj-y += nxp/
 obj-y += nxp/amphion/
 obj-y += omap/
-obj-y += omap3isp/
 obj-y += qcom/camss/
 obj-y += qcom/venus/
 obj-y += renesas/
@@ -42,6 +41,7 @@ obj-y += sti/stm32/
 obj-y += ti-vpe/
 obj-y += ti/am437x/
 obj-y += ti/davinci/
+obj-y += ti/omap3isp/
 obj-y += via/
 obj-y += xilinx/
 
diff --git a/drivers/media/platform/omap3isp/Kconfig b/drivers/media/platform/ti/omap3isp/Kconfig
similarity index 100%
rename from drivers/media/platform/omap3isp/Kconfig
rename to drivers/media/platform/ti/omap3isp/Kconfig
diff --git a/drivers/media/platform/omap3isp/Makefile b/drivers/media/platform/ti/omap3isp/Makefile
similarity index 100%
rename from drivers/media/platform/omap3isp/Makefile
rename to drivers/media/platform/ti/omap3isp/Makefile
diff --git a/drivers/media/platform/omap3isp/cfa_coef_table.h b/drivers/media/platform/ti/omap3isp/cfa_coef_table.h
similarity index 100%
rename from drivers/media/platform/omap3isp/cfa_coef_table.h
rename to drivers/media/platform/ti/omap3isp/cfa_coef_table.h
diff --git a/drivers/media/platform/omap3isp/gamma_table.h b/drivers/media/platform/ti/omap3isp/gamma_table.h
similarity index 100%
rename from drivers/media/platform/omap3isp/gamma_table.h
rename to drivers/media/platform/ti/omap3isp/gamma_table.h
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
similarity index 100%
rename from drivers/media/platform/omap3isp/isp.c
rename to drivers/media/platform/ti/omap3isp/isp.c
diff --git a/drivers/media/platform/omap3isp/isp.h b/drivers/media/platform/ti/omap3isp/isp.h
similarity index 100%
rename from drivers/media/platform/omap3isp/isp.h
rename to drivers/media/platform/ti/omap3isp/isp.h
diff --git a/drivers/media/platform/omap3isp/ispccdc.c b/drivers/media/platform/ti/omap3isp/ispccdc.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispccdc.c
rename to drivers/media/platform/ti/omap3isp/ispccdc.c
diff --git a/drivers/media/platform/omap3isp/ispccdc.h b/drivers/media/platform/ti/omap3isp/ispccdc.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispccdc.h
rename to drivers/media/platform/ti/omap3isp/ispccdc.h
diff --git a/drivers/media/platform/omap3isp/ispccp2.c b/drivers/media/platform/ti/omap3isp/ispccp2.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispccp2.c
rename to drivers/media/platform/ti/omap3isp/ispccp2.c
diff --git a/drivers/media/platform/omap3isp/ispccp2.h b/drivers/media/platform/ti/omap3isp/ispccp2.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispccp2.h
rename to drivers/media/platform/ti/omap3isp/ispccp2.h
diff --git a/drivers/media/platform/omap3isp/ispcsi2.c b/drivers/media/platform/ti/omap3isp/ispcsi2.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispcsi2.c
rename to drivers/media/platform/ti/omap3isp/ispcsi2.c
diff --git a/drivers/media/platform/omap3isp/ispcsi2.h b/drivers/media/platform/ti/omap3isp/ispcsi2.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispcsi2.h
rename to drivers/media/platform/ti/omap3isp/ispcsi2.h
diff --git a/drivers/media/platform/omap3isp/ispcsiphy.c b/drivers/media/platform/ti/omap3isp/ispcsiphy.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispcsiphy.c
rename to drivers/media/platform/ti/omap3isp/ispcsiphy.c
diff --git a/drivers/media/platform/omap3isp/ispcsiphy.h b/drivers/media/platform/ti/omap3isp/ispcsiphy.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispcsiphy.h
rename to drivers/media/platform/ti/omap3isp/ispcsiphy.h
diff --git a/drivers/media/platform/omap3isp/isph3a.h b/drivers/media/platform/ti/omap3isp/isph3a.h
similarity index 100%
rename from drivers/media/platform/omap3isp/isph3a.h
rename to drivers/media/platform/ti/omap3isp/isph3a.h
diff --git a/drivers/media/platform/omap3isp/isph3a_aewb.c b/drivers/media/platform/ti/omap3isp/isph3a_aewb.c
similarity index 100%
rename from drivers/media/platform/omap3isp/isph3a_aewb.c
rename to drivers/media/platform/ti/omap3isp/isph3a_aewb.c
diff --git a/drivers/media/platform/omap3isp/isph3a_af.c b/drivers/media/platform/ti/omap3isp/isph3a_af.c
similarity index 100%
rename from drivers/media/platform/omap3isp/isph3a_af.c
rename to drivers/media/platform/ti/omap3isp/isph3a_af.c
diff --git a/drivers/media/platform/omap3isp/isphist.c b/drivers/media/platform/ti/omap3isp/isphist.c
similarity index 100%
rename from drivers/media/platform/omap3isp/isphist.c
rename to drivers/media/platform/ti/omap3isp/isphist.c
diff --git a/drivers/media/platform/omap3isp/isphist.h b/drivers/media/platform/ti/omap3isp/isphist.h
similarity index 100%
rename from drivers/media/platform/omap3isp/isphist.h
rename to drivers/media/platform/ti/omap3isp/isphist.h
diff --git a/drivers/media/platform/omap3isp/isppreview.c b/drivers/media/platform/ti/omap3isp/isppreview.c
similarity index 100%
rename from drivers/media/platform/omap3isp/isppreview.c
rename to drivers/media/platform/ti/omap3isp/isppreview.c
diff --git a/drivers/media/platform/omap3isp/isppreview.h b/drivers/media/platform/ti/omap3isp/isppreview.h
similarity index 100%
rename from drivers/media/platform/omap3isp/isppreview.h
rename to drivers/media/platform/ti/omap3isp/isppreview.h
diff --git a/drivers/media/platform/omap3isp/ispreg.h b/drivers/media/platform/ti/omap3isp/ispreg.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispreg.h
rename to drivers/media/platform/ti/omap3isp/ispreg.h
diff --git a/drivers/media/platform/omap3isp/ispresizer.c b/drivers/media/platform/ti/omap3isp/ispresizer.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispresizer.c
rename to drivers/media/platform/ti/omap3isp/ispresizer.c
diff --git a/drivers/media/platform/omap3isp/ispresizer.h b/drivers/media/platform/ti/omap3isp/ispresizer.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispresizer.h
rename to drivers/media/platform/ti/omap3isp/ispresizer.h
diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/ti/omap3isp/ispstat.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispstat.c
rename to drivers/media/platform/ti/omap3isp/ispstat.c
diff --git a/drivers/media/platform/omap3isp/ispstat.h b/drivers/media/platform/ti/omap3isp/ispstat.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispstat.h
rename to drivers/media/platform/ti/omap3isp/ispstat.h
diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
similarity index 100%
rename from drivers/media/platform/omap3isp/ispvideo.c
rename to drivers/media/platform/ti/omap3isp/ispvideo.c
diff --git a/drivers/media/platform/omap3isp/ispvideo.h b/drivers/media/platform/ti/omap3isp/ispvideo.h
similarity index 100%
rename from drivers/media/platform/omap3isp/ispvideo.h
rename to drivers/media/platform/ti/omap3isp/ispvideo.h
diff --git a/drivers/media/platform/omap3isp/luma_enhance_table.h b/drivers/media/platform/ti/omap3isp/luma_enhance_table.h
similarity index 100%
rename from drivers/media/platform/omap3isp/luma_enhance_table.h
rename to drivers/media/platform/ti/omap3isp/luma_enhance_table.h
diff --git a/drivers/media/platform/omap3isp/noise_filter_table.h b/drivers/media/platform/ti/omap3isp/noise_filter_table.h
similarity index 100%
rename from drivers/media/platform/omap3isp/noise_filter_table.h
rename to drivers/media/platform/ti/omap3isp/noise_filter_table.h
diff --git a/drivers/media/platform/omap3isp/omap3isp.h b/drivers/media/platform/ti/omap3isp/omap3isp.h
similarity index 100%
rename from drivers/media/platform/omap3isp/omap3isp.h
rename to drivers/media/platform/ti/omap3isp/omap3isp.h
-- 
2.35.1

