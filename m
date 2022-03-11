Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C64D6285
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348959AbiCKNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348755AbiCKNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:39:25 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6D182DA1;
        Fri, 11 Mar 2022 05:38:20 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLiTI-1nkCK328Xo-00HflP; Fri, 11 Mar 2022 14:38:19 +0100
Received: by mail-wr1-f42.google.com with SMTP id j17so13082467wrc.0;
        Fri, 11 Mar 2022 05:38:19 -0800 (PST)
X-Gm-Message-State: AOAM530NHWtfkC3DsO+FNOIJv8GVeP1ApOXHEZzVyzGNB0/Mz7LAVGKS
        lBsMP1e9BeXwVie/TjoiWUBeXv8uEakk3KUE9xw=
X-Google-Smtp-Source: ABdhPJyQyoYHZh+pVslr/vmoDVsDXk3gvhxbqLrROJJ+HWkN4Vk43usfrnZ6D257Ws7a0R12okqcFdfYA8OnpIhB5tk=
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id
 t6-20020adff606000000b002038dfff4acmr5286812wrp.12.1647005899008; Fri, 11 Mar
 2022 05:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
 <20220311093800.18778-4-singh.kuldeep87k@gmail.com> <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
In-Reply-To: <4aae560d-d266-d0d0-136f-32891b15bc01@mleia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 11 Mar 2022 14:38:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
Message-ID: <CAK8P3a3a_WXbDKN-jJUt_Wuvop0rfaUs4ytwyhogOxdtJAPx0w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: lpc32xx: Update spi clock properties
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XSeFGmX/txJrCAHFVpLK2GhMis+7Wz2vLi//2rw/ykEeTfFNt6s
 +yKd6PNt5632hZAVRy/SOJicjC+lqMvuxnkYlzbWj6PdYLVUJeg7xb0m//7tz/ajkO6+J92
 /Fyk4XD3uUA8kYO4mvUtoVRPLWqMu0v2tQNgQLFpjVcxi9sEOjpoXbkQdRp7UEmKUeN6rqV
 6qdE2H0prqj0mm5+svZow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7cgqlkgaSik=:okkbofmT9d5LcEAtASy0zM
 /raw6y8zST89OXuDuGsybXgInABQRn+i7kYAzG4V74DjzyotTgKIEEhw8EmeXMtcP8HyhIUzi
 co0ZOJCcfmQTLowZfIpu2s5XQeC5eYWXNSoIPzR3rCc1Vz8GcSIGPg7RZMeF1TeaeZ7snvbt2
 KZEPOxHIvYNjVaK/U8BpB1CFe2NunmQlbALYNYlL+/sjMPVbeBm4HshWjdG/madCbL4UawvUR
 v4CHC4Xw3M7pn81D+rpq1xWAFDHKMaPLZ1hMtVgnhktpdsKktfCUgqU9XqrsdrSat4sMQ0qfC
 wiJVc/GYTdkkcdW2LuDsUXbAqgUoqBw8qAHpw8oQovGoTQNbH3q5dxhcxrA59B1Hy7YbTW1mV
 qB640tSUJL6b5uxtvUCZQLUKBzPGPjPx8T/R5jhgr/jkP3YQDw42UW+pu3NdYkw9kvD8bIHx+
 g7iFHUsWbegWvQCNr1xjIDOclexE7OS+4M0XnJBB6oVeUmSqmVDfUfhn4ws4x6AqV4CusCCgG
 mP0ctm0Vci1A1KwXbUWr1KGz3v46EwPOaJ+TftmcaSo3dMgALoXQ7DYhItXv6RPDBTdY4jRB8
 W4mkD/R2xARDUsrECFusYRcmdFGSiu1EruXvXvQOl2Qn6Av0Gcr13o8Pw6wfDwyVPWRZhVHjo
 vo0Poxfycxj+v72g1uUnMkvRe6DID8IdQ3mWeBENvZb+q2uF0oVGogDKOYTN5jtTpQp/mY+MX
 8boSFX1DjFdBioNq3WQfV3hH0MjJ0b3HYukFEzNpvaDZuUnYOi48fMdxTqRFhLIXvaMTmVPjh
 7Q+MPnKcgkAqoQSgPwbzf3GKLYUxV2b3FogSVAWO+mGYJDWyTw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 2:20 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> On 3/11/22 11:38 AM, Kuldeep Singh wrote:
> > PL022 binding require two clocks to be defined but lpc platform doesn't
> > comply with bindings and define only one clock i.e apb_pclk.
> >
> > Update spi clocks and clocks-names property by adding appropriate clock
> > reference to make it compliant with bindings.
> >
> > CC: Vladimir Zapolskiy <vz@mleia.com>
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> > v2:
> > - New patch with similar changeset
> > - Send to soc ML
> >
> >   arch/arm/boot/dts/lpc32xx.dtsi | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> > index c87066d6c995..30958e02d5e2 100644
> > --- a/arch/arm/boot/dts/lpc32xx.dtsi
> > +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> > @@ -178,8 +178,8 @@ ssp0: spi@20084000 {
> >                               compatible = "arm,pl022", "arm,primecell";
> >                               reg = <0x20084000 0x1000>;
> >                               interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk LPC32XX_CLK_SSP0>;
> > -                             clock-names = "apb_pclk";
> > +                             clocks = <&clk LPC32XX_CLK_SSP0>, <&clk LPC32XX_CLK_SSP0>;
> > +                             clock-names = "sspclk", "apb_pclk";
>
> In fact I'm uncertain if it is the right change, could it happen that the commit
> cc0f6e96c4fd ("spi: dt-bindings: Convert Arm pl022 to json-schema") sets a wrong
> schema pattern?

Good pointm this doesn't quite seem right: it is unlikely that the same clock
is used for both the SPI bus and the APB bus.

> Apparently just one clock is wanted on all observed platforms and cases, this
> is implicitly confirmed by clock handling in the drivers/spi/spi-pl022.c :
>
>         pl022->clk = devm_clk_get(&adev->dev, NULL);
>
> So, I would vote to fix the device tree bindings schema.

Isn't this just using the wrong name? The name of the macro
LPC32XX_CLK_SSP0 might indicate that this is indeed the SPI clock
rather than the APB clock, so we only need to change clock-names
property here and leave it unchanged otherwise.

Looking at the driver, I also see that this refers to the clock as
"SSP/SPI bus clock", and it reads the rate from that.

In case of the LG platform, my impression is that the clocks listed
in DT don't reflect the system at all, they all refer to the same
fixed clock node at 198000000HZ, which is also used as for the
UART and timer nodes. Changing the name on that one doesn't
really make it correct, but should not hurt either.

        Arnd
