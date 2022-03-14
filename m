Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F644D89A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbiCNQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiCNQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E1831DFD;
        Mon, 14 Mar 2022 09:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA5161492;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ACBC36AFA;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=S1QzD54NI2VOy0jZem526Pj8WyLSwsLwdUgiDAJ4r6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjHLfMu8fjOdFswY/IjTSH1Xxr9tTiIabVRfDHSWoSLAzvwgZcZXmq3N5q/ZMZYQj
         G2WwXkBwD3ls73cgfrEBjDa0fByjZEZ4fxK16ZqY48N64rSgW1gQZ3iQUV/VCUgx6u
         SJWsqL7KjuUtRJxf0Kj5tELStzZDA0I3x03sxJr9GDeFv0RDJrvVgNfj1FC+OTtCQd
         lHSjoj/R8hFbuHZgAAcegGt8U8xWZyFWJugwZ7EaREYsTq1/ztmCOhnMV3MO4k4LQG
         ca3NA1jo6s4/dy3RdfzIz1Pq/EBOuhLvf3SbUX8LH/5IlvFJ4ZcFTuPKDOAC0KgV5J
         L1uHgMEvlR5xg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x36-Hl; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 60/67] media: platform: rename omap/ to ti/omap/
Date:   Mon, 14 Mar 2022 17:34:55 +0100
Message-Id: <b01e1edbcf0589d1f3150340db6c2e81d034975a.1647274407.git.mchehab@kernel.org>
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
rename omap/ to ti/omap/.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                        | 2 +-
 drivers/media/platform/Makefile                       | 2 +-
 drivers/media/platform/{ => ti}/omap/Kconfig          | 0
 drivers/media/platform/{ => ti}/omap/Makefile         | 0
 drivers/media/platform/{ => ti}/omap/omap_vout.c      | 0
 drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.c | 0
 drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.h | 0
 drivers/media/platform/{ => ti}/omap/omap_voutdef.h   | 0
 drivers/media/platform/{ => ti}/omap/omap_voutlib.c   | 0
 drivers/media/platform/{ => ti}/omap/omap_voutlib.h   | 0
 10 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/media/platform/{ => ti}/omap/Kconfig (100%)
 rename drivers/media/platform/{ => ti}/omap/Makefile (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_vout.c (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.c (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.h (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_voutdef.h (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_voutlib.c (100%)
 rename drivers/media/platform/{ => ti}/omap/omap_voutlib.h (100%)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 4f95ea9b1221..43a654e87613 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -81,7 +81,6 @@ source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
 source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
-source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/qcom/Kconfig"
 source "drivers/media/platform/renesas/Kconfig"
 source "drivers/media/platform/rockchip/Kconfig"
@@ -96,6 +95,7 @@ source "drivers/media/platform/stm/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/ti/am437x/Kconfig"
 source "drivers/media/platform/ti/davinci/Kconfig"
+source "drivers/media/platform/ti/omap/Kconfig"
 source "drivers/media/platform/ti/omap3isp/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index c2bab3ba9ef6..39fa6aaad13b 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -21,7 +21,6 @@ obj-y += mediatek/mtk-vcodec/
 obj-y += mediatek/mtk-vpu/
 obj-y += nvidia/tegra-vde/
 obj-y += nxp/
-obj-y += omap/
 obj-y += qcom/camss/
 obj-y += qcom/venus/
 obj-y += renesas/
@@ -41,6 +40,7 @@ obj-y += stm/stm32/
 obj-y += ti-vpe/
 obj-y += ti/am437x/
 obj-y += ti/davinci/
+obj-y += ti/omap/
 obj-y += ti/omap3isp/
 obj-y += via/
 obj-y += xilinx/
diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platform/ti/omap/Kconfig
similarity index 100%
rename from drivers/media/platform/omap/Kconfig
rename to drivers/media/platform/ti/omap/Kconfig
diff --git a/drivers/media/platform/omap/Makefile b/drivers/media/platform/ti/omap/Makefile
similarity index 100%
rename from drivers/media/platform/omap/Makefile
rename to drivers/media/platform/ti/omap/Makefile
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
similarity index 100%
rename from drivers/media/platform/omap/omap_vout.c
rename to drivers/media/platform/ti/omap/omap_vout.c
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/ti/omap/omap_vout_vrfb.c
similarity index 100%
rename from drivers/media/platform/omap/omap_vout_vrfb.c
rename to drivers/media/platform/ti/omap/omap_vout_vrfb.c
diff --git a/drivers/media/platform/omap/omap_vout_vrfb.h b/drivers/media/platform/ti/omap/omap_vout_vrfb.h
similarity index 100%
rename from drivers/media/platform/omap/omap_vout_vrfb.h
rename to drivers/media/platform/ti/omap/omap_vout_vrfb.h
diff --git a/drivers/media/platform/omap/omap_voutdef.h b/drivers/media/platform/ti/omap/omap_voutdef.h
similarity index 100%
rename from drivers/media/platform/omap/omap_voutdef.h
rename to drivers/media/platform/ti/omap/omap_voutdef.h
diff --git a/drivers/media/platform/omap/omap_voutlib.c b/drivers/media/platform/ti/omap/omap_voutlib.c
similarity index 100%
rename from drivers/media/platform/omap/omap_voutlib.c
rename to drivers/media/platform/ti/omap/omap_voutlib.c
diff --git a/drivers/media/platform/omap/omap_voutlib.h b/drivers/media/platform/ti/omap/omap_voutlib.h
similarity index 100%
rename from drivers/media/platform/omap/omap_voutlib.h
rename to drivers/media/platform/ti/omap/omap_voutlib.h
-- 
2.35.1

