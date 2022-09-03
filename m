Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC735AC108
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiICTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiICTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:06:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1541357E37;
        Sat,  3 Sep 2022 12:06:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m1so6676895edb.7;
        Sat, 03 Sep 2022 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=PgXAoEjaK+oBqIHlUNSsVz+XYAWaT4gNl9Cw4DlvWvk=;
        b=nZdmq14cxKphnBHlXGOFXuqbYhrcbVOU4VintRpC40x9LLWper3dLsYcLp5ygtBhn9
         tKiqtuw0oIevYBzRZx9G8S4jS5IeoJ0EpFRDJvS/N4GExmNsdo6DOMQOrcxOk6AU5hSl
         99G1p6i3mpTRjH0dE9tMWHGUPCnsDC4G/6n9cr7x5UvXoRXwxCOtLfFWSfqSyqCg+Px5
         niF+CkffW/D/oI/fRDxM+amUYVmv8VNkbd4z9yZNgbEyRAKalQS+iJ155EC99xyhqHdX
         d8sKL0CtzjMhR3zGYMQ1P1rhS9AnBYAXZYdYq4HsEU0TX8mip5bOkTqRpQdEPX4EPniM
         Notg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PgXAoEjaK+oBqIHlUNSsVz+XYAWaT4gNl9Cw4DlvWvk=;
        b=OEICzExQzJKw6YlCgyLGmm5TN9LVBmEDnkwMZQSuiAqFPsCQQsu9nBQS/CCOYL1DYr
         vWbXgGbgh4HaVFJglmcXmQLlT8XFiaa8wVkyqF6s4NT17h0HSWAT6ZTJMCqcgDwjgvAa
         edtNRCcULOma6M+i69xmLLFZHPs/HIiykhrGyykUAzZGv88ZqQShV86gOaAiIRgPgF9i
         8Nmc/VUBZsgGSeDLxZUstP/wbdQilQipJ44H0Rb2t60WTVmBy1OhShqamEvOfeakrRWH
         O/BbXBzXooyRQPjRLHcA4GMtJxA9dhI3rUM6K2v4F4qRpxkFEOjMuVw71VomjWNCuYfW
         L2cA==
X-Gm-Message-State: ACgBeo20i7MEvBKXpzH2BgpxltfLpUir12ItMkx7F+C5ubIdXOz7eJwz
        8E69IulS+KmS7hrgY1GPD75c6gqvZs+BtpVqjII=
X-Google-Smtp-Source: AA6agR6tzif0PTLPRjrJRC9n3NDsx1UfOC1EJTRL9N+BQ1uPNw79YC5jgfZkorGBMCmrSqeEBuuzrKuZ9NMh6JiQIfY=
X-Received: by 2002:a05:6402:11d0:b0:448:89ff:88f0 with SMTP id
 j16-20020a05640211d000b0044889ff88f0mr23202839edw.166.1662231980416; Sat, 03
 Sep 2022 12:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220821173051.155038-1-peron.clem@gmail.com> <20220821173051.155038-5-peron.clem@gmail.com>
 <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org> <CAJiuCcf7NuXFFLw6-RFcyZPNFPagfSB5aR7rY5528USzNB-iKg@mail.gmail.com>
In-Reply-To: <CAJiuCcf7NuXFFLw6-RFcyZPNFPagfSB5aR7rY5528USzNB-iKg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Sep 2022 21:06:08 +0200
Message-ID: <CAJiuCcf0io5T=+Ap8io2uKn+CNqrCi2pbaCtyq2PVW=bEqKakg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
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

Hi Samuel,

On Sat, 3 Sept 2022 at 20:41, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Samuel,
>
> On Tue, 23 Aug 2022 at 05:07, Samuel Holland <samuel@sholland.org> wrote:
> >
> > On 8/21/22 12:30 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > > Enable GPU OPP table for Beelink GS1
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > index 6249e9e02928..20fc0584d1c6 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > > @@ -5,6 +5,7 @@
> > >
> > >  #include "sun50i-h6.dtsi"
> > >  #include "sun50i-h6-cpu-opp.dtsi"
> > > +#include "sun50i-h6-gpu-opp.dtsi"
> > >
> > >  #include <dt-bindings/gpio/gpio.h>
> > >
> > > @@ -261,6 +262,7 @@ reg_dcdca: dcdca {
> > >                       };
> > >
> > >                       reg_dcdcc: dcdcc {
> > > +                             regulator-always-on;
> >
> > Why is this necessary? This file already has:
>
> This is a relica from the first serie at this time the OPP doesn't
> properly enable the regulator it's now fixed since:
> https://patchwork.kernel.org/project/linux-pm/patch/81eb2efeeed1556d12406=
5252f32777838a6d850.1589528491.git.viresh.kumar@linaro.org/
>
> I will drop it.

After retesting it, it seems to still no take the regulator and make
my board hang... :(

[   17.698597] sun8i-dw-hdmi 6000000.hdmi: registered DesignWare HDMI
I2C bus driver
[   17.708475] sun4i-drm display-engine: bound 6000000.hdmi (ops
sun8i_dw_hdmi_ops [sun8i_drm_hdmi])
[   17.718350] [drm] Initialized sun4i-drm 1.0.0 20150629 for
display-engine on minor 1
[   17.877443] Console: switching to colour frame buffer device 320x90
[   17.936050] sun4i-drm display-engine: [drm] fb0: sun4i-drmdrmfb
frame buffer device
[   17.961881] platform 5200000.usb: deferred probe pending
>>>> [   31.710731] vdd-gpu: disabling <<<<<




>
> Thanks for the review.
> Regards,
> Clement
>
>
>
>
> >
> > &gpu {
> >         mali-supply =3D <&reg_dcdcc>;
> >         status =3D "okay";
> > };
> >
> > So there is a consumer for this regulator.
> >
> > Regards,
> > Samuel
> >
> > >                               regulator-enable-ramp-delay =3D <32000>=
;
> > >                               regulator-min-microvolt =3D <810000>;
> > >                               regulator-max-microvolt =3D <1080000>;
> > >
> >
