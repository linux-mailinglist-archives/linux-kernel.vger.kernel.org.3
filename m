Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF84B8E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiBPQvV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Feb 2022 11:51:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiBPQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:51:20 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729729059A;
        Wed, 16 Feb 2022 08:51:05 -0800 (PST)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHGPA-1nXYmu11Xs-00DKpD; Wed, 16 Feb 2022 17:51:04 +0100
Received: by mail-wm1-f52.google.com with SMTP id c192so1580099wma.4;
        Wed, 16 Feb 2022 08:51:04 -0800 (PST)
X-Gm-Message-State: AOAM53215idIRCb6fop41eJyR00x+Tf0B0ZeoiZIeCw3jliFfQmJEmC0
        XE3roa9px2c5a/feOpXWNRiwkpxgQQo3irApi8c=
X-Google-Smtp-Source: ABdhPJx8RqMyzjqG4qRfmf4/0bQTcftVw4SQPsOIYZkGgW8WAtBynLxNtL5rZYmPjYJ0eMNasjhYVG/ePq+kp7P5uvU=
X-Received: by 2002:a05:600c:4ecb:b0:37c:9125:ac03 with SMTP id
 g11-20020a05600c4ecb00b0037c9125ac03mr2448520wmq.98.1645030263859; Wed, 16
 Feb 2022 08:51:03 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216153632.40981-1-nick.hawkins@hpe.com>
 <CAK8P3a0NmyxrzxgfwfDXuFvhmc3OL_-yBj8PDdEHh-2qm4NVkw@mail.gmail.com> <PH0PR84MB17185157544CFEB1D8AE267088359@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB17185157544CFEB1D8AE267088359@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Feb 2022 17:50:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1HuTMt5WmOw3aQcLwGZd_WQ5nsKZ2HFDPQ0CHFvKsygA@mail.gmail.com>
Message-ID: <CAK8P3a1HuTMt5WmOw3aQcLwGZd_WQ5nsKZ2HFDPQ0CHFvKsygA@mail.gmail.com>
Subject: Re: [PATCH] [v3] arch: arm: boot: dts: Create HPE GXP Device Tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:RnLDglf0AH3oOyV8TTYEtG8RtU28VZIfAPP5QrqhEbdoob37J/x
 JNOhIV4glMgKZvIb0spcghmMy3BmaZpt9JMR39ArAgVqcHYWo/Q/0LOzMSLe2RqsVMSVmRQ
 6kQdxvYTlgrV3GBg1HAanjdIH0yFQocMRkxcTnA5tXBiykxLXeH9rGS+HixEihZUXeyb96e
 VNQ68gDbo/o/TIIQcEeOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qDd2au7NLC8=:SY5OR61SwQiqQEt4uTBfCG
 5zO/wSwH2dUkhlpOQXMkqAGQ6PLlYIlJ/y9e4MwsyfKstYTD2kemRztCdf4+6/HHj1YGOUZP7
 hBbuKVyGDpITD8jcs5m2GRDIELnY/hJAkE9J8O0kHjywT9JujfuhhiSXcml2viVIAbXjruXRV
 gRUUNdJ+jsbbVXnIjhANOxPdsNjmSTWXLScU0aJsgcA69dT7pqX7e4jX/93BubZxtd+ISRjIY
 3Rfe4JVq1nRD56M9m9ApmSc/isjdrgnRe4lK4QWrUbqdhXocq/4SvK+HIgpbt3y9kufW+prn4
 F2Luc0f1smVoYfBWS1fCmrBsx15Od6/XrGZe0sH9Z2P0AZ7EGqT2sM/3SKR8Xh6AgCrM3eDAN
 rUlPKmsnI6x2EZq0rCmDpCuPHSXzCud/jq4q4kR3yg0mtmGXpiJGaaf6k7EoN4somaUeip+Pd
 F0kE0QQHM8kxgHX3cZecG3GmQjr2pBlbAU3eCfPX+eAIYDN5DkX8bn4bLuhH0iL8acO3j26w7
 MlKUgK28GMBrVX+NYY4RCRkHoEC7Ys6MfpLTQiKudPbHWkOad7h3VEK9XkUxOyi4u8ROBdZmt
 BPRMPoT7+mTcVXEXkVbVBfJRCIwmoGI5HSQf+2Ar7Nnj03JzRbVZGhJiJQA50QMXC07UOW9DX
 gV5YU4+4UwF5SS/a7EAhBUmH4RVhBqYJfAD82oNaJZm4zoAL5V0b57KIm0N+/hEDNfW+aouji
 xeSp7tUDv+1jjzRC5P5eiVvIE95O0OKSHNjssk5uRG0OyhNAkjIZnEza07YGYjLCJ2U2LL7o0
 pqBKyLzVNUhsW0iOo5aG/ONyfjJdlf+yw20eAgDwdaAcdQk8UM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 5:29 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> > +GXP ARM ARCHITECTURE
