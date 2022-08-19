Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6E59988D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347907AbiHSJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbiHSJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:08:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BFC7669;
        Fri, 19 Aug 2022 02:08:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so4861911edb.9;
        Fri, 19 Aug 2022 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=dJN4T+ue3SObncsuJ7neBi3J5OlmFODSpIxWtHwr9YA=;
        b=GJOUQLyqYr1U/1FvP6Zq/oTaBISO3ikHpCYTQkzc6YOBloQrFBvpWUuM145VfhKHwg
         /IqYU8QgWpCjv8+wRsX8Pymo+Kp9IvOQAAdx0QZpjOUCrMRq45qLjvspEXRyAhIxYEgX
         ZDtpdXhR0nhDzm2z7X/pNAmA4mTpT7T8KfkUV+o0I3d56qxjQMB4YNm2GQ8GTwFkX6RE
         +hXTeywq2dChXQIP960mwV2bAS+onNc6pdWi/DvBeKPX9i56aqbGFks4M8q9MuBuHCsv
         xnX0c2G5GVhx0eu4j25shM6bbAbHIen8rgheu9beKhp82evDObq4CT5fYjRq5Sl8TVdB
         cZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=dJN4T+ue3SObncsuJ7neBi3J5OlmFODSpIxWtHwr9YA=;
        b=aI2gh7f8nBkY9kwVPuhD3GjvKnxtHfcSUFvPKFbpsTOLt0j6SX7POoOtrVMsJCmUSu
         sbZ0NdUqvtsVg0kCorTt+0eCwWfgkZySxfa4Z9zKqqFYPXnorOriK6z7t7lCcsnmnyxR
         KVDtJ9pnnWY1MjPjhHAbE152NI3YmXzL5mAYTM5nIoQ8IBiNbZhympigYuMNc/pEn0Et
         MhYW1g+pcyWRl+ylecyWER6IFKMd4zbN/OGBgUUN6gI/b6UR9s2BIHcE4nFzez0oX95m
         LNlAkbjgVOJ7R31dOs/2hVjX+8OXnlMhvuyKrXFItOzRIcll0zRQSBvEyA09IVPMv1Xi
         7hFQ==
X-Gm-Message-State: ACgBeo3j8X8tHcOQVZDYRfl4+VaU/a/aqfEmK3ARlyb1MU9M2WtZusxt
        Tw+c28e72j4u6+xMIS2HNIXPOoPh3j8EBCOGShc=
X-Google-Smtp-Source: AA6agR6F4r4SDZxIaIja8V8l2g61Z0gwf9bYv+XqxLEVbWmacqtCiR7o2NAbThQzU1DsYSyMqZq7Ffe8iMd70hVfIjg=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr5353281edc.126.1660900098448; Fri, 19
 Aug 2022 02:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220818203928.131059-1-cpe@outsight.tech> <20220818203928.131059-3-cpe@outsight.tech>
 <2641460.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <2641460.mvXUDI8C0e@jernej-laptop>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 19 Aug 2022 11:08:06 +0200
Message-ID: <CAJiuCcfdE_B8FacrJSGHcRZpzmd6qorY7DT9DiH8iCJujVmjVA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: allwinner: h6: Add cooling map for GPU
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
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

Hi Jernej,

On Fri, 19 Aug 2022 at 06:13, Jernej =C5=A0krabec <jernej.skrabec@gmail.com=
> wrote:
>
> Dne =C4=8Detrtek, 18. avgust 2022 ob 22:39:26 CEST je Cl=C3=A9ment P=C3=
=A9ron napisal(a):
> > From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >
> > Add a simple cooling map for the GPU.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Is this really patch 2/4? I only got patches 2-4, but not patch 1.

Sorry I have updated the way I send my patches, so each patch is sent
regarding what is outputted by 'scripts/get_maintainer.pl'

Patch 1 is https://lore.kernel.org/linux-arm-kernel/20220818203928.131059-2=
-cpe@outsight.tech/T/#md5d89721ac1861f31ca5d101ab9561371c35c904

Which has been sent to :
Catalin Marinas / Will Deacon <will@kernel.org>
And CC to :
linux-arm-kernel@lists.infradead.org / linux-kernel@vger.kernel.org

I will resend and force this patch to be sent to linux ML / Maintainer too.

Best regards,
Clement

>
> Best regards,
> Jernej
>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 22 ++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> > 5a28303d3d4c..943ae5374dd6 100644
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
> > +                                     temperature =3D
> <100000>;
> > +                                     hysteresis =3D <0>;
> > +                                     type =3D "critical";
> > +                             };
> > +                     };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip =3D <&gpu_alert>;
> > +                                     cooling-device =3D <&gpu
> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> >               };
> >       };
> >  };
>
>
>
>
