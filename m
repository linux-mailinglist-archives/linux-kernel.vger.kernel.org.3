Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105B350B385
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376759AbiDVJEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445919AbiDVJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:04:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52D53739;
        Fri, 22 Apr 2022 02:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A1C3B82B2F;
        Fri, 22 Apr 2022 09:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EC6C385AF;
        Fri, 22 Apr 2022 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650618081;
        bh=/m9HtiXeSolu5qrg2Hq80k+3cr1LM6XYLdAbp3oTHTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jBBBgfxNw8Qg5UPzBjmDTjT+E3APsjuWTMVt+hprqOwS6DIxRVDImGrZN7wMEx+rx
         86vdIpshLw/2xvYq9EXVD6U2UdmQg2jRX0+t8216G1sy5tFLNYTW6io3yJaCI0QPDi
         +fH/z8A5Z81qWD80aniD3CFr9+DcQ5t/+T4FsFJZDyW+Lf8LBXr2ZWf8iswYK9yKfa
         i6FRRqnzC3GECksp/PEHUWBaSiEgEAKgocxi6UKsOOgJj2oKl2WyGacfZfbT6muE++
         R+suLf2CeI5uMPJbWVzOPVsVKgB0U5HrVu/hHPwlJEySlo+e+tm5dGIoX+20rq6n6I
         1LbvJa+916YEg==
Received: by mail-wm1-f46.google.com with SMTP id q20so4708636wmq.1;
        Fri, 22 Apr 2022 02:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM531iQPKC7tDafbQgrxM8A5fPYLPvNc07bzy+GpC5CUwexNDkFsVc
        NpS/ULGgNtZkFbWmGBwEzly5Zc6w1iLAge5OLC4=
X-Google-Smtp-Source: ABdhPJyXx4ILSyW4olBWclzAEyhWJERXMp826335O4ZspD2rq64GVKddYaqSWtWZief/QyASpmBJtJchA9yTbG1sWmU=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr3134739wmc.71.1650618079284; Fri, 22
 Apr 2022 02:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220421082040.2866638-1-arnd@kernel.org> <2d2c0c14-461b-985b-ebf1-3c03fe97f332@gmail.com>
In-Reply-To: <2d2c0c14-461b-985b-ebf1-3c03fe97f332@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 22 Apr 2022 11:01:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1PvZUV9MDNqLWUZGT6Bb18SoPEv-j1V6RTEziKV74Z0A@mail.gmail.com>
Message-ID: <CAK8P3a1PvZUV9MDNqLWUZGT6Bb18SoPEv-j1V6RTEziKV74Z0A@mail.gmail.com>
Subject: Re: [PATCH] [v4] m68k: coldfire: drop ISA_DMA_API support
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:48 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 21.04.2022 um 20:20 schrieb Arnd Bergmann:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > After a build regression report, I took a look at possible users of
> > CONFIG_ISA_DMA_API on m68k and found none, which Greg confirmed. The
> > CONFIG_GENERIC_ISA_DMA option in turn is only needed to implement
> > ISA_DMA_API, and is clearly not used on the platforms with ISA support.
> >
> > The CONFIG_ISA support for AMIGA_PCMCIA is probably also unneeded,
> > but this is less clear. Unlike other PCMCIA implementations, this one
> > does not use the drivers/pcmcia subsystem at all and just supports
> > the "apne" network driver. When it was first added, one could use
> > ISA drivers on it as well, but this probably broke at some point.
>
> Hoping to clarify some of this:
>
> For the Amiga PCMCIA "apne" driver, both the definitions of
> isa_type/isa_sex and the definitions of the low-level accessor and
> address translation functions are protected by CONFIG_ISA (see
> arch/m68k/kernel/setup_mm.c and arch/m68k/include/asm/io_mm.h for details).
>
> This could conceivably be changed (only AMIGA_PCMCIA and Q40 do use
> these definitions, aside from ATARI_ROM_ISA), but as things are right
> now, neither Q40 ISA nor Amiga PCMCIA will work without CONFIG_ISA defined.

Ok, thanks for clarifying that, this makes a lot more sense now. I was wondering
what ISA devices one can actually use without DMA, but it turns out that a
lot of the older storage (pata_legacy, pata_isapnp, aha152x) and network
(3c509, 8390, cs89x0, smc9194) devices work in PIO mode, aside from
a couple of oddball special-purpose stuff (speech, busmouse, comedi,
appletalk, wan, ...).

> Regarding the Amiga PCMCIA driver's use of the drivers/pcmcia subsystem,
> I have a patch in limbo at netdev that makes use of the cftable parser
> code from drivers/pcmcia, but as far as I can recall, none of this
> depends on CONFIG_ISA.

Yes, Geert mentioned that on IRC already. Note that Dominik Brodowski
has said in the past that he would plan to eventually drop PCMCIA
support from the kernel, but I think if that happens, the cftable
parser can just be moved into the amiga_pcmcia code.

       Arnd
