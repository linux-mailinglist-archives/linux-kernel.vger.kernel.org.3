Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1B49C9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbiAZMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:37:59 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:35772 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbiAZMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:37:58 -0500
Received: by mail-vk1-f180.google.com with SMTP id o15so4205956vki.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmp3oORs5i5H5AZl878+yd1UI/WaXT8+i4zt2rlWV8s=;
        b=rJYCOHBT1HupNO1FzYRUK2MgMT5cQzeLGnWLoDTM/Y9Rmc6MquC5Nf1qbozyzcJ5hT
         usFD34eNsxH574W92pdGYAVbn+qTX2sYQl7qu/zLljR3LynyaEuzMPykzqaWqOyPXsjW
         EQluYm9FSz+GvtymotEy42bxiILZJFrYrWXHOuG0/QT+c2jpe62+rDKacoC5a1CPT+yL
         OARRnH9Nx+qe8g57q9W7cnfaz9gda1ALxAIhFt6/BC3Cp90kXjQf342U4ZZff7qxgFt3
         zfkd9NxxJkNZhZNW3IS59aS2VyuTgYqNMQBRCR+Itojj8uXGV0o/k3MSo2QlmyW5Zbmo
         b+WA==
X-Gm-Message-State: AOAM533eo/0dHr7biF0+zVafuM/DV1MxnvvAHqhLvRr/hYAxQ6ujVluT
        0Zc+ea2E4AIQwV2HnvbiLmyzh2t7L+zc4Z94
X-Google-Smtp-Source: ABdhPJykIaH2+dn4uGR3Ojk9CdxryC4wqJZMEBp9ka5u8yVXeuYcZX+Uv2j8wCiNN/HA/RB9AEd3cA==
X-Received: by 2002:a67:f5ca:: with SMTP id t10mr5111424vso.80.1643200677421;
        Wed, 26 Jan 2022 04:37:57 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id x20sm2904196vsr.17.2022.01.26.04.37.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 04:37:57 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id w5so14318286vke.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:37:57 -0800 (PST)
X-Received: by 2002:a67:b009:: with SMTP id z9mr6116538vse.57.1643200676905;
 Wed, 26 Jan 2022 04:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20220125073137.1.83124@7e6451f583e7> <CAMuHMdVYhwpP0vSK4LT+50ZqB9opD8gcm-2aor8wAc49=GR+-w@mail.gmail.com>
 <CAAH8bW93TUpyn8GaZfB83pu8Kvrsz9PHPCBHcG3+UStU7v=s=A@mail.gmail.com>
 <31219CC3-CEE4-4CFA-A416-B98F2115A527@chromium.org> <CAMuHMdUwd=2KGk9JkZPSZsvAWG4wddxZFxd5bFfbrtZi3JynQA@mail.gmail.com>
 <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com>
In-Reply-To: <CAK8P3a0bLTWc-UG4eX14CQ=hiXms+wHx2VvaovXA-ZUQYAA1fA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 13:37:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVA5M3J5dxWWVQV+GPLQU9xU=qFm6fO6NXXS+thYYqnKQ@mail.gmail.com>
Message-ID: <CAMuHMdVA5M3J5dxWWVQV+GPLQU9xU=qFm6fO6NXXS+thYYqnKQ@mail.gmail.com>
Subject: Re: kisskb: FAILED linux-next/m68k-allmodconfig/m68k-gcc8 Tue Jan 25, 18:24
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Jan 26, 2022 at 1:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Jan 26, 2022 at 10:16 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Jan 26, 2022 at 9:54 AM Kees Cook <keescook@chromium.org> wrote:
> > > >>
> > > >> The code that causes this is drivers/net/ipa/ipa_mem.c:ipa_mem_valid():
> > > >>
> > > >>         DECLARE_BITMAP(regions, IPA_MEM_COUNT) = { };
> > > >>         ...
> > > >>         for_each_clear_bit(mem_id, regions, IPA_MEM_COUNT) {
> > > >>                 if (ipa_mem_id_required(ipa, mem_id))
> > > >>                         dev_err(dev, "required memory region %u missing\n",
> > > >>                                 mem_id);
> > > >>         }
> > > >>
> > > >> This only happens with gcc-8, not with gcc-9, so it might be a
> > > >> compiler bug. I don't see anything wrong with c:ipa_mem_valid()
> > > >> nor with m68k's find_first_zero_bit().
> > > >
> > > >I don't see any problems about how this code uses bitmap API.
> > > >The m68k version of find_first_zero_bit() looks correct as well.
> > >
> > > The trouble is with "enum ipa_mem_id mem_id;" which is an int, and the bitmap API requires unsigned long. I tried to fix this[1] at the source, but the maintainers want each[2] call site to fix it instead. :(
> >
> > Sorry, I don't get it. "mem_id" is not used as the bitmap, "regions" is,
> > and the latter has the correct type?
>
> I think you are right here, and even if it was an array of 'unsigned
> int' instead
> of 'unsigned long', this should not change the size of the object on
> a 32-bit architecture.

Indeed, size matters not here.

> I ran the preprocessed code through cvise[1], bisecting for a reduced
> test case that fails on gcc-8 but succeeds on gcc-9. The reduced
> case is still fairly complex, and it appears to only happen in the
> presence of an inline asm. Narrowing down the compiler versions shows
> that anything after gcc-9.2 does not warn, but 9.1 and earlier versions do,
> which is further indication that  it was probably a false-positive that got
> fixed in gcc.

Thanks for investigating! So let's ignore this.

FTR, my gcc-9 is 9.4.0, i.e. >= 9.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
