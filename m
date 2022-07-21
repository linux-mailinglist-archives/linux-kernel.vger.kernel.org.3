Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681E57CDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiGUOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGUOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:37:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E99FCA;
        Thu, 21 Jul 2022 07:37:04 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Ma1wY-1o2LZy47IS-00W0Yl; Thu, 21 Jul 2022 16:37:03 +0200
Received: by mail-yb1-f171.google.com with SMTP id c131so3075134ybf.9;
        Thu, 21 Jul 2022 07:37:02 -0700 (PDT)
X-Gm-Message-State: AJIora+OlxEsMclG7HRfV3/Z8wEbqvpsuTmnq3BY4AiK1qKS5zg8KS50
        boiK7OsyvCvLb4NDakzK26FtAn7i6uljCOdhhI8=
X-Google-Smtp-Source: AGRyM1sipmxaJDGQ/BXJ6IogC7daDCl2+j4F9uhSVcXz89KYHnAMaLqcK10XehN8TJ/WBsHB+lO9Dw0DiPklmfIK8Mk=
X-Received: by 2002:a81:493:0:b0:31e:6ab9:99a5 with SMTP id
 141-20020a810493000000b0031e6ab999a5mr8799929ywe.209.1658414210293; Thu, 21
 Jul 2022 07:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-2-arnd@kernel.org>
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Jul 2022 16:36:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2X7unsa2N5ynkUdk6H1=GZiWTyKBiLrDjQirAc9nfKhg@mail.gmail.com>
Message-ID: <CAK8P3a2X7unsa2N5ynkUdk6H1=GZiWTyKBiLrDjQirAc9nfKhg@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: refresh defconfig files
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>
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
X-Provags-ID: V03:K1:Jc3Fh2gfdpN+8HVDOauBXVPpRe0WBUQLIN/mBe+fdzftNpQ5j6Y
 /Q8TCadAMtrVhIsC3l+NMErEOqf1CkMOZ7tXCY3PXUqZVs7nMPYBlnDfaOTIEAUI6P65nwV
 8sRqJEpiEO39deVCaI3xdN9CH5pIxRs/NTtw4v3PHA/UKVjLePA+kgrsrbEyeZqy6qRKMJD
 y3u6z4TSZcHEZ+y8AsByQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CwOUKFV/LxQ=:FDmh5vyhQrb/b5rVNhrlaX
 5UoAVjtwTh8NLpY1KxKL7EQ/MFPQg7QrtHG/Et2HFkDlX/FTrgA5qA3xCrYamd/SRdfOfCWTE
 IiXm4jWFVYbQJIWTnM440kQf8IYOlB4T6e1w/nxXAGD/cq2mdqvWjp7oDMvGJJ10aDANN2x/v
 tKy3Y3DGyjl4XeQNfLms4KBpHlXv78hddGIDxB8dlasZMU7SXr4X8Q3hHlWBLvFpWnZJB+AVH
 rHoLux/0NvZAyq+qoqVYAEc9JCCcGo/CcOvCzoJpDIzNDhF+cG8Bsj9nQEZHDsqh039+i6ks+
 Aj3JsUJc6MKWSO6KBbNQ2pm7U3uUJtOHrs9gCWW0yk814+w68fFjjed8ZnUdvuTBruDymnss4
 uz9eNh10RvemeTuNYrsT1BmsQZ//V0d7vb6ABmTbo9Sf26j+HvtKFCeWHt0jlrp1mBSGq7HIY
 uvCXqQF7wBVn8uLNcb3zYaltOVe8wRvn+SgZxXYZNSrLHvMxoA9E3XsNPEkoQMYeWw2kbxyB4
 qoXdyp3hF9/nLHyDaFB4n4t48F1eVyCqkgdSNzwwLNWp7TwggM6b0BZDNtP2ErYUFbIAg5Lwq
 btq3T4L4kyXtRycWYNzHUo+CAt6WxTHmWK1ECTHo1/eZbqb7plxrWLVtF4Nk75BxTVVRx4SAY
 1rIP8Rh10uTP5Q8iPcxWrwNLyVfzET0ZXRe7nSqtoBr+8bhxVnd/pDU4HuFiXxyrno3DSHeND
 v9RLaCk3rkzL8JF7fi3D37w9FmVGuGteXwzbdH5xasbGrrWxwMp+/IXsyDhnsr8BHGNpgbE2U
 f28Jg4hkVNB8gogHmno5c6D1uT7fpJDFdqzeLbUOFZdMhrdhwbvzHRXL9XTJ5ocoHljij3qTY
 nt40WK7VGvRXrUDhSBnCN5qwpvrExGBL4BX6ED12s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 4:13 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
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

