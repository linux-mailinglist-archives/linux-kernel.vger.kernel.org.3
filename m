Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C04463C24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbhK3Qso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Nov 2021 11:48:44 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:45650 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhK3Qsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:48:42 -0500
Received: by mail-ua1-f41.google.com with SMTP id ay21so42707061uab.12;
        Tue, 30 Nov 2021 08:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iWgemuLdY/QvKYnwAaq261iQpjOIP4k64nwlshQt2Gk=;
        b=06tGN5zT7nu8LL2I5jvkSjwI9uYYQXPRleYUx8BSWYfAWwN9TP6iNn98PUktY7ibyc
         uGRjxHFZ4vEDU7keyaMe1T9Li7xf5L3xISg+tZXUlU+hdTQjQVjpe2bjemEIbZ0D9Pj6
         MiZhh9ACG/k8FXTgjYRbFIityyZm55lv61gVokSy9ijOCaxLEpvO9CWZaaXJQh3K6NLP
         9navW24vMwHADXt5kzcOOTaxgBeiiNUiQHGBNpVdgkOC6oGFAa5DxlJj9StNEAZhSBeW
         r0XtwaHbkrj8Y0CU7QjpAE3U1FBpzoPX/ftkJyUmYZa8KO29CTzmi4yRtUeqEYXXTFFP
         eKWQ==
X-Gm-Message-State: AOAM531GMvFDw2drvg5xTElaU1CiLFMMqmgDpK64YXjoDj4GTUQMx7tO
        1BDmH6vA+wwwReiJHyJlOqwZ6OwZc4uyug==
X-Google-Smtp-Source: ABdhPJzWFBi+9YzLqxNYPpo5Vw5ER0M1AsEPaK939U5P1mm6CN5DHogz53UvV5qw4tbm5zk1phUy2Q==
X-Received: by 2002:a67:eb54:: with SMTP id x20mr42992663vso.18.1638290722616;
        Tue, 30 Nov 2021 08:45:22 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id j17sm10084776vkp.27.2021.11.30.08.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:45:22 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id p2so42632524uad.11;
        Tue, 30 Nov 2021 08:45:22 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr42038722vsj.77.1638290721992;
 Tue, 30 Nov 2021 08:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20211104224033.3997504-1-kieran.bingham+renesas@ideasonboard.com>
 <CAMuHMdXVBj58ZM3LqCN3cudsE3VJV8AQC5OCOJP96RaqYf4NDQ@mail.gmail.com>
 <YYo0syH9m/CYlB2d@oden.dyn.berto.se> <YYo62jdzSTxqCMtk@oden.dyn.berto.se>
In-Reply-To: <YYo62jdzSTxqCMtk@oden.dyn.berto.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 17:45:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNZ+TOGU-H9dZu08WKO2fO2sbgL1BbN3JzEVBkOyMhdA@mail.gmail.com>
Message-ID: <CAMuHMdUNZ+TOGU-H9dZu08WKO2fO2sbgL1BbN3JzEVBkOyMhdA@mail.gmail.com>
Subject: Re: [PATCH 0/9] arm64: dts: renesas: Thermal binding validation
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Tue, Nov 9, 2021 at 10:09 AM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> On 2021-11-09 09:43:33 +0100, Niklas Söderlund wrote:
> > > > linux/arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dt.yaml:
> > > > thermal-zones: sensor3-thermal:cooling-maps:map0:contribution:0:0:
> > > > 1024 is greater than the maximum of 100
> > > >         From schema: Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > >
> > > > This validation error appears to be pervasive across all of these
> > > > bindings, but changing that will be more invasive and require someone to
> > > > perform dedicated testing with the thermal drivers to ensure that the
> > > > updates to the ranges do not cause unexpected side effects.
> > >
> > > Niklas?
> >
> > I will have a look. The thermal driver is the one driver where I have
> > automated CI test running.
>
> So the core of the issue is that the definition of the property changed
> in the txt to yaml conversion. The original definition was,
>
>   Optional property:
>   - contribution:         The cooling contribution to the thermal zone of the
>     Type: unsigned        referred cooling device at the referred trip point.
>     Size: one cell        The contribution is a ratio of the sum
>                             of all cooling contributions within a thermal zone.
>
> While the  new binding states,
>
>   contribution:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     minimum: 0
>     maximum: 100
>     description:
>       The percentage contribution of the cooling devices at the
>       specific trip temperature referenced in this map
>       to this thermal zone
>
> Looking at the real world usage of this only 2 out of 17 platforms sets
> a contribution value less or equal to 100. I will send a patch to fix
> the bindings.

Given Rob said he applied your patch[1], does that mean this series
is good to be applied?
Thanks!

[1] https://lore.kernel.org/all/YaU4XuiaJgEjGCdQ@robh.at.kernel.org/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
