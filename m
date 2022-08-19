Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3535999B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348278AbiHSKRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbiHSKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:17:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0DDAEED;
        Fri, 19 Aug 2022 03:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B20B4616D7;
        Fri, 19 Aug 2022 10:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBBCC43143;
        Fri, 19 Aug 2022 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660904267;
        bh=bBGGs+VaVwa9GZVrl+mfip/PNxqOhyRiV5mtJK9gULA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LSwaVI8rUzMmO/Ct43XNW9RruD+qxBI8tnG2OoF/s63ywpKDgUlWIi/aLX949UKPN
         jM20X3grcEAWH38fx5/oYHEV7F5sTeuvwCDPVnMMG53ff2UByclp++LklueQkXypFU
         H7c9/JJp/RjyIB8BwC52gvvAYZIk2WNxpCZz5cJXuJNC06FJis2sLmU6k3EGL09lKc
         Jb0xsF7kl1AKAIK0xmR/ofWHEdPxStI2V1NvsgZa+z5y1Ow/2cxRWkgNKh/52pgoWK
         DCt8ZOZFDA7eTYb7MHgMkmQVIDOYTuxR00NmLv1qFt7npxJhkX1i5DzsxxCLPXCGpY
         yOQjDCPKxSuDQ==
Received: by mail-ej1-f46.google.com with SMTP id gb36so7910196ejc.10;
        Fri, 19 Aug 2022 03:17:47 -0700 (PDT)
X-Gm-Message-State: ACgBeo3V1Hsa3QBjLGdI35DnZzMYK7sNyj2Mkp+8WtQFYukn/rhgCEFm
        ByD7GnwBR/nTb0IY/PPcL4cNUxMrhXswDraLMTg=
X-Google-Smtp-Source: AA6agR5J9QREsVSQar6+cAcI+eQkL21ldizqJ/P5eBUIHXbbNTd/IG0qShM+KxoLNU3uFpfrKuXX255VS5DFZKFqEjU=
X-Received: by 2002:a05:6402:2751:b0:443:d90a:43d4 with SMTP id
 z17-20020a056402275100b00443d90a43d4mr5657123edd.368.1660904254658; Fri, 19
 Aug 2022 03:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220818135522.3143514-1-arnd@kernel.org> <20220818135522.3143514-2-arnd@kernel.org>
 <CAMuHMdXEXQNeOQGnYTQG58nHwB8YwLQ5q1vaje7kPQexrAMsRA@mail.gmail.com>
In-Reply-To: <CAMuHMdXEXQNeOQGnYTQG58nHwB8YwLQ5q1vaje7kPQexrAMsRA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 19 Aug 2022 12:17:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0kJVLEFqS0E=Lv2=HE9dbmjgA=_T2NX4zhq7EHvk4DBg@mail.gmail.com>
Message-ID: <CAK8P3a0kJVLEFqS0E=Lv2=HE9dbmjgA=_T2NX4zhq7EHvk4DBg@mail.gmail.com>
Subject: Re: [PATCH 01/11] ARM: defconfig: reorder defconfig files
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shannon Nelson <snelson@pensando.io>,
        Peter Chen <peter.chen@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Felipe Balbi <balbi@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev,
        linux-tegra <linux-tegra@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 11:17 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> This may cause conflicts with the usual refresh I plan to do for
> v6.0-rc1, which will be very similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?id=517d634d376042ab797d9feeb94236ad4cb03396
> So it may be better to drop this part.
>
> However, that decision is up to you, as you will have to handle the
> conflict when merging renesas-arm-defconfig-for-v6.0-tag1 later ;-)
> But sfr might complain before...

I'm not too worried here, if you just do the 'savedefconfig' step, you
should get
the same change and the mergetool will figure it out. In case there is a nasty
context conflict, you could just send that part early so I can resolve it.

       Arnd
