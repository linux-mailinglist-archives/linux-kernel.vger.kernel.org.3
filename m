Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DAE4634D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhK3M4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhK3M4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:56:06 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F5C061574;
        Tue, 30 Nov 2021 04:52:47 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v203so52327451ybe.6;
        Tue, 30 Nov 2021 04:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7pU/kZSEQ2Dl/MfTJFE6qU6ngZCzA+kwHkAzVPjJRE=;
        b=VpY3mCz1pDajDzAgxCxxKwEqPkRec2rAkHui4tB/LNcRdMtclD9PYg6jNK2TbqZ3hz
         3n4ZSgQhRbL7HnocMja4zmbNimmss5eT6Luna0tFfFHi5/dUSbci9ZBpPojAY5+RT9w8
         0AMkCumlSnOJNRMNNWNRw2YNmHsFZEdx2kv3WFAgfd8++g8a6bdfo/h1wf7cDyQEq9Fb
         KuAKZLHUpFCNsodTMn5zsRC7gpx+IGZ4g5Ssz28VX/+Nr3c46p6CsgXn8ZS83lXZHmRD
         Ya02oRdG2Y7K5HnMYwULexEhu+HgWRf2da6M6Py+A0UT7pZPfzPWplD6qGJznnSL/+EQ
         5YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7pU/kZSEQ2Dl/MfTJFE6qU6ngZCzA+kwHkAzVPjJRE=;
        b=pCqf8Cjepifvrfs5r5qpACX2LyIpjF6FBIsVZZBrTNvlMyNlqIls5/7M9XLx/2vmAF
         IBSSthxAFNR0DVRlGxNB5/kzLA45qxaeOjWiutChLkYkccgn0/uOJQ+7ZvlWJ4bKU1JV
         ifutaNS/aPsWQmFVLYs4cQNUiWEFyjIK8IrGW+XFXCkclvVAxGkGifkXkaLzU+5p5bLw
         F6g9xMuOs28ctkJGIMuzKLHtfbF3BjKpgP1+uXXh+UEY63QY9EJ9dsrXZt7k20SUMD+9
         fl3gLB4OoxBMxr49A9exnMeEciIhGNem7gV2ig3EpjbvS4DOrTGqORndwKrKP6T3W/Zh
         FX1w==
X-Gm-Message-State: AOAM532Rz1eRbf8hV8M2W12iKjGkiCfUl79DOnpPGTmxp0IJTMCEkW5L
        RElgLzXLhSmtMI36nIvORUEm+jbJd/3WPbQzdalUl2OontSDpA==
X-Google-Smtp-Source: ABdhPJwrHnQFOdq/jnYWzLYu3CCd1llestqqmIsGRwquBsrL1ZFpPxh57d8a+Y5kNXkVgF6un4Po+Vqgx/1jLYCCzRE=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr40055915ybe.422.1638276766783;
 Tue, 30 Nov 2021 04:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org> <CAMuHMdX2ZRvDYA3idmw3nBcP6CO=2od6ZU-UeJo9vYsuB=fQNQ@mail.gmail.com>
 <8735no70tt.wl-maz@kernel.org> <CAMuHMdVS67BLP2XEdD6ZvVBVE2x11gKnQa1TqG659HXPM5scqQ@mail.gmail.com>
 <CAMuHMdWJhnXabKGpW7k944dzQHtwQtxw-yb2bRBsoaMw6N6nuA@mail.gmail.com>
 <87tug3clvc.wl-maz@kernel.org> <CAMuHMdWGb2xik+94RVwtq8E6+9eN=HfQLX3a4sTjKQXR96Udkw@mail.gmail.com>
 <87r1b7ck40.wl-maz@kernel.org> <OSZPR01MB7019E7DD7119EFF9C994AA62AA649@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <87tufvmes9.wl-maz@kernel.org> <CA+V-a8siHRjF+bJu88QFwz0a_MZ+kiJEwmER58_feyr8O+WNGA@mail.gmail.com>
 <CAL_JsqK+GcnChx3i9fsYnw+FzZgON4PtKB=CzYLUj6sXtxX6fQ@mail.gmail.com>
