Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0ED55AAB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiFYOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiFYOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 10:02:40 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9714D12;
        Sat, 25 Jun 2022 07:02:39 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c1so8531412qvi.11;
        Sat, 25 Jun 2022 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YaU1kXnV6LeaAcGxgWHWpyw/PlmZs0eVEVa2S4Lg9U0=;
        b=H6IyFBessDmHRNerNaGmtJlCBDxoBo1ob+iWsuj2gUWdDKbDUtDLmYnzQt52DJxAC2
         OlfdeHWfK2zFgpaEMIgVR4HiTv4sS8zvIsXX3TuabWepK3T3SFP6zgxYip1ifgzT/y/X
         SeBZfKU10A2LD7vydDZgKy6aPC13YFJ1n9B4/mv85DqCDcXlJpxaO9sbKURvUVN81n4x
         WimSFvPfhJebjd6dx0NZMAfLGx8Z7iSmAMSKC5S28tmvdIO6pjDj9cRs9QNqEJaaB9JE
         nGW6WXG6/SsMBn/ev+PF3cCO+LxuEXO5SGhFphCQUJDFe4kqi1Ceyh4A4Nr/JFzgNrWn
         GoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YaU1kXnV6LeaAcGxgWHWpyw/PlmZs0eVEVa2S4Lg9U0=;
        b=Qrg01DeUWj0xiHjBA2TH5sKqQ4FepZHbakoV1v89uwupvbNixRNGQk2mHh7hr7q8XD
         Q3S8gOzDlMwOwCk/1sE4oLklL8EuvXVbxBHdqQoL6h3EdgA0S65ngQWDh/bUS8D+hDrG
         3BCnH3z7gVmHDFf7HCfZaIe3n9EDcSvDenekbZ5+oRyrj9e+EFtlay17zt/FGAGfSutS
         puBtQTGsbGVl5lGgy+p5SIlfKfoWWA5Q2pKUEMhf5Co9S/yKAQzmkqD+LUuBeubno132
         P9LBj+TVOnSsCrDgJj0LHrdDYLl7ZW72n6ZBlZmijEobxmTbZl+ExiKz9ZBF4g+Uf5EO
         EgHw==
X-Gm-Message-State: AJIora/WfQUd/vFwm2rATgj9nBTWx7s8AsO3Vb1fAQ8Ugm5en6pUV7pp
        YPYa5RAfHE7xCVBPkcdIUXxJhQkrvCWkGe+WT1CdEjTG
X-Google-Smtp-Source: AGRyM1u4h/f3IIWgZMp/8Us/BSvNENV9+XqECUv0ZmKNC0v4etsDsv6fiZGj3RcyfSSeY0SDjFvova+bS+Kyt/FCq1Q=
X-Received: by 2002:a05:6214:c83:b0:470:5385:ffb0 with SMTP id
 r3-20020a0562140c8300b004705385ffb0mr784909qvr.122.1656165758595; Sat, 25 Jun
 2022 07:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220624165211.4318-1-r.stratiienko@gmail.com>
 <1779483.VLH7GnMWUR@jernej-laptop> <CAGphcd=ND93Kek+8=WhXQcU2Z54megQJOetZnwx-EhHwG8ZjDQ@mail.gmail.com>
In-Reply-To: <CAGphcd=ND93Kek+8=WhXQcU2Z54megQJOetZnwx-EhHwG8ZjDQ@mail.gmail.com>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Sat, 25 Jun 2022 17:02:27 +0300
Message-ID: <CAGphcdkqWwXhF+4uEjCyRc3TJ_cbs+rbcE=buuZfVu12Es9nyg@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration
 to support DFS
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PS:

For better DFS resolution P or GPU_CLK divider can be preprogrammed
and GPU_PLL can be marked with fixed out divider. It's safe. Not safe
to touch these regs during runtime.
But do we really need that resolution?

