Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1794670FB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378452AbhLCD71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239074AbhLCD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:59:26 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A75C06174A;
        Thu,  2 Dec 2021 19:56:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b1so3286400lfs.13;
        Thu, 02 Dec 2021 19:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqWClX8wf746RWljknNlhrCQutL2BNblsj8hgdUcX34=;
        b=Z0PiBT5EJSG48ueRdwGCYZ2YEGpS1/EI5veqmY2d+e49m8I+Igi8YFh9LRiov19ajJ
         h3WbYTKuzknud+jaaJavQDJZWYzl1ZqLw+Sl5oFc1BkBLgTziaXm6taEb8U4HzzR/OwM
         ZTK9RCNuA/ckTzS6+m9lDHq2R4nKImctiFJUSG/Zp7SKMGudHMxkGn3DT/IU3jeyydoS
         gSIhb+eBFPE8eNWSjjcxZCB+5jhJcRtNOe2Q8T8PpLvaHkvn0sbBlLJ2vzcWtLZCBg+k
         R+yGnX1dtIPTJL3EMuI7CvXFvKnYXW5PQYqrxVULcwh4379sNYt9efWtCOGXkziyX1DR
         xjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqWClX8wf746RWljknNlhrCQutL2BNblsj8hgdUcX34=;
        b=kOGZs/4AEQ8f6Ote3PrFo4ADwNytlupgGZoLQXGgE+OPHYfo13wtD5F1/r2/pVHyeQ
         9C5+Ki6pwCJKAVFLFLj2CXF5TuoCbY93CTVDJh+UjcHxUzg2uPEZ54NcoUXghWfjBACk
         szRcMpLaVoEPLnza6fB39HXyQ9c3nJNQBWfnL+tW3wZ1haZ4LdzTHpc/CfQZfcWKW0Zi
         w8Ozg7DoCqIfpgRHZuciZgERyKeMjEmamm25WOFyprFXoOUa4mrC9Lzg3ENpohJCH2GU
         3rvp1AYtZwp0yoRlDB22dRU6bRH6uVu9opxs0VejR7WQxxSJI7R7/K733ep3GkRoTVsV
         56eQ==
X-Gm-Message-State: AOAM533wB1EFQv9/3Fl6v/ABzPhW/lMENSJ06J09MfBhpvfLyf3IQ0iN
        BSP4We2iKQkXa3vyBCG+wCSxh8bUPJPpK+qv6Rs=
X-Google-Smtp-Source: ABdhPJzqLqjG1FfR5n/iHBX9kenXQxkhOBEtQ/bCp2OeEdSaMzLUwYt2983bqJXPJgA2PCkZv0fFA79sHvNOCjA7XT8=
X-Received: by 2002:a05:6512:3988:: with SMTP id j8mr15859575lfu.599.1638503761493;
 Thu, 02 Dec 2021 19:56:01 -0800 (PST)
MIME-Version: 1.0
References: <537742e7af4a21baf79429469ba7c30947ddca7a.1637362542.git.plr.vincent@gmail.com>
 <mhng-25baa8a5-d7c1-4a37-8489-123fd12499f0@palmer-ri-x1c9>
In-Reply-To: <mhng-25baa8a5-d7c1-4a37-8489-123fd12499f0@palmer-ri-x1c9>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Fri, 3 Dec 2021 05:55:25 +0200
Message-ID: <CAEn-LTpjqroMXbncWrxa9+3fMyF2jQUkhPocO18qAd2PQJKZFA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] riscv: dts: sifive unmatched: Fix regulator for
 board rev3
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     plr.vincent@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        krzysztof.kozlowski@canonical.com, qiuwenbo@kylinos.com.cn,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"

On Thu, Dec 2, 2021 at 11:45 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 19 Nov 2021 14:55:41 PST (-0800), plr.vincent@gmail.com wrote:
> > The existing values are rejected by the da9063 regulator driver, as they
> > are unachievable with the declared chip setup (non-merged vcore and bmem
> > are unable to provide the declared curent).
> >
> > Fix voltages to match rev3 schematics, which also matches their boot-up
>
> There's a few references to rev 3 here.  I'm not sure if that means we
> should have multiple device trees -- this one seems pretty benign, but
> some of the regulator stuff worries me there, where anything rev 3
> specific might not be safe on other revisions.

As I mentioned some time before there is no such thing as Unmatched "A00".

The production boards is:
PCB revision: 3
BOM revision: B
BOM variant: 0

Or "3B0".

There are a few "3A0" boards out in the wild, but the changes are
minimal and the same DT applies.

