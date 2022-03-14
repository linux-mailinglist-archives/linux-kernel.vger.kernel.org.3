Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6D4D89E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244222AbiCNQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371120F4C;
        Mon, 14 Mar 2022 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 565F26146E;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E73C36B01;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=T57cdHFeL3LWNWdKjdqbrP5DRLKf48B5lP10MQxta4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P38JNHCw6/RaFpUjGAL9tSukthJRgzQU8X9RqyE2gb1ZQQRJtOFty7ALkniON6qjq
         GdXL6cdObfI5sETUqSmLineXp149mJK8kDCkgFgBS5EWaJ8xUT18ki5993TU3NS1/p
         dwXQHBZ/xt/ahdZ0/muKO0PW+XqEZ2AYZF7ufz86UgLtwckav8hbIKwHynT0CHxIgH
         KQPoE38ZbYEQ6pykfaXp7/mX/SJun09ALdAHCJZZ5VLLuWO6SpucbOX36FeJcLWw9w
         X3ZOFaD0ztXxMe4r8V4zAQquqslAYNOQHJBOkBf28jxcmZ5xK+N/LAObqzY5RB2U8y
         5DMJeMI2W4eQQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wzE-Py; Mon, 14 Mar 2022 17:35:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 48/67] media: platform: rename tegra/vde/ to nvidia/tegra-vde/
Date:   Mon, 14 Mar 2022 17:34:43 +0100
Message-Id: <da4cde4f2787b70d3425e5e43464eac38fc3c1bf.1647274407.git.mchehab@kernel.org>
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
rename tegra/vde/ to nvidia/tegra-vde/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                                    | 2 +-
 drivers/media/platform/Kconfig                                 | 2 +-
 drivers/media/platform/Makefile                                | 2 +-
 drivers/media/platform/nvidia/Makefile                         | 3 +++
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/Kconfig | 0
 .../media/platform/{tegra/vde => nvidia/tegra-vde}/Makefile    | 0
 .../platform/{tegra/vde => nvidia/tegra-vde}/dmabuf-cache.c    | 0
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/h264.c  | 0
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/iommu.c | 0
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/trace.h | 2 +-
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/v4l2.c  | 0
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/vde.c   | 0
 drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/vde.h   | 0
 13 files changed, 7 insertions(+), 4 deletions(-)
 create mode 100644 drivers/media/platform/nvidia/Makefile
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/Kconfig (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/Makefile (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/dmabuf-cache.c (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/h264.c (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/iommu.c (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/trace.h (97%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/v4l2.c (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/vde.c (100%)
 rename drivers/media/platform/{tegra/vde => nvidia/tegra-vde}/vde.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f29195850c16..c9333d46047e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11964,7 +11964,7 @@ L:	linux-tegra@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
-F:	drivers/media/platform/tegra/vde/
+F:	drivers/media/platform/nvidia/tegra-vde/
 
 MEDIA DRIVERS FOR RENESAS - CEU
 M:	Jacopo Mondi <jacopo@jmondi.org>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 61240f8226bb..13d8f3e59116 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -83,6 +83,7 @@ source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mediatek/mtk-mdp/Kconfig"
 source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
+source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
@@ -95,7 +96,6 @@ source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/s5p-mfc/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
-source "drivers/media/platform/tegra/vde/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 88519e902919..ce9909534218 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -23,6 +23,7 @@ obj-y += mediatek/mtk-jpeg/
 obj-y += mediatek/mtk-mdp/
 obj-y += mediatek/mtk-vcodec/
 obj-y += mediatek/mtk-vpu/
+obj-y += nvidia/tegra-vde/
 obj-y += nxp/
 obj-y += omap/
 obj-y += omap3isp/
@@ -40,7 +41,6 @@ obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
 obj-y += sti/hva/
 obj-y += stm32/
-obj-y += tegra/vde/
 obj-y += ti-vpe/
 obj-y += via/
 obj-y += xilinx/
diff --git a/drivers/media/platform/nvidia/Makefile b/drivers/media/platform/nvidia/Makefile
new file mode 100644
index 000000000000..428415ff83de
--- /dev/null
+++ b/drivers/media/platform/nvidia/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += tegra-vde/
diff --git a/drivers/media/platform/tegra/vde/Kconfig b/drivers/media/platform/nvidia/tegra-vde/Kconfig
similarity index 100%
rename from drivers/media/platform/tegra/vde/Kconfig
rename to drivers/media/platform/nvidia/tegra-vde/Kconfig
diff --git a/drivers/media/platform/tegra/vde/Makefile b/drivers/media/platform/nvidia/tegra-vde/Makefile
similarity index 100%
rename from drivers/media/platform/tegra/vde/Makefile
rename to drivers/media/platform/nvidia/tegra-vde/Makefile
diff --git a/drivers/media/platform/tegra/vde/dmabuf-cache.c b/drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
similarity index 100%
rename from drivers/media/platform/tegra/vde/dmabuf-cache.c
rename to drivers/media/platform/nvidia/tegra-vde/dmabuf-cache.c
diff --git a/drivers/media/platform/tegra/vde/h264.c b/drivers/media/platform/nvidia/tegra-vde/h264.c
similarity index 100%
rename from drivers/media/platform/tegra/vde/h264.c
rename to drivers/media/platform/nvidia/tegra-vde/h264.c
diff --git a/drivers/media/platform/tegra/vde/iommu.c b/drivers/media/platform/nvidia/tegra-vde/iommu.c
similarity index 100%
rename from drivers/media/platform/tegra/vde/iommu.c
rename to drivers/media/platform/nvidia/tegra-vde/iommu.c
diff --git a/drivers/media/platform/tegra/vde/trace.h b/drivers/media/platform/nvidia/tegra-vde/trace.h
similarity index 97%
rename from drivers/media/platform/tegra/vde/trace.h
rename to drivers/media/platform/nvidia/tegra-vde/trace.h
index 77358ddfdb8f..7853ab095ca4 100644
--- a/drivers/media/platform/tegra/vde/trace.h
+++ b/drivers/media/platform/nvidia/tegra-vde/trace.h
@@ -90,6 +90,6 @@ TRACE_EVENT(vde_ref_l1,
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../drivers/media/platform/tegra/vde
+#define TRACE_INCLUDE_PATH ../../drivers/media/platform/nvidia/tegra-vde
 #define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
diff --git a/drivers/media/platform/tegra/vde/v4l2.c b/drivers/media/platform/nvidia/tegra-vde/v4l2.c
similarity index 100%
rename from drivers/media/platform/tegra/vde/v4l2.c
rename to drivers/media/platform/nvidia/tegra-vde/v4l2.c
diff --git a/drivers/media/platform/tegra/vde/vde.c b/drivers/media/platform/nvidia/tegra-vde/vde.c
similarity index 100%
rename from drivers/media/platform/tegra/vde/vde.c
rename to drivers/media/platform/nvidia/tegra-vde/vde.c
diff --git a/drivers/media/platform/tegra/vde/vde.h b/drivers/media/platform/nvidia/tegra-vde/vde.h
similarity index 100%
rename from drivers/media/platform/tegra/vde/vde.h
rename to drivers/media/platform/nvidia/tegra-vde/vde.h
-- 
2.35.1

