Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB5553304
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351022AbiFUNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350371AbiFUNLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:11:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8C1147;
        Tue, 21 Jun 2022 06:11:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g4so9927319lfv.9;
        Tue, 21 Jun 2022 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pT++iK9WcctTanQiCvnTfb9W8yhobxvRpjyCBAIZWck=;
        b=oJUJPABoUnG2+qZ2VCmG39A8g5dROXZgeRM0/gI/v5LVcnGVMIPP/gd3eMshxv0an9
         R6EfvZOy+68SlNADRtK9kg1+d97J1/vu/D6amSunFQqTYbSUX1SiyZOUO4hm7bM82Xsf
         CAzcikm/lw9Q82+fc5RAr9zGbuqvFK5PHJFediOkxu5JALP4Z+gl2XWOsMcqdJmp1hoJ
         yGl2ACaJeJX7WGt0cwz7Olxfol1QI7D7c6A2NBAG3wb4+BDFWh6DoRNYoz08cHR+b6P4
         sq5oG/C6EgDUb6UbS4f9d9IbsHLTkUwpDe4tKQaI5M/jFBz13iInIbApwIbTmR0zxg+o
         womQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pT++iK9WcctTanQiCvnTfb9W8yhobxvRpjyCBAIZWck=;
        b=yqTXDRisWy8UpFtrTG7LI7cAazSCJq2RCTD0aP09hAjZhNEVg3Ix6yAVVX0jeuKHwP
         KtwOuecv8fLgotZkKTwVfgYKoJ+k22Kr156EWcmPdqBUpxXZ+Hn+eOlIztjK6OSLcWhB
         nRbCSvQ3nKxXyteXhpuA9Tc3HoyUXHY/RTAdo1Kpzt7jh+ySDL8g466FRxmKMpP+SSin
         5/LbyYsLvB0OGChhQOqnS4jw+r3aBezcne8nXCI/sMudxiZeVP4t+B9JsQ+zCh2xUhhU
         53VlGH83yCsrgkkwYjMkZsv56yBENw+B4o3lWmTtt1jCrA7tH3zZrq1/H2KbWmncVcg5
         vF1Q==
X-Gm-Message-State: AJIora8TpJGbWdtQCHZ90VKUgSXjs1AuigJjQIBQCtwjY/KmP2oFjj3p
        NIwOnj/0D2J5+0dhlLRFHUavr+x3YcIcDQ4xaE4=
X-Google-Smtp-Source: AGRyM1vzRjl2gY2luQ42k/bZxR1pdhPsnRL7fI9WShuU2un2uuHMcYtajgZZvGJlwMyuHXkhTgNx25P/XxVJkAR80N4=
X-Received: by 2002:a05:6512:2291:b0:47f:7c78:bd01 with SMTP id
 f17-20020a056512229100b0047f7c78bd01mr2272879lfu.668.1655817101911; Tue, 21
 Jun 2022 06:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220619151225.209029-1-tmaimon77@gmail.com> <20220619151225.209029-7-tmaimon77@gmail.com>
 <6566c16c-f36f-6806-3879-3e6b40713e5e@wanadoo.fr> <CAP6Zq1jT3fbbRzDhriPT7JVYsrAOVGa4ukL_3yh_=wj-4f6zyA@mail.gmail.com>
 <8e35f372-0ce6-fd91-3ce0-3aae2f1f27c2@wanadoo.fr>
