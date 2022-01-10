Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087E648933B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiAJI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:26:26 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:38846 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240397AbiAJI0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:26:11 -0500
Received: by mail-ua1-f52.google.com with SMTP id h11so86470uar.5;
        Mon, 10 Jan 2022 00:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sInr+joEp/exnuFtoXKUR1JFErKpOSHvuvlIYhoSkyY=;
        b=2RSQZBTgwj1SNCyW3+315t6QI6Ke0+sJc4j+O92k/B22W+hQskRy7oRqtacm5g/ikn
         sCCDl4/d2enQjpgH3UwR0Q7jBmw+4QzGfHNmeTRorC1nEF/qdxU2Gw6uzFIAkkcoUYcb
         UcJqbeFbzY9JLf9spFkuWBv9ff5RS5agUwP0GGMW2edc+C42yRo3JLCFv97doL39CQ7a
         LxGFg8M8208KB6pAmLg1IFpuMgBJO3YegMjUqf9jIphWFszHdjtm/sl7+N8VcowqlIAG
         0HSY4fL5ja//PrXc3Lk8WQ6Cj7T3zGqikNYTAwwDVo+m89iVoxfnt0k1GJIkXv2eHLi2
         MmwQ==
X-Gm-Message-State: AOAM533NEb5ltG+rj2hS49iIS+tBh3MZ3V8LAK62ufHzqMTz/dBhybDu
        IshMDJxo2w56jqjapz3qur4H2ZgU/97/IQ==
X-Google-Smtp-Source: ABdhPJynWikk/LCf89nrhhMH/vkMLMdL4UFtp9VDRXFqN6ufu31IPPQYxBKCyr8gDLkymecZC/q0Bw==
X-Received: by 2002:a67:e88c:: with SMTP id x12mr430910vsn.34.1641803170341;
        Mon, 10 Jan 2022 00:26:10 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id l202sm2170374vkl.40.2022.01.10.00.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:26:09 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id l15so10558453uai.11;
        Mon, 10 Jan 2022 00:26:09 -0800 (PST)
X-Received: by 2002:ab0:2118:: with SMTP id d24mr24987663ual.78.1641803169401;
 Mon, 10 Jan 2022 00:26:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VeEvT-_47gKFAYdz-BR9y=KLEw2uMbRxYKo1rLQSQEfyg@mail.gmail.com>
 <Ydorm5HirY2i/RCg@errol.ini.cmu.edu>
In-Reply-To: <Ydorm5HirY2i/RCg@errol.ini.cmu.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jan 2022 09:25:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzMaKyG84CBt4S1xy4Jd+y85LG+KhbR4QvJ09PcU-f3A@mail.gmail.com>
Message-ID: <CAMuHMdWzMaKyG84CBt4S1xy4Jd+y85LG+KhbR4QvJ09PcU-f3A@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Sun, Jan 9, 2022 at 1:26 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Sat, Jan 08, 2022 at 07:43:19PM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 8, 2022 at 6:11 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> > > +       u32 div;
> > > +
> > > +       div = freq ? host->ref_clk / freq : 256U;
> >
> > > +       div = roundup_pow_of_two(div);
> > > +       div = clamp(div, 2U, 256U);
> >
> > Not sure why it becomes two lines again.
>
> Per my previous email, I have:
>
>         div = clamp((u32)roundup_pow_of_two(div), 2U, 256U);
>
> ... lined up for v10 (pending also Geert's OK on the (u32) cast
> to shut up compiler warnings) :)

JFY (as you decided to keep the two separate lines), this is
exactly why clamp_t()exists: to avoid the explicit cast.

i.e.

    div = clamp_t(u32, roundup_pow_of_two(div), 2U, 256U);

or

    div = clamp_t(u32, roundup_pow_of_two(div), 2, 256);

(the implicit cast is applied to all parameters).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
