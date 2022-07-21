Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941B557CD0A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiGUOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiGUOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EB5A165;
        Thu, 21 Jul 2022 07:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0484261F7C;
        Thu, 21 Jul 2022 14:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F99C341C6;
        Thu, 21 Jul 2022 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658412842;
        bh=wBwn/3S4U/C+84mEJ1IIISlBToX1u/euXvSyxyIrCUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAUv897MdqL08oMA4IJEguFP+btJBsOYtLvZrYbgFhbxhG1g37ZxkmZOU2RpuJFvQ
         qI0jKi0ooJ47oW1zpOD7k3l2oNv1P218qYFJaZIEXmClWAcIlj5VZ9JIC31AfIezee
         VVHwTWfqzMwNxsKTiVwPykNnQ4MBVmCi1c/gVg0IQPtX3X4AARg/yaBaarDCwQkhwb
         opvD7qhKKClonzCM7/biQ/jiI+Ih5fh52hSiEaRdP0QX0zPXXGYKzWH5wPjUj7qo9b
         Mg/c7uEeMiHRkRBThQvM6crgXOUtqooZDSbDmxDZih0zQWwANcpgrElcJvau1lVbuU
         JNXxYGGqv9zGg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-sh@vger.kernel.org
Subject: [PATCH 2/6] ARM: defconfig: remove irda remnants
Date:   Thu, 21 Jul 2022 16:13:21 +0200
Message-Id: <20220721141325.2413920-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220721141325.2413920-1-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A couple of ARM defconfig files (and one for sh) still refer to the
IRDA options that were removed in linux-4.14. Remove the entries
as well now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/assabet_defconfig        |  3 ---
 arch/arm/configs/badge4_defconfig         |  5 -----
 arch/arm/configs/clps711x_defconfig       |  2 --
 arch/arm/configs/colibri_pxa270_defconfig |  7 -------
 arch/arm/configs/corgi_defconfig          |  5 -----
 arch/arm/configs/eseries_pxa_defconfig    |  7 -------
 arch/arm/configs/footbridge_defconfig     |  9 ---------
 arch/arm/configs/h3600_defconfig          |  4 ----
 arch/arm/configs/jornada720_defconfig     |  4 ----
 arch/arm/configs/lart_defconfig           |  7 -------
 arch/arm/configs/magician_defconfig       |  9 ---------
 arch/arm/configs/pxa_defconfig            | 10 ----------
 arch/arm/configs/simpad_defconfig         |  6 ------
 arch/arm/configs/spitz_defconfig          |  5 -----
 arch/arm/configs/trizeps4_defconfig       |  8 --------
 arch/sh/configs/ecovec24_defconfig        |  2 --
 16 files changed, 93 deletions(-)

diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index db80b8193e66..ae7354550a63 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -16,9 +16,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_SA1100_FIR=m
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
 CONFIG_MTD=y
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index cdf3e3f99942..3a46dce304c4 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -17,11 +17,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRLAN=y
-CONFIG_IRCOMM=y
-CONFIG_IRDA_ULTRA=y
-CONFIG_SA1100_FIR=y
 CONFIG_BT=m
 CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIVHCI=m
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index b56d82d4eacd..8d86599e4de3 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -22,8 +22,6 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRTTY_SIR=y
 # CONFIG_WIRELESS is not set
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 14bc9a1e185b..c3d15b8dfc39 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -35,13 +35,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_VLAN_8021Q=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRTTY_SIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 8bc19fc9ca6c..126ddc2a0d09 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -56,11 +56,6 @@ CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index 5c58aa407897..a8db4f45a68d 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -25,13 +25,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_PXA_FICP=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_RC_PID=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 10905e53067c..2c4e15261d42 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -29,15 +29,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
 CONFIG_ATM=y
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_WINBOND_FIR=m
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 6066aea1d9c2..1bf143e69de3 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -15,10 +15,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
 # CONFIG_WIRELESS is not set
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 0521f427efce..6c99a48e2812 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -17,10 +17,6 @@ CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_SA1100_FIR=m
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
 CONFIG_BLK_DEV_LOOP=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index f4966d033a65..a414fe01ef52 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -20,13 +20,6 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_SYN_COOKIES=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_SA1100_FIR=m
 CONFIG_MTD=y
 CONFIG_MTD_DEBUG=y
 CONFIG_MTD_DEBUG_VERBOSE=1
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index aaddc07c16d9..75a15efa6e06 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -35,15 +35,6 @@ CONFIG_IP_PNP=y
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_IRTTY_SIR=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index ed92947244a1..d3fc216de6fa 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -115,16 +115,6 @@ CONFIG_BRIDGE=m
 CONFIG_VLAN_8021Q=m
 CONFIG_IEEE802154=y
 CONFIG_DNS_RESOLVER=y
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRDA_DEBUG=y
-CONFIG_IRTTY_SIR=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index 042f9626e0ee..0e1871fc8311 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -23,12 +23,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRTTY_SIR=m
-CONFIG_SA1100_FIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 4630aac47a8e..7757d26396c1 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -53,11 +53,6 @@ CONFIG_IP6_NF_MATCH_RT=m
 CONFIG_IP6_NF_FILTER=m
 CONFIG_IP6_NF_MANGLE=m
 CONFIG_IP6_NF_RAW=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_PXA_FICP=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index db0444aada48..01a0901120e8 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -38,14 +38,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_NETFILTER=y
 CONFIG_VLAN_8021Q=m
-CONFIG_IRDA=m
-CONFIG_IRLAN=m
-CONFIG_IRNET=m
-CONFIG_IRCOMM=m
-CONFIG_IRDA_ULTRA=y
-CONFIG_IRDA_CACHE_LAST_LSAP=y
-CONFIG_IRDA_FAST_RR=y
-CONFIG_IRTTY_SIR=m
 CONFIG_BT=m
 CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index d90d29d44469..e699e2e04128 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -29,8 +29,6 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
-CONFIG_IRDA=y
-CONFIG_SH_SIR=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-- 
2.29.2

