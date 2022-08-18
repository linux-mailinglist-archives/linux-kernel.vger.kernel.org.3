Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D276E5984ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbiHRN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiHRN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:56:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD58B7284;
        Thu, 18 Aug 2022 06:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1AFE616F4;
        Thu, 18 Aug 2022 13:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D466C433D6;
        Thu, 18 Aug 2022 13:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660830939;
        bh=fHzcBNlzGIZpl1xhXWFZNUDkhjIsfNqXuL0NTcnbSpk=;
        h=From:To:Cc:Subject:Date:From;
        b=a1Rz0rDFPWuA7x8HY71a9klDTS7phrO7CnzcNYqrI/L2GvFT+RZWZyoewgnd3RMoG
         3V1zaan4Wz2R1xAXJ5Pvrwoi9ky/RDZGOzCFsMhiIVd11yOr3RIr25wBN5VyaAVJUX
         cMyEaaJGETJ/OS892Rjm1jP7uo02MXutvpbI7b30rOaNWAgSoKnZ/XuLBvVUH0OuMq
         buenYGD5g12Wtfp3Jh+iPkwxWxUj1UDyvXSTpK11YHA+JcXOQC/ZC6i+HIVtMRema+
         XERxdZknt9iTB3KXMzp0sz8ZSvkWFS2BVNNEmzz09TETaH0JS0MvNCskXudG5AQWiq
         Wgl/naXAHsAZA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Qin Jian <qinjian@cqplus1.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shannon Nelson <snelson@pensando.io>,
        Peter Chen <peter.chen@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 00/11] ARM: defconfig cleanup
Date:   Thu, 18 Aug 2022 15:55:21 +0200
Message-Id: <20220818135522.3143514-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I have continued the cleanup of the multi_*_defconfig files, and
reordered the other files according to the 'make savedefconfig'
output as before.

I would like to queue these up for 6.1, though the last two
should probably be considered bugfixes and merged for 6.0.

Since a third of the defconfig files are for machines that
are now marked as unused, I skipped those files. There are still
a few things that get removed by 'make savedefconfig' as they
now get selected by some driver:

-CONFIG_SERIAL_BCM63XX=y
-CONFIG_SND_AUDIO_GRAPH_CARD=m
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_TEGRA20_APB_DMA=y

I think for those we should follow up with patches to remove the
'select' statements.

       Arnd

Cc: Russell King <linux@armlinux.org.uk>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Qin Jian <qinjian@cqplus1.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Łukasz Stelmach" <l.stelmach@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shannon Nelson <snelson@pensando.io>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-sunxi@lists.linux.dev
Cc: linux-tegra@vger.kernel.org
Cc: linux-usb@vger.kernel.org


Arnd Bergmann (11):
  ARM: defconfig: reorder defconfig files
  ARM: defconfig: clean up multi_v4t and multi_v5 configs
  ARM: defconfig: drop CONFIG_NET_VENDOR_ASIX=y
  ARM: defconfig: drop CONFIG_SERIAL_OMAP references
  ARM: defconfig: drop CONFIG_DRM_RCAR_LVDS
  ARM: defconfig: drop CONFIG_PTP_1588_CLOCK=y
  ARM: defconfig: drop CONFIG_SND_SOC_FSL_SAI
  ARM: defconfig: drop CONFIG_USB_FSL_USB2
  ARM: defconfig: drop CONFIG_MICROCHIP_PIT64B
  ARM: defconfig: fix CONFIG_SND_SOC_AC97_CODEC name
  musb: fix USB_MUSB_TUSB6010 dependency

 arch/arm/configs/at91_dt_defconfig   |  2 +-
 arch/arm/configs/dove_defconfig      |  2 +-
 arch/arm/configs/exynos_defconfig    |  2 +-
 arch/arm/configs/imx_v6_v7_defconfig |  2 +-
 arch/arm/configs/keystone_defconfig  |  7 +++----
 arch/arm/configs/lpc18xx_defconfig   |  2 +-
 arch/arm/configs/mmp2_defconfig      |  2 +-
 arch/arm/configs/mps2_defconfig      |  2 +-
 arch/arm/configs/multi_v4t_defconfig |  2 --
 arch/arm/configs/multi_v5_defconfig  |  3 +--
 arch/arm/configs/multi_v7_defconfig  | 22 +++++++---------------
 arch/arm/configs/mvebu_v5_defconfig  |  2 +-
 arch/arm/configs/mxs_defconfig       |  4 ++--
 arch/arm/configs/omap1_defconfig     |  2 +-
 arch/arm/configs/omap2plus_defconfig |  7 ++-----
 arch/arm/configs/orion5x_defconfig   |  2 +-
 arch/arm/configs/pxa168_defconfig    |  2 +-
 arch/arm/configs/pxa910_defconfig    |  2 +-
 arch/arm/configs/pxa_defconfig       |  2 +-
 arch/arm/configs/s3c6400_defconfig   |  2 +-
 arch/arm/configs/s5pv210_defconfig   |  2 +-
 arch/arm/configs/sama5_defconfig     |  6 +++---
 arch/arm/configs/sama7_defconfig     |  4 ++--
 arch/arm/configs/shmobile_defconfig  |  2 +-
 arch/arm/configs/socfpga_defconfig   |  6 +++---
 arch/arm/configs/sp7021_defconfig    |  2 +-
 arch/arm/configs/spear13xx_defconfig |  2 +-
 arch/arm/configs/spear3xx_defconfig  |  2 +-
 arch/arm/configs/spear6xx_defconfig  |  2 +-
 arch/arm/configs/stm32_defconfig     |  2 +-
 arch/arm/configs/sunxi_defconfig     |  2 +-
 arch/arm/configs/tegra_defconfig     |  2 +-
 arch/arm/configs/vexpress_defconfig  |  2 +-
 drivers/usb/musb/Kconfig             |  2 +-
 34 files changed, 48 insertions(+), 63 deletions(-)

-- 
2.29.2