>
> Did any previous revisions make it out of the lab?
>
> > configuration within the chip's available precision.
> > Declare bcore1/bcore2 and bmem/bio as merged.
> > Set ldo09 and ldo10 as always-on as their consumers are not declared but
> > exist.
> > Drop ldo current limits as there is no current limit feature for these
> > regulators in the DA9063. Fixes warnings like:
> >   DA9063_LDO3: Operation of current configuration missing
> >
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
> >
> > ---
> > Changes since v2:
> > - Fix end-of-commit-message separator so change lists do not end up in them.
> > Changes since v1:
> > - Remove trailing "." on subject line.
> > ---
> >  .../boot/dts/sifive/hifive-unmatched-a00.dts  | 84 ++++++-------------
> >  1 file changed, 24 insertions(+), 60 deletions(-)
> >
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > index 6e7775fdae32..1abad0eec02e 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > @@ -93,47 +93,31 @@ wdt {
> >               };
> >
> >               regulators {
> > -                     vdd_bcore1: bcore1 {
> > -                             regulator-min-microvolt = <900000>;
> > -                             regulator-max-microvolt = <900000>;
> > -                             regulator-min-microamp = <5000000>;
> > -                             regulator-max-microamp = <5000000>;
> > -                             regulator-always-on;
> > -                     };
> > -
> > -                     vdd_bcore2: bcore2 {
> > -                             regulator-min-microvolt = <900000>;
> > -                             regulator-max-microvolt = <900000>;
> > -                             regulator-min-microamp = <5000000>;
> > -                             regulator-max-microamp = <5000000>;
> > +                     vdd_bcore: bcores-merged {
> > +                             regulator-min-microvolt = <1050000>;
> > +                             regulator-max-microvolt = <1050000>;
> > +                             regulator-min-microamp = <4800000>;
> > +                             regulator-max-microamp = <4800000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_bpro: bpro {
> >                               regulator-min-microvolt = <1800000>;
> >                               regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <2500000>;
> > -                             regulator-max-microamp = <2500000>;
> > +                             regulator-min-microamp = <2400000>;
> > +                             regulator-max-microamp = <2400000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_bperi: bperi {
> > -                             regulator-min-microvolt = <1050000>;
> > -                             regulator-max-microvolt = <1050000>;
> > +                             regulator-min-microvolt = <1060000>;
> > +                             regulator-max-microvolt = <1060000>;
> >                               regulator-min-microamp = <1500000>;
> >                               regulator-max-microamp = <1500000>;
> >                               regulator-always-on;
> >                       };
> >
> > -                     vdd_bmem: bmem {
> > -                             regulator-min-microvolt = <1200000>;
> > -                             regulator-max-microvolt = <1200000>;
> > -                             regulator-min-microamp = <3000000>;
> > -                             regulator-max-microamp = <3000000>;
> > -                             regulator-always-on;
> > -                     };
> > -
> > -                     vdd_bio: bio {
> > +                     vdd_bmem_bio: bmem-bio-merged {
> >                               regulator-min-microvolt = <1200000>;
> >                               regulator-max-microvolt = <1200000>;
> >                               regulator-min-microamp = <3000000>;
> > @@ -144,86 +128,66 @@ vdd_bio: bio {
> >                       vdd_ldo1: ldo1 {
> >                               regulator-min-microvolt = <1800000>;
> >                               regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <100000>;
> > -                             regulator-max-microamp = <100000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo2: ldo2 {
> >                               regulator-min-microvolt = <1800000>;
> >                               regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo3: ldo3 {
> > -                             regulator-min-microvolt = <1800000>;
> > -                             regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo4: ldo4 {
> > -                             regulator-min-microvolt = <1800000>;
> > -                             regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> > +                             regulator-min-microvolt = <2500000>;
> > +                             regulator-max-microvolt = <2500000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo5: ldo5 {
> > -                             regulator-min-microvolt = <1800000>;
> > -                             regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <100000>;
> > -                             regulator-max-microamp = <100000>;
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo6: ldo6 {
> > -                             regulator-min-microvolt = <3300000>;
> > -                             regulator-max-microvolt = <3300000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> > +                             regulator-min-microvolt = <1800000>;
> > +                             regulator-max-microvolt = <1800000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo7: ldo7 {
> > -                             regulator-min-microvolt = <1800000>;
> > -                             regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ldo8: ldo8 {
> > -                             regulator-min-microvolt = <1800000>;
> > -                             regulator-max-microvolt = <1800000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> > +                             regulator-min-microvolt = <3300000>;
> > +                             regulator-max-microvolt = <3300000>;
> >                               regulator-always-on;
> >                       };
> >
> >                       vdd_ld09: ldo9 {
> >                               regulator-min-microvolt = <1050000>;
> >                               regulator-max-microvolt = <1050000>;
> > -                             regulator-min-microamp = <200000>;
> > -                             regulator-max-microamp = <200000>;
> > +                             regulator-always-on;
> >                       };
> >
> >                       vdd_ldo10: ldo10 {
> >                               regulator-min-microvolt = <1000000>;
> >                               regulator-max-microvolt = <1000000>;
> > -                             regulator-min-microamp = <300000>;
> > -                             regulator-max-microamp = <300000>;
> > +                             regulator-always-on;
> >                       };
> >
> >                       vdd_ldo11: ldo11 {
> >                               regulator-min-microvolt = <2500000>;
> >                               regulator-max-microvolt = <2500000>;
> > -                             regulator-min-microamp = <300000>;
> > -                             regulator-max-microamp = <300000>;
> >                               regulator-always-on;
> >                       };
> >               };
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
