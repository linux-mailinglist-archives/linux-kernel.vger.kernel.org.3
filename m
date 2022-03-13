Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C24D74BA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiCMK4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiCMKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF605B3DF;
        Sun, 13 Mar 2022 03:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175F26102A;
        Sun, 13 Mar 2022 10:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3020DC36AF4;
        Sun, 13 Mar 2022 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168730;
        bh=2uLL+ZtF31dbNZj181Q8sc1+wodu0nbS8F5Qtq6NRHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpYjplnb6pm7PAmVUX3CjCq8KfddhR8lm9ZCLfLL1Bz4XWbwpw6k4hBfs3p3H+YBt
         NX3bFndKiR5f9E3QBbHl+KkZs26touwhF51wsxCzQI+pmX8t24CPiqfqDFEeDjP8zc
         fHXFIjIFCPhSHvGVttqJJsIcbGI0vsBoG+oaLly3vwR5CVEcwzixOq3hYIz6BluFb2
         sNWHI/XBPFUJ8hhHMy4GrKoTx9zJ7JbwGvqi4vXx45WV/SJw8GIrF9JoNTRkHhEDSx
         VkF5gr+5WvK3pQqA+CX1Owv/S0/aIyAdhPmolESUNc1+Fo6J9KQXNkPcjTdhmXhs+C
         Z9BBAKEJRAymA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTLpX-001I2e-Q0; Sun, 13 Mar 2022 11:52:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhou Qingyang <zhou1615@umn.edu>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 22/24] media: platform: rename ti-vpe/ to ti/vpe/
Date:   Sun, 13 Mar 2022 11:52:03 +0100
Message-Id: <0ab499d911085179ee54d06c4b326cb8b313d005.1647167750.git.mchehab@kernel.org>
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
rename ti-vpe/ to ti/vpe/.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/

 MAINTAINERS                                              | 2 +-
 drivers/media/platform/Kconfig                           | 2 +-
 drivers/media/platform/Makefile                          | 2 +-
 drivers/media/platform/{ti-vpe => ti/vpe}/Kconfig        | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/Makefile       | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/cal-camerarx.c | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/cal-video.c    | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/cal.c          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/cal.h          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/cal_regs.h     | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/csc.c          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/csc.h          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/sc.c           | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/sc.h           | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/sc_coeff.h     | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.c        | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.h        | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpdma_priv.h   | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpe.c          | 0
 drivers/media/platform/{ti-vpe => ti/vpe}/vpe_regs.h     | 0
 20 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/Kconfig (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/Makefile (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/cal-camerarx.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/cal-video.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/cal.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/cal.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/cal_regs.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/csc.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/csc.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/sc_coeff.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpdma_priv.h (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpe.c (100%)
 rename drivers/media/platform/{ti-vpe => ti/vpe}/vpe_regs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a85c98a77e4..031cb2cbecba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19407,7 +19407,7 @@ W:	http://linuxtv.org/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/ti,cal.yaml
 F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
-F:	drivers/media/platform/ti-vpe/
+F:	drivers/media/platform/ti/vpe/
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 366a0fa5e519..d9bd7a675c22 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -92,11 +92,11 @@ source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
 source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/sti/stm32/Kconfig"
-source "drivers/media/platform/ti-vpe/Kconfig"
 source "drivers/media/platform/ti/am437x/Kconfig"
 source "drivers/media/platform/ti/davinci/Kconfig"
 source "drivers/media/platform/ti/omap/Kconfig"
 source "drivers/media/platform/ti/omap3isp/Kconfig"
+source "drivers/media/platform/ti/vpe/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index a9740f6021d2..1e62a4009b6c 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -37,11 +37,11 @@ obj-y += sti/c8sectpfe/
 obj-y += sti/delta/
 obj-y += sti/hva/
 obj-y += sti/stm32/
-obj-y += ti-vpe/
 obj-y += ti/am437x/
 obj-y += ti/davinci/
 obj-y += ti/omap/
 obj-y += ti/omap3isp/
+obj-y += ti/vpe/
 obj-y += via/
 obj-y += xilinx/
 
diff --git a/drivers/media/platform/ti-vpe/Kconfig b/drivers/media/platform/ti/vpe/Kconfig
similarity index 100%
rename from drivers/media/platform/ti-vpe/Kconfig
rename to drivers/media/platform/ti/vpe/Kconfig
diff --git a/drivers/media/platform/ti-vpe/Makefile b/drivers/media/platform/ti/vpe/Makefile
similarity index 100%
rename from drivers/media/platform/ti-vpe/Makefile
rename to drivers/media/platform/ti/vpe/Makefile
diff --git a/drivers/media/platform/ti-vpe/cal-camerarx.c b/drivers/media/platform/ti/vpe/cal-camerarx.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal-camerarx.c
rename to drivers/media/platform/ti/vpe/cal-camerarx.c
diff --git a/drivers/media/platform/ti-vpe/cal-video.c b/drivers/media/platform/ti/vpe/cal-video.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal-video.c
rename to drivers/media/platform/ti/vpe/cal-video.c
diff --git a/drivers/media/platform/ti-vpe/cal.c b/drivers/media/platform/ti/vpe/cal.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal.c
rename to drivers/media/platform/ti/vpe/cal.c
diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti/vpe/cal.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal.h
rename to drivers/media/platform/ti/vpe/cal.h
diff --git a/drivers/media/platform/ti-vpe/cal_regs.h b/drivers/media/platform/ti/vpe/cal_regs.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/cal_regs.h
rename to drivers/media/platform/ti/vpe/cal_regs.h
diff --git a/drivers/media/platform/ti-vpe/csc.c b/drivers/media/platform/ti/vpe/csc.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/csc.c
rename to drivers/media/platform/ti/vpe/csc.c
diff --git a/drivers/media/platform/ti-vpe/csc.h b/drivers/media/platform/ti/vpe/csc.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/csc.h
rename to drivers/media/platform/ti/vpe/csc.h
diff --git a/drivers/media/platform/ti-vpe/sc.c b/drivers/media/platform/ti/vpe/sc.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/sc.c
rename to drivers/media/platform/ti/vpe/sc.c
diff --git a/drivers/media/platform/ti-vpe/sc.h b/drivers/media/platform/ti/vpe/sc.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/sc.h
rename to drivers/media/platform/ti/vpe/sc.h
diff --git a/drivers/media/platform/ti-vpe/sc_coeff.h b/drivers/media/platform/ti/vpe/sc_coeff.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/sc_coeff.h
rename to drivers/media/platform/ti/vpe/sc_coeff.h
diff --git a/drivers/media/platform/ti-vpe/vpdma.c b/drivers/media/platform/ti/vpe/vpdma.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpdma.c
rename to drivers/media/platform/ti/vpe/vpdma.c
diff --git a/drivers/media/platform/ti-vpe/vpdma.h b/drivers/media/platform/ti/vpe/vpdma.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpdma.h
rename to drivers/media/platform/ti/vpe/vpdma.h
diff --git a/drivers/media/platform/ti-vpe/vpdma_priv.h b/drivers/media/platform/ti/vpe/vpdma_priv.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpdma_priv.h
rename to drivers/media/platform/ti/vpe/vpdma_priv.h
diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti/vpe/vpe.c
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpe.c
rename to drivers/media/platform/ti/vpe/vpe.c
diff --git a/drivers/media/platform/ti-vpe/vpe_regs.h b/drivers/media/platform/ti/vpe/vpe_regs.h
similarity index 100%
rename from drivers/media/platform/ti-vpe/vpe_regs.h
rename to drivers/media/platform/ti/vpe/vpe_regs.h
-- 
2.35.1

