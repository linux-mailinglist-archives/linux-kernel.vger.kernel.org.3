Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2A4A48DB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379227AbiAaN5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:57:09 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:40031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379285AbiAaN5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:57:08 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDyoU-1n4bXq2UeC-009wI0 for <linux-kernel@vger.kernel.org>; Mon, 31 Jan
 2022 14:57:06 +0100
Received: by mail-wm1-f51.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so13710971wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:57:06 -0800 (PST)
X-Gm-Message-State: AOAM5318Zr4x5GNULyEdE+1J5djzpR5+UEwh0hJhj7Y+YFEFpjiLeBf5
        I5I0E/9MWrwODmP9bnTtnVuNpZIUyatNti/Jl0g=
X-Google-Smtp-Source: ABdhPJyCdfYqPFNmYBHdVNyIMNd7iA0YCInVn3QxpZaorB/N7/GMT0WnkA19JE/0Eu40a4rdlyjUc+dSWxOMpZgcSE8=
X-Received: by 2002:a05:600c:2309:: with SMTP id 9mr27424396wmo.82.1643635850350;
 Mon, 31 Jan 2022 05:30:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
 <YfKngOPLeI3rQOn3@casper.infradead.org> <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
 <Yfa4WMeauvmgkQ9H@kernel.org> <YfbQlMyohx31FhSW@casper.infradead.org>
In-Reply-To: <YfbQlMyohx31FhSW@casper.infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 31 Jan 2022 14:30:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1UcY7Lkm0U5igQCq2K5kpqpjVi-sW3R=JzpciS-+c-gQ@mail.gmail.com>
Message-ID: <CAK8P3a1UcY7Lkm0U5igQCq2K5kpqpjVi-sW3R=JzpciS-+c-gQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:p4g4Uuj37k2Pg7pPD2WvF2mZ3eU1zXvVCn5vkAZXuUOzek4mMS/
 PrpNNUtKKLiU2IyNBgA+HcfSuUoqFvkDXqqOECVpXyNwTc8pgaRQwi1d6MdNNy4FqslBtlm
 xzhQcItxsS9Uzfij+ff11NMUXVJGBp71UpCezoilRJo0AJoA7g9IreNvpB60tqxoKY6dLi7
 3h0AQCDfC6Qsl06gSllNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g5TV19tzgPc=:AEiN7qlEsNcXmA4H1No0n5
 1dpBpePlWwWC+Q2g0mCOjRwaUQUv3nxsd3Ltk+zo9chhtd640uA+qjOln4HT2DkFY/6se5mAI
 6bJH3Swy5zlr0HWAsqa90GQ1x5VxyQZLI7w98Vdk6kRy4dINReFErVVAEHTVZvvSy0FJG3jbH
 HFx3fgLPSJ/b1YXrUYy1qQNLouSe4oykjinznuqwSv6gVrdogR4adI9Rv+CC737mKN085V5td
 5yJoSOy0BaTVzXqGQ5aQdceVm2J1s5nS3U3v5MLJYfXitYAV39nadVhZKz5T3nNBui/aMuQCv
 YlMcrtlF+bqANLfCkXgPEOBO1jsucUJjxLerF/yryB9QjG+burVhZJb5Ss97tHUCLD9vnoON0
 KcjA32PETIyLjsEoS2yjVGtKmbXlRNGFnuk8l8zoHGuYzf998eeSBI7Va0ZkCu81WIut6gMgG
 65MxD5ZbZTHPSTZAp9xLxqANqKSalp/A4gJ1G5EJEyuZssxW8ayn2UihTgXozNHZooABXD9JG
 snVCY12nvxywFbfoGnmUaRNHFk0h3AT50gRAR4hQO0gfMlvL52Z1hql87l93lCEO/gXrdoWf2
 4o/kqgZo8zEXl3V02c26iXoUS09M5U+5RtNGHXjU/vF31xVxmEhEEs3+JcrYaLwcLZvPlC/mS
 f3AJFeTIIF0q5QHtefYeF7jENv9as4sGujlz9iWFpMPK73V+R4RDTUCCXmVEVMu12mbIqsueR
 fQ6ol/O5To1nbFAbKjnEK8ezyPnO596WSUnUFBlvxUh1KiFUd1kSvfNC7AWFCWxrxILltFp+V
 f9U2fTNi0glkBCdCott0kLvFTSgn1TKWGOOKrQ0arChGzkrqSY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 6:53 PM Matthew Wilcox <willy@infradead.org> wrote:

> Thanks for doing the sweep, Mike.
>
> I think I found a deeper problem which is masked due to our maze of
> header files:
>
> include/asm-generic/io.h:#ifndef virt_to_phys
> include/asm-generic/io.h:#define virt_to_phys virt_to_phys
>
> so there's an assumption that <asm/io.h> defines virt_to_phys().
> You can see that in a number of architectures, eg:
>
> arch/alpha/include/asm/io.h:static inline unsigned long virt_to_phys(volatile void *address)
> arch/ia64/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/mips/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/nios2/include/asm/io.h:#define virt_to_phys(vaddr) \
> arch/parisc/include/asm/io.h:#define virt_to_phys(a) ((unsigned long)__pa(a))
> arch/powerpc/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/sh/include/asm/io.h:#define virt_to_phys(address)  ((unsigned long)(address))
> arch/x86/include/asm/io.h:#define virt_to_phys virt_to_phys
>
> That's clearly not the right place to define it.  Two architectures
> put it in asm/memory.h:
>
> arch/arm/include/asm/memory.h:#define virt_to_phys virt_to_phys
> arch/arm64/include/asm/memory.h:#define virt_to_phys virt_to_phys
>
> then:
>
> arch/m68k/include/asm/virtconvert.h:#define virt_to_phys virt_to_phys
> arch/sparc/include/asm/page_32.h:#define virt_to_phys           __pa
> arch/sparc/include/asm/page_64.h:#define virt_to_phys __pa
>
> This needs to be properly sorted out, but I don't want to tell Karolina
> that's now her job as a prerequisite for merging this patchset; that
> would be unfair.
>
> Cc'ing Arnd.  This is the kind of awful mess that he loves fixing ;-)

Adding Ingo as well. I'm in the middle of getting his fast-headers tree
to work well on a couple of other architectures, and the memory.h/page.h/io.h
mess is one of the  tricky bits in there, both in his series and in my
follow-ups.

What makes this bit even worse is that the architectures also not just
inconsistent about where they put __va/__pa and
virt_to_phys/phys_to_virt, they are also inconsistent about which of the
two pairs is based on the other, so any way you touch it means you
will break something, and changing it now will likely require a tricky
rebase of Ingo's patches.

Ingo, do you happen to have patches already that could be isolated
from your series to address this? Maybe we can add the
linux/mm_page_address.h header first and require that each
architecture puts these macros into asm/page_address.h.
We need to isolate these anyway, because the page addresses
are used in a lot of places that don't need to include any of the
remaining headers (page.h, mm.h, memory.h, io.h) that pull in
hundreds more.

          Arnd
