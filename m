Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8D5018C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiDNQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiDNQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:37:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A79DFDE2E;
        Thu, 14 Apr 2022 09:07:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bh17so10952480ejb.8;
        Thu, 14 Apr 2022 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZ9b/z89dch9gLvF5vASMxbmJ/Wzdwmfjy6OZsSqtqA=;
        b=L5sP55TAgL2AI4FDkJ+eMhfVeG1Y6n+mayllGbh7HAbtrbX8Kq31bKTjMTAqXQRdL+
         uxf5PF0+vennnKdDh1T5GXF47ae2ZFWslbFdRB1FcgBWFjZOP1tG9QRTiMQ5+OPvrUiI
         uvKkZBe1bmA87leVgy4H4aHNqAh9Ddz8maIOFpwfFldbi/9KASDbBidQAReNFKsRndjF
         mLrjHMWmyxtIw+DEVEBY5vPe4CNbEs7P2o7fRt23W0xo0/MlvZIRvflgp+6FVESYhKzj
         /+fwRMHo3W2c6bb3X30RDhJQAUPQQznabpXEXbKrWgIMGkIjBbescnE/2k5wlzkTPJ5D
         PnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZ9b/z89dch9gLvF5vASMxbmJ/Wzdwmfjy6OZsSqtqA=;
        b=ZuleybUwTBA2lAYh9087tXpZMu5bAv8vSW5J0fS5vKh+2cGY65D5drKyMMSZODaEcY
         m9ip1PmLX/3v1IljsMGnrX0kribcegZYUCnfGbf46/XE+NI4tM5uOUXnUER0CR9+fsJ0
         QJsvT/AaUYUKUBQ8ClCGfhLV+vRXmUw4lyzpLWi5rRrbdPcijJAEH16+hcMcufk6FIof
         6rstVL/GW2MhhhFF1BtQf5z1JDQzVGEVQ0x0UkKZlnLzGNamfEPYTv9tzyoduwGXrjN7
         pSixGR5o6BNaA1cAo3nCr3tkEFr8nPOHzLbhllyQBLe6+jU7KdXPDoB8rSLJMMuYTrWb
         Rfig==
X-Gm-Message-State: AOAM530D/GyabXimb4hGtd6H+ixCkmZ0v7sOFPKYTSNhC3sKh1zthBCl
        pF828yM/PYtPJZyRiBQFTWHp0+rmJRqJaqh9xN8=
X-Google-Smtp-Source: ABdhPJyF91NZOaGxS5Pl0tuT7o0nmwxyK0YmWaO6cyOAzEQDgBQtN5VcAICIZk16A9Jhgd3oPfGbcQ4Yyrca0dRmbw8=
X-Received: by 2002:a17:906:1692:b0:6e8:d245:44a9 with SMTP id
 s18-20020a170906169200b006e8d24544a9mr2933455ejd.639.1649952418435; Thu, 14
 Apr 2022 09:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <CGME20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9@eucas1p1.samsung.com>
 <20220401103604.8705-12-andriy.shevchenko@linux.intel.com>
 <3a24ef01-3231-1bee-7429-dce5680c5682@samsung.com> <CAHp75VfMPpfeMpawRyLo_GtLR8+gVGgm8zW-fatp6=9a9wK18A@mail.gmail.com>
 <CAFBinCCCtZvdp+01DdEE=-f7rZ8V46O125wKDqE1muA645sdUg@mail.gmail.com>
In-Reply-To: <CAFBinCCCtZvdp+01DdEE=-f7rZ8V46O125wKDqE1muA645sdUg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 19:06:21 +0300
Message-ID: <CAHp75VcYaGmEruEsi2UUrLU4=k3OpBn2YV8B0LhyrhtQ=uCTXg@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] pinctrl: meson: Replace custom code by
 gpiochip_node_count() call
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 6:32 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> On Thu, Apr 14, 2022 at 3:51 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> [...]
> > > This patch landed in linux next-20220413 as commit 88834c75cae5
> > > ("pinctrl: meson: Replace custom code by gpiochip_node_count() call").
> > > Unfortunately it breaks booting of all my Amlogic-based test boards
> > > (Odroid C4, N2, Khadas VIM3, VIM3l). MMC driver is no longer probed and
> > > boards are unable to mount rootfs. Reverting this patch on top of
> > > linux-next fixes the issue.
> >
> > Thank you for letting me know, I'll withdraw it and investigate.
> If needed I can investigate further later today/tomorrow. I think the
> problem is that our node name doesn't follow the .dts recommendation.
>
> For GXL (arch/arm64/boot/dts/amlogic/meson-gxl.dtsi) the GPIO
> controller nodes are for example:
>   gpio: bank@4b0 {
>       ...
>   }
> and
>   gpio_ao: bank@14 {
>       ...
>   }
>
> See also:
> $ git grep -C6 gpio-controller arch/arm64/boot/dts/amlogic/*.dtsi
>
> Marek did not state which error he's getting but I suspect it fails
> with "no gpio node found".

Would be interesting to know that, yeah.

The subtle difference between the patched and unpatched version is
that the former uses only available nodes, it means that node is not
available by some reason and then the error would be the one you
guessed.

-- 
With Best Regards,
Andy Shevchenko
