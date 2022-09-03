Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E947A5AC0E1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiICSlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:41:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0DF2CC95;
        Sat,  3 Sep 2022 11:41:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z8so6637525edb.6;
        Sat, 03 Sep 2022 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=y/fyX7Fgx7pidbZm1EbW1sYH2qqBKD2aPEMgJoc7r7A=;
        b=cKK/oblrAd4xpjnI2tAso16qm9Dx5ZK4cT9a7pOslArAyWGvZQRvP1C+61uKZGqXk0
         ChPwXWrEMKYiQTq5IUIaeVfy0FoC83K/EIqZxIdqHQuY1C+C3J3FbAQt30nvIvJlm5Px
         N56ZDNfNHMvDNvJ/WpHR2Sro4SujJxEZILta2c04tx4IWWRio66XCVXRrHUhADjYrsgV
         3Cx+lmZ3pKqnBvGhIZGIp4Q1m3da4V+loZCcfZhXRR9BdqmogEpQ3nFQVeO8xa8osaTy
         Iu1mgRjIIMfhXeIDFDV/CXGyXgA4zOfkCwXINP1A6Ae0KVVSRKR+9XdjkiXEClxQCgWb
         KsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y/fyX7Fgx7pidbZm1EbW1sYH2qqBKD2aPEMgJoc7r7A=;
        b=HvwYyNXmNSh9wZ9cSfSLbT77NRqkgJBuS0/0ECRCavo1MgHn+2F8WHNJQoq6GY3NO2
         OXbXK0PHaI93iLleoZyiO+W79GdSeqr6UQWPF7iIOTGahwtd5dbKWJMp+uBY5zoc3O54
         zLtFOuLjbHSszrBi2YxISQ3PY86JjHBNAGEgxh7ylhIDf8a52Uz9XXzwoH0Qq/T60Y0l
         D1VPczKbQFZO/lrrWyaN2hjCsxjyYt3wrLJ1SCaZOfpXijJfjYCwLZ83b/9p3FOHbsvK
         tKXu8HYl92EHM+QZ9y2upx7roLjbyNF0XBpMhTSgcV83jcePiXVF2KgWiyH2PqY2ZkRL
         qFUQ==
X-Gm-Message-State: ACgBeo2Dh+k1vhQ2Bw6/feoGECxRJDhSaW1IFoRsTaTO33DorHgVQYaT
        /fEZQr8MYfdll2eSMAffiWdzd1/MVSGhm9NC6og=
X-Google-Smtp-Source: AA6agR5kquHLK08sJV7wPSiA6uDfnxrcaGSZokgPnt8ENqvTPyodp6p6/lTYfIShLzXKEcAmhUXvwNyourKGFKn/PFU=
X-Received: by 2002:a05:6402:11d0:b0:448:89ff:88f0 with SMTP id
 j16-20020a05640211d000b0044889ff88f0mr23145854edw.166.1662230508161; Sat, 03
 Sep 2022 11:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220821173051.155038-1-peron.clem@gmail.com> <20220821173051.155038-5-peron.clem@gmail.com>
 <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org>
In-Reply-To: <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Sep 2022 20:41:36 +0200
Message-ID: <CAJiuCcf7NuXFFLw6-RFcyZPNFPagfSB5aR7rY5528USzNB-iKg@mail.gmail.com>
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

On Tue, 23 Aug 2022 at 05:07, Samuel Holland <samuel@sholland.org> wrote:
>
> On 8/21/22 12:30 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > Enable GPU OPP table for Beelink GS1
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/=
arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > index 6249e9e02928..20fc0584d1c6 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > @@ -5,6 +5,7 @@
> >
> >  #include "sun50i-h6.dtsi"
> >  #include "sun50i-h6-cpu-opp.dtsi"
> > +#include "sun50i-h6-gpu-opp.dtsi"
> >
> >  #include <dt-bindings/gpio/gpio.h>
> >
> > @@ -261,6 +262,7 @@ reg_dcdca: dcdca {
> >                       };
> >
> >                       reg_dcdcc: dcdcc {
> > +                             regulator-always-on;
>
> Why is this necessary? This file already has:

This is a relica from the first serie at this time the OPP doesn't
properly enable the regulator it's now fixed since:
https://patchwork.kernel.org/project/linux-pm/patch/81eb2efeeed1556d1240652=
52f32777838a6d850.1589528491.git.viresh.kumar@linaro.org/

I will drop it.

Thanks for the review.
Regards,
Clement




>
> &gpu {
>         mali-supply =3D <&reg_dcdcc>;
>         status =3D "okay";
> };
>
> So there is a consumer for this regulator.
>
> Regards,
> Samuel
>
> >                               regulator-enable-ramp-delay =3D <32000>;
> >                               regulator-min-microvolt =3D <810000>;
> >                               regulator-max-microvolt =3D <1080000>;
> >
>