Apparently this patch got a little large and was rejected by some of
the mailing lists, in case someone wonders what happened.
Fortunately the contents  don't actually matter here, as I'm just
reordering the lines as seen in the diffstat.

        Arnd

> ---
>  arch/arm/configs/am200epdkit_defconfig    |  26 ++---
>  arch/arm/configs/aspeed_g4_defconfig      |  16 +--
>  arch/arm/configs/aspeed_g5_defconfig      |  16 +--
>  arch/arm/configs/assabet_defconfig        |   8 +-
>  arch/arm/configs/at91_dt_defconfig        |  10 +-
>  arch/arm/configs/axm55xx_defconfig        |  22 ++--
>  arch/arm/configs/badge4_defconfig         |   8 +-
>  arch/arm/configs/bcm2835_defconfig        |  36 +++----
>  arch/arm/configs/cerfcube_defconfig       |  16 +--
>  arch/arm/configs/clps711x_defconfig       |   2 +-
>  arch/arm/configs/cm_x300_defconfig        |  26 ++---
>  arch/arm/configs/cns3420vb_defconfig      |  18 ++--
>  arch/arm/configs/colibri_pxa270_defconfig |  32 +++---
>  arch/arm/configs/colibri_pxa300_defconfig |  10 +-
>  arch/arm/configs/collie_defconfig         |  20 ++--
>  arch/arm/configs/corgi_defconfig          |  44 ++++----
>  arch/arm/configs/davinci_all_defconfig    |  26 ++---
>  arch/arm/configs/dove_defconfig           |  28 ++---
>  arch/arm/configs/ep93xx_defconfig         |  16 +--
>  arch/arm/configs/eseries_pxa_defconfig    |  26 ++---
>  arch/arm/configs/exynos_defconfig         |  20 ++--
>  arch/arm/configs/ezx_defconfig            |  72 ++++++-------
>  arch/arm/configs/footbridge_defconfig     |  14 +--
>  arch/arm/configs/h3600_defconfig          |  10 +-
>  arch/arm/configs/h5000_defconfig          |  18 ++--
>  arch/arm/configs/hackkit_defconfig        |   4 +-
>  arch/arm/configs/hisi_defconfig           |  24 ++---
>  arch/arm/configs/imx_v4_v5_defconfig      |   8 +-
>  arch/arm/configs/imx_v6_v7_defconfig      |   8 +-
>  arch/arm/configs/integrator_defconfig     |   2 +-
>  arch/arm/configs/iop32x_defconfig         |  20 ++--
>  arch/arm/configs/jornada720_defconfig     |  10 +-
>  arch/arm/configs/keystone_defconfig       |  62 +++++------
>  arch/arm/configs/lart_defconfig           |   6 +-
>  arch/arm/configs/lpc18xx_defconfig        |  12 +--
>  arch/arm/configs/lpc32xx_defconfig        |   8 +-
>  arch/arm/configs/lpd270_defconfig         |   6 +-
>  arch/arm/configs/lubbock_defconfig        |  10 +-
>  arch/arm/configs/magician_defconfig       |  30 +++---
>  arch/arm/configs/mainstone_defconfig      |   4 +-
>  arch/arm/configs/milbeaut_m10v_defconfig  |   6 +-
>  arch/arm/configs/mini2440_defconfig       |   6 +-
>  arch/arm/configs/mmp2_defconfig           |  28 ++---
>  arch/arm/configs/moxart_defconfig         |  18 ++--
>  arch/arm/configs/mps2_defconfig           |  14 +--
>  arch/arm/configs/multi_v4t_defconfig      |   4 +-
>  arch/arm/configs/multi_v5_defconfig       |  12 +--
>  arch/arm/configs/multi_v7_defconfig       |  62 +++++------
>  arch/arm/configs/mv78xx0_defconfig        |  32 +++---
>  arch/arm/configs/mvebu_v5_defconfig       |  28 ++---
>  arch/arm/configs/mvebu_v7_defconfig       |   2 +-
>  arch/arm/configs/mxs_defconfig            |   4 +-
>  arch/arm/configs/neponset_defconfig       |  24 ++---
>  arch/arm/configs/netwinder_defconfig      |  10 +-
>  arch/arm/configs/nhk8815_defconfig        |   6 +-
>  arch/arm/configs/omap1_defconfig          |  74 ++++++-------
>  arch/arm/configs/omap2plus_defconfig      |  16 +--
