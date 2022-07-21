Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D9157D4F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiGUUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9FC8F50B;
        Thu, 21 Jul 2022 13:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B3660ADD;
        Thu, 21 Jul 2022 20:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F74C341D2;
        Thu, 21 Jul 2022 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658436220;
        bh=IXAnQ6GemUSS9XzXU96zGBYCowAVAOwBRn59x35Rp2M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NkTiTfrrxj1iU+b+r0b0ntp39t/E1hEi2Xj50vKZ6wptqB0NSuEUpNXGr2KjPG7Q4
         1irccpqlKdKeRDrOuI0QeuJBWKWaTWYrA8FKMLdlqg5+LadBNKjYslU9SvljhG9O6G
         v0chW+z+igz4p0c6pHxFDQpH8gJnA/o1+WnIaUkyztEi0cNY5L69WREyQfaUW7j9aZ
         vn9fz6HMXYPol0rC8GWbkwJOKEc8+FYNjD7VS1JWUS1nmzsq6LHgvIqrz83gSGP3vD
         BGL5JPXkpHPmDmSQjofNfUIyTidrNqQlWMfGhnwvYRDVY3y142pFzvxVKOfElvYZl8
         0BopXP0GcsHvg==
Received: by mail-oo1-f51.google.com with SMTP id r193-20020a4a37ca000000b0043578138958so527497oor.4;
        Thu, 21 Jul 2022 13:43:40 -0700 (PDT)
X-Gm-Message-State: AJIora9MF7PI9RbgCqxEUuq5WFjuHpKS1wXujLuZCs7zx4gY3DyIF7lb
        m+iupbTa0eOXhOCkWl27euk1ccsXVTEYz+5hd7o=
X-Google-Smtp-Source: AGRyM1seo9DqPLT2Y67c1F9GPoLfoH/Dg7y5rc4GhGQoQDEAaUTYumu5ZH8+R/xhfkBTlrUa8ZxdgCiDlkpRaThuTk0=
X-Received: by 2002:a81:6dce:0:b0:31e:5a3b:d3a2 with SMTP id
 i197-20020a816dce000000b0031e5a3bd3a2mr305661ywc.495.1658436209315; Thu, 21
 Jul 2022 13:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-5-arnd@kernel.org>
 <e83c98f9-f32a-6bfd-71b6-9aba22aa7abb@linaro.org>
In-Reply-To: <e83c98f9-f32a-6bfd-71b6-9aba22aa7abb@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jul 2022 22:43:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0yc_iZ1dqbReckvune6KszCPvysCX9okYoaU-by+YRhQ@mail.gmail.com>
Message-ID: <CAK8P3a0yc_iZ1dqbReckvune6KszCPvysCX9okYoaU-by+YRhQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: defconfig: address renamed CONFIG_DEBUG_INFO=y
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alexander Shiyan <shc_work@mail.ru>,
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
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>, linux-oxnas@groups.io,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 5:42 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 16:13, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > CONFIG_DEBUG_INFO is now implicitly selected if one picks one of the
> > explicit options that could be DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT,
> > DEBUG_INFO_DWARF4, DEBUG_INFO_DWARF5.
> >
> > This was actually not what I had in mind when I suggested making
> > it a 'choice' statement, but it's too late to change again now,
> > and the Kconfig logic is more sensible in the new form.
> >
> > Change any defconfig file that had CONFIG_DEBUG_INFO enabled
> > but did not pick DWARF4 or DWARF5 explicitly to now pick the toolchain
> > default.
>
> I think this should be split - into remove DEBUG_INFO (noop) and into
> selecting CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT (a fix).

I'd rather keep them together: while removing the DEBUG_INFO is
now a NOP, keeping the two changes together explains much better
why this is done and is atomically needed based on the single patch
that caused the change.

It's the same with the LEDS patch that replaces the CONFIG_LEDS
option with CONFIG_NEW_LEDS.

       Arnd
