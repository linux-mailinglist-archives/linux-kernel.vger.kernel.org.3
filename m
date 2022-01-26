Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8F249C609
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiAZJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:16:40 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:42509 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiAZJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:16:37 -0500
Received: by mail-ua1-f50.google.com with SMTP id e17so3387243uad.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8fyLjneVpTkQwxgneMNmICjJve2m3jg836j6+UHKfc=;
        b=Bd75r9pMP+N69US+r8ZzIxS2PfxuXZvMRirppOnrLNCtEcO/hUyLb3ekfJDGuUFQHR
         rr2ZpYDe14VkwGVGLWJcuogHJvejUzYjXfDWHJaSmmRadRP7aGDyTay8wl1t8TJj2u6m
         xwhMd0oM5AwBfvsNGfL8uIIlAmfbzCEsWtEzO0aQzwagJ6O3zo0Xqz1CqXG6BnvNwnBN
         dRnnHXr4ne1/HCT2AnoyjKE5y4sptmRaT7mj+xNGd/Jooh1bVbS/XEz8CvibRZ957+ff
         PZICnTroAgh2fAiFP1JV8wkikDq2MHRJlJIh2CO+IVxB4V/6U6C3TMlc3yFG0CwzoNsb
         es7Q==
X-Gm-Message-State: AOAM532tXMQl3tHYG5aK0rnvGmcA4vLSb2kK3LmkK2oHM3Es8v9pXIhY
        E0guaz59p3nnKXFikRhtIGl8xiBwBVBmc1pU
X-Google-Smtp-Source: ABdhPJwrXy9pVym5l3mIGdVX+ZdTslWoYHTSVcdaBFqUsKFWCvQWOY/nzZCZN/fmGUHKPr0xm35I0Q==
X-Received: by 2002:a67:f7d5:: with SMTP id a21mr4993461vsp.24.1643188596395;
        Wed, 26 Jan 2022 01:16:36 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id w124sm3434866vke.20.2022.01.26.01.16.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:16:36 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id j185so10272185vkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:16:35 -0800 (PST)
X-Received: by 2002:a1f:384b:: with SMTP id f72mr9684107vka.0.1643188595735;
 Wed, 26 Jan 2022 01:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
 <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com> <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org>
In-Reply-To: <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 10:16:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
Message-ID: <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     Kees Cook <keescook@chromium.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees

On Wed, Jan 26, 2022 at 9:54 AM Kees Cook <keescook@chromium.org> wrote:
> On January 25, 2022 10:02:56 AM PST, Yury Norov <yury.norov@gmail.com> wrote:
> >On Tue, Jan 25, 2022 at 12:47 AM Geert Uytterhoeven
> ><geert@linux-m68k.org> wrote:
> >> On Tue, Jan 25, 2022 at 8:31 AM <noreply@ellerman.id.au> wrote:
> >> > FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
> >> >
> >> > http://kisskb.ellerman.id.au/kisskb/buildresult/14688953/
> >> >
> >> > Commit:   Add linux-next specific files for 20220125
> >> >           d25ee88530253138d0b20d43511ca5acbda4e9f7
> >> > Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
> >> >
> >> > Possible errors
> >> > ---------------
> >> >
> >> > arch/m68k/include/asm/bitops.h:329:20: error: array subscript 2 is above array bounds of 'long unsigned int[1]' [-Werror=array-bounds]
> >
> >The array-bounds warning has been enabled just recently. CC Kees Cook for this.
> >
> >> > cc1: all warnings being treated as errors
> >> > make[4]: *** [scripts/Makefile.build:289: drivers/net/ipa/ipa_mem.o] Error 1
> >> > make[3]: *** [scripts/Makefile.build:572: drivers/net/ipa] Error 2
> >> > make[2]: *** [scripts/Makefile.build:572: drivers/net] Error 2
> >> > make[1]: *** [Makefile:1965: drivers] Error 2
> >> > make: *** [Makefile:226: __sub-make] Error 2
> >> >
> >> > No warnings found in log.
> >>
> >> The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():
> >>
> >>         DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
> >>         ...
> >>         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
> >>                 if (ipa_mem_id_required(ipa, mem_id))
> >>                         dev_err(dev, "required memory region %u missing\n",
> >>                                 mem_id);
> >>         }
> >>
> >> This only happens with gcc-8, not with gcc-9, so it might be a
> >> compiler bug. I don't see anything wrong with c:ipa_mem_valid()
> >> nor with m68k's find_first_zero_bit().
> >
> >I don't see any problems about how this code uses bitmap API.
> >The m68k version of find_first_zero_bit() looks correct as well.
>
> The trouble is with "enum ipa_mem_id mem_id;" which is an int, and the bitmap API requires unsigned long. I tried to fix this[1] at the source, but the maintainers want each[2] call site to fix it instead. :(

Sorry, I don't get it. "mem_id" is not used as the bitmap, "regions" is,
and the latter has the correct type?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
