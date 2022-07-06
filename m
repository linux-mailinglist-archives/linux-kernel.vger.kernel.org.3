Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0323A5683F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiGFJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGFJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:46:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584B223;
        Wed,  6 Jul 2022 02:46:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o26so3516047qkl.6;
        Wed, 06 Jul 2022 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FlGR5yjoFVwhTWKssnAw48fbsd+AG8btuIa/MYgoHwQ=;
        b=GyQKyBfcbaQn0NY3C/hXODPWJ2dkrlNEeiztnZ2zXpbzSpHYGloYq7XHMEJ9vxVdc8
         s0bgr+fkHNk94NF13sbHLYAYLvsweCnLOdpzcrbAFB2zl0gKsdYNnNRT/DgQOaxgJqIz
         br3yoXUCmIto/jlzELS29AGHJxBVlvfe6y8DWXhDfnohDFhXlfVoDherH/Oe32qCULEa
         AMNjB0upksTLcWxVDVDqr6dI1fKI3klfMk2i6W4PdSU7+T9N4V9qk5sJjkyTcRoYXanZ
         xMgwaVEaVQpnFGOqz1AIAHG5s1dWaN7stqz+2Ydhur1Ef0H6EsdthXOCvUtAmBZms+B9
         K1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FlGR5yjoFVwhTWKssnAw48fbsd+AG8btuIa/MYgoHwQ=;
        b=CbEvTbQVpNT+8Ra0/2qiZZD1+KB5b7iZQfvO4x8I380cs9N39zjRMSfVq4m1/FtzcC
         wGKFKD8wdbq/5xZBqSreEhmYv6kg1G8P8uQNlk03rd0ZoF/MQ9tCmLTO7c3cvlk3obxE
         JWaKmAA7M+zkSl/mQuYEmuyw32UtbbS4VZJVG1WbsaYh5wNw9ueFXGJhYP/Scr7jjj4c
         IwL0cr7Jm3Xl5BWNgdi0ULszLYWMDnYRDHeSqv3HRrKCZTnQKSLIa9CfDbvH8M/GkGDo
         cOD63WNNOX7Mb4gcIjgKHdTb2Au0NjI7K4PIchBPIHspXGnKE7I8Bnq4HAP/foWZZn2p
         I1QA==
X-Gm-Message-State: AJIora8gcvHZ3fF2quFcYskdftb7mi4YbqNNiExi4iuE2jKvDgBXrHeO
        DVFbpGeCVTTJgiMOMBZTCykjV/Di5UkKdVD2L7qJ8dI4gdU=
X-Google-Smtp-Source: AGRyM1u3wRkI6zt+DKDj6XJdZvXJuqhSbz2ET2++iRICYDpUnH2UbBCwlTN9J0CRziNYkVlaM+tfryyE+GZiJ7R+cyc=
X-Received: by 2002:a05:620a:408c:b0:6b2:678c:6091 with SMTP id
 f12-20020a05620a408c00b006b2678c6091mr17060003qko.518.1657100783827; Wed, 06
 Jul 2022 02:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220705075226.359475-1-r.stratiienko@gmail.com>
 <5580615.DvuYhMxLoT@kista> <CAGphcd=O-BQRJwQbUbbFMt29jxHf+KpJWrrm5SmMhumkCBam0Q@mail.gmail.com>
 <2562485.k3LOHGUjKi@kista>
In-Reply-To: <2562485.k3LOHGUjKi@kista>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Wed, 6 Jul 2022 12:46:13 +0300
Message-ID: <CAGphcdnw3+E9cHZGUOLnroo7wTR4HRjiKJXdmihSK40jsga9Qw@mail.gmail.com>
Subject: Re: Re: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock
 configuration to support DFS
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
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

=D0=B2=D1=82, 5 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 21:07, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
>
> Dne torek, 05. julij 2022 ob 18:29:39 CEST je Roman Stratiienko napisal(a=
):
> > Hi Jernej,
> >
> > =D0=B2=D1=82, 5 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 19:07, Jernej =
=C5=A0krabec <jernej.skrabec@gmail.com>:
> > > Hi Roman,
> > >
> > > Dne torek, 05. julij 2022 ob 09:52:26 CEST je Roman Stratiienko
> napisal(a):
> > > > Using simple bash script it was discovered that not all CCU registe=
rs
> > > >
> > > > can be safely used for DFS, e.g.:
> > > >     while true
> > > >     do
> > > >
> > > >         devmem 0x3001030 4 0xb0003e02
> > > >         devmem 0x3001030 4 0xb0001e02
> > > >
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
> > > > DVFS started to work seamlessly once dividers which caused the
> > > > glitches were set to fixed values.
> > > >
> > > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > > >
> > > > ---
> > > >
> > > > Changelog:
> > > >
> > > > V2:
> > > > - Drop changes related to mux
> > > > - Drop frequency limiting
> > > > - Add unused dividers initialization
> > > >
> > > > V3:
> > > > - Adjust comments
> > >
> > > I don't see any comment fixed, at least not to "1", as we discussed. =
Did I
> > > miss anything?
> >
> > I've added the "bits" word, so now it should sound correct.
>
> Technically it's correct, but this would be third form of comments for fi=
xed
> bits. Let's stick to the form which is most informative ("Force PLL_GPU o=
utput
> divider to 1"). Ideally, comment would also point to gpu_clk comment for
> reason why, like it's done for video PLL block already.
>
> >
> > > Also, please add min and max.
> >
> > What is the rationale for additional limits?
>
> If limits are specified in whatever form, they should be added. As I said
> several times already, vendor code limits PLL frequency to 288 MHz minimu=
m and
> lists maximum. As experienced a few times before with video PLLs, these a=
re
> important, otherwise PLL is unstable. For example, OPP table in vendor DT=
 has
