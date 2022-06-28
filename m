Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E62555E3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbiF1M7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiF1M7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:59:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D62FFC4;
        Tue, 28 Jun 2022 05:59:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so25568875ejc.10;
        Tue, 28 Jun 2022 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xDecVtCYD/XjP/cNxfyUNjbT22tvyLt7gwAbzs5/kc0=;
        b=X/ShBLHihRUDKZ000u8wVfrWGL6G5yXX5y+1EwDRFK4CRDdMz/rQO7D/NSlHp0lGzx
         nLr6XBx4C4P75mJpqkXBOLaDErJqTw/llcE4iQPvcQu7tdM7kevZgWZt1+RBvyLfchWn
         KVTj42bWhLl/AoXlO0SccC7+FTFz+DY60SLzsxoXbsNqW0rFLr+k7Ebh7z9FpgEAKl1E
         vGqvc+pVwVE/xanKFAJfRaqVc0tF840Dc3ydBta7e/fldfaRdlejz9vZdcvVQd60xdCQ
         oJNys+Piy6FLU/uLYXd3WS8f1KNHY/QUOTQa1pl1hZjslNxnR+I1+YpkuFz3ZolQKk30
         fWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xDecVtCYD/XjP/cNxfyUNjbT22tvyLt7gwAbzs5/kc0=;
        b=ZlhjrN4EQXDaHO+87eUMURY+MVCeJwJE1eDmEeWp28w2c/n6H0nJZXfBbBRNpzLos/
         xt+S8sA5E5dYEXcTJ5TX/d3d4OHsVzOl3EhCYKLG70rTjwP90R5wgvDPmueIj9eJRfc/
         2MHBamud1E9z1hkdwwkX/CMM+IgxamYFqVSkvt+Jx8LWnG93usX20GZnpQBeTScZG3BS
         hoZhSAeAqt8aOBrqOqK2nozuCHJEIoBsW6xlJnFzTfDge1649ODo4pZGut6KX3Uc45Cc
         JYsyDNCsp8UOd0B/yWz9brx0U20+qwoJVOQRdVkBAUhEJQuXWv5KsoH9fBxP3/82juSd
         +PKg==
X-Gm-Message-State: AJIora8xzCtG62zKyiVaMan4io7XuK391Zd8G61zZ3di1uxrUpyfqfGI
        NrwhQ7561djk0+9FWicmFp2vM4jBt6IH3jbanu8=
X-Google-Smtp-Source: AGRyM1vBt1Zma4l92xd9XCjZPNuqb5fG7YZItlTpxadxcxiR3I/h+XYFdlIJe3z5eR86vEZ5tlfLHO1FFw4deCPnWus=
X-Received: by 2002:a17:907:97d0:b0:726:ccd3:1757 with SMTP id
 js16-20020a17090797d000b00726ccd31757mr3354107ejc.399.1656421151376; Tue, 28
 Jun 2022 05:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220624165211.4318-1-r.stratiienko@gmail.com>
 <1779483.VLH7GnMWUR@jernej-laptop> <CAGphcd=ND93Kek+8=WhXQcU2Z54megQJOetZnwx-EhHwG8ZjDQ@mail.gmail.com>
 <CAGphcdkqWwXhF+4uEjCyRc3TJ_cbs+rbcE=buuZfVu12Es9nyg@mail.gmail.com>
In-Reply-To: <CAGphcdkqWwXhF+4uEjCyRc3TJ_cbs+rbcE=buuZfVu12Es9nyg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Jun 2022 14:58:59 +0200
Message-ID: <CAJiuCcfC6px7nGW5wAeu1B5g1+5wY4kciD8PSRhOa96r=u9YHw@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration
 to support DFS
To:     Roman Stratiienko <r.stratiienko@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Roman, Jernej,

