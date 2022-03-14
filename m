Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE54D7CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiCNIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiCNH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF14161F;
        Mon, 14 Mar 2022 00:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D164611C5;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFF5C36B06;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244562;
        bh=S1VM+oW7wRch+UqYMXOGytVT7MR4fILO5/kTGL/OkT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gULm8d4rxnTObBSGKxu44j/nPccwYXumWmDybuhcsBhvy8zB21W+bLRDm8RE9sTRK
         VJ5XBAzSm0OoyNNoqkdYT6UIGOFNJo/AmPIaHhtvM/BzRsuTWKpI2yuPVPkLLNtvom
         QxwP1jfAqKMbTsvqfhLXwEq6GlqHBFeDVV+nlBoM+4Q4K60uVEigLNzbiHr6HCjcOA
         Hzl0M13SNZJ10FWzrLT1ABzad+tC51GVlNvX8xU3rsX41ZvAgk2DEm4tJCdiwUrtCF
         o9ErVvoqBrfcsBAeFEX7lg7RLn9PXJvbi8iWJcHknNzpVoA5XSFEMWcaFcpVRO/+gp
         XXzE4Ixlhwvmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kWx-2L; Mon, 14 Mar 2022 08:56:00 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Xu Wang <vulab@iscas.ac.cn>, Yong Wu <yong.wu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 43/64] media: platform: rename mtk-jpeg/ to mediatek/mtk-jpeg/
Date:   Mon, 14 Mar 2022 08:55:35 +0100
Message-Id: <6b4d80f28b481bdf9385faeb3bf46f10bc1242cb.1647242579.git.mchehab@kernel.org>
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
rename mtk-jpeg/ to mediatek/mtk-jpeg/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 MAINTAINERS                                                     | 2 +-
 drivers/media/platform/Kconfig                                  | 2 +-
 drivers/media/platform/Makefile                                 | 2 +-
 drivers/media/platform/{ => mediatek}/mtk-jpeg/Kconfig          | 0
 drivers/media/platform/{ => mediatek}/mtk-jpeg/Makefile         | 0
 drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_core.c  | 0
 drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_core.h  | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_hw.c    | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_hw.h    | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_parse.c | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_parse.h | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_reg.h   | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_enc_hw.c    | 0
 .../media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_enc_hw.h    | 0
 14 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/Kconfig (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/Makefile (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_core.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_core.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_hw.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_hw.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_parse.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_parse.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_dec_reg.h (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_enc_hw.c (100%)
 rename drivers/media/platform/{ => mediatek}/mtk-jpeg/mtk_jpeg_enc_hw.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b0e60da4e9..fa0a3de3865f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12130,7 +12130,7 @@ M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
-F:	drivers/media/platform/mtk-jpeg/
+F:	drivers/media/platform/mediatek/mtk-jpeg/
 
 MEDIATEK MDP DRIVER
 M:	Minghsiu Tsai <minghsiu.tsai@mediatek.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index b4faee0a1b63..f1746529e763 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -78,7 +78,7 @@ source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
-source "drivers/media/platform/mtk-jpeg/Kconfig"
+source "drivers/media/platform/mediatek/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 48531f93d92f..c792f6216918 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -18,7 +18,7 @@ obj-y += exynos-gsc/
 obj-y += exynos4-is/
 obj-y += intel/
 obj-y += marvell/
-obj-y += mtk-jpeg/
+obj-y += mediatek/mtk-jpeg/
 obj-y += mtk-mdp/
 obj-y += mtk-vcodec/
 obj-y += mtk-vpu/
diff --git a/drivers/media/platform/mtk-jpeg/Kconfig b/drivers/media/platform/mediatek/mtk-jpeg/Kconfig
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/Kconfig
rename to drivers/media/platform/mediatek/mtk-jpeg/Kconfig
diff --git a/drivers/media/platform/mtk-jpeg/Makefile b/drivers/media/platform/mediatek/mtk-jpeg/Makefile
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/Makefile
rename to drivers/media/platform/mediatek/mtk-jpeg/Makefile
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_core.c
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_core.c
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_core.h
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_core.h
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_hw.c
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.c
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_hw.c
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.h b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_hw.h
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_hw.h
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_hw.h
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_parse.c b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_parse.c
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_parse.c
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_parse.c
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_parse.h b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_parse.h
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_parse.h
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_parse.h
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_reg.h b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_reg.h
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_dec_reg.h
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_dec_reg.h
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_enc_hw.c
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_enc_hw.c
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.h b/drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_enc_hw.h
similarity index 100%
rename from drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.h
rename to drivers/media/platform/mediatek/mtk-jpeg/mtk_jpeg_enc_hw.h
-- 
2.35.1

