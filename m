Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E88489406
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiAJIqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:46:51 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:40640 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241989AbiAJIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:44:12 -0500
Received: by mail-ua1-f43.google.com with SMTP id v12so22053360uar.7;
        Mon, 10 Jan 2022 00:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8L7Ts6Y/3w7PZcX5mTRn1c1+l5sen9Q1rKBXZdOEiQ=;
        b=VIyD3Oga3cp6EWxK01dUJp9p2CfjKJN7vvgTHRksLUC6Mh3PlOpQFM+76VrQyAQ2sj
         uiFQg8yQfM90hl1r0j2A8JYWzwaWKR6/IR8FCm1ieOEEG6O3FtLm6Q1djMX14o2ai7j+
         kdnlr77OwGW1oOrOUt4h1q4RZoTr2GzyeLaqU1J959ocax6nmUuNLug+qdNrIzBmsXnn
         PwmXZrrOoeC8ksqqsu6PDGfHSm7Tvu+U5xDuRcdpofJq3jBjrOUMAk4ETEIeukbJD3Yq
         /Gij0ukdXxhEvaE+M/6OJj9mUlAb1xQ8R1AvfMSSP1c36o90xvNaZrlNMtYfDvT2BRex
         qxTA==
X-Gm-Message-State: AOAM532u273aG8e1YBg0XpuHNuBORIhdqsccMbiXcvzrxfRaBOm0pH44
        okgcYBxuVKDUPA3INcGn2fgXl4+PHUe34g==
X-Google-Smtp-Source: ABdhPJxBX5mhOFs3Wht213J8BQdQRMWsGGTWU4IY2Nf1KYc2IAI4VcnTYsbfVBDJa2+TuLwuTw049g==
X-Received: by 2002:ab0:70cf:: with SMTP id r15mr10483498ual.80.1641804251409;
        Mon, 10 Jan 2022 00:44:11 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id b8sm3728203vsl.19.2022.01.10.00.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:44:10 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id n12so30404vkc.12;
        Mon, 10 Jan 2022 00:44:10 -0800 (PST)
X-Received: by 2002:a05:6122:21a6:: with SMTP id j38mr27491098vkd.39.1641804249990;
 Mon, 10 Jan 2022 00:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com> <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
In-Reply-To: <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 09:43:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqUcjRQHD898Ja4R0X3QpXvTODE8=pG7UjJ-NtHTFSDA@mail.gmail.com>
Message-ID: <CAMuHMdVqUcjRQHD898Ja4R0X3QpXvTODE8=pG7UjJ-NtHTFSDA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, Dec 29, 2021 at 5:56 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Dec 24, 2021 at 08:23:08AM +0300, Nikita Yushchenko wrote:
> > Add the missing lvds0 node for the R-Car M3-W+ SoC.
> >
> > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77961.dtsi | 27 +++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > index 86d59e7e1a87..a34d5b1d6431 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > @@ -2718,6 +2718,33 @@ du_out_hdmi0: endpoint {
> >                               port@2 {
> >                                       reg = <2>;
> >                                       du_out_lvds0: endpoint {
> > +                                             remote-endpoint = <&lvds0_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             lvds0: lvds@feb90000 {
> > +                     compatible = "renesas,r8a77961-lvds";
> > +                     reg = <0 0xfeb90000 0 0x14>;
> > +                     clocks = <&cpg CPG_MOD 727>;
> > +                     power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
> > +                     resets = <&cpg 727>;
> > +                     status = "disabled";
> > +
> > +                     ports {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +
> > +                             port@0 {
> > +                                     reg = <0>;
> > +                                     lvds0_in: endpoint {
> > +                                             remote-endpoint = <&du_out_lvds0>;
> > +                                     };
> > +                             };
> > +                             port@1 {
> > +                                     reg = <1>;
> > +                                     lvds0_out: endpoint {
> >                                       };
>
> Endpoints must have a remote-endpoint property. Let's drop the endpoint
> here and keep the port only, the endpoint can be declared in board
> files.
>
> If you're fine with this change I can make it when applying the patch.

Isn't this patch for me to apply to renesas-devel?

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