On Sat, 25 Jun 2022 at 16:02, Roman Stratiienko <r.stratiienko@gmail.com> w=
rote:
>
> PS:
>
> For better DFS resolution P or GPU_CLK divider can be preprogrammed
> and GPU_PLL can be marked with fixed out divider. It's safe. Not safe
> to touch these regs during runtime.
> But do we really need that resolution?
>
> =D1=81=D0=B1, 25 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 16:27, Roman Str=
atiienko <r.stratiienko@gmail.com>:
> >
> > Hi,
> >
> > DVFS was tested as DVFS using devfreq driver, not the script.
> >
> > The following OPP table was used:
> > https://github.com/clementperon/linux/commit/add3ef683238095d2721de0360=
1d5b01f2d9ce22

I now remember when I tried to enable GPU devfreq on H6 and noticed
instability, I made a recap of my searches:
https://lore.kernel.org/lkml/CAJiuCce58Gaxf_Qg2cnMwvOgUqYU__eKb3MDX1Fe_+47h=
tg2bA@mail.gmail.com/

And found that Megous gave a possible explanation on linux-sunxi IRC:

20:12 <megi> looks like gpu pll on H6 is NKMP clock, and those are
implemented in such a way in mainline that they are prone to
overshooting the frequency during output divider reduction
20:13 <megi> so disabling P divider may help
20:13 <megi> or fixing the dividers
20:14 <megi> and just allowing N to change
20:22 <megi> hmm, I haven't looked at this for quite some time, but H6
BSP way of setting PLL factors actually makes the most sense out of
everything I've seen/tested so far
20:23 <megi> it waits for lock not after setting NK factors, but after
reducing the M factor (pre-divider)
20:24 <megi> I might as well re-run my CPU PLL tester with this
algorithm, to see if it fixes the lockups
20:26 <megi> it makes sense to wait for PLL to stabilize "after"
changing all the factors that actually affect the VCO, and not just
some of them
20:27 <megi> warpme_: ^
20:28 <megi> it may be the same thing that plagues the CPU PLL rate
changes at runtime

Regards,
Clement


> >
> > As is already mentioned in the commit message, P causes the issues as w=
ell.
> >
> > Regards,
> > Roman
> >
> > =D1=81=D0=B1, 25 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 13:43, Jernej =
=C5=A0krabec <jernej.skrabec@gmail.com>:
> >
> > >
> > > Hi Roman,
> > >
> > > Dne petek, 24. junij 2022 ob 18:52:11 CEST je Roman Stratiienko napis=
al(a):
> > > > Using simple bash script it was discovered that not all CCU registe=
rs
> > > > can be safely used for DFS, e.g.:
> > > >
> > > >     while true
> > > >     do
> > > >         devmem 0x3001030 4 0xb0003e02
> > > >         devmem 0x3001030 4 0xb0001e02
> > > >     done
> > > >
> > > > Script above changes the GPU_PLL multiplier register value. While t=
he
> > > > script is running, the user should interact with the user interface=
.
> > > >
> > > > Using this method the following results were obtained:
> > > > | Register  | Name           | Bits  | Values | Result |
> > > > | --        | --             | --    | --     | --     |
> > > > | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> > > > | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> > > > | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> > > > | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> > > >
> > > > Once bits that caused system failure disabled (kept default 0),
> > > > it was discovered that GPU_CLK.MUX was used during DFS for some
> > > > reason and was causing the failure too.
> > > >
> > > > After disabling GPU_PLL.OUTDIV the system started to fail during
> > > > booting for some reason until the maximum frequency of GPU_PLL
> > > > clock was limited to 756MHz.
> > > >
> > > > After all the changes made DVFS started to work seamlessly.
> > >
> > > I appreciate testing effort, but I don't think userspace approach is =
good way
> > > for testing DVFS. I see 2 issues:
> > > - As name already suggest, voltage also plays crucial role for stabil=
ity. You
> > > didn't say on which board you tested this, but I assume it has PMIC. =
Did you
> > > make sure GPU voltage regulator is always at 1.04 V, which is needed =
for 756
> > > MHz?
> > > - Kernel clock driver always goes through proper procedure for clock =
rate
> > > change, which involves several steps. Bypassing them might also cause=
 some