In-Reply-To: <8e35f372-0ce6-fd91-3ce0-3aae2f1f27c2@wanadoo.fr>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 21 Jun 2022 16:11:30 +0300
Message-ID: <CAP6Zq1gCSY68wHb-OrO5w=qDTSHh0rAsM+E61F7dq3nLf=JKog@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] clk: npcm8xx: add clock controller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, 20 Jun 2022 at 20:59, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 20/06/2022 =C3=A0 14:48, Tomer Maimon a =C3=A9crit :
> > Hi Christophe,
> >
> > Thanks for your comments.
> >
> > On Sun, 19 Jun 2022 at 20:14, Christophe JAILLET
> > <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
> >>
> >> Le 19/06/2022 =C3=A0 17:12, Tomer Maimon a =C3=A9crit :
> >>> Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller whi=
ch
> >>> generates and supplies clocks to all modules within the BMC.
> >>>
> >>> Signed-off-by: Tomer Maimon <tmaimon77-Re5JQEeQqe8AvxtiuMwx3w-XMD5yJD=
bdMQAvxtiuMwx3w@public.gmane.organe.org>
> >>> ---
> >>>    drivers/clk/Kconfig       |   6 +
> >>>    drivers/clk/Makefile      |   1 +
> >>>    drivers/clk/clk-npcm8xx.c | 760 ++++++++++++++++++++++++++++++++++=
++++
> >>>    3 files changed, 767 insertions(+)
> >>>    create mode 100644 drivers/clk/clk-npcm8xx.c
> >>>
> >>
> >> [...]
> >>
> >> Hi, below a few comments related to error handling and possible
> >> dev_err_probe() usage to savec a few LoC.
> >>
> >> CJ
> >>
> >>> +static struct clk_hw *
> >>> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> >>> +                      const char *name, const char *parent_name,
> >>> +                      unsigned long flags)
> >>> +{
> >>> +     struct npcm8xx_clk_pll *pll;
> >>> +     struct clk_init_data init;
> >>> +     struct clk_hw *hw;
> >>> +     int ret;
> >>> +
> >>> +     pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> >>> +     if (!pll)
> >>> +             return ERR_PTR(-ENOMEM);
> >>> +
> >>> +     pr_debug("%s reg, name=3D%s, p=3D%s\n", __func__, name, parent_=
name);
> >>> +
> >>> +     init.name =3D name;
> >>> +     init.ops =3D &npcm8xx_clk_pll_ops;
> >>> +     init.parent_names =3D &parent_name;
> >>> +     init.num_parents =3D 1;
> >>> +     init.flags =3D flags;
> >>> +
> >>> +     pll->pllcon =3D pllcon;
> >>> +     pll->hw.init =3D &init;
> >>> +
> >>> +     hw =3D &pll->hw;
> >>> +
> >>> +     ret =3D devm_clk_hw_register(dev, hw);
> >>> +     if (ret) {
> >>> +             kfree(pll);
> >>
> >> Hi,
> >>
> >> there is no other kfree(() in this patch. It is handled by the framewo=
rk
> >> once the clk is registered or should there be another kfree() somewher=
e
> >> or should pll be devm_alloc()'ed?
> > Could use the devm_kzalloc but the hw is sent to the devm function and
> > not the pll struct.
>
> My point, as explained below is that some resources are managed (i.e.
> allocated by a devm_ function and released by the framework if the probe
> fails or if the driver is removed), but not all.
>
> I think that it is not consistent and that maybe the release of the
> corresponding resources should be handled in a way or another.
Thanks for your clarification will Address in V4
>
> >>
> >>
> >>> +             return ERR_PTR(ret);
> >>> +     }
> >>> +
> >>> +     return hw;
> >>> +}
> >>> +
> >>
> >> [...]
> >>
> >>> +static int npcm8xx_clk_probe(struct platform_device *pdev)
> >>> +{
> >>> +     struct clk_hw_onecell_data *npcm8xx_clk_data;
> >>> +     struct device *dev =3D &pdev->dev;
> >>> +     void __iomem *clk_base;
> >>> +     struct clk_hw *hw;
> >>> +     int i;
> >>> +
> >>> +     npcm8xx_clk_data =3D devm_kzalloc(dev, struct_size(npcm8xx_clk_=
data, hws,
> >>> +                                                      NPCM8XX_NUM_CL=
OCKS),
> >>> +                                     GFP_KERNEL);
> >>> +     if (!npcm8xx_clk_data)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     clk_base =3D devm_platform_ioremap_resource(pdev, 0);
> >>> +     if (IS_ERR(clk_base))
> >>> +             return PTR_ERR(clk_base);
> >>> +
> >>> +     npcm8xx_clk_data->num =3D NPCM8XX_NUM_CLOCKS;
> >>> +
> >>> +     for (i =3D 0; i < NPCM8XX_NUM_CLOCKS; i++)
> >>> +             npcm8xx_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> >>> +
> >>> +     /* Reference 25MHz clock */
> >>> +     hw =3D clk_hw_register_fixed_rate(dev, "refclk", NULL, 0, NPCM8=
XX_REF_CLK);
> >>
> >> Other resoruces are managed, but not this one.
> >> Is it on purpose?
> > This is the fixed clock - the SoC Reference clock, what do you mean by
> > not managed?
>
> clk_hw_register_fixed_rate() allocates some memory. If an error occures
> later on or if the driver is .remove()'ed, this memory will leak.
> (unless I missed something).
>
> Most of your other function calls use some devm_ variant, so the
> corresponding resources are released automatically in case of error or
> if the driver is unloaed.
Thanks for your clarification will Address in V4
>
> >> Is an error handling path needed or a devm_add_action_or_reset()?
> >>
> >>> +     if (IS_ERR(hw))
> >>> +             return PTR_ERR(hw);
> >>> +     npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK] =3D hw;
> >>> +
> >>> +     /* Register plls */
> >>> +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_plls); i++) {
> >>> +             const struct npcm8xx_clk_pll_data *pll_data =3D &npcm8x=
x_plls[i];
> >>> +
> >>> +             hw =3D npcm8xx_clk_register_pll(dev, clk_base + pll_dat=
a->reg,
> >>> +                                           pll_data->name,
> >>> +                                           pll_data->parent_name,
> >>> +                                           pll_data->flags);
> >>> +             if (IS_ERR(hw)) {
> >>> +                     dev_err(dev, "npcm8xx_clk: Can't register pll\n=
");
> >>> +                     return PTR_ERR(hw);
> >>> +             }
> >>> +
> >>> +             if (pll_data->onecell_idx >=3D 0)
> >>> +                     npcm8xx_clk_data->hws[pll_data->onecell_idx] =
=3D hw;
> >>> +     }
> >>> +
> >>> +     /* Register fixed dividers */
> >>> +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL=
1_DIV2,
> >>> +                                            NPCM8XX_CLK_S_PLL1, 0, 1=
, 2);
> >>> +     if (IS_ERR(hw)) {
> >>> +             dev_err(dev, "npcm8xx_clk: Can't register fixed div\n")=
;
> >>> +             return PTR_ERR(hw);
> >>
> >> return dev_err_probe()?
> > it will save online but still enter to a bigger function, I am not
> > sure that the error will be EPROBE_DEFER, and we have returned the
> > error in the code.
>
> It is mostly a matter of taste, so if you don't think my proposal
> improves anything, just forget about it.
>
> >>
> >>> +     }
> >>> +
> >>> +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL=
2_DIV2,
> >>> +                                            NPCM8XX_CLK_S_PLL2, 0, 1=
, 2);
> >>> +     if (IS_ERR(hw)) {
> >>> +             dev_err(dev, "npcm8xx_clk: Can't register pll div2\n");
> >>> +             return PTR_ERR(hw);
> >>
> >> Same here and in other calls below.
> >>
> >>> +     }
> >>> +
> >>> +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE=
_CLK,
> >>> +                                            NPCM8XX_CLK_S_CPU_MUX, 0=
, 1, 2);
> >>> +     if (IS_ERR(hw)) {
> >>> +             dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n"=
);
> >>> +             return PTR_ERR(hw);
> >>> +     }
> >>> +
> >>> +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI=
,
> >>> +                                            NPCM8XX_CLK_S_TH, 0, 1, =
2);
> >>> +     if (IS_ERR(hw)) {
> >>> +             dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
> >>> +             return PTR_ERR(hw);
> >>> +     }
> >>> +
> >>> +     hw =3D devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB=
,
> >>> +                                            NPCM8XX_CLK_S_AXI, 0, 1,=
 2);
