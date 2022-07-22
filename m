Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8457E38E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiGVPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiGVPMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:12:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60119C279;
        Fri, 22 Jul 2022 08:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B8C2B827C3;
        Fri, 22 Jul 2022 15:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E56C341C6;
        Fri, 22 Jul 2022 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658502762;
        bh=QNDA1Wl/P9Tdabb9er+hcjmLg+ZWPQYKQjQn31syPZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TOvvu0qlyhr+tmgrzFarODSHy2nmwd/vZkaOfw7UOlCrWttzwGKU19rg8AV7A8T7i
         IfjgWg0t2g4Ij3/wDGk0CzmXgSTPXgE3n1u2iwGUjmleTogf4uINMSXjxmVGVqzSDf
         NdnzljfzlPJdmijyVLMwEzZZ53euLLK3T+7lg1++pTTDKLDbOWkoP2Kq2RUZ3s84P6
         FBICts7HV/wapVFQ1AVuS+EXg97CVEyaQ8kbfAxQREHvjUc07BdPWl0gXMD41NG9LD
         308lnEB6RcxuafVaPDXSt3EJNt5k6THt96Bq2WKrP+Lj0X4kKIL9pRDDVTaN2puF9b
         HBK7vSUuswD+Q==
Message-ID: <8430301c-3682-fde0-4bf3-033450563be3@kernel.org>
Date:   Fri, 22 Jul 2022 10:12:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/6] ARM: refresh defconfig files
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
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
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-2-arnd@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/22 09:13, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A lot of Kconfig options have changed over the years, and we tend
> to not do a blind 'make defconfig' to refresh the files, to ensure
> we catch options that should not have gone away.
> 
> I used some a bit of scripting to only rework the bits where an
> option moved around in any of the defconfig files, without also
> dropping any of the other lines, to make it clearer which options
> we no longer have.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/configs/am200epdkit_defconfig    |  26 ++---
>   arch/arm/configs/aspeed_g4_defconfig      |  16 +--
>   arch/arm/configs/aspeed_g5_defconfig      |  16 +--
>   arch/arm/configs/assabet_defconfig        |   8 +-
>   arch/arm/configs/at91_dt_defconfig        |  10 +-
>   arch/arm/configs/axm55xx_defconfig        |  22 ++--
>   arch/arm/configs/badge4_defconfig         |   8 +-
>   arch/arm/configs/bcm2835_defconfig        |  36 +++----
>   arch/arm/configs/cerfcube_defconfig       |  16 +--
>   arch/arm/configs/clps711x_defconfig       |   2 +-
>   arch/arm/configs/cm_x300_defconfig        |  26 ++---
>   arch/arm/configs/cns3420vb_defconfig      |  18 ++--
>   arch/arm/configs/colibri_pxa270_defconfig |  32 +++---
>   arch/arm/configs/colibri_pxa300_defconfig |  10 +-
>   arch/arm/configs/collie_defconfig         |  20 ++--
>   arch/arm/configs/corgi_defconfig          |  44 ++++----
>   arch/arm/configs/davinci_all_defconfig    |  26 ++---
>   arch/arm/configs/dove_defconfig           |  28 ++---
>   arch/arm/configs/ep93xx_defconfig         |  16 +--
>   arch/arm/configs/eseries_pxa_defconfig    |  26 ++---
>   arch/arm/configs/exynos_defconfig         |  20 ++--
>   arch/arm/configs/ezx_defconfig            |  72 ++++++-------
>   arch/arm/configs/footbridge_defconfig     |  14 +--
>   arch/arm/configs/h3600_defconfig          |  10 +-
>   arch/arm/configs/h5000_defconfig          |  18 ++--
>   arch/arm/configs/hackkit_defconfig        |   4 +-
>   arch/arm/configs/hisi_defconfig           |  24 ++---
>   arch/arm/configs/imx_v4_v5_defconfig      |   8 +-
>   arch/arm/configs/imx_v6_v7_defconfig      |   8 +-
>   arch/arm/configs/integrator_defconfig     |   2 +-
>   arch/arm/configs/iop32x_defconfig         |  20 ++--
>   arch/arm/configs/jornada720_defconfig     |  10 +-
>   arch/arm/configs/keystone_defconfig       |  62 +++++------
>   arch/arm/configs/lart_defconfig           |   6 +-
>   arch/arm/configs/lpc18xx_defconfig        |  12 +--
>   arch/arm/configs/lpc32xx_defconfig        |   8 +-
>   arch/arm/configs/lpd270_defconfig         |   6 +-
>   arch/arm/configs/lubbock_defconfig        |  10 +-
>   arch/arm/configs/magician_defconfig       |  30 +++---
>   arch/arm/configs/mainstone_defconfig      |   4 +-
>   arch/arm/configs/milbeaut_m10v_defconfig  |   6 +-
>   arch/arm/configs/mini2440_defconfig       |   6 +-
>   arch/arm/configs/mmp2_defconfig           |  28 ++---
>   arch/arm/configs/moxart_defconfig         |  18 ++--
>   arch/arm/configs/mps2_defconfig           |  14 +--
>   arch/arm/configs/multi_v4t_defconfig      |   4 +-
>   arch/arm/configs/multi_v5_defconfig       |  12 +--
>   arch/arm/configs/multi_v7_defconfig       |  62 +++++------
>   arch/arm/configs/mv78xx0_defconfig        |  32 +++---
>   arch/arm/configs/mvebu_v5_defconfig       |  28 ++---
>   arch/arm/configs/mvebu_v7_defconfig       |   2 +-
>   arch/arm/configs/mxs_defconfig            |   4 +-
>   arch/arm/configs/neponset_defconfig       |  24 ++---
>   arch/arm/configs/netwinder_defconfig      |  10 +-
>   arch/arm/configs/nhk8815_defconfig        |   6 +-
>   arch/arm/configs/omap1_defconfig          |  74 ++++++-------
>   arch/arm/configs/omap2plus_defconfig      |  16 +--
>   arch/arm/configs/orion5x_defconfig        |  32 +++---
>   arch/arm/configs/oxnas_v6_defconfig       |  14 +--
>   arch/arm/configs/palmz72_defconfig        |  14 +--
>   arch/arm/configs/pcm027_defconfig         |  22 ++--
>   arch/arm/configs/pleb_defconfig           |   6 +-
>   arch/arm/configs/pxa168_defconfig         |  18 ++--
>   arch/arm/configs/pxa255-idp_defconfig     |  10 +-
>   arch/arm/configs/pxa3xx_defconfig         |  18 ++--
>   arch/arm/configs/pxa910_defconfig         |  22 ++--
>   arch/arm/configs/pxa_defconfig            | 126 +++++++++++-----------
>   arch/arm/configs/qcom_defconfig           |  60 +++++------
>   arch/arm/configs/realview_defconfig       |   8 +-
>   arch/arm/configs/rpc_defconfig            |  18 ++--
>   arch/arm/configs/s3c2410_defconfig        |   8 +-
>   arch/arm/configs/s3c6400_defconfig        |   2 +-
>   arch/arm/configs/s5pv210_defconfig        |   4 +-
>   arch/arm/configs/sama5_defconfig          |   8 +-
>   arch/arm/configs/sama7_defconfig          |   8 +-
>   arch/arm/configs/shannon_defconfig        |   8 +-
>   arch/arm/configs/simpad_defconfig         |  18 ++--
>   arch/arm/configs/socfpga_defconfig        |   4 +-

for socfpga

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
