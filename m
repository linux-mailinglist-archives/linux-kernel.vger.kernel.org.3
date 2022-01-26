Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D123349CEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242945AbiAZPfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:35:31 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:33417 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiAZPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:35:27 -0500
Received: by mail-ua1-f44.google.com with SMTP id u6so43640160uaq.0;
        Wed, 26 Jan 2022 07:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+VI0Hfc96C23EZYLDB91lCJyEYrscQJm5YA9s3qTNM=;
        b=UZ6mm/764eD8LeDwA5AeGHUcAP2Ecnw/Q1iawK07ctkqwdnOVnT+e6PlXWpswWaOj2
         TFz9IBUjDtE4wvkk9HT7IYrJKeDNaXc6mc5sjSD078TnTIeUL4amNpVB7gO3D3JcE3by
         Oq5FuD5BgYWhQO110xQM4Yws0/cxdlPiPeyjobZrXKzcJW6A/r+yt9dFpvtmj4WdD8m6
         SPfx7QaD6OpZWnvqssSb2+v5XhdvFx2y/NFsh/MOwG7/Xl8TynzVvrWxG5ZxlB6XdhwM
         tXz6JFXmYTyCI/5JLDU66DPqZNOXeFzrA9UeuEP3BlFiBkyyoifsQC0XcvwgYdQmjUXp
         s4pw==
X-Gm-Message-State: AOAM531Pn4Uay1I7T+QMGkmRha/PARAHS231DZi3ADHmE6Nc5ktOWkvF
        pQD9EPX3Gx+oSyQRIcrTfO7wDakkKLcnidQA
X-Google-Smtp-Source: ABdhPJzEC9aXeiP92DGXdnI7dGQ8nW3w9cruF2taTCmDI7jEUnW9PquUtrYT95E71uKw7MQT2+hbuA==
X-Received: by 2002:a67:ec82:: with SMTP id h2mr10506948vsp.53.1643211326608;
        Wed, 26 Jan 2022 07:35:26 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id e18sm1292620vsb.29.2022.01.26.07.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 07:35:26 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id b37so25873327uad.12;
        Wed, 26 Jan 2022 07:35:25 -0800 (PST)
X-Received: by 2002:a05:6102:a04:: with SMTP id t4mr4333511vsa.77.1643211325726;
 Wed, 26 Jan 2022 07:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20220112205205.4082026-1-nikita.yoush@cogentembedded.com>
 <CAMuHMdU0h+VaAbwOqJE5YRK2f69H8JrVgtXsoYNwvNgGJKH7mQ@mail.gmail.com> <a30c55ad-ec14-6cb8-0384-b07b79212351@cogentembedded.com>
In-Reply-To: <a30c55ad-ec14-6cb8-0384-b07b79212351@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 16:35:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWWu=be9pxh3QQSy-xnFjOs60JZt9mr-Q=rkQnBKFKMjQ@mail.gmail.com>
Message-ID: <CAMuHMdWWu=be9pxh3QQSy-xnFjOs60JZt9mr-Q=rkQnBKFKMjQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add 9-asix sensor device
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

On Wed, Jan 26, 2022 at 4:28 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> >> Interrupt definition is not added yet, because the interrupt lines of
> >> lsm9ds0 are pulled to VCC on the board, which implies need for
> >> active-low configuration. But st_sensors drivers currently can't work
> >> with active-low interrupts on this chip.
> >
> > That's unfortunate, as DT describes hardware, not limitations of the
> > software stack.
>
> Unfortunately, if interrupt definition is added, driver does wrong things and causes board hang.

OK.

> >> +                               vdd-supply = <&accel_3v3>;
> >> +                               vddio-supply = <&accel_3v3>;
> >
> > According to the bindings, the supplies are not required, so you can
> > leave them out? Or are the bindings wrong?
>
> If supplies are not defined, warning messages about dummy regulator are logged.

OK.

> > (The bindings also say "interrupts: maxItems 2", while the "interrupts:
> >   description" says up to three interrupts, doh...)
>
> Chip has 3 interrupt outputs. On KF board, all those are ANDed together and result connected to SoC's
> gpio that is expected to be used as a shared active-low interrupt. Driver currently claims that this
> chip does not support active-low interrupts. Per datasheet, this is not true. But driver's way to set up
> interrupt registers does not scale to the case when interrupts have to be configured by different bits
> in several registers, that part of the driver has to be somehow rewritten. I guess nobody has ever tried
> to make these drivers (st_*) to drive a compound device (accel+gyro) with interrupts.
>
> At the same time, the device is perfectly useful without interrupts, and that is how it is enabled in
> the vendor BSP.

OK, will queue in renesas-devel for v5.18, with the low-hanging fruits
(node names, order) fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
