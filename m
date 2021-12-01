Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309FF464EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349559AbhLANkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239346AbhLANkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:40:41 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840CC061574;
        Wed,  1 Dec 2021 05:37:20 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x32so63432721ybi.12;
        Wed, 01 Dec 2021 05:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJQwgAcn3m3gWE5P+/ZzPN9/7OfOm1vUbRkJxx4e0j8=;
        b=TEaLkNsTM5R2G2hzecnDKfJVQfE4lPZuYkiffO/Pi8fuRQCqKA4zTZ2Kk4PFhqVYhJ
         FpA/OYHeANU8BDNHZq7/VJdD6ADAFpiAb/VUfSBTkfi2bUIlxfvIeNABTY68xbzokAmS
         CydYFIKccHYe4zwo81gDqg4Xhpz6YTKP3qjqeicHJVvgK2+3lRbLPRxXv0Zai0rZyoZV
         Jn+8r1ALpTlpeTH0JJwKHz1TOZDRaebSJ3O0cIgpPqBUXc++l/Mo8KHwwO5Nsdh5J57V
         gHA/MstmFVLJrTuhbeNl8au4kzmt5IgEHhd84g5ddPJySEfUBuTXPFDcrvrRu6b8peoz
         nDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJQwgAcn3m3gWE5P+/ZzPN9/7OfOm1vUbRkJxx4e0j8=;
        b=qJCEbfNQGYFFKDEQDcBHPbEqEJc2aFU+HD2eMPEE21I6sx8L3JsPha5jTivRO1kXc+
         6Eh50Ih63QEoVT5QyBPiFv3GtOc9qVoSg/39kkXMsGcJFpv+SU/br4YsAhaE60+9gQFi
         Erfk6kKlou+cSLVS1lPl2yqq9In3c6axrVDyfzi3970FwwCOkSjI1Y1ev76A99ObhJmE
         HC4CV7M2nu3nLDZGC4H2NyVy3ofbbUXevQ9gsOb0acrFII9rAkbWug7CDVYSnPLHQQab
         VRiQLmCq2yeIyUI9GVm9YWCeKP6PaqsyCwIuXAExsyjxKe1N9j8AjJWYi5DziIhfXMSp
         2jmQ==
X-Gm-Message-State: AOAM533z5pOFNFP09pVBHLNZTmkJn2nS/ji8pJxsPfMGvZyrX/DC3NKF
        vvz3K5OydQB/yrOH1QMcKRlCY0oBC2nUChbFYegQ0YwtHeOjvw==
X-Google-Smtp-Source: ABdhPJyuLtjiZFz4i2ldW8v3MFG5mNquGjqnktLLVNQsky5FbQuHfCfTQXhSVxd+Gm/dhkk1ijm/KcESk/upnIYQqro=
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr7040527ybe.422.1638365839479;
 Wed, 01 Dec 2021 05:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20211122103032.517923-1-maz@kernel.org> <CAMuHMdX2ZRvDYA3idmw3nBcP6CO=2od6ZU-UeJo9vYsuB=fQNQ@mail.gmail.com>
 <8735no70tt.wl-maz@kernel.org> <CAMuHMdVS67BLP2XEdD6ZvVBVE2x11gKnQa1TqG659HXPM5scqQ@mail.gmail.com>
 <CAMuHMdWJhnXabKGpW7k944dzQHtwQtxw-yb2bRBsoaMw6N6nuA@mail.gmail.com>
 <87tug3clvc.wl-maz@kernel.org> <CAMuHMdWGb2xik+94RVwtq8E6+9eN=HfQLX3a4sTjKQXR96Udkw@mail.gmail.com>
 <87r1b7ck40.wl-maz@kernel.org> <OSZPR01MB7019E7DD7119EFF9C994AA62AA649@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <87tufvmes9.wl-maz@kernel.org> <CA+V-a8siHRjF+bJu88QFwz0a_MZ+kiJEwmER58_feyr8O+WNGA@mail.gmail.com>
 <CAL_JsqK+GcnChx3i9fsYnw+FzZgON4PtKB=CzYLUj6sXtxX6fQ@mail.gmail.com>
 <CA+V-a8sVS_1hUWJ3uM+VffGyMtdnctBOJTyHTQAoJZGOh0a1Tw@mail.gmail.com> <87bl21mqwk.wl-maz@kernel.org>
In-Reply-To: <87bl21mqwk.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 1 Dec 2021 13:36:53 +0000
Message-ID: <CA+V-a8vA0P-yhm2SHJmVh+cuUw7qodQLQBqzNPTz31x5q18xaA@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Add a quirk for controllers with their own
 definition of interrupt-map
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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

Hi Marc/Rob,

On Tue, Nov 30, 2021 at 6:37 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 30 Nov 2021 12:52:21 +0000,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > On Mon, Nov 29, 2021 at 6:33 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > interrupts would work just fine here:
> > >
> > > interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> > >   <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > We don't need a different solution for N:1 interrupts from N:M. Sure,
> > > that could become unweldy if there are a lot of interrupts (just like
> > > interrupt-map), but is that an immediate problem?
> > >
> > It's just that with this approach the driver will have to index the
> > interrupts instead of reading from DT.
> >
> > Marc - is it OK with the above approach?
>
> Anything that uses standard properties in a standard way works for me.
>
I added interrupts property now instead of interrupt-map as below:

irqc: interrupt-controller@110a0000 {
      compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
       #address-cells = <0>;
       interrupt-parent = <&gic>;
       interrupt-controller;
       reg = <0 0x110a0000 0 0x10000>;
       interrupts =
                      <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
                       <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
          clock-names = "clk", "pclk";
          power-domains = <&cpg>;
          resets = <&cpg R9A07G044_IA55_RESETN>;
};


In the hierarchal interrupt code its parsed as below:
on probe fetch the details:
range = of_get_property(np, "interrupts", &len);
if (!range)
      return -EINVAL;

for (len /= sizeof(*range), j = 0; len >= 3; len -= 3) {
      if (j >= IRQC_NUM_IRQ)
            return -EINVAL;

      priv->map[j].args[0] = be32_to_cpu(*range++);
      priv->map[j].args[1] = be32_to_cpu(*range++);
      priv->map[j].args[2] = be32_to_cpu(*range++);
      priv->map[j].args_count = 3;
      j++;
}

On alloc callback:
     spec.fwnode = domain->parent->fwnode;
     spec.param_count = priv->map[hwirq].args_count;
     for (i = 0; i < spec.param_count; i++)
          spec.param[i] = priv->map[hwirq].args[i];

     return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &spec);

In the board DTS (map interrupt 3 (index 3 is used as hwirq) to GIC):
&eth0 {
    pinctrl-0 = <&eth0_pins>;
    ...
    phy0: ethernet-phy@7 {
        compatible = "ethernet-phy-id0022.1640", "ethernet-phy-ieee802.3-c22";
        reg = <7>;
        interrupt-parent = <&irqc>;
        interrupts = <3  IRQ_TYPE_LEVEL_LOW>;
        rxc-skew-psec = <2400>;
       ....
    };
};

With this approach I see the kernel hangs. It looks like using
"interrupts" property makes the core to parse it and is used somewhere
(I have not looked where exactly it's done or causes this issue) I say
this because if I rename the "interrupts" property to something else I
no longer see any kernel hangs.

Is there something else I'm missing here?

Cheers,
Prabhakar



>         M.
>
> --
> Without deviation from the norm, progress is not possible.
