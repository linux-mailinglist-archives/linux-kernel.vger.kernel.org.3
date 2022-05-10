Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD3520EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiEJHkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiEJHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:34:47 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88663C4;
        Tue, 10 May 2022 00:30:49 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id c1so12612082qkf.13;
        Tue, 10 May 2022 00:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fo4vqfFCJO4dTHiOSh+MRYxkxA7rYkGYBM5+Lz22icc=;
        b=UmHxso13IjA2mku/Wdk9OREuCmAPbFw8jsknirIOP2QD28XmEtmJt011uwZQMmvpWX
         wWsbWOAfazYENaIupnmB/qIofJCbG7tjRFfqORL4rYtBP7VIRHCj2SFH8W4EJ3VboBff
         TjH61ml9Ie/cRZPJ/rUccOpePBe1RfR5JJnXaF0IP7u3obuOcLGp2kwWbEYDtvsZwZDj
         Ayn5yjIjIMPlSlN+meU6fF7ZlWhUfr2iJSPuoqEVYJc0Jj7s3Xz1a3ZUi8dGfcplXT0O
         IGfSAMfja7add+Mvf1bczSvxrUY0MCa9yocszK5DCpvTjkSK79gaFxAd37S0uR4J8lu8
         bqtg==
X-Gm-Message-State: AOAM531P1HvNxvvJeIOtjhS0CN6g81HqZ+XO8IVwLw968c33pi7bzbJ1
        oGY4VyYVnzLHsz39mUgY7iWD/jwYiB1SWQ==
X-Google-Smtp-Source: ABdhPJwkyLSyTz8gcaU5Rrfg9AccMe3UotI70OHAP75AaOkkcAQ8pnq1Lg8wwSSqfr4iXa3SZIj5MQ==
X-Received: by 2002:a37:5e82:0:b0:69f:529c:4d39 with SMTP id s124-20020a375e82000000b0069f529c4d39mr14302377qkb.440.1652167847953;
        Tue, 10 May 2022 00:30:47 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a0d5c00b0069fc167df92sm8045726qkl.82.2022.05.10.00.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 00:30:47 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f7c57ee6feso169876417b3.2;
        Tue, 10 May 2022 00:30:47 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr17920371ywg.316.1652167847192; Tue, 10
 May 2022 00:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <2b7d411b4a7913335082c858cb0d63b9e4bf7c5b.1652103920.git.geert+renesas@glider.be>
 <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
In-Reply-To: <20fd1a74-c0f5-d8e9-4903-b74c185d5aa3@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 May 2022 09:30:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
Message-ID: <CAMuHMdVXHSnOOnn3jchezQc+bsPYTnSPuw_rOe+pyskAVaQGnQ@mail.gmail.com>
Subject: Re: [PATCH] memory: OMAP_GPMC should depend on ARCH_OMAP2PLUS || ARCH_K3
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Tue, May 10, 2022 at 9:22 AM Roger Quadros <rogerq@kernel.org> wrote:
> On 09/05/2022 16:48, Geert Uytterhoeven wrote:
> > The Texas Instruments OMAP General Purpose Memory Controller (GPMC) is
> > only present on TI OMAP2/3/4/5, AM33xx, AM43x, DRA7xx, TI81xx, and K3
> > SoCs.  Hence add a dependency on ARCH_OMAP2PLUS || ARCH_K3, to prevent
> > asking the user about this driver when configuring a kernel without
> > OMAP2+ or K3 SoC family support.
> >
> > Fixes: be34f45f0d4aa91c ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -105,6 +105,7 @@ config TI_EMIF
> >  config OMAP_GPMC
> >       tristate "Texas Instruments OMAP SoC GPMC driver"
> >       depends on OF_ADDRESS
> > +     depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
> >       select GPIOLIB
> >       help
> >         This driver is for the General Purpose Memory Controller (GPMC)
>
> Is there any possibility that CONFIG_IRQ_DOMAIN is not set while both
> OF_ADDRESS and COMPILE_TEST are set?
>
> That particular case will lead to build failures.
>
> e.g.
> https://krzk.eu/#/builders/63/builds/162

So it needs an additional dependency on IRQ_DOMAIN.
That is a pre-existing problem, not caused by my patch (which adds
more dependencies, and doesn't remove any).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
