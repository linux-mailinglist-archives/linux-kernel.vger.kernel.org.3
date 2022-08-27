Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DE35A38E1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiH0QuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiH0QuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:50:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1DF40543;
        Sat, 27 Aug 2022 09:50:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w19so8280056ejc.7;
        Sat, 27 Aug 2022 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=VJNF98Jqt99AprHtKq0G9VG/d2DqpgJHfktlSDmD0pg=;
        b=MN8/ETsFbLJzerJD4Via51PdSRuPXLXahkl3CImMSuj4F8mgXXCxd1i7VSiHIxGCFt
         gBttjvyy2grENAq0rDAl+cNdRaDE3lNvlKf2IeqZwyYRDjDvyPc/pN/XP/gjo4gyM/x3
         4XXg7RiJ0uzLoKXcfRrl/IJbFKNAc1nJvBBkxWeZVMOibC4FAJgnVctwKodiVPTIDhQc
         LTlbKqwN7Fbw69qAMl6oyXnRmHf8viBq8EaaXO6UUQC2h1AhyBinSnJBLKHSQoJrGF7d
         qXcB4TVtkJAqlqafVN1p1VDLGDnktOE7BgFdMFAeOvhc6yegecVQM8v34b9IUzLbaDfR
         TSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=VJNF98Jqt99AprHtKq0G9VG/d2DqpgJHfktlSDmD0pg=;
        b=DUhw9xch4fR5xnCOT1h3+r4PoGZsM5q8/HckiRU08GoSzKtVdabJ3qHvc73MHC4dUq
         yaDWMF5qagjarX467fKLQ4g0uXdbXdMuX5+fF21OwMPln9k32yyUp5mHSF+b8/pLFG1D
         85BzVu5wzFZoZZFlvMUV4Yq/qkntWqvkOVR25h7dc/1qOi28QDsSmoUH8lOFSmLA4cIc
         r37QBorbYe9yzd56jsWLvECVR/EPcnv+LLrT24M5FIL05ZnZIzlK8kSpVS1cRE8oKq5D
         FcmGww7Xca96E/HtnHXp9gaqIG7v5xIqcQ75+5E2Sr3WqZpprB+QYYlwtJo4aP0kf6yb
         P6ZA==
X-Gm-Message-State: ACgBeo0AN1WQGPAZfDkHDF1xo1YTJW1qfTh3ei/gOFJqutgrYdMghRkB
        /1ByA6vS2RAEMCUL67iERGBTSHFdFECB8C6YBtg=
X-Google-Smtp-Source: AA6agR45ebN9N8dztQ/gX5HvnhEDpExulXI+ZZGejqq5d1WBpjxzmH9DKLOsuHlQFtJuyFzYNpSq3aIf5qCCqjTt62c=
X-Received: by 2002:a17:907:8a09:b0:731:610:ff8d with SMTP id
 sc9-20020a1709078a0900b007310610ff8dmr8431923ejc.399.1661619008050; Sat, 27
 Aug 2022 09:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220821173051.155038-1-peron.clem@gmail.com> <20220821173051.155038-3-peron.clem@gmail.com>
 <72f901e6-f646-336b-70e6-2747363944ab@sholland.org>
In-Reply-To: <72f901e6-f646-336b-70e6-2747363944ab@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 27 Aug 2022 18:49:56 +0200
Message-ID: <CAJiuCcfF=1Ob1oGABtHhM88m0LST727h88fXqCKYBiWRsYmtnA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
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

On Tue, 23 Aug 2022 at 05:16, Samuel Holland <samuel@sholland.org> wrote:
>
> On 8/21/22 12:30 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > Add a simple cooling map for the GPU.
>
> It would be good to document where the trip point temperatures came from.

If I remember correctly, I got those when getting the dtb from my
Beelink GS1 when it was running vendor Android with the oldest
Allwinner kernel.

But now that you ask I double check with the "new" vendor kernel source:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/=
boot/dts/sunxi/sun50iw6p1.dtsi#L2034-L2053

And It's different from what I got in the past.
The throttling starts when the GPU is already very hot (95, 100 and
105=C2=B0C) and seems to only disable the highest frequency (756, 624 and
576MHz).
Which let the GPU running at 0.91V @ 540MHz.

Which is far to be the lowest possible consumption for the GPU (0.81V
@ 336MHz would be better in the hottest situation)

I'm not an expert but either I could just try to copy/paste the same
behavior or try to have a more smooth cooling map (70, 85, 100=C2=B0C).

What do you think?

Thanks,
Clement



>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Acked-by: Samuel Holland <samuel@sholland.org>
>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-h6.dtsi
> > index 5a28303d3d4c..943ae5374dd6 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -186,6 +186,7 @@ gpu: gpu@1800000 {
> >                       clocks =3D <&ccu CLK_GPU>, <&ccu CLK_BUS_GPU>;
> >                       clock-names =3D "core", "bus";
> >                       resets =3D <&ccu RST_BUS_GPU>;
> > +                     #cooling-cells =3D <2>;
> >                       status =3D "disabled";
> >               };
> >
> > @@ -1075,6 +1076,27 @@ gpu-thermal {
> >                       polling-delay-passive =3D <0>;
> >                       polling-delay =3D <0>;
> >                       thermal-sensors =3D <&ths 1>;
> > +
> > +                     trips {
> > +                             gpu_alert: gpu-alert {
> > +                                     temperature =3D <85000>;
> > +                                     hysteresis =3D <2000>;
> > +                                     type =3D "passive";
> > +                             };
> > +
> > +                             gpu-crit {
> > +                                     temperature =3D <100000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&gpu_alert>;
> > +                                     cooling-device =3D <&gpu THERMAL_=
NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> >               };
> >       };
> >  };
> >
>
