Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4E4D899C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbiCNQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EAC17076;
        Mon, 14 Mar 2022 09:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAB126144F;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E367C341D6;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275708;
        bh=eDQeajChn3UjFQC4O8YehTdZf6q+u3kEO5eQanQRww4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqlfCf6NMggWEZSiU5L9KzsIk4RTWhhtwDsoZeqQ04UWuapYNUChp2MM/0pJuOMMx
         KvtBG+9gK9tYCL3LSGPGgQzvS0htR4MGmQ/OgH/kX6m2L3/S1E+dsIQb5JIpK2LeOi
         qR0uJPMFSf8lsSGh/APlkHooklsS7Sp7U0SSjK70uxoIuENumYtIMdDwF7RcQyFy5O
         Te1p8n6mlPxxRIdFJdTQA7N1p7b69zJzAS2fJODRlZ5iGi2YnABAh+bGkJNsGB6hsw
         Ds55IiHOgoIcJ+tut2pJiz5bDJDNzAuqewB9I6nUIzEHTjCX/o5geEgATL1KOQB8Nh
         D22bbf/wDu8aw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wym-Dv; Mon, 14 Mar 2022 17:35:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Evgeny Novikov <novikov@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Herman <yanshuaijun@yulong.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 41/67] media: platform: rename marvell-ccic/ to marvell/
Date:   Mon, 14 Mar 2022 17:34:36 +0100
Message-Id: <ee2d2808bcba51d1879bff04c6d97e69453d8729.1647274407.git.mchehab@kernel.org>
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
rename marvell-ccic/ to marvell/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                                    | 2 +-
 drivers/media/platform/Kconfig                                 | 2 +-
 drivers/media/platform/Makefile                                | 2 +-
 drivers/media/platform/{marvell-ccic => marvell}/Kconfig       | 0
 drivers/media/platform/{marvell-ccic => marvell}/Makefile      | 0
 drivers/media/platform/{marvell-ccic => marvell}/cafe-driver.c | 0
 drivers/media/platform/{marvell-ccic => marvell}/mcam-core.c   | 0
 drivers/media/platform/{marvell-ccic => marvell}/mcam-core.h   | 0
 drivers/media/platform/{marvell-ccic => marvell}/mmp-driver.c  | 0
 9 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{marvell-ccic => marvell}/Kconfig (100%)
 rename drivers/media/platform/{marvell-ccic => marvell}/Makefile (100%)
 rename drivers/media/platform/{marvell-ccic => marvell}/cafe-driver.c (100%)
 rename drivers/media/platform/{marvell-ccic => marvell}/mcam-core.c (100%)
 rename drivers/media/platform/{marvell-ccic => marvell}/mcam-core.h (100%)
 rename drivers/media/platform/{marvell-ccic => marvell}/mmp-driver.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84bc106acc57..b83cf0eb99ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4248,7 +4248,7 @@ L:	linux-media@vger.kernel.org
 S:	Orphan
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/cafe_ccic*
-F:	drivers/media/platform/marvell-ccic/
+F:	drivers/media/platform/marvell/
 
 CAIF NETWORK LAYER
 L:	netdev@vger.kernel.org
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 24a43cef18de..0a4260627a00 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -76,7 +76,7 @@ source "drivers/media/platform/davinci/Kconfig"
 source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/intel/Kconfig"
-source "drivers/media/platform/marvell-ccic/Kconfig"
+source "drivers/media/platform/marvell/Kconfig"
 source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 8d6e15fad0b1..8b2deba4b62c 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -16,7 +16,7 @@ obj-y += davinci/
 obj-y += exynos-gsc/
 obj-y += exynos4-is/
 obj-y += intel/
-obj-y += marvell-ccic/
+obj-y += marvell/
 obj-y += meson/ge2d/
 obj-y += mtk-jpeg/
 obj-y += mtk-mdp/
diff --git a/drivers/media/platform/marvell-ccic/Kconfig b/drivers/media/platform/marvell/Kconfig
similarity index 100%
rename from drivers/media/platform/marvell-ccic/Kconfig
rename to drivers/media/platform/marvell/Kconfig
diff --git a/drivers/media/platform/marvell-ccic/Makefile b/drivers/media/platform/marvell/Makefile
similarity index 100%
rename from drivers/media/platform/marvell-ccic/Makefile
rename to drivers/media/platform/marvell/Makefile
diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell/cafe-driver.c
similarity index 100%
rename from drivers/media/platform/marvell-ccic/cafe-driver.c
rename to drivers/media/platform/marvell/cafe-driver.c
diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
similarity index 100%
rename from drivers/media/platform/marvell-ccic/mcam-core.c
rename to drivers/media/platform/marvell/mcam-core.c
diff --git a/drivers/media/platform/marvell-ccic/mcam-core.h b/drivers/media/platform/marvell/mcam-core.h
similarity index 100%
rename from drivers/media/platform/marvell-ccic/mcam-core.h
rename to drivers/media/platform/marvell/mcam-core.h
diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/media/platform/marvell/mmp-driver.c
similarity index 100%
rename from drivers/media/platform/marvell-ccic/mmp-driver.c
rename to drivers/media/platform/marvell/mmp-driver.c
-- 
2.35.1

