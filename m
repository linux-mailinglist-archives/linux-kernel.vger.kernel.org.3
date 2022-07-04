Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F8565D03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiGDRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGDRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:34:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6DD101F7;
        Mon,  4 Jul 2022 10:34:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so17835944ejb.6;
        Mon, 04 Jul 2022 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntBm6YCFWqLI4Jifkq6aFgvski3omE1H3bv/CSOM6qc=;
        b=GBdC6pzu8EVPLJsIQoXp6zsx2jlrJ1iJYDMhew3YhI2Qnefslog6Cdt9VHCB1jXfhx
         Kl83bPB0vUeztwq4AxjwuigD4W2P042Q3AhnfVpPkgWhaeUFFFXOhdtJ9s2iIC2C2Myk
         7O3dUitydNGfxsHYB1Iyi6DWJII9j8zO/Qyr7+/uCoxobq/B8tK2FFY3Pc7v/OsQQ0sd
         sy4Els9NRE3Cc0PnWIGs4pHhjc0HX6RREyczs9FAE86SrAqJdRKvRg3NoqPQSSRFAvSz
         kkK3DjCrcnazJnXRxFms5KnshcklxLNX5g+uNsfzy02Ioleh5mjOZb5YjIhvt4qJwCHG
         sdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntBm6YCFWqLI4Jifkq6aFgvski3omE1H3bv/CSOM6qc=;
        b=iQT1lf9sKZTAwSUbUOxKzkTrc85lxyA1JlSCJSnhjIF7uvjo3FpsD/fc8zJDTQet1g
         kYKkRy33TYpmshMwCPf8d3hFq3n1b796uME8WNEFarECk10WlsNsrPr023D3E0kP4QDb
         nJ1aZmOsKgzRmuDKtrhXoLdzwsQn3uL8BeQdv9mI8na6dztAADCFM2yHA9Y7fm1ej2K/
         DEBmNKkawYDOF4n65ZVPQoeO1CavMeJUljD3bZ5bXNFMbrwK3zyhJfw2VzhvKT33u5eZ
         ZRZyNYZ6faZoYa8D9OcNs7B7uEFwxVgr5dDUHDszdr8K3UEZjksD2P5kCcjeiK0r4ZLw
         H/ug==
X-Gm-Message-State: AJIora+YomHddXeA6wCNpoIBfyNk5mBfQVU2LrCZTScvUjewA+7HwR9A
        32rkZqIsn8zYQU9/xSpUg9s=
X-Google-Smtp-Source: AGRyM1tzYdkegf4LD5FIRjzUzy9j+x4YZaeYS0wfjBi2wCjFHJYvDlyuaC02znpDLDcaFLbuQAwtng==
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id e21-20020a170906505500b006ff1dfb1e2cmr13791384ejk.200.1656956085385;
        Mon, 04 Jul 2022 10:34:45 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906455000b00722bc0aa9e3sm8201642ejq.162.2022.07.04.10.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:34:44 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Mon, 04 Jul 2022 19:34:43 +0200
