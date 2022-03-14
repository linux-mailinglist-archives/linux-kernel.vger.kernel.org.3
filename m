Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A74D89E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiCNQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3925C6F;
        Mon, 14 Mar 2022 09:35:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A030B6147F;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC29C36AE7;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275709;
        bh=VRQda2tMB4KIfpCexAx6sritTOy8Q9GvC+ZZgReP5hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxvC0ru7bp6etupfdOniNCCDKIpc3bpM5VcKUcpRQi/5CQp/hExvGdP9EhwQN7lnQ
         Smx6r2mQnkoyyFDEVGNLhQOJfYooX4g+V0PzX1AM+KiOVKPqHP3a8XAC1wIAyeGjzN
         HNUhWf8POZkpUpRwwegwV2bAq357J4GnVmMXr9gXzanu5HbUN1weMcP8bkPAbqML2c
         +RTI9LDIbinfAvbYxpe9JAxFn6rOjuAiblpZuj/NLHHx8s4ydg0BP+6UV37AoHNMLX
         mW4iEFNYKEyfzxYRoahHXYv1dCFgw4wnoyFTIJqaWtIX+7/xQ4NSK5j3qf2lyt/Nvb
         687Q9toIxCNRQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf1-001x1R-BP; Mon, 14 Mar 2022 17:35:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 57/67] media: platform: rename am437x/ to ti/am437x/
Date:   Mon, 14 Mar 2022 17:34:52 +0100
Message-Id: <1ebc47e42c2692fe09947d517a5e9a3b12fc58a3.1647274407.git.mchehab@kernel.org>
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
rename am437x/ to ti/am437x/.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 MAINTAINERS                                               | 2 +-
 drivers/media/platform/Kconfig                            | 2 +-
 drivers/media/platform/Makefile                           | 2 +-
 drivers/media/platform/{ => ti}/am437x/Kconfig            | 0
 drivers/media/platform/{ => ti}/am437x/Makefile           | 0
 drivers/media/platform/{ => ti}/am437x/am437x-vpfe.c      | 0
 drivers/media/platform/{ => ti}/am437x/am437x-vpfe.h      | 0
 drivers/media/platform/{ => ti}/am437x/am437x-vpfe_regs.h | 0
 8 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/media/platform/{ => ti}/am437x/Kconfig (100%)
 rename drivers/media/platform/{ => ti}/am437x/Makefile (100%)
 rename drivers/media/platform/{ => ti}/am437x/am437x-vpfe.c (100%)
 rename drivers/media/platform/{ => ti}/am437x/am437x-vpfe.h (100%)
 rename drivers/media/platform/{ => ti}/am437x/am437x-vpfe_regs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c1055c27c65..f0b262176a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19262,7 +19262,7 @@ S:	Maintained
 W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
-F:	drivers/media/platform/am437x/
+F:	drivers/media/platform/ti/am437x/
 
 TI BANDGAP AND THERMAL DRIVER
 M:	Eduardo Valentin <edubezval@gmail.com>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2ad5fde02543..5d56058fa397 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -67,7 +67,6 @@ config VIDEO_MUX
 
 source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/allwinner/Kconfig"
-source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
 source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
@@ -97,6 +96,7 @@ source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
 source "drivers/media/platform/stm/sti/Kconfig"
 source "drivers/media/platform/stm/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
+source "drivers/media/platform/ti/am437x/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index f20f1287c665..f8c4617da0ae 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -7,7 +7,6 @@
 # (e. g. LC_ALL=C sort Makefile)
 obj-y += allegro-dvt/
 obj-y += allwinner/
-obj-y += am437x/
 obj-y += amlogic/meson-ge2d/
 obj-y += amphion/
 obj-y += aspeed/
@@ -42,6 +41,7 @@ obj-y += stm/sti/delta/
 obj-y += stm/sti/hva/
 obj-y += stm/stm32/
 obj-y += ti-vpe/
+obj-y += ti/am437x/
 obj-y += via/
 obj-y += xilinx/
 
diff --git a/drivers/media/platform/am437x/Kconfig b/drivers/media/platform/ti/am437x/Kconfig
similarity index 100%
rename from drivers/media/platform/am437x/Kconfig
rename to drivers/media/platform/ti/am437x/Kconfig
diff --git a/drivers/media/platform/am437x/Makefile b/drivers/media/platform/ti/am437x/Makefile
similarity index 100%
rename from drivers/media/platform/am437x/Makefile
rename to drivers/media/platform/ti/am437x/Makefile
diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
similarity index 100%
rename from drivers/media/platform/am437x/am437x-vpfe.c
rename to drivers/media/platform/ti/am437x/am437x-vpfe.c
diff --git a/drivers/media/platform/am437x/am437x-vpfe.h b/drivers/media/platform/ti/am437x/am437x-vpfe.h
similarity index 100%
rename from drivers/media/platform/am437x/am437x-vpfe.h
rename to drivers/media/platform/ti/am437x/am437x-vpfe.h
diff --git a/drivers/media/platform/am437x/am437x-vpfe_regs.h b/drivers/media/platform/ti/am437x/am437x-vpfe_regs.h
similarity index 100%
rename from drivers/media/platform/am437x/am437x-vpfe_regs.h
rename to drivers/media/platform/ti/am437x/am437x-vpfe_regs.h
-- 
2.35.1

