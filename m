Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E657DA90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiGVHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:02:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019517E33;
        Fri, 22 Jul 2022 00:02:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B5DDB8267D;
        Fri, 22 Jul 2022 07:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1CAC341C7;
        Fri, 22 Jul 2022 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658473361;
        bh=iotqH2KQue2AiSu+Cjadhr0GvbjJVQjBtGSTWOoab/U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=csPHM7UUPMgnnpmrq0eP44ROWe289Uv5gBIMKr5JRPFWBo/Nlr8ILbmJ4f36eKG6r
         v8AVC73hwjVUIPp9uj1mz1As8NUsg744UdB6qUex0JzEz06jgX7LpYrfL9rvkq4+A5
         naNl6uOSzXDwWQEHvDIQQsOyei+sqoIzDGi9Opl8UjIrf9oDgJcC/3NTv/vRQ6cfM+
         Z/PzFJlnsjWMgQLbf4qLR5eTZftn+1VsBoC9wo3UicxwRa/yOI8wgGXeA2ENwq/fGm
         Xn2J/7pJUVPlPf9P7tWmVKyESIZzZLmOArA7Pe3goLljTMT38XkANiwZMf2RCJ0dnk
         e8b8nBE6pnVWQ==
Received: by mail-ot1-f48.google.com with SMTP id g19-20020a9d1293000000b0061c7bfda5dfso2813814otg.1;
        Fri, 22 Jul 2022 00:02:40 -0700 (PDT)
X-Gm-Message-State: AJIora8CKfFqDNXnkxTqQv4CLgPgCEef7LrXRWoX+V0CrPcHI9OZVRPy
        z+wnepgoYUik5NuxoNiVmHFpRtcouMTn9BWVa68=
X-Google-Smtp-Source: AGRyM1tWrEXcUTSnTrmZZLEQML12zznS5gM3uAMpW8cF4DVN1GJxIS8qAIorEs3cjMnhQmpiC3ITqi37eiY9KARJUac=
X-Received: by 2002:a25:3841:0:b0:670:a1b9:f18e with SMTP id
 f62-20020a253841000000b00670a1b9f18emr1789926yba.480.1658473349878; Fri, 22
 Jul 2022 00:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-2-arnd@kernel.org>
 <9321ce6c-7565-a7eb-2bfe-dac144ab7733@broadcom.com> <9e872a00-966a-aaf8-7bb9-6627fcb0cf83@linaro.org>
In-Reply-To: <9e872a00-966a-aaf8-7bb9-6627fcb0cf83@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 22 Jul 2022 09:02:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jF=7atLkWKwrvgYLcZuEObbMF79cbj0XaFEiVw40Piw@mail.gmail.com>
Message-ID: <CAK8P3a3jF=7atLkWKwrvgYLcZuEObbMF79cbj0XaFEiVw40Piw@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: refresh defconfig files
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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

On Thu, Jul 21, 2022 at 5:36 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2022 17:33, Scott Branden wrote:
> > Hi Arnd,
> >
> > On 2022-07-21 07:13, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> A lot of Kconfig options have changed over the years, and we tend
> >> to not do a blind 'make defconfig' to refresh the files, to ensure
> >> we catch options that should not have gone away.
> >>
> >> I used some a bit of scripting to only rework the bits where an
> >> option moved around in any of the defconfig files, without also
> >> dropping any of the other lines, to make it clearer which options
> >> we no longer have.
> > Resync is fine.  But, it would be great if the defconfig files were kept
> > in sync. Almost every kernel version kconfig options change which affect
> > these files. Could we put in place a defconfig refresh per kernel
> > version to keep them all in sync going forward?
> >
>
> Not entirely, because some Kconfig changes are causing symbols to
> disappear. Also defconfig is expected to include user-visible options,
> even if savedefconfig would drop them.
>
> This is why blind savedefconfig is not acceptable.

Right. I mostly scripted the changes to move the options around, but
had to do a few files manually so I can't fully automate this, and
the removed options always need manual inspection. There are still
around 400 lines in the defconfig files that go away after a
savedefconfig, and it's a lot of work to go through those.

I might do a few more of these, but if anyone wants to help, these
are the most common lines that get dropped, sorted by frequency:

     34 -# CONFIG_VGA_CONSOLE is not set
     32 -CONFIG_NET_ETHERNET=y
     26 -CONFIG_NFS_V3=y
     22 -# CONFIG_CRYPTO_ANSI_CPRNG is not set
     20 -CONFIG_PM=y
     18 -CONFIG_FPE_NWFPE=y
     18 -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
     18 -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
     18 -# CONFIG_INET_XFRM_MODE_BEET is not set
     15 -CONFIG_SYSFS_DEPRECATED_V2=y
     15 -CONFIG_DEBUG_KERNEL=y
     15 -# CONFIG_BLK_DEV_BSG is not set
     14 -# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
     14 -# CONFIG_INPUT_MOUSEDEV is not set
     12 -CONFIG_LEDS=y
     12 -CONFIG_AEABI=y
     11 -CONFIG_NET_PCMCIA=y
     11 -CONFIG_GPIO_SYSFS=y
     10 -# CONFIG_ENABLE_MUST_CHECK is not set
      9 -CONFIG_LEDS_CPU=y
      9 -# CONFIG_EXT3_FS_XATTR is not set
      8 -CONFIG_CRYPTO_SHA512=m
      8 -CONFIG_BINFMT_AOUT=y
      8 -# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
      7 -CONFIG_SND_PCM_OSS=m
      7 -CONFIG_SND_MIXER_OSS=m
      7 -CONFIG_SMB_FS=m
      7 -CONFIG_MTD_M25P80=y
      6 -CONFIG_NET_PCI=y
      6 -CONFIG_CRYPTO_ECB=m
      5 -CONFIG_SECCOMP=y
      5 -CONFIG_MEDIA_CAMERA_SUPPORT=y
      5 -CONFIG_IPV6=y
      5 -CONFIG_CRYPTO_TEA=m
      5 -CONFIG_CRYPTO_SHA256=m
      5 -CONFIG_CRYPTO_KHAZAD=m
      5 -CONFIG_CRYPTO_ARC4=m
      5 -CONFIG_BACKLIGHT_PWM=y
      5 -# CONFIG_NET_CADENCE is not set

The majority of these lines are options that no longer exist and are
not needed, or things that dropped off because they get selected by
something else.

The interesting ones we need to catch are the ones that should be
enabled but are either renamed to something else or gained a
dependency that now also needs to be turned on.

           Arnd