=D1=81=D0=B1, 25 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 16:27, Roman Strat=
iienko <r.stratiienko@gmail.com>:
>
> Hi,
>
> DVFS was tested as DVFS using devfreq driver, not the script.
>
> The following OPP table was used:
> https://github.com/clementperon/linux/commit/add3ef683238095d2721de03601d=
5b01f2d9ce22
>
> As is already mentioned in the commit message, P causes the issues as wel=
l.
>
> Regards,
> Roman
>
> =D1=81=D0=B1, 25 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 13:43, Jernej =
=C5=A0krabec <jernej.skrabec@gmail.com>:
>
> >
> > Hi Roman,
> >
> > Dne petek, 24. junij 2022 ob 18:52:11 CEST je Roman Stratiienko napisal=
(a):
> > > Using simple bash script it was discovered that not all CCU registers
> > > can be safely used for DFS, e.g.:
> > >
> > >     while true
> > >     do
> > >         devmem 0x3001030 4 0xb0003e02
> > >         devmem 0x3001030 4 0xb0001e02
> > >     done
> > >
> > > Script above changes the GPU_PLL multiplier register value. While the
> > > script is running, the user should interact with the user interface.
> > >
> > > Using this method the following results were obtained:
> > > | Register  | Name           | Bits  | Values | Result |
> > > | --        | --             | --    | --     | --     |
> > > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> > >
> > > Once bits that caused system failure disabled (kept default 0),
> > > it was discovered that GPU_CLK.MUX was used during DFS for some
> > > reason and was causing the failure too.
> > >
> > > After disabling GPU_PLL.OUTDIV the system started to fail during
> > > booting for some reason until the maximum frequency of GPU_PLL
> > > clock was limited to 756MHz.
> > >
> > > After all the changes made DVFS started to work seamlessly.
> >
> > I appreciate testing effort, but I don't think userspace approach is go=
od way
> > for testing DVFS. I see 2 issues:
> > - As name already suggest, voltage also plays crucial role for stabilit=
y. You
> > didn't say on which board you tested this, but I assume it has PMIC. Di=
d you
> > make sure GPU voltage regulator is always at 1.04 V, which is needed fo=
r 756
> > MHz?
> > - Kernel clock driver always goes through proper procedure for clock ra=
te
> > change, which involves several steps. Bypassing them might also cause s=
ome
> > stability problems.
> >
> > I agree that GPU PLL should be limited to 756 MHz max. This seems to be
> > maximum operating point specified at vendor DT. But I managed to extrac=
t some
> > more information from vendor GPU driver. More specifically, from this s=
nippet,
> > located in modules/gpu/mali-midgard/kernel_mode/driver/drivers/gpu/arm/
> > midgard/platform/sunxi/mali_kbase_config_sunxi.c:
> >
> > pll_freq =3D target->freq;
> > while (pll_freq < 288000000)
> >         pll_freq *=3D 2;
> >
> > err =3D clk_set_rate(sunxi_mali->gpu_pll_clk, pll_freq);
> > <...>
> > err =3D clk_set_rate(kbdev->clock, target->freq);
> > <...>
> >
> > Apparently, minimum stable PLL frequency is 288 MHz (this should be add=
ed) and
> > divider in peripheral clock can really be used, although preferably not=
.
> > Vendor GPU operating points specify only 2 lower than 288 MHz points - =
at 264
> > MHz and 216 MHz. I'm fully aware that they may not be really stable and=
 given
> > that these two and next two all share minimum voltage of 810 mV, power =
and
> > thermal savings are probably not that great, so we can skip them and pi=
n
> > peripheral divider to 1, as you already did.
> >
> > Another discrepancy I see is that vendor DT has two operating points, a=
t 336
> > MHz and 384 MHz, which also use factor P (also known as d2 in vendor cl=
ock
> > source). This can be again an oversight or alternatively, it can be tha=
t P
> > factor can actually be used, but just with lower frequencies.
> >
> > Can you please make another test with GPU operating points specified in=
 DT and
> > check if it works with P factor left in?
> >
> > For reference, vendor DT has following operating points (kHz, uV):
> > 756000 1040000
> > 624000 950000
> > 576000 930000
> > 540000 910000
> > 504000 890000
> > 456000 870000
> > 432000 860000
> > 420000 850000
> > 408000 840000
> > 384000 830000
> > 360000 820000
> > 336000 810000
> > 312000 810000
> > 264000 810000
> > 216000 810000
> >
> > Best regards,
> > Jernej
> >
> > >
> > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > > ---
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..d941238cd=
178a
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > @@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> > >       },
> > >  };
> > >
> > > +/* For GPU PLL, using an output divider for DFS causes system to fai=
l */
> > >  #define SUN50I_H6_PLL_GPU_REG                0x030
> > >  static struct ccu_nkmp pll_gpu_clk =3D {
> > >       .enable         =3D BIT(31),
> > >       .lock           =3D BIT(28),
> > >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> > */
> > > +     .max_rate       =3D 756000000UL,
> > >       .common         =3D {
> > >               .reg            =3D 0x030,
> > >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > > @@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk=
,
> > > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> > >
> > > -static const char * const gpu_parents[] =3D { "pll-gpu" };
> > > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > > -                                    0, 3,    /* M */
> > > -                                    24, 1,   /* mux */
> > > -                                    BIT(31), /* gate */
> > > -                                    CLK_SET_RATE_PARENT);
> > > +/* GPU_CLK divider kept disabled to avoid interferences with DFS */
> > > +static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
> > > +                   BIT(31), CLK_SET_RATE_PARENT);
> > >
> > >  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
> > >                     0x67c, BIT(0), 0);
> >
> >
> >
> >