> two operating points lower than 288 MHz, which means it would either lock=
 up
> or be unstable. In such cases, vendor code actually sets GPU_CLK divider =
to 2,
> but we can skip them, because GPU_CLK divider will be hardcoded to 1 with=
 this
> patch.

What is the rationale behind vendor's freq limitation?

There's no min_rate field in ccu_nkmp. After I changed it to ccu_nm
and set limits, the system started to behave unstable with a lot of
messages in dmesg:

[   40.089091] panfrost 1800000.gpu: _generic_set_opp_clk_only: failed
to set clock rate: -22
[   40.097698] devfreq 1800000.gpu: dvfs failed with (-22) error

From the other end I have no issues so far with the current version
and I have a lot of other work to do.
I think it's a good point to stop any further improvements until
testing results show any issues with the current version.

> > CPU_PLL doesn't have these limits. I don't want to make them different.
>
> Why CPU_PLL?

According to the H6 usermanual only CPU and GPU PLLs support smooth
clock transition during DFS.

Regards,
Roman.

> Why not video PLL? In any case, it doesn't matter if struct looks
> similar to some other or is unique. Only important thing is that struct
> describes PLL as best as possible.
>
> >
> > > I also consent to R-B, which you
> > > didn't include.
> >
> > I was expecting an explicit 'review-by' line. Anyway I can add it and
> > resend v4 if it's necessary.
>
> If you at least add min and max limits, you can add following tag:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> If you send it before Friday, it will be in 5.20.
>
> Best regards,
> Jernej
>
> >
> > Regards,
> > Roman
> >
> > > Did you resend v2 instead of v3?
> > >
> > > Best regards,
> > > Jernej
> > >
> > > > ---
> > > >
> > > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
> > > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index
> > > > 2ddf0a0da526f..068d1a6b2ebf3
> > > > 100644
> > > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > > @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> > > >
> > > >       },
> > > >
> > > >  };
> > > >
> > > > +/* For GPU PLL, using an output divider for DFS causes system to f=
ail
> > > > */
> > > >
> > > >  #define SUN50I_H6_PLL_GPU_REG                0x030
> > > >  static struct ccu_nkmp pll_gpu_clk =3D {
> > > >
> > > >       .enable         =3D BIT(31),
> > > >       .lock           =3D BIT(28),
> > > >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > > >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > > >
> > > > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> > >
> > > */
> > >
> > > >       .common         =3D {
> > > >
> > > >               .reg            =3D 0x030,
> > > >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > > >
> > > > @@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_cl=
k,
> > > > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > > > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> > > >
> > > > +/* Keep GPU_CLK divider const to avoid DFS instability. */
> > > >
> > > >  static const char * const gpu_parents[] =3D { "pll-gpu" };
> > > >
> > > > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x67=
0,
> > > > -                                    0, 3,    /* M */
> > > > +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > > >
> > > >                                      24, 1,   /* mux */
> > > >                                      BIT(31), /* gate */
> > > >                                      CLK_SET_RATE_PARENT);
> > > >
> > > > @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct
> > > > platform_device *pdev) if (IS_ERR(reg))
> > > >
> > > >               return PTR_ERR(reg);
> > > >
> > > > +     /* Force PLL_GPU output divider bits to 0 */
> > > > +     val =3D readl(reg + SUN50I_H6_PLL_GPU_REG);
> > > > +     val &=3D ~BIT(0);
> > > > +     writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> > > > +
> > > > +     /* Force GPU_CLK divider bits to 0 */
> > > > +     val =3D readl(reg + gpu_clk.common.reg);
> > > > +     val &=3D ~GENMASK(3, 0);
> > > > +     writel(val, reg + gpu_clk.common.reg);
> > > > +
> > > >
> > > >       /* Enable the lock bits on all PLLs */
> > > >       for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> > > >
> > > >               val =3D readl(reg + pll_regs[i]);
> > > >
> > > > --
> > > > 2.34.1
>
>
