Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F8F4D7CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiCNIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiCNH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C61641985;
        Mon, 14 Mar 2022 00:56:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 147AE611FB;
        Mon, 14 Mar 2022 07:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801DFC341F0;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244563;
        bh=VpaiS3yFbQMi+HZbkvIsEJmpQYTuY1O47ezPvl+yyl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4T6n+Lru4cp/FOAvrDlcR7RfTDUcR1QtawwlkbYNgIkqL8X7TuwOaRBfxsecfiUT
         IKzIaM60Cft5J+tOAGIc19MEZWaqyOgnwWRLakqgrSZHdLktWAOTKZoWAYRUSld01L
         pjJ3FNUsS4DAv9f3vSZe9yypf8XROfDPkal3R5sjexCWKEHmasMqLrTgr/pJhBscbx
         WWNUJuCFUwfJl6Z32F2shGHDUU+94XISOhsedyXrslgIr1d+msuOE3MYw5EKnAmQcJ
         thTQ/9ZFeJkSEbB+3mbvbcfZn1c7/kYDlzCMS7H2jAbVwon/1tBrs8adCS/i96rswc
         6bqtQCXRPGMxA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYe-001kXr-OK; Mon, 14 Mar 2022 08:56:00 +0100
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 57/64] media: platform: rename am437x/ to ti/am437x/
Date:   Mon, 14 Mar 2022 08:55:49 +0100
Message-Id: <e665d697f0561ceeb08eb95ef7cb0f91c9179144.1647242579.git.mchehab@kernel.org>
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
rename am437x/ to ti/am437x/.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

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
index 620705e0f043..a8599cb4091e 100644
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
index 7321c76ec582..9456144cd347 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -67,7 +67,6 @@ config VIDEO_MUX
 
 source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/allwinner/Kconfig"
-source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
@@ -97,6 +96,7 @@ source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
 source "drivers/media/platform/sti/Kconfig"
 source "drivers/media/platform/sti/stm32/Kconfig"
 source "drivers/media/platform/ti-vpe/Kconfig"
+source "drivers/media/platform/ti/am437x/Kconfig"
 source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
 
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index e3dd2331003a..a34278911145 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -7,7 +7,6 @@
 # (e. g. LC_ALL=C sort Makefile)
 obj-y += allegro-dvt/
 obj-y += allwinner/
-obj-y += am437x/
 obj-y += amlogic/meson-ge2d/
 obj-y += aspeed/
 obj-y += atmel/
@@ -42,6 +41,7 @@ obj-y += sti/delta/
 obj-y += sti/hva/
 obj-y += sti/stm32/
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