> >>> +     if (IS_ERR(hw)) {
> >>> +             dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
> >>> +             return PTR_ERR(hw);
> >>> +     }
> >>> +
> >>> +     /* Register muxes */
> >>> +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> >>> +             const struct npcm8xx_clk_mux_data *mux_data =3D &npcm8x=
x_muxes[i];
> >>> +
> >>> +             hw =3D clk_hw_register_mux_table(dev, mux_data->name,
> >>> +                                            mux_data->parent_names,
> >>> +                                            mux_data->num_parents,
> >>> +                                            mux_data->flags,
> >>> +                                            clk_base + NPCM8XX_CLKSE=
L,
> >>> +                                            mux_data->shift,
> >>> +                                            mux_data->mask, 0,
> >>> +                                            mux_data->table,
> >>> +                                            &npcm8xx_clk_lock);
> >>> +
> >> Same here. Error handling?
> > what do you mean?
>
> I mean the same as above. clk_hw_register_mux_table() allocates some
> memory. If an error occures later on or if the driver is .remove()'ed,
> this memory will leak. (unless I missed something).
>
> Error handling was not a really good wording. You should read "should
> the resources allocated by this function be released if an error occures
> below"
Thanks for your clarification will Address in V4
>
> >>
> >>> +             if (IS_ERR(hw)) {
> >>> +                     dev_err(dev, "npcm8xx_clk: Can't register mux\n=
");
> >>> +                     return PTR_ERR(hw);
> >>> +             }
> >>> +
> >>> +             if (mux_data->onecell_idx >=3D 0)
> >>> +                     npcm8xx_clk_data->hws[mux_data->onecell_idx] =
=3D hw;
> >>> +     }
> >>> +
> >>> +     /* Register clock dividers specified in npcm8xx_divs */
> >>> +     for (i =3D 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> >>> +             const struct npcm8xx_clk_div_data *div_data =3D &npcm8x=
x_divs[i];
> >>> +
> >>> +             hw =3D clk_hw_register_divider(dev, div_data->name,
> >>> +                                          div_data->parent_name,
> >>> +                                          div_data->flags,
> >>> +                                          clk_base + div_data->reg,
> >>> +                                          div_data->shift, div_data-=
>width,
> >>> +                                          div_data->clk_divider_flag=
s,
> >>> +                                          &npcm8xx_clk_lock);
> >>
> >> devm_clk_hw_register_divider()?
> > Will do.
>
> Here, the devm_ alternative exist. But my point is the same as above.
> (release of resources in cae of error or if the driver is removed)
>
> >>
> >>> +             if (IS_ERR(hw)) {
> >>> +                     dev_err(dev, "npcm8xx_clk: Can't register div t=
able\n");
> >>> +                     return PTR_ERR(hw);
> >>> +             }
> >>> +
> >>> +             if (div_data->onecell_idx >=3D 0)
> >>> +                     npcm8xx_clk_data->hws[div_data->onecell_idx] =
=3D hw;
> >>> +     }
> >>> +
> >>> +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> >>> +                                        npcm8xx_clk_data);
> >>> +}
> >>> +
> >>> +static const struct of_device_id npcm8xx_clk_dt_ids[] =3D {
> >>> +     { .compatible =3D "nuvoton,npcm845-clk", },
> >>> +     { }
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
> >>> +
> >>> +static struct platform_driver npcm8xx_clk_driver =3D {
> >>> +     .probe  =3D npcm8xx_clk_probe,
> >>> +     .driver =3D {
> >>> +             .name =3D "npcm8xx_clk",
> >>> +             .of_match_table =3D npcm8xx_clk_dt_ids,
> >>> +     },
> >>> +};
> >>> +
> >>> +static int __init npcm8xx_clk_driver_init(void)
> >>> +{
> >>> +     return platform_driver_register(&npcm8xx_clk_driver);
> >>> +}
> >>> +arch_initcall(npcm8xx_clk_driver_init);
> >>> +
> >>
> >
> > Best regards,
> >
> > Tomer
> >
>

Best regards,

Tomer
