Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C3A49C997
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiAZM0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:26:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:41247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbiAZM0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:26:04 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MUog3-1mm3gZ2tZR-00Qkhw for <linux-kernel@vger.kernel.org>; Wed, 26 Jan
 2022 13:26:02 +0100
Received: by mail-oi1-f177.google.com with SMTP id s9so37082992oib.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:26:02 -0800 (PST)
X-Gm-Message-State: AOAM531HDGxplxCkRoKFd7uv0rC+1qJ0q4AipIiDLLTD7gox6dARMuiG
        N6IUf/fbKHHUXzBj0GbBldTSGtGWBVdmDO7u4YI=
X-Google-Smtp-Source: ABdhPJzjEjqhZoVQ+aruRja21IFaCnlBOb64TzKBhR5d9+tIFUiNbT7Go647+tOZs0+HEX4+aquiUBzLNiHHkx3x2jU=
X-Received: by 2002:a05:6808:2312:: with SMTP id bn18mr3658260oib.102.1643199961403;
 Wed, 26 Jan 2022 04:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
 <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com>
 <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org> <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
In-Reply-To: <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Jan 2022 13:25:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com>
Message-ID: <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AdT+uoNBMi5tsaCaWYyxyApQ0iDc4tFP0NTOTRXv0O4XCF3NbBj
 TWN76RMwlxCd3/9w8zXiW+Sydqxeh5IIvJyaqD2QJw8CzIqX5jf0aYEFAUdpWqGoHaqzEan
 6zunuAvVKwh2fWy6sSZJ/8zj/tSBQlDhoGoW/OjymkEnqMCHQcF4h/ZSbOP7W/3GJ845iL/
 U23hpj0sGeoQVJitJUfDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ux9Xv5K7uk8=:hUQjQZcC/McLASWnAbe04A
 sLX5t0Ib5tfjVWp19Fmd8a0Vzaa/zDMUvpnTOFhN2Y/RQnPr4Nlv8QQH1G9i9jXkZbZEmezer
 j70GR8sHt9oqLJGJmiQuFKlfBZRNqR/RMJF4mnZnXcMJ+wA6Ulh20DnOtdyXiEkjn8w4nKm3S
 w3abbwyk2uKpgg3iPR1S2sjy3dPY7g5kSG+PsqAeYdZ2MqTbQseqr5E7CNMFZ5XmHZcs/G2xR
 oengq8ABv0ddUsx6MA/SvuxUWqYgLym/CPYT6uf35vz3a+FwiJee3sUg/Bxuj90mhDaNfHl3q
 hRtspKXpn6NGVBr1GHaPZOW+Z7nTngIAiRPqSaqwkqozXG8CYTIoKQd+h7jbkm6+WDaAbJg3a
 0Q89mpz6cEmxvXj7kB9dM2hyI8GaburQe18oSG4ubhU8lUNMs0DxIIZsXVIUr6l4QkkfO3xSR
 PN6BVu49wyLCgtq9FWcqewq1pnJzpZB7PTXSUf5v24tzxmDeB0q4uEiegIRGnxC/8x0Jg6Cod
 Kik+FVRO1Rrp/kDlwRlXVo2H0IpZh2svrqKtrHOO8JVzbxpbqAlMu28+MvtyykQQL4HlKjFSC
 KrvXECcwVdJNZ8hxLl5QyfaP/JFvTvTJRJ5ow7gs+Jdm7v7zkfGrZCwYRzHzXa40FOElajvzS
 1FX2Mx/F6zyoVhKqIP0pNuAT5bgbsPCqC28YsaQxJQ0Fh998fieMh3amciXq1cJXYdUI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:16 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Jan 26, 2022 at 9:54 AM Kees Cook <keescook@chromium.org> wrote:
> > >>
> > >> The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():
> > >>
> > >>         DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
> > >>         ...
> > >>         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
> > >>                 if (ipa_mem_id_required(ipa, mem_id))
> > >>                         dev_err(dev, "required memory region %u missing\n",
> > >>                                 mem_id);
> > >>         }
> > >>
> > >> This only happens with gcc-8, not with gcc-9, so it might be a
> > >> compiler bug. I don't see anything wrong with c:ipa_mem_valid()
> > >> nor with m68k's find_first_zero_bit().
> > >
> > >I don't see any problems about how this code uses bitmap API.
> > >The m68k version of find_first_zero_bit() looks correct as well.
> >
> > The trouble is with "enum ipa_mem_id mem_id;" which is an int, and the bitmap API requires unsigned long. I tried to fix this[1] at the source, but the maintainers want each[2] call site to fix it instead. :(
>
> Sorry, I don't get it. "mem_id" is not used as the bitmap, "regions" is,
> and the latter has the correct type?

I think you are right here, and even if it was an array of 'unsigned
int' instead
of 'unsigned long', this should not change the size of the object on
a 32-bit architecture.

I ran the preprocessed code through cvise[1], bisecting for a reduced
test case that fails on gcc-8 but succeeds on gcc-9. The reduced
case is still fairly complex, and it appears to only happen in the
presence of an inline asm. Narrowing down the compiler versions shows
that anything after gcc-9.2 does not warn, but 9.1 and earlier versions do,
which is further indication that  it was probably a false-positive that got
fixed in gcc.

     Arnd

[1] https://github.com/marxin/cvise
[2] https://www.godbolt.org/z/xMr9v1nPT
