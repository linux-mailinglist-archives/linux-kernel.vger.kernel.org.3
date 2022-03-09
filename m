Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B0A4D3549
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiCIQeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiCIQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:27:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D847425FD;
        Wed,  9 Mar 2022 08:22:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70A506194A;
        Wed,  9 Mar 2022 16:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CD3C340F3;
        Wed,  9 Mar 2022 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646842948;
        bh=oo9xuTopnDeaYjwi7l3v1e6htB3VyexeBkNhxNnIHC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cy5qQKoZDRTEEzf4FZjUIjpMAYzRFS+VgoR/9wdi7RZ6ASeJeQF2+UG6GlKt8K/iv
         S0rBO1qOQes2p7rd6Rh654NrRcsBkaYv2CAE7GSrrt31MqUlpfhqgxpRU6PoXsArDU
         OgtjsKMwTxccJfs9q08mvo3yvnqOcBft24qTEsAAqtt8eTmMwdPgAp2g+0zb0rZv4P
         9XCIP/7bI7wm7rvvoaAImIcAZ1S0NsmT1RBsDNfzKfKmbRyxKY8Ekvl4zZxCcNEmkV
         WgwXCp7O7NeFihZ4bf4F71Jm3orq9sfQYmycLu60xgb0XL6/yLv8OhzXzPZvp3dy99
         okRSOUdon/ImQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nRz50-00E6Ai-Bh; Wed, 09 Mar 2022 17:22:26 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 2/5] media: platform: Makefile: group some Makefile options
Date:   Wed,  9 Mar 2022 17:22:22 +0100
Message-Id: <30661693e9b8f5e084bbbf96043aaf49f0b40db5.1646842741.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646842741.git.mchehab@kernel.org>
References: <cover.1646842741.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple Kconfig entries inside a Makefile, just
include the makefile, as the per-Kconfig option will already
be inside platform/*/Makefile.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/5] at: https://lore.kernel.org/all/cover.1646842741.git.mchehab@kernel.org/

 drivers/media/platform/Makefile | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 4032816f8e8a..764b5bf45e5a 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -7,8 +7,7 @@ obj-$(CONFIG_VIDEO_ALLEGRO_DVT)		+= allegro-dvt/
 obj-$(CONFIG_VIDEO_ASPEED)		+= aspeed-video.o
 obj-$(CONFIG_VIDEO_CADENCE)		+= cadence/
 obj-$(CONFIG_VIDEO_VIA_CAMERA) += via-camera.o
-obj-$(CONFIG_VIDEO_CAFE_CCIC) += marvell-ccic/
-obj-$(CONFIG_VIDEO_MMP_CAMERA) += marvell-ccic/
+obj-y += marvell-ccic/
 
 obj-$(CONFIG_VIDEO_OMAP3)	+= omap3isp/
 obj-$(CONFIG_VIDEO_PXA27x)	+= pxa_camera.o
@@ -67,13 +66,9 @@ obj-$(CONFIG_VIDEO_XILINX)		+= xilinx/
 obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
 obj-$(CONFIG_VIDEO_RCAR_VIN)		+= rcar-vin/
 
-obj-$(CONFIG_VIDEO_ATMEL_ISC)		+= atmel/
-obj-$(CONFIG_VIDEO_ATMEL_ISI)		+= atmel/
-obj-$(CONFIG_VIDEO_ATMEL_XISC)		+= atmel/
-obj-$(CONFIG_VIDEO_MICROCHIP_CSI2DC)	+= atmel/
+obj-y	+= atmel/
 
-obj-$(CONFIG_VIDEO_STM32_DCMI)		+= stm32/
-obj-$(CONFIG_VIDEO_STM32_DMA2D)		+= stm32/
+obj-y	+= stm32/
 
 obj-$(CONFIG_VIDEO_MEDIATEK_VPU)	+= mtk-vpu/
 
-- 
2.35.1