In-Reply-To: <CAL_JsqK+GcnChx3i9fsYnw+FzZgON4PtKB=CzYLUj6sXtxX6fQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 30 Nov 2021 12:52:21 +0000
Message-ID: <CA+V-a8sVS_1hUWJ3uM+VffGyMtdnctBOJTyHTQAoJZGOh0a1Tw@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 6:33 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 29, 2021 at 6:13 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
>
> I timed my vacation well...
>
> > On Mon, Nov 29, 2021 at 10:34 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sat, 27 Nov 2021 00:42:49 +0000,
> > > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > > -----Original Message-----
> > > > > From: Marc Zyngier <maz@kernel.org>
> > > > > Sent: 23 November 2021 09:11
> > > > > To: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; kernel-team@android.com; Rob Herring
> > > > > <robh@kernel.org>; John Crispin <john@phrozen.org>; Biwen Li <biwen.li@nxp.com>; Chris Brandt
> > > > > <Chris.Brandt@renesas.com>; linux-renesas-soc@vger.kernel.org; Prabhakar Mahadev Lad
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own definition of interrupt-map
> > > > >
> > > > > On Tue, 23 Nov 2021 08:44:19 +0000,
> > > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > >
> > > > > > Hi Marc,
> > > > > >
> > > > > > On Tue, Nov 23, 2021 at 9:33 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > > > On Tue, 23 Nov 2021 07:57:48 +0000,
> > > > > > > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > Summarized:
> > > > > > > >   - Before the bad commit, and after your fix, irqc-rza1 is invoked,
> > > > > > > >     and the number of interrupts seen is correct, but input events
> > > > > > > >     are doubled.
> > > > > > > >   - After the bad commit, irqc-rza1 is not invoked, and there is an
> > > > > > > >     interrupt storm, but input events are OK.
> > > > > > >
> > > > > > > OK, that's reassuring, even if the "twice the events" stuff isn't
> > > > > > > what you'd expect. We at least know this is a separate issue, and
> > > > > > > that this patch on top of -rc1 brings you back to the 5.15 behaviour.
> > > > > > >
> > > > > > > I'd expect it to be the case for the other platforms as well.
> > > > > >
> > > > > > OK.
> > > > > >
> > > > > > BTW, what would have been the correct way to do this for irqc-rza1?
> > > > > > I think we're about to make the same mistake with RZ/G2L IRQC
> > > > > > support[1]?
> > > > >
> > > > > Indeed, and I was about to look into it.
> > > > >
> > > > > There are multiple ways to skin this cat, including renaming 'interrupt-map' to 'my-own-private-
> > > > > interrupt-map'. Or use something akin the new 'msi-range' (which we could call interrupt-range), and
> > > > > replace:
> > > > >
> > > > >   interrupt-map = <0 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <1 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <2 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <3 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <4 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <5 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <6 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > > > >                   <7 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > > > >
> > > > > with:
> > > > >
> > > > >   interrupt-range = <&gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH 0 8>;
>
> interrupts would work just fine here:
>
> interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
>   <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>
> We don't need a different solution for N:1 interrupts from N:M. Sure,
> that could become unweldy if there are a lot of interrupts (just like
> interrupt-map), but is that an immediate problem?
>
It's just that with this approach the driver will have to index the
interrupts instead of reading from DT.

Marc - is it OK with the above approach?

> > > > >
> > > > Just to clarify, do you suggest to add interrupt-range as a generic
> > > > DT property or SoC/company specific property?
> > >
> > > As a generic one. I have no interest in SoC-specific stuff (though you
> > > are free to invent your own and run it by Rob).
> > >
> > OK will go with a generic one.
> >
> > > > If you meant to add generic property where would you suggest to
> > > > document this property?
> > >
> > > Ideally collocated with the rest of the interrupt properties.
> > >
> > OK, I will go with interrupts.txt for now. Is that OK with you Rob?
>
> Nope. As the rest of interrupts are documented in DT Spec it goes
> there and there needs to be a schema (in dtschema).
>
Agreed.

> > (the reason I ask because interrupt-map/mask haven't been documented).
>
> Yes, they are. Only for the last 20+ years.
>
My bad I was referring in
Documentation/devicetree/bindings/interrupt-controller/

Cheers,
Prabhakar

> Rob
