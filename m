Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30F6580122
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiGYPHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGYPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 11:07:14 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD41B10FCD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:07:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id p132so13777307oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLYdNu88rwK9RKi0Hdu8L2qjedcRHOnzO3eSS99Jj+4=;
        b=uSX66gaqfINSKgXXJRgV9sqXY+qx32zQLxcNjZ6CWsyfWP6uWpYcmvETA9qCT8azEH
         wyrpJBz+8s3IJvKOu8sbcmIchg37H79YpU9DkLH3SQCGSjT7zsV3DO7zu6tlXN1PPB/i
         KlvTM7bzjKlqmrmFj9E6PafmJ8mI+33KkvwBqCCTu02zeu86uE2OarY3Yknu7tznn8pj
         KC+ppdyG3FAfrsbP7kt/xCUNNRXAs09PQhm3yXRxiQt5BHeXJlcNKcBm7S3gFxABYeBF
         Nq7K0X67Tp2umeeRku8MeZClQRl/W4tzXGoJwFNQZvEQ/Bmxe8Z7pGjdyajott0pYUcg
         E/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLYdNu88rwK9RKi0Hdu8L2qjedcRHOnzO3eSS99Jj+4=;
        b=FCNj6mZy462Okt8oCH06O38hkgkytzrP8k9zamPbvJzwfhOWKvjoGzIaSY0BXSvSsB
         S8tyH93RPDmwGtX69KEDctjkubhBvuJecI+Gp0LFF6daVMGDyDoWJ8vx/N04aFZSDmm8
         dmGSznKS7A7obt1eioRSt/roQPv2f1+SZFvgwvu5z5cmkTW4OE46WvDcDvDFYITd5C+9
         InnI/Y0jFFj0qpg5C00xgWbNvmIpmt3rrHrdNvYUMetpzaMhayzfq2YwR356qQGwC4aX
         tsVhDUlA4PD0k+YQpqpukw8RuFMnTzSRavMevQIkA3nPFMbVQsuDvgPzcmGceYCxooPh
         9iCA==
X-Gm-Message-State: AJIora97NuVjCdiYX0svWMjgWze3kQrfyCFVl0h8IYhltkAhOFHDl0+T
        0bZ7Tj1bENndGTNvlGSQNVf0HDSPZEczX05hit4nSg==
X-Google-Smtp-Source: AGRyM1v7J6NrpM5+VYdxmL1VK1k+qwfa9rxkPwG/5wkAIEBb1fYGvBYNHVcpI2jpl2oYPKyinajp9kZ1GoG3d3VJEzo=
X-Received: by 2002:a05:6808:1b20:b0:33a:b9ab:30d8 with SMTP id
 bx32-20020a0568081b2000b0033ab9ab30d8mr7623167oib.8.1658761633157; Mon, 25
 Jul 2022 08:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220725131521.607904-1-robert.marko@sartura.hr>
 <20220725131521.607904-2-robert.marko@sartura.hr> <CAK8P3a1mL7Pm5+0Ce89LTrup476WaxSQKpTgn=o98_uFuOdfyQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mL7Pm5+0Ce89LTrup476WaxSQKpTgn=o98_uFuOdfyQ@mail.gmail.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Mon, 25 Jul 2022 17:07:02 +0200
Message-ID: <CA+HBbNEjYcZ1yU+h3ZR_g=6+18JBQ2U=v3VesRxR21Rc9N4LbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: microchip: sparx5: dont use PSCI for core bringup
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 3:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jul 25, 2022 at 3:15 PM Robert Marko <robert.marko@sartura.hr> wrote:
> >
> > As described in previous commit, PSCI is not implemented on this SoC at
> > all, so use spin-tables to bringup the cores.
> >
> > Tested on PCB134 with eMMC (VSC5640EV).
> >
> > Fixes: 6694aee00a4b ("arm64: dts: sparx5: Add basic cpu support")
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
>
> Surely this is only a machine specific bug in the boot loader, not something
> the SoC is incapable of supporting, right?


PSCI itself could be implemented on this SoC, you can even implement
it just by using U-boot.
I have been looking into adding basic reset and core bring up PSCI
support to the BSP U-boot for start.

>
>
> >  arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > index 38da24c1796c..ea2b07ca2887 100644
> > --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > @@ -40,14 +40,16 @@ cpu0: cpu@0 {
> >                         compatible = "arm,cortex-a53";
> >                         device_type = "cpu";
> >                         reg = <0x0 0x0>;
> > -                       enable-method = "psci";
> > +                       enable-method = "spin-table";
> > +                       cpu-release-addr = <0x0 0x0000fff8>;
> >                         next-level-cache = <&L2_0>;
> >                 };
>
> I think the psci method should be kept in the dtsi file here, since actual
> product boards would have to support it to be useful, you can just add
> the spin-table as an override in the broken reference boards, with a
> comment about which u-boot version is broken, in case this gets fixed
> in the future.


Well, that's the thing, Microchip-s BSP is not utilizing PSCI at all,
they reverted
to using spin-tables in both Linux and U-boot, and they dont implement
PSCI at all.
I highly doubt that any of the vendors are gonna implement it themselves.

I have contacted Microchip and they confirmed that there is no PSCI
support, they stated
that they started working on PSCI but that images were larger and took
longer to boot
and they dont see any advantage so they removed that.

So I doubt that we are gonna be seeing any boards that implement PSCI
by default.
I can tell you that it's annoying me as we are back to 2013 and using
a GPIO for restart.

U-boot version that I tested is the last one from their 2022.06 BSP,
its based off U-boot 2019.10.

Maybe somebody from Microchip can chime in on this?

Regards,
Robert
>
>
>        Arnd



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
