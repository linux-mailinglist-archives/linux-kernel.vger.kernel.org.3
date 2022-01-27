Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2642B49DE79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiA0JxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiA0JxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:53:01 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BEDC061714;
        Thu, 27 Jan 2022 01:53:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g14so6891607ybs.8;
        Thu, 27 Jan 2022 01:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCeh3tJziJOXCrnnixTkBD7AYHB2A+IHZABHF/dzYCU=;
        b=jLYDifpGZwQT05W+rS6oG34Z57CQot8Zti/7gLcLa+vf9idQ5ovGvGd9sbBvPeZ1Jr
         NezUg66EcyWxAeYLjGrXJA2duIBfAchL7kqG3Ue/HybKy4lxrCKT4AfDsnxoPrN1wpDq
         Hpq1Rgsqjj9Ro0skwwROmDIylrMCeD+H7T1INsi9/2D/CmcZIJSUZeftjhQNZYIF7yaM
         3+thHuba8byLdxHS4lxhAHruimbhqxztbSXTvlL9lLD2qefF4/fRo3CrQXUyrvYvz3S8
         gmfiJfGSLaHBFNFgjbQEgW6zAnyU36TmMWOoBJ+INFl/k4mPKytvC7RCuJMy2SwOJ2O7
         d91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCeh3tJziJOXCrnnixTkBD7AYHB2A+IHZABHF/dzYCU=;
        b=IvoRMqtWF+4YF6dOokt6/OnQmPiBdCVY5LGSGjGZf7wd4oq+IMa8ufBDeG/Se4R0Zq
         PZ9QYbUrrAVPn7JxtpL8Y/rYRtrddAFPtdeMvG22nswguxCZt4fwMeY6COfYFDv4a8CE
         GSZB48GDoPUifbNqCF1m3mPYiN4ze3WIfKnH6HbiA16GMIbGcX/m4YE93r+rXKVgj/H1
         EITy5P/KRgUQj3fkjmkFUHn47cSO2CvT9oOt+PKh6PdjN63pDPq+vEagQ3idW4FU1r9G
         iiuDVftzap5HiMMtxegYhLgxCZfzAeE6RvHLPiEtNcGPjNZaTNwWWH7p+Q1kQ7xNB2xY
         LD1Q==
X-Gm-Message-State: AOAM533nHoPQ7ro8ALkteEkcTgSXUQ0WTKJFhy9WSLXYLNkjjh32O4mZ
        rEUFxK1BgxE0v94NMFRDEch/e4QAt+oU7GvUbU6kdWuseobC5g==
X-Google-Smtp-Source: ABdhPJwr04wc46axSGKrtv+MH4U4swgz1FO7YD5H05ogTMFf9FsI0RrB7S0p7bS2eDOkZ1cFAcXnl4JBF+Sxta6GINg=
X-Received: by 2002:a25:d0cb:: with SMTP id h194mr4833431ybg.680.1643277180574;
 Thu, 27 Jan 2022 01:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20220127010023.3169415-1-pgwipeout@gmail.com> <20220127010023.3169415-3-pgwipeout@gmail.com>
 <e2479729-154a-122f-f2e0-89b62ffe2c8d@gmail.com>
In-Reply-To: <e2479729-154a-122f-f2e0-89b62ffe2c8d@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 27 Jan 2022 04:52:49 -0500
Message-ID: <CAMdYzYrKjVvXHftaJDyOv6MwjEwmvwgMnzZK4gm0+D=XuA+ijg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: add Quartz64-A pmu_io_domains
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:57 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Peter,

Good Morning,

The Rockchip schematics IO Power Domain Map is rarely *if ever* 100%
accurate, you need to check the actual schematic for ground truth.

>
> On 1/27/22 02:00, Peter Geis wrote:
> > Several io power domains on the Quartz64-A operate at 1.8v.
> > Add the pmu_io_domains definition to enable support for this.
> > This permits the enablement of the following features:
> > sdio - wifi support
> > sdhci - mmc-hs200-1_8v
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > index d9eb92d59099..33c2c18caaa9 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > @@ -482,6 +482,19 @@ vcc_sd_h: vcc-sd-h {
> >       };
> >  };
> >
>
> https://files.pine64.org/doc/quartz64/Quartz64_model-A_schematic_v2.0_20210427.pdf
>
> Could you check with the IO Power Domain Map?
>
> > +&pmu_io_domains {
> > +     pmuio1-supply = <&vcc3v3_pmu>;
> VCC3V3_PMU
>
> > +     pmuio2-supply = <&vcc3v3_pmu>;
> VCC3V3_PMU
>
> > +     vccio1-supply = <&vccio_acodec>;
> VCCIO_ACODEC
>
> > +     vccio2-supply = <&vcc_1v8>;
> VCC_1V8
>
> > +     vccio3-supply = <&vccio_sd>;
> VCCIO_SD
>
> > +     vccio4-supply = <&vcc_1v8>;
> ==> VCC1V8_PMU

Page 16 of the schematic, VCCIO4 is tied to VCC_1V8 via R1519

>
> > +     vccio5-supply = <&vcc_3v3>;
> ==> VCC_1V8

Page 20 of the schematic, VCCIO5 is tied to VCC_3V3 via R1800

>
> > +     vccio6-supply = <&vcc1v8_dvp>;
> VCC1V8_DVP
>
> > +     vccio7-supply = <&vcc_3v3>;
> VCC_3V3
>
> > +     status = "okay";
> > +};
> > +
> >  &sdhci {
> >       bus-width = <8>;
> >       mmc-hs200-1_8v;

Thanks for double checking,
Peter