> > +M:     Nick Hawkins <nick.hawkins@hpe.com>
> > +M:     Jean-Marie <verdun@hpe.com>
>
> It looks like you are missing the family name here.
>
> NH: Do you mean I need to have an HPE in front of it?

No, I meant a 'Verdun' after Jean-Marie ;-)

> ...
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 235ad559acb2..a96b4d5b7f68 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1549,3 +1549,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >         aspeed-bmc-vegman-n110.dtb \
> >         aspeed-bmc-vegman-rx20.dtb \
> >         aspeed-bmc-vegman-sx20.dtb
> > +dtb-$(CONFIG_ARCH_HPE_GXP) += \
> > +       hpe-bmc-dl360gen10.dtb
>
> This Kconfig symbol does not yet exist
>
> NH: Should I include the definition of this Kconfig symbol in this patch or just not modify the makefile when doing device tree changes?

I would start with a patch for the bindings, or one per binding, then
the Kconfig
patch, then the dts file and finally the MAINTAINERS entry.

The order is not super important, but it helps to do it in a way that one patch
builds on the previous one in the series, rather than having a single big patch,
or separate small patches that are not in a series.

>
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +       compatible = "hpe,gxp";
>
> No board specific compatible string? Also, this value is not documented anywhere.
>
> NH: I was uncertain if this needed to be documented or not, checkpatch did not notice it. Where would you recommend I should put this in documentation? I was considering Documentation/devicetree/bindings/soc/hpe/

Documentation/devicetree/bindings/arm/hpe.yaml would be best.
The bindings/soc/ directory is not for the SoC as a whole but more
for components on the SoC that are either for identifying the chip
(as in struct soc_device in Linux)  or for things that don't fit anywhere
else but are specific to one soc.

> ...
>
> > +
> > +               watchdog: watchdog@c0000090 {
> > +                       compatible = "hpe,gxp-wdt";
> > +                       reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
> > +               };
>
> As mentioned in a previous review, it would be helpful to have the drivers and bindings together in the same series for easier review.
>
> NH: Just to confirm, I need the driver source and the new DTS file in one review? I also need to have a review to add files: arch/arm/configs/gxp_defconfig, arch/arm/mach-hpe/gxp.c should those be included as well? I am trying to not create too massive of a patch. I could also create completely separate patches for these items so that reviewers could refer to it.

Yes, I think it's best to have all patches in a larger series for the
initial review. The defconfig
patch is usually separate, but the gxp.c file can be in the same patch
as maintainers entry
and the Kconfig and Makefile changes (outside of dts).

Try to keep each patch in the series self-contained, e.g. don't
separate a .c file from the Makefile
and Kconfig change, but don't group things into one patch that are not
directly related, e.g.
the dts file.

> ...
>
> To a lesser degree, the same is true for the uart.
>
> Please check the devicetree files in order to validate the bindings. In this case, you should get a warning about the 'ehci@' name being non-standard. The normal name is usb@
>
> NH: Which tool are you using to validate bindings? I did not receive any warnings but I did receive several errors which I corrected.

You can run "make dtbs W=1" to get most of the useful checks enabled.

> > +
> > +               vrom@58000000 {
> > +                       compatible = "mtd-ram";
>
> Same thing here, "vrom" is clearly not a standard name.
>
> NH: VROM is a Virtual ROM device that we use to create a memory mapping of a SPI flash content copy that is served to a host system. How should I rename it?

Not sure, I don't remember seeing this case so far. Adding Joel to Cc,
maybe he knows of
another BMC that does the same thing.

         Arnd
