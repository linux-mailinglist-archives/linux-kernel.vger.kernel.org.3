Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8AE578A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiGRTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiGRTO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD92C2CCB4;
        Mon, 18 Jul 2022 12:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D524616BD;
        Mon, 18 Jul 2022 19:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5D3C341C0;
        Mon, 18 Jul 2022 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658171694;
        bh=dqjX1mmlML3aigT0dIo8r1Wy/YrsKN/Sc5/hAu3AZzE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g5m5lFVBpvfVj/WQ+kexwatTrjuly4N3LBV3QOw/e0BZ3pUCvUeUn9ogK8GqAA/He
         3GjokFeeQjW9zgoMmALq66vrpNXxp9pqDOw0T9C6y2RE2QnH9T5UYntnaYytTYW6iC
         BZSChVAJv9ydeKNVw3xFg8QSQRSCcntrrS1T5NxqwfHwTy3hY0Yr4ST6W5c+LFT/Gr
         Ts+dsAqW5UX3PhieBu/xbTnqjQLDQNvlyFB+P1qn5hSUCqL4eC3xARjzRPQgNecrKm
         lbyEwb1cL4pBOblVbBagqIitt/yx0TtUhlh8eySseKctsxu259KSAAZD0ZWuPDHkXZ
         j21F1HzcZR6fg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com> <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, open list:
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>, ;
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     ;
                        ^-missing semicolon to end mail group, extraneous tokens in mailbox, missing end of mailbox
To:     Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 18 Jul 2022 12:14:52 -0700
User-Agent: alot/0.10
Message-Id: <20220718191454.5B5D3C341C0@smtp.kernel.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-07-12 00:28:30)
> On Mon, 11 Jul 2022 at 22:55, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Tomer Maimon (2022-07-11 05:35:07)
> > > +        */
> > > +       int onecell_idx;
> > > +};
> > > +
> > > +struct npcm8xx_clk_pll_data {
> > > +       u32 reg;
> > > +       const char *name;
> > > +       const char *parent_name;
> >
> > Any reason why we're not using clk_parent_data or direct clk_hw
> > pointers?
> For more historical reasons, I did the same method as done in the
> NPCM7XX driver.
> The clk_init_data struct can use * const *parent_names,
> https://elixir.bootlin.com/linux/v5.19-rc6/source/include/linux/clk-provi=
der.h#L289
> Is it problematic?

It will need to be changed to not use global string matching. Ideally
new drivers use clk_parent_data or clk_hw pointers directly. It's faster
and preferred.

> >
> > > +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0=
},
> > > +       /* bit 10-6 SPI0CKDV*/
> > > +       {NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX,
> > > +       NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX=
},
> > > +       /* bit 5-1 SPIXCKDV*/
> > > +
> > > +       {NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, NPCM8XX_CLK_S_RG_M=
UX,
> > > +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG},
> > > +       /* bit 31-28 RGREFDIV*/
> > > +       {NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, NPCM8XX_CLK_S_RCP=
_MUX,
> > > +       CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP},
> > > +       /* bit 15-12 RCPREFDIV*/
> > > +       {NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, NPCM8XX_CLK_S_CPU=
_MUX,
> > > +       CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_=
CLK_TH},
> > > +       /* bit 1-0 TH_DIV*/
> > > +};
> > > +
> > > +static DEFINE_SPINLOCK(npcm8xx_clk_lock);
> > > +
> > > +static int npcm8xx_clk_probe(struct platform_device *pdev)
> > > +{
> > > +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct device_node *np =3D dev->of_node;
> > > +       void __iomem *clk_base;
> > > +       struct resource res;
> > > +       struct clk_hw *hw;
> > > +       int i, err;
> > > +
> > > +       npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_cl=
k_data, hws,
> > > +                                                        NPCM8XX_NUM_=
CLOCKS),
> > > +                                       GFP_KERNEL);
> > > +       if (!npcm8xx_clk_data)
> > > +               return -ENOMEM;
> > > +
> > > +       err =3D of_address_to_resource(np, 0, &res);
> >
> > Why can't we use platform_get_resource()?
> >
> > > +       if (err) {
> > > +               dev_err(dev, "Failed to get resource, ret %d\n", err);
> > > +               return err;
> > > +       }
> > > +
> > > +       clk_base =3D ioremap(res.start, resource_size(&res));
> >
> > And use devm_platform_ioremap_resource()?
> Clock and reset driver use the same memory register map 0xF0801000 - 0xF0=
801FFF.
> For historical reasons the registers of both modules are mixed in the
> memory range 0xF0801000 - 0xF0801FFF this is why we can't have a
> separate region for each module.
> In case I will use devm_platform_ioremap_resource function the reset
> ioremap will fail so the driver using the method above.

So the clk and reset driver should be the same driver, or one driver
should register the other and use the auxiliary bus to express the
relationship. That way we know that the drivers are tightly coupled and
aren't going to stomp over each other.

> >
> > > +       if (!clk_base) {
> > > +               dev_err(&pdev->dev, "Failed to remap I/O memory\n");
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > > +       npcm8xx_clk_data->num =3D NPCM8XX_NUM_CLOCKS;
> > > +
> > > +       for (i =3D 0; i < NPCM8XX_NUM_CLOCKS; i++)
> > > +               npcm8xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> > > +
> > > +       /* Reference 25MHz clock */
> >
> > Does this exist on the board? If so, I'd make a fixed rate clk in the
> > dts and have 'refclk' be an input in the binding for this clk controlle=
r.
> No, it is an internal clock in the SoC, this is why it is in the driver.

Ok. I suppose that could be inside the 'soc' node for this device as a
fixed rate clk but registering it here is also fine.
