Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3AD4D74A9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiCMKzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiCMKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4071A80B;
        Sun, 13 Mar 2022 03:53:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C696460FFA;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9090C36AEA;
        Sun, 13 Mar 2022 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168729;
        bh=SXIXVsi92d7TTgQSfMh1FbNBtB+/BjvkX1VTtXotizw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMNpfwTaqQk9Zq25A29N/K6B8c5COAid1ZPnABf0MEvyq9YSYOekuONniA9p6B41a
         +8qooFFUo5mrQKln1KIwS0+icW5E/CiEOMr51zUwXyetlhGChSQE7/Y3PkxjBxUDbA
         lcPtztIfTIdJx5LP7n7RnvR/U0YhH0CFzP6jHEyKuUt5rKa61TKG1Ybdl6u6kcvyzC
         GsI9QwpDNrhWTMFpvotSUSMHZp9GYYINqLh4JWJmkX20OY6D8KmO+ODYsyF5DGiHMb
         1HKsWPPjoGxX6C07OqxDAF9O0bjphmPXnYWx+FTmxedokGkJWOCnJ27elMn2zLSld7
         Dqk7uva2OAn+Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I2K-IY; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 17/24] media: platform: rename stm32/ to sti/stm32/
Date:   Sun, 13 Mar 2022 11:51:58 +0100
Message-Id: <dc5be62a56ac19c6f49f4c8432558fd7b0efe7e6.1647167750.git.mchehab@kernel.org>
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
rename stm32/ to sti/stm32/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 MAINTAINERS                                               | 2 +-
 drivers/media/platform/Kconfig                            | 2 +-
 drivers/media/platform/Makefile                           | 2 +-
 drivers/media/platform/{ => sti}/stm32/Kconfig            | 0
 drivers/media/platform/{ => sti}/stm32/Makefile           | 0
 drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-hw.c   | 0
 drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-regs.h | 0
 drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.c      | 0
 drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.h      | 0
 drivers/media/platform/{ => sti}/stm32/stm32-dcmi.c       | 0
 10 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => sti}/stm32/Kconfig (100%)
 rename drivers/media/platform/{ => sti}/stm32/Makefile (100%)
 rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-hw.c (100%)
 rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-regs.h (100%)
 rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.c (100%)
 rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.h (100%)
 rename drivers/media/platform/{ => sti}/stm32/stm32-dcmi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7711a5ea125e..620705e0f043 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12046,7 +12046,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
-F:	drivers/media/platform/stm32/stm32-dcmi.c
+F:	drivers/media/platform/sti/stm32/stm32-dcmi.c
 
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index c3594807f8d7..cf373bfbca1b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -95,7 +95,7 @@ source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
 source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
 source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
-source "drivers/media/platform/stm32/Kconfig"
+source "drivers/media/platform/sti/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 6a766acfbe37..e3dd2331003a 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -40,7 +40,7 @@ obj-y += sti/bdisp/
 obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
 obj-y += sti/hva/
-obj-y += stm32/
+obj-y += sti/stm32/
 obj-y += ti-vpe/
 obj-y += via/
 obj-y += xilinx/
diff --git a/drivers/media/platform/stm32/Kconfig b/drivers/media/platform/sti/stm32/Kconfig
similarity index 100%
rename from drivers/media/platform/stm32/Kconfig
rename to drivers/media/platform/sti/stm32/Kconfig
diff --git a/drivers/media/platform/stm32/Makefile b/drivers/media/platform/sti/stm32/Makefile
similarity index 100%
rename from drivers/media/platform/stm32/Makefile
rename to drivers/media/platform/sti/stm32/Makefile
diff --git a/drivers/media/platform/stm32/dma2d/dma2d-hw.c b/drivers/media/platform/sti/stm32/dma2d/dma2d-hw.c
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d-hw.c
rename to drivers/media/platform/sti/stm32/dma2d/dma2d-hw.c
diff --git a/drivers/media/platform/stm32/dma2d/dma2d-regs.h b/drivers/media/platform/sti/stm32/dma2d/dma2d-regs.h
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d-regs.h
rename to drivers/media/platform/sti/stm32/dma2d/dma2d-regs.h
diff --git a/drivers/media/platform/stm32/dma2d/dma2d.c b/drivers/media/platform/sti/stm32/dma2d/dma2d.c
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d.c
rename to drivers/media/platform/sti/stm32/dma2d/dma2d.c
diff --git a/drivers/media/platform/stm32/dma2d/dma2d.h b/drivers/media/platform/sti/stm32/dma2d/dma2d.h
similarity index 100%
rename from drivers/media/platform/stm32/dma2d/dma2d.h
rename to drivers/media/platform/sti/stm32/dma2d/dma2d.h
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/sti/stm32/stm32-dcmi.c
similarity index 100%
rename from drivers/media/platform/stm32/stm32-dcmi.c
rename to drivers/media/platform/sti/stm32/stm32-dcmi.c
-- 
2.35.1

