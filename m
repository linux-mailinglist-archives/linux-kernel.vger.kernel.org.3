Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3555AA7A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiFYN1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiFYN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:27:30 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64761AD90;
        Sat, 25 Jun 2022 06:27:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id cu16so8480086qvb.7;
        Sat, 25 Jun 2022 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xRdSP7QQn9LxuyU8uv6iNySp3ZKuXkCcCH1GRGHjMhA=;
        b=QLaZ8jRqnmn+9YHJWbj270cALwkgOZZr6BIgy7cd33D71vTwiC1VdOdBZZQzViLLAh
         M8ZgtPmC1H5wHXvkjaitqL9tQYwTmzB+tPsNFNGDwjQK3evna4OlxXCIL+Y+JIxLLCIm
         WeP0mUi1VOCacm+AJVACduooRHEIUG4S1gVSr4BQUrulDatp7EDv7KCY2FIW4DoZO2l7
         yrZwcBogbb+KpYV3ya1HDk7PJV0OpQok9C3dTSLO5hvzMNKQ28AYWw8bcm0PDQpZFoXd
         XWh+c4FjMHQJm602b3vVqOCQ2qKSRmElJkMdXqjFJEnV5DIfHCoOt2rWkKxEQAzKio2Z
         HMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xRdSP7QQn9LxuyU8uv6iNySp3ZKuXkCcCH1GRGHjMhA=;
        b=pVppNEz6saPyn3a/TIKuBqz91H+3Wp9ERQory/xsOde4f5cIHidIqGDUfvL3MMUH2o
         Y7Oje5Jcw1jFKDiNGqjqqeJ/DRHO2H0ixZeB5faZzWEgq3uSaoA6llHiHOep1A/vP5tN
         DCO1b9FepPZY9bRbxmcC0ilEddUaaHLDX1H+VM4YzS8qU78/nJNEehd5cJSOifLMTkKf
         PQ4GIF4Bd5LhlXFbhlB07KMKroE/8/Vobhdq8cijzOX9AuGP0ViGFmwkcs+HoNpU0xZ2
         q/UPdqivUhfsSDzX08OlEG6MWFb3cHqWfzDu+fqVDJLnLNb2+zjRy27Gu2xOz+R2C97q
         wWoA==
X-Gm-Message-State: AJIora95HhiT+atTkLh8/2k5pXEtcbQaKgDDUAyDaqX5QYV6AR1gogvz
        utwznWifPMZxvStx/dF2DGQGzErL6KZJD9sHw5I=
X-Google-Smtp-Source: AGRyM1veJ9zCab2JIsHPgJYe6UpnuItqSwEVBCKKsidMdpV+rQCH8l49x5l+t0wLum7a8SbFY4wn3G+LcaNbV+cErt0=
X-Received: by 2002:a05:622a:2c6:b0:305:2da6:831f with SMTP id
 a6-20020a05622a02c600b003052da6831fmr3027687qtx.304.1656163648699; Sat, 25
 Jun 2022 06:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220624165211.4318-1-r.stratiienko@gmail.com> <1779483.VLH7GnMWUR@jernej-laptop>
In-Reply-To: <1779483.VLH7GnMWUR@jernej-laptop>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Sat, 25 Jun 2022 16:27:18 +0300
Message-ID: <CAGphcd=ND93Kek+8=WhXQcU2Z54megQJOetZnwx-EhHwG8ZjDQ@mail.gmail.com>
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

Hi,

DVFS was tested as DVFS using devfreq driver, not the script.

The following OPP table was used:
https://github.com/clementperon/linux/commit/add3ef683238095d2721de03601d5b=
01f2d9ce22

As is already mentioned in the commit message, P causes the issues as well.

Regards,
Roman

=D1=81=D0=B1, 25 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 13:43, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:

