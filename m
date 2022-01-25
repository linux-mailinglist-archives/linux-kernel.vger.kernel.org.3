Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3562749B46C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344824AbiAYM7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:59:19 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:33561 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573866AbiAYMza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:55:30 -0500
Received: by mail-ua1-f51.google.com with SMTP id u6so37274858uaq.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD9DQTul+wLkemI+WYQEXCcdTorD0NRU8/TuOZO7PRM=;
        b=PeM1W0HTuCAsRRlC+g9ossGy4xjFShOiMyoBtE9m+PK/zLCOxBC2Cu+yRLrJao/FBg
         O0/o32O6Dj3fxEV+saRNaJri41Q1RgBpPyQuaFpOqOfqGOkRrVvlSBal2dkVWlMy8PXo
         5vMuexdd+L5BO8O/3S0QjGiZ6fDGEhAKZq2rJ0x7IOrsPQ/qqfNytOWOZdguheHJLg2H
         mp/jwM3l0Xluvl9nb8SDBLctTTJM5jFa5xpfo9fXiKpX5ISe5HkII/cNkHC0/N95MQZ8
         VBvy0lGuoJMQYjtcnJZAK1j67AyY/dJDFNLGrwEeQMR/YfZT6UIryZDrKc6wB3Kb+ikC
         fW5g==
X-Gm-Message-State: AOAM531PEkzPHYh7JOPRZJ65w/70ddE+XerVA/4Ero0AtCZp6JMvnnuI
        ayr/5JjOzM/QGOzgyrJkEsQp1S1etfeDwIqh
X-Google-Smtp-Source: ABdhPJwUBYgIcPOMzNxGSPujv+shtPwSVopYcTRAV7bLlnmjMbGHqcKMz8w76YwRMSNzCU2RWHyQcQ==
X-Received: by 2002:a67:d591:: with SMTP id m17mr3192144vsj.44.1643115328947;
        Tue, 25 Jan 2022 04:55:28 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id g199sm3330656vkf.30.2022.01.25.04.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 04:55:28 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id l1so35314630uap.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:55:28 -0800 (PST)
X-Received: by 2002:a05:6102:34e:: with SMTP id e14mr449142vsa.68.1643115328137;
 Tue, 25 Jan 2022 04:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
 <CAK8P3a2Qik6A9ts0J_oXP-LMbqA0-kvZ4E9=bgLx5spxvLuC8w@mail.gmail.com>
In-Reply-To: <CAK8P3a2Qik6A9ts0J_oXP-LMbqA0-kvZ4E9=bgLx5spxvLuC8w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 13:55:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUdDxfWpuD6nuZUhTUsfWTOtxHVjogj1_QSjcds0uKww@mail.gmail.com>
Message-ID: <CAMuHMdWUdDxfWpuD6nuZUhTUsfWTOtxHVjogj1_QSjcds0uKww@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jan 25, 2022 at 1:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jan 25, 2022 at 9:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jan 25, 2022 at 8:31 AM <noreply@ellerman.id.au> wrote:
> > > FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
> > >
> > > http://kisskb.ellerman.id.au/kisskb/buildresult/14688953/
> > >
> > > Commit:   Add linux-next specific files for 20220125
> > >           d25ee88530253138d0b20d43511ca5acbda4e9f7
> > > Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
> > >
> > > Possible errors
> > > ---------------
> > >
> > > arch/m68k/include/asm/bitops.h:329:20: error: array subscript 2 is above array bounds of 'long unsigned int[1]' [-Werror=array-bounds]
> > > cc1: all warnings being treated as errors
> > > make[4]: *** [scripts/Makefile.build:289: drivers/net/ipa/ipa_mem.o] Error 1
> > > make[3]: *** [scripts/Makefile.build:572: drivers/net/ipa] Error 2
> > > make[2]: *** [scripts/Makefile.build:572: drivers/net] Error 2
> > > make[1]: *** [Makefile:1965: drivers] Error 2
> > > make: *** [Makefile:226: __sub-make] Error 2
> > >
> > > No warnings found in log.
> >
> > The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():
> >
> >         DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
> >         ...
> >         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
> >                 if (ipa_mem_id_required(ipa, mem_id))
> >                         dev_err(dev, "required memory region %u missing\n",
> >                                 mem_id);
> >         }
> >
> > This only happens with gcc-8, not with gcc-9, so it might be a
> > compiler bug. I don't see anything wrong with c:ipa_mem_valid()
> > nor with m68k's find_first_zero_bit().
>
> I've seen problems with warnings like this when gcc only partially
> inlines one of the functions. Does it go away if you mark find_next_bit()
> and find_first_bit() as __always_inline?

Thanks for the suggestio, but it doesn't make a difference.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
