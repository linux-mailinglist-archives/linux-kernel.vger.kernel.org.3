Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8804D7CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiCNICQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbiCNH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDBC41602;
        Mon, 14 Mar 2022 00:56:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D6CB611AE;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E9BC341D7;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244562;
        bh=0NC/tC/kV06rr47XvjpViOX6Ts4NzorwYqCzhcRrWH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SVGjmsYIDysSiC05lcChWEnhMsnfGs7QFC+eJGuvGtp3n1unDAX9L+7FRlgAPq68h
         6DjoiT+0WOc9M/BKIVTpk8HIposCeEsyI40X3cONdC24JhOLqt9x2dvY0epQzfOCVM
         Ows9PlZYVAqmBLAaWaKeD45lv/6Fxh8pwDJvp3DOGyDVi3jTh+tp3QrcyGlSojlUwP
         tKJCz0PRAnN7YknW6fkcbrJLbmSuxlJarZLSQaR5fwYQlvE2058uELQCOH+SiZpVbv
         aK+9XqOUorg7DFyrxVhokEVogh5hrlwiN405UzZd8gYq9a1zgpwdGlM9VBkwjxmW8q
         2SyFybRyCf5cA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kWt-0t; Mon, 14 Mar 2022 08:56:00 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 42/64] media: platform: rename meson/ge2d/ to amlogic/meson-ge2d/
Date:   Mon, 14 Mar 2022 08:55:34 +0100
Message-Id: <ca17efa7ff931475071461fd046e50c300575834.1647242579.git.mchehab@kernel.org>
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
rename meson/ge2d/ to amlogic/meson-ge2d/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 MAINTAINERS                                                     | 2 +-
 drivers/media/platform/Kconfig                                  | 2 +-
 drivers/media/platform/Makefile                                 | 2 +-
 .../media/platform/{meson/ge2d => amlogic/meson-ge2d}/Kconfig   | 0
 .../media/platform/{meson/ge2d => amlogic/meson-ge2d}/Makefile  | 0
 .../platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d-regs.h     | 0
 .../media/platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d.c    | 0
 7 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/Kconfig (100%)
 rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/Makefile (100%)
 rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d-regs.h (100%)
 rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index b83cf0eb99ce..09b0e60da4e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12523,7 +12523,7 @@ L:	linux-amlogic@lists.infradead.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
-F:	drivers/media/platform/meson/ge2d/
+F:	drivers/media/platform/amlogic/meson-ge2d/
 
 MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
 M:	Liang Yang <liang.yang@amlogic.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0a4260627a00..b4faee0a1b63 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -67,6 +67,7 @@ config VIDEO_MUX
 
 source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/am437x/Kconfig"
+source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
 source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
@@ -77,7 +78,6 @@ source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
 source "drivers/media/platform/marvell/Kconfig"
-source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 8b2deba4b62c..48531f93d92f 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -7,6 +7,7 @@
 # (e. g. LC_ALL=C sort Makefile)
 obj-y += allegro-dvt/
 obj-y += am437x/
+obj-y += amlogic/meson-ge2d/
 obj-y += amphion/
 obj-y += aspeed/
 obj-y += atmel/
@@ -17,7 +18,6 @@ obj-y += exynos-gsc/
 obj-y += exynos4-is/
 obj-y += intel/
 obj-y += marvell/
-obj-y += meson/ge2d/
 obj-y += mtk-jpeg/
 obj-y += mtk-mdp/
 obj-y += mtk-vcodec/
diff --git a/drivers/media/platform/meson/ge2d/Kconfig b/drivers/media/platform/amlogic/meson-ge2d/Kconfig
similarity index 100%
rename from drivers/media/platform/meson/ge2d/Kconfig
rename to drivers/media/platform/amlogic/meson-ge2d/Kconfig
diff --git a/drivers/media/platform/meson/ge2d/Makefile b/drivers/media/platform/amlogic/meson-ge2d/Makefile
similarity index 100%
rename from drivers/media/platform/meson/ge2d/Makefile
rename to drivers/media/platform/amlogic/meson-ge2d/Makefile
diff --git a/drivers/media/platform/meson/ge2d/ge2d-regs.h b/drivers/media/platform/amlogic/meson-ge2d/ge2d-regs.h
similarity index 100%
rename from drivers/media/platform/meson/ge2d/ge2d-regs.h
rename to drivers/media/platform/amlogic/meson-ge2d/ge2d-regs.h
diff --git a/drivers/media/platform/meson/ge2d/ge2d.c b/drivers/media/platform/amlogic/meson-ge2d/ge2d.c
similarity index 100%
rename from drivers/media/platform/meson/ge2d/ge2d.c
rename to drivers/media/platform/amlogic/meson-ge2d/ge2d.c
-- 
2.35.1