>
> Hi Roman,
>
> Dne petek, 24. junij 2022 ob 18:52:11 CEST je Roman Stratiienko napisal(a=
):
> > Using simple bash script it was discovered that not all CCU registers
> > can be safely used for DFS, e.g.:
> >
> >     while true
> >     do
> >         devmem 0x3001030 4 0xb0003e02
> >         devmem 0x3001030 4 0xb0001e02
> >     done
> >
> > Script above changes the GPU_PLL multiplier register value. While the
> > script is running, the user should interact with the user interface.
> >
> > Using this method the following results were obtained:
> > | Register  | Name           | Bits  | Values | Result |
> > | --        | --             | --    | --     | --     |
> > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> >
> > Once bits that caused system failure disabled (kept default 0),
> > it was discovered that GPU_CLK.MUX was used during DFS for some
> > reason and was causing the failure too.
> >
> > After disabling GPU_PLL.OUTDIV the system started to fail during
> > booting for some reason until the maximum frequency of GPU_PLL
> > clock was limited to 756MHz.
> >
> > After all the changes made DVFS started to work seamlessly.
>
> I appreciate testing effort, but I don't think userspace approach is good=
 way
> for testing DVFS. I see 2 issues:
> - As name already suggest, voltage also plays crucial role for stability.=
 You
> didn't say on which board you tested this, but I assume it has PMIC. Did =
you
> make sure GPU voltage regulator is always at 1.04 V, which is needed for =
756
> MHz?
> - Kernel clock driver always goes through proper procedure for clock rate
> change, which involves several steps. Bypassing them might also cause som=
e
> stability problems.
>
> I agree that GPU PLL should be limited to 756 MHz max. This seems to be
> maximum operating point specified at vendor DT. But I managed to extract =
some
> more information from vendor GPU driver. More specifically, from this sni=
ppet,
> located in modules/gpu/mali-midgard/kernel_mode/driver/drivers/gpu/arm/
> midgard/platform/sunxi/mali_kbase_config_sunxi.c:
>
> pll_freq =3D target->freq;
> while (pll_freq < 288000000)
>         pll_freq *=3D 2;
>
> err =3D clk_set_rate(sunxi_mali->gpu_pll_clk, pll_freq);
> <...>
> err =3D clk_set_rate(kbdev->clock, target->freq);
> <...>
>
> Apparently, minimum stable PLL frequency is 288 MHz (this should be added=
) and
> divider in peripheral clock can really be used, although preferably not.
> Vendor GPU operating points specify only 2 lower than 288 MHz points - at=
 264
> MHz and 216 MHz. I'm fully aware that they may not be really stable and g=
iven
> that these two and next two all share minimum voltage of 810 mV, power an=
d
> thermal savings are probably not that great, so we can skip them and pin
> peripheral divider to 1, as you already did.
>
> Another discrepancy I see is that vendor DT has two operating points, at =
336
> MHz and 384 MHz, which also use factor P (also known as d2 in vendor cloc=
k
> source). This can be again an oversight or alternatively, it can be that =
P
> factor can actually be used, but just with lower frequencies.
>
> Can you please make another test with GPU operating points specified in D=
T and
> check if it works with P factor left in?
>
> For reference, vendor DT has following operating points (kHz, uV):
> 756000 1040000
> 624000 950000
> 576000 930000
> 540000 910000
> 504000 890000
> 456000 870000
> 432000 860000
> 420000 850000
> 408000 840000
> 384000 830000
> 360000 820000
> 336000 810000
> 312000 810000
> 264000 810000
> 216000 810000
>
> Best regards,
> Jernej
>
> >
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..d941238cd17=
8a
> > 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > @@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> >       },
> >  };
> >
> > +/* For GPU PLL, using an output divider for DFS causes system to fail =
*/
> >  #define SUN50I_H6_PLL_GPU_REG                0x030
> >  static struct ccu_nkmp pll_gpu_clk =3D {
> >       .enable         =3D BIT(31),
> >       .lock           =3D BIT(28),
> >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> */
> > +     .max_rate       =3D 756000000UL,
> >       .common         =3D {
> >               .reg            =3D 0x030,
> >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > @@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> >
> > -static const char * const gpu_parents[] =3D { "pll-gpu" };
> > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > -                                    0, 3,    /* M */
> > -                                    24, 1,   /* mux */
> > -                                    BIT(31), /* gate */
> > -                                    CLK_SET_RATE_PARENT);
> > +/* GPU_CLK divider kept disabled to avoid interferences with DFS */
> > +static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
> > +                   BIT(31), CLK_SET_RATE_PARENT);
> >
> >  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
> >                     0x67c, BIT(0), 0);
>
>
>
>
