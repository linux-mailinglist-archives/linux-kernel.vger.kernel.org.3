Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AF4B2628
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350261AbiBKMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:45:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiBKMpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:45:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFFF6E;
        Fri, 11 Feb 2022 04:45:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE9E61DEB;
        Fri, 11 Feb 2022 12:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687A6C340E9;
        Fri, 11 Feb 2022 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644583539;
        bh=a1nIrevSTfQHaNTl5tK3IirmV7M2QtwKa+Q70VHGp7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxW136osjG0DCtSgTC1++bNXVzMJT8HrjzGuIKlir7OX+heUiJvkJcyOSDInkuloM
         bctGT+5nKHq8RAbyUyavY6IjZg/IETYv3ZtOA/os8XTwQCf4nsCNbjG05+2UOP7V6u
         J55RDc1HjMV1fH20LNI6kkHkS5m7tcGEysM6IgrJ3GeM2QGwXh/eV4tIoxccQoBWCi
         RhhU5NynH92GLmJeNItMSYPMVY3Vap/sJjnokOXLv6SIFw0tmzsWZQ1Fyf+I6GUcRm
         0cb9MinSJ/QG9kOffexd2LGeUV3DPrzMDVKSyiv2SoXx+iT7QYsOWKWc2DskotkZEb
         ad67vfUG8ZWHw==
Date:   Fri, 11 Feb 2022 20:45:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>, Chester Lin <clin@suse.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Lucas Stach <dev@lynxeye.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/12] arm64: dts: freescale: add initial support for
 verdin imx8m mini
Message-ID: <20220211124531.GV4909@dragon>
References: <20220211092322.287487-1-marcel@ziswiler.com>
 <20220211092322.287487-13-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211092322.287487-13-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:23:22AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This patch adds the device tree to support Toradex Verdin iMX8M Mini a
> computer on module which can be used on different carrier boards.
> 
> The module consists of an NXP i.MX 8M Mini family SoC (either i.MX 8M
> Mini Quad or 8M Mini DualLite), a PCA9450A PMIC, a Gigabit Ethernet PHY,
> 1 or 2 GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC, an I2C EEPROM, an
> RX8130 RTC, an optional SPI CAN controller plus an optional Bluetooth/
> Wi-Fi module.
> 
> Anything that is not self-contained on the module is disabled by
> default.
> 
> The device tree for the Dahlia includes the module's device tree and
> enables the supported peripherals of the carrier board.
> 
> The device tree for the Verdin Development Board includes the module's
> device tree as well as the Dahlia one as it is a superset and supports
> almost all peripherals available.
> 
> So far there is no display functionality supported at all but basic
> console UART, PCIe, USB host, eMMC and Ethernet and PCIe functionality
> work fine.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied, thanks!