Message-ID: <5835545.lOV4Wx5bFT@kista>
In-Reply-To: <CAGphcdkZzjw-6oSnpiDM5YgPkuSV3VPX4nKo_FfPeg36MzT8Ew@mail.gmail.com>
References: <20220703164514.308622-1-r.stratiienko@gmail.com> <4748270.31r3eYUQgx@jernej-laptop> <CAGphcdkZzjw-6oSnpiDM5YgPkuSV3VPX4nKo_FfPeg36MzT8Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne ponedeljek, 04. julij 2022 ob 11:54:06 CEST je Roman Stratiienko=20
napisal(a):
> Hi Jernej,
>=20
> =D0=B2=D1=81, 3 =D0=B8=D1=8E=D0=BB. 2022 =D0=B3. =D0=B2 21:43, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
> >
> > Dne nedelja, 03. julij 2022 ob 18:45:14 CEST je Roman Stratiienko=20
napisal(a):
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
> > > DVFS started to work seamlessly once dividers which caused the
> > > glitches were set to fixed values.
> > >
> > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > >
> > > ---
> > >
> > > Changelog:
> > >
> > > V2:
> > > - Drop changes related to mux
> > > - Drop frequency limiting
> > > - Add unused dividers initialization
> > > ---
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
> > >  1 file changed, 13 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index 2ddf0a0da526f..1b0205ff2=
4108
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > @@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk =3D {
> > >       },
> > >  };
> > >
> > > +/* For GPU PLL, using an output divider for DFS causes system to fai=
l=20
*/
> > >  #define SUN50I_H6_PLL_GPU_REG                0x030
> > >  static struct ccu_nkmp pll_gpu_clk =3D {
> > >       .enable         =3D BIT(31),
> > >       .lock           =3D BIT(28),
> > >       .n              =3D _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > >       .m              =3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> > > -     .p              =3D _SUNXI_CCU_DIV(0, 1), /* output divider
> > */
> >
> > Having minimum (288 MHz) as per vendor GPU driver and maximum, either m=
ax.=20
opp
> > or max. from datasheet is equally good. I know that both are basically=
=20
limited
> > with opp table, but people like to play with these, so it's good to hav=
e=20
them
> > in.
> >
> > >       .common         =3D {
> > >               .reg            =3D 0x030,
> > >               .hw.init        =3D CLK_HW_INIT("pll-gpu", "osc24M",
> > > @@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk,
> > > "deinterlace", static SUNXI_CCU_GATE(bus_deinterlace_clk,
> > > "bus-deinterlace", "psi-ahb1-ahb2", 0x62c, BIT(0), 0);
> > >
> > > +/* Keep GPU_CLK divider const to avoid DFS instability. */
> > >  static const char * const gpu_parents[] =3D { "pll-gpu" };
> > > -static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > > -                                    0, 3,    /* M */
> > > +static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> > >                                      24, 1,   /* mux */
> > >                                      BIT(31), /* gate */
> > >                                      CLK_SET_RATE_PARENT);
> > > @@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct=20
platform_device
> > > *pdev) if (IS_ERR(reg))
> > >               return PTR_ERR(reg);
> > >
> > > +     /* Force PLL_GPU output divider to 0 */
> >
> > Divider  0 here
> >
> > > +     val =3D readl(reg + SUN50I_H6_PLL_GPU_REG);
> > > +     val &=3D ~BIT(0);
> > > +     writel(val, reg + SUN50I_H6_PLL_GPU_REG);
> > > +
> > > +     /* Force GPU_CLK divider to 0 */
> >
> > and here sounds wrong, since division by zero is not defined. Using 1 i=
s=20
more
> > intuitive and correct, since that's what HW actually uses.
> >
>=20
> You're right but a few lines below there is already a similar message
> (see below) , so I used similar formulation to avoid confusion.

Right. But there is another block of code below:

/*
 * Force the post-divider of pll-audio to 12 and the output divider
 * of it to 2, so 24576000 and 22579200 rates can be set exactly.
 */
=2E..
writel(val | (11 << 16) | BIT(0), reg + SUN50I_H6_PLL_AUDIO_REG);

Let's follow better practice. Eventually video PLL comment should be fixed =
by=20
somebody.

>=20
>         /*
>          * Force the output divider of video PLLs to 0.
>          *
>          * See the comment before pll-video0 definition for the reason.
>          */
>=20
> > Patch looks good otherwise.
>=20
> May I have your r-b?

Yes.

Best regards,
Jernej

>=20
> Best regards,
> Roman
>=20
> >
> > Best regards,
> > Jernej
> >
> > > +     val =3D readl(reg + gpu_clk.common.reg);
> > > +     val &=3D ~GENMASK(3, 0);
> > > +     writel(val, reg + gpu_clk.common.reg);
> > > +
> > >       /* Enable the lock bits on all PLLs */
> > >       for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> > >               val =3D readl(reg + pll_regs[i]);
> >
> >
> >
> >
>=20