> > > stability problems.
> > >
> > > I agree that GPU PLL should be limited to 756 MHz max. This seems to =
be
> > > maximum operating point specified at vendor DT. But I managed to extr=
act some
> > > more information from vendor GPU driver. More specifically, from this=
 snippet,
> > > located in modules/gpu/mali-midgard/kernel_mode/driver/drivers/gpu/ar=
m/
> > > midgard/platform/sunxi/mali_kbase_config_sunxi.c:
> > >
> > > pll_freq =3D target->freq;
> > > while (pll_freq < 288000000)
> > >         pll_freq *=3D 2;
> > >
> > > err =3D clk_set_rate(sunxi_mali->gpu_pll_clk, pll_freq);
> > > <...>
> > > err =3D clk_set_rate(kbdev->clock, target->freq);
> > > <...>
> > >
> > > Apparently, minimum stable PLL frequency is 288 MHz (this should be a=
dded) and
> > > divider in peripheral clock can really be used, although preferably n=
ot.
> > > Vendor GPU operating points specify only 2 lower than 288 MHz points =
- at 264
> > > MHz and 216 MHz. I'm fully aware that they may not be really stable a=
nd given
> > > that these two and next two all share minimum voltage of 810 mV, powe=
r and
> > > thermal savings are probably not that great, so we can skip them and =
pin
> > > peripheral divider to 1, as you already did.
> > >
> > > Another discrepancy I see is that vendor DT has two operating points,=
 at 336
> > > MHz and 384 MHz, which also use factor P (also known as d2 in vendor =
clock
> > > source). This can be again an oversight or alternatively, it can be t=
hat P
> > > factor can actually be used, but just with lower frequencies.
> > >
> > > Can you please make another test with GPU operating points specified =
in DT and
> > > check if it works with P factor left in?
> > >
> > > For reference, vendor DT has following operating points (kHz, uV):
> > > 756000 1040000
> > > 624000 950000
> > > 576000 930000
> > > 540000 910000
> > > 504000 890000
> > > 456000 870000
> > > 432000 860000
> > > 420000 850000
> > > 408000 840000
> > > 384000 830000
> > > 360000 820000
> > > 336000 810000
> > > 312000 810000
> > > 264000 810000
> > > 216000 810000
> > >
> > > Best regards,
> > > Jernej
> > >
> > > >
> > > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > > > ---
> > > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 12 +++++-------
> > > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..d941238=
cd178a
> > > > 100644
> > > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > @@ -95,13 +95,14 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> > > >       },
> > > >  };
> > > >
> > > > +/* For GPU PLL, using an output divider for DFS causes system to f=
ail */
> > > >  #define SUN50I_H6_PLL_GPU_REG                0x030
> > > >  static struct ccu_nkmp pll_gpu_clk =3D {
> > > >       .enable         =3D BIT(31),
> > > >       .lock           =3D BIT(28),
> > > >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > > >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > > > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> > > */
> > > > +     .max_rate       =3D 756000000UL,
> > > >       .common         =3D {
> > > >               .reg            =3D 0x030,
> > > >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > > > @@ -294,12 +295,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_c=
lk,
> > > > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > > > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> > > >
> > > > -static const char * const gpu_parents[] =3D { "pll-gpu" };
> > > > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x67=
0,
> > > > -                                    0, 3,    /* M */
> > > > -                                    24, 1,   /* mux */
> > > > -                                    BIT(31), /* gate */
> > > > -                                    CLK_SET_RATE_PARENT);
> > > > +/* GPU_CLK divider kept disabled to avoid interferences with DFS *=
/
> > > > +static SUNXI_CCU_GATE(gpu_clk, "gpu", "pll-gpu", 0x670,
> > > > +                   BIT(31), CLK_SET_RATE_PARENT);
> > > >
> > > >  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
> > > >                     0x67c, BIT(0), 0);
> > >
> > >
> > >
> > >
