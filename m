Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454E45A4580
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiH2IxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiH2IxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:53:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D77C5A158;
        Mon, 29 Aug 2022 01:53:10 -0700 (PDT)
Received: from mail-ed1-f54.google.com ([209.85.208.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6UuX-1oV2QG0qU5-006wee; Mon, 29 Aug 2022 10:53:09 +0200
Received: by mail-ed1-f54.google.com with SMTP id a36so5416614edf.5;
        Mon, 29 Aug 2022 01:53:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo2riAW7/qNEOVTnGTC4bJx4eLD7rRPQaKHwQ9R+wfTY2TVVgwC9
        DObtGsbBLXYfNIVtoa43tqmLRSARv0mGrZIUMwM=
X-Google-Smtp-Source: AA6agR4dO9Qog99EOhFMYD2/TUvDUFPeLAFKpCKJySAtY2CWxJsmH8fvbDozC2seipJY5siIbg1N/2rhc6q5GDAswIQ=
X-Received: by 2002:a17:907:d0b:b0:741:7ca6:a2b with SMTP id
 gn11-20020a1709070d0b00b007417ca60a2bmr3580848ejc.654.1661763177783; Mon, 29
 Aug 2022 01:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220818135522.3143514-1-arnd@kernel.org>
In-Reply-To: <20220818135522.3143514-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Aug 2022 10:52:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1tsby7+xfKTQaaBQZ4t-=uWG5Dtbcn_jPEsSMG_YVHgA@mail.gmail.com>
Message-ID: <CAK8P3a1tsby7+xfKTQaaBQZ4t-=uWG5Dtbcn_jPEsSMG_YVHgA@mail.gmail.com>
Subject: Re: [PATCH 00/11] ARM: defconfig cleanup
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
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/EcVK/F1GzKJg7nI3gnx3l2/fiz8nAQrDCtoD8KunxCnbGLi+7x
 wou1KG1wFlZgmfaKCW3Y/bWTNMRPmBIhC8qgdkgfK74v6HyrxWjhFowjUEZVuhv7YUyczz/
 W9gU4s3/TJuGjFMxEADckk9m11NT1n8B8Seif14yMZ5BZHAY2y0RlIFTzOTuqtmLt47IlSQ
 5FiFQ4K612imzNyrfXpTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hyZpA9LylN8=:QfBKmGOitqo2UKo5+9ZcPQ
 /dNHHwc6qA1RDTSwmbtZ744H4HTnJFbfDY134iuzwdf/80vl11WliIqpIWQfbOy3i9C9SCF47
 KGxIzGjq/HAc3+QeB8rOyNjEWu6kH0CFMGw09O4Vs5O2AXFFkbex37kSJoHwagvvos77pSiY6
 SRjqxCeP2LHkuHuUZM2vjAKqe8W88N9TvmjGJwJ9LxDVDwLanPhF/7APq+atg1KuLUpIUnW3a
 J+WFRj/ugCVlpQo4bY4xWkwjmnBQDq3IbI+JWU9MOlixgyZ3IE6nYzkbuDDzY7oG4w2Af0gZ/
 nuz0eMLlhFzvBRsXFrZgtDkw6R1xGEGt6+nW8/WtnNwgHBzk2Wp9c7OFmjziLAmCNw9fKLJcY
 spO+KPsES8yAD3WTRrFPKzJO1V80GcapY7YGRnGfdlVILmL/8Ud6V/p5c7NDsxflgj1vmxExu
 mFNOkFqd7XHbbp2UUjQJJ7Utgfvtqx9p/rzDMBRiiskgUPwkTs8El/Wswt5tWNgqtNpQFg43l
 0TZfScNgjdg51VaEbhFjxPjL70orSb7ll5pdwU9+QiejRCi8E8bNFKx1azdHUZrXCPPdYOW5b
 KdFQ4N3xICd7ihSYqJGDE98V6LCBYLexLDLVe6NZ3HOhZddx66iC2nW0RV4Ens1CwkDCNwMgX
 MNsuy4rFYYK5OtBYXG1ar+VvDX0pOihL+w0Dzh43cHd7kITxV0wxHEBoN/WJwLuqeYArZFx9j
 6/fZHZXyJFR/vgEKUMk56njnC+iB/GceKR0V7ef4BrLooLZjh1rFOl8FKautDgyaXcKZqLHWg
 MUDSQR1mo94DzpsbNIJ4b39+sjUpcf246Vl1p7S0m/jNS916t1KFHnYeDWThoB/qMJwxDc9bi
 Vt/hVEaJMQe1HlxV1nHw==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 3:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> I have continued the cleanup of the multi_*_defconfig files, and
> reordered the other files according to the 'make savedefconfig'
> output as before.
>
> I would like to queue these up for 6.1, though the last two
> should probably be considered bugfixes and merged for 6.0.
>
> Since a third of the defconfig files are for machines that
> are now marked as unused, I skipped those files. There are still
> a few things that get removed by 'make savedefconfig' as they
> now get selected by some driver:
>
> -CONFIG_SERIAL_BCM63XX=y
> -CONFIG_SND_AUDIO_GRAPH_CARD=m
> -CONFIG_NEW_LEDS=y
> -CONFIG_LEDS_TRIGGERS=y
> -CONFIG_TEGRA20_APB_DMA=y
>
> I think for those we should follow up with patches to remove the
> 'select' statements.

I dropped the last patch that Greg has already picked up, and merged the
rest into the arm/defconfig branch of the soc tree.

Thanks for the Acks.

        Arnd
