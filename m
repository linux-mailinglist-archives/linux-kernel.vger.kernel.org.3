Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7437A497F96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiAXMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiAXMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:31:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A0DC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:31:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so20951571eje.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RhPYuS2G+COq83UI0pFOYrwspRC0HIvjHjPdqohYyY=;
        b=tCsbaFtKKfABsCe4Ogt8GLq8k5ez/5SfbB4TP57iHBgzcz6RnOmWSxAVJX+Ma6lZuP
         8w8R315YVWor56yrGvsOqGF997qU5Elf766jCzRl4yaHg699OArePHIgnP+AJit+PyN3
         ZAl87ElGtnGWVnc5qRuIUnhBlZXzo9kI2DzuHDvPEXYD29i8HXOSpHrm2/iXNv9x3lXc
         6RpwA+1kEzDD8HHGkYnzoMPxWbfJF53ilC/2yV2zKKdwqcwSw25aMKd1SYBchx/n8EGZ
         K7E2bA4OW6ycLzhXxh/NtF+ejpeB97iGd2k+KLeILCxgNlWukb5/FIQtyKokzKGtwaUP
         kETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RhPYuS2G+COq83UI0pFOYrwspRC0HIvjHjPdqohYyY=;
        b=mb32es/lZjaLzNlGMNv3TGI+KaD9u7GXznWWEdsijkH6n3hw3xGC3gLpIExy/hge10
         WEMv/YBedQiMsa3aAyAfDWrvWNldBcu+a6+YryJgzSA5QbK2Ke4CTe9JhKiDMxVEbT9r
         vVpu4ZR9WE5PR2vfuuARAktKuFpIkaOrskxVEXbqvsKZ1/SJX7pFP9Yw04OXuRS8wvvR
         cpbjm/eTzjt1/R8/wBQahdqyVKeEAACbkD7RsuwsVEJ9r/bEjElKR2cIkpEvfOvthMxq
         ix31yXDwc+7qqpNBl6WGY4peTEpKq3KWsjMmPoCKKcJPTM/VZzb8sd0bgh9NS2OeyEgX
         26mw==
X-Gm-Message-State: AOAM531P4XHRHrFRxn063wGFoG7KkRibp3px95q9t+HZYi9ff7FeyY2/
        yrK9JgYt44ldVj8DTZXQ+6BirqpKnkefG0YqEYUvwA==
X-Google-Smtp-Source: ABdhPJy6TIq9mOvg/feHF5oRvnpf1PBlsIUkzIkXFsnNty13n9tQATxF/WcG0L5T+KwHGseVpQk5G9rGMVlYuraPMg8=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr12932024ejn.294.1643027511685;
 Mon, 24 Jan 2022 04:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
 <20220121081810.155500-6-jeanmichel.hautbois@ideasonboard.com> <Yes3c1v+V1hMlWfW@pendragon.ideasonboard.com>
In-Reply-To: <Yes3c1v+V1hMlWfW@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 24 Jan 2022 12:31:34 +0000
Message-ID: <CAPY8ntDR5AsxGE5fh_KHMonoZait9evxQkpidu10F7EY9CPxZA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/7] ARM: dts: bcm2711: Add unicam CSI nodes
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        devicetree@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Naushir Patuck <naush@raspberrypi.com>, robh@kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent and Jean-Michel

On Fri, 21 Jan 2022 at 22:45, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jean-Michel,
>
> Thank you for the patch.
>
> On Fri, Jan 21, 2022 at 09:18:08AM +0100, Jean-Michel Hautbois wrote:
> > Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
> > interrupt declaration, corresponding clocks and default as disabled.
> >
> > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> > ---
> >  arch/arm/boot/dts/bcm2711.dtsi | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> > index dff18fc9a906..077141df7024 100644
> > --- a/arch/arm/boot/dts/bcm2711.dtsi
> > +++ b/arch/arm/boot/dts/bcm2711.dtsi
> > @@ -3,6 +3,7 @@
> >
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/soc/bcm2835-pm.h>
> > +#include <dt-bindings/power/raspberrypi-power.h>
> >
> >  / {
> >       compatible = "brcm,bcm2711";
> > @@ -293,6 +294,36 @@ hvs: hvs@7e400000 {
> >                       interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> >               };
> >
> > +             csi0: csi1@7e800000 {
>
> The node name should be csi@7e800000, not csi1@7e800000. Now, this will
> probably cause issues with the firmware that looks for csi1 (and csi0 ?)
> to hand over control of the Unicam CSI-2 receiver to the kernel. I
> wonder if this is something that could be handled by a firmware update,
> to also recognize nodes named "csi" ?

It already looks for any node starting "csi". If you check the
downstream DT [1], then the nodes are "csi0: csi@7e800000" and "csi1:
csi@7e801000".

There is no actual action required to hand the peripheral over to the
kernel, it just prevents the firmware from using it and causing
problems (it masks out the interrupt, and that's checked as part of
the firmware initialising the peripheral).

If using imx219 or one of the other sensors supported by the firmware,
"vcgencmd get_camera" should report that the sensor isn't detected,
and "sudo vcdbg log msg" should have a line similar to
"020174.613: camsubs: Ignoring camera 0 as unicam device not available"

  Dave

[1] https://github.com/raspberrypi/linux/blob/rpi-5.10.y/arch/arm/boot/dts/bcm270x.dtsi#L88

> > +                     compatible = "brcm,bcm2835-unicam";
> > +                     reg = <0x7e800000 0x800>,
> > +                           <0x7e802000 0x4>;
> > +                     interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clocks BCM2835_CLOCK_CAM0>,
> > +                              <&firmware_clocks 4>;
> > +                     clock-names = "lp", "vpu";
> > +                     power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     #clock-cells = <1>;
>
> Why do you need #address-cells, #size-cells and #clock-cells ? They're
> not mentioned in the binding.
>
> > +                     status="disabled";
>
> Missing spaces around the =.
>
> Same comment for the next node.
>
> > +             };
> > +
> > +             csi1: csi1@7e801000 {
> > +                     compatible = "brcm,bcm2835-unicam";
> > +                     reg = <0x7e801000 0x800>,
> > +                           <0x7e802004 0x4>;
> > +                     interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&clocks BCM2835_CLOCK_CAM1>,
> > +                              <&firmware_clocks 4>;
> > +                     clock-names = "lp", "vpu";
> > +                     power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     #clock-cells = <1>;
> > +                     status="disabled";
> > +             };
> > +
> >               pixelvalve3: pixelvalve@7ec12000 {
> >                       compatible = "brcm,bcm2711-pixelvalve3";
> >                       reg = <0x7ec12000 0x100>;
>
> --
> Regards,
>
> Laurent Pinchart
