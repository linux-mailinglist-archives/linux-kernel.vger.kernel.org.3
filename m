Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87149B456
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457189AbiAYMwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:52:11 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457385AbiAYMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:49:35 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MtwpW-1mI3FO2fTo-00uLwo for <linux-kernel@vger.kernel.org>; Tue, 25 Jan
 2022 13:49:30 +0100
Received: by mail-wr1-f53.google.com with SMTP id s9so3860567wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:49:30 -0800 (PST)
X-Gm-Message-State: AOAM531TflCP6C7cIzf90W5AED9VnxkxFkb1Caknn9GKGWLzBwNpFg6h
        OW3tHIklZ201JMLukrPtPeLp4TuK5k+VwCphvwY=
X-Google-Smtp-Source: ABdhPJwQyRjnqkte/w6LuEz/PgKqyset8mRi8LGcNH/Fw+cF+Zcm5LVpOY8735bx7VtBAM3uI0s1L5n7mEaAKrvHJTw=
X-Received: by 2002:adf:fd05:: with SMTP id e5mr18127892wrr.192.1643114970282;
 Tue, 25 Jan 2022 04:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
In-Reply-To: <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Jan 2022 13:49:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Qik6A9ts0J_oXP-LMbqA0-kvZ4E9=bgLx5spxvLuC8w@mail.gmail.com>
Message-ID: <CAK8P3a2Qik6A9ts0J_oXP-LMbqA0-kvZ4E9=bgLx5spxvLuC8w@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TanfwuwFqZNfooVyZgHD3+rUPD3f1cJdCK5zG84TDZo31iIv5YG
 GXRVzIA19kzuQ/qkVFgnWBNIl/wxczrAaB46TSjL1q43y69CYK8CIt/5RsDTAPghffi3XRT
 kOc0/ofpbVemuYoW2IHdttLjGnnQQ8ifpX9iRQrzRUm88+44FNqOJ0KuBvgfOGpn3gaIeGP
 J2qtGQmD8O/lHZnoRFnBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oPQ+h+sOS+Q=:NII+iD2HrntS2r/VzhmExq
 wordjS5knJYuG8+7yR0zkTaqLSvZJL8/GNi5+zY3zMtzu4zh9abBk5VVYvIoBeQrCuWIi7Vmh
 9Xa2n9whgrJZ9iM71tj1ewnzDJ5acoMwja/e3po3Lh5P30KNXPAGGMHW6pL1JwLdgjt9Lps0x
 ZGTKtivRJDDYxHdzSGTymm0WUtiFmorwLQYrKNnh/6LR065phMXQ64boGFN9/ZTWC1oc0m6IT
 G2rhLtwaXn1YIZa/BkgYWkSCgibJYbR6VFutq+JdSEhkU5dQoy459FcO5cEIcswOxtPE12pYS
 v7+paa2ReI0gAblR1jXDu644DDJhmLALDiC4IYkMH3TsIp5m1XUhRhuneal2yHZkKsnA/tUzz
 YTXxctXgERmJNDkZo9xsbwKubRBR2m9vYXsBpiznegh0E9b4E4O5Wv9M2tmxUOQ+v+0CL32tF
 K91WAtE4yS4omyg3B+xzXdmBaEtZnpFZPi/omEdW9XMz0ne+TsgusIGYKn0Aeil1Z1BbDwKvr
 f6RSYzw8uriFlRbFocf2b2H1iIphNXs2BBlIhF/8EZ1vlFoBs/blaevcwKo/4m37WQGFfxuww
 4yKz8YL5I0SLxltqffa8hKwfYfMBSYZG/S6OPpKAgWXoMO7jWfbQOcP7PYsAgbdmiP7wak3lx
 PJtsQvsfUPdAWqFhYhMI5YUBEyCNIVMik2lLabgm/+SZLJpBxdqGg+/yTwKUjtu3JFUQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Jan 25, 2022 at 8:31 AM <noreply@ellerman.id.au> wrote:
> > FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/14688953/
> >
> > Commit:   Add linux-next specific files for 20220125
> >           d25ee88530253138d0b20d43511ca5acbda4e9f7
> > Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
> >
> > Possible errors
> > ---------------
> >
> > arch/m68k/include/asm/bitops.h:329:20: error: array subscript 2 is above array bounds of 'long unsigned int[1]' [-Werror=array-bounds]
> > cc1: all warnings being treated as errors
> > make[4]: *** [scripts/Makefile.build:289: drivers/net/ipa/ipa_mem.o] Error 1
> > make[3]: *** [scripts/Makefile.build:572: drivers/net/ipa] Error 2
> > make[2]: *** [scripts/Makefile.build:572: drivers/net] Error 2
> > make[1]: *** [Makefile:1965: drivers] Error 2
> > make: *** [Makefile:226: __sub-make] Error 2
> >
> > No warnings found in log.
>
> The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():
>
>         DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
>         ...
>         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
>                 if (ipa_mem_id_required(ipa, mem_id))
>                         dev_err(dev, "required memory region %u missing\n",
>                                 mem_id);
>         }
>
> This only happens with gcc-8, not with gcc-9, so it might be a
> compiler bug. I don't see anything wrong with c:ipa_mem_valid()
> nor with m68k's find_first_zero_bit().

I've seen problems with warnings like this when gcc only partially
inlines one of the functions. Does it go away if you mark find_next_bit()
and find_first_bit() as __always_inline?

       Arnd
