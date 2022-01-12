Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6CD48BD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbiALDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiALDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:13:20 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730BCC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 19:13:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso9097667pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 19:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lMp0AuFrBq5xGQqZoI/ZrkPZbEyEn6AhnpJj2DbBjCM=;
        b=GQniuv9oc4KtjDonXPrUSbIKvv8NMf6WFS+VcKz2WAHgB/6RVHUWXVi6xg3Pw0RKHG
         Ebf0a+QqcsTsaVOh5dS0Ng8DlsuExFsuSwwJBmyvSauGJIJYEe3F4NT7X/1F3bMil+zN
         oQ6gBd1TrsRImoaakAuT6fRCs5nIYw6rRMiPuwMlYUR8jFlopraQLao2KLe2v+rs7mL7
         Y4PEoiEHc/a5z35DRD5+gTCu62w2SPOKwLamxV+evNp9Hr/qMCDPIHH2LJ10mgX34DMP
         Se87/iO01J8LrDJNoIx6ZqXa8Dmwb2jeJrCxymHya3Pe40JG5VVpi7yWWWjbXGyG5wL5
         EtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lMp0AuFrBq5xGQqZoI/ZrkPZbEyEn6AhnpJj2DbBjCM=;
        b=KYqJZNP9bGotm9FgWFVYEy0lAmSgXhMzkxonMhlm2MnGzA2/efSiPF9GXFHgpac8oh
         QvkaTRH0Fmf/Vc7D+XwgYyGwe2CQ+TmYMENRYmu4bgk0rbHn0FKd0CdcJhfDwNuGV5+h
         NLL0NlFF3+yKBbw9G0Xtw2o6xAioPrW7xcQtHKiDqQcp18tvE/I6ub5jr6D/4VeASGG+
         Ay/HfxYbi65QWGsXMOj0ZSpj/pz3pJbD0ZPBO9iNAnInyooCcDfbqjim77SZEE9ZHF7Z
         +eYob9bD1M51JBu7rFOE7WF8QqfrIkQUQs+TpXpvx4LYL1WczZqc6zZaJFvS2Z4prs31
         n76w==
X-Gm-Message-State: AOAM532zBVCAr6sWVy3juHwaROnR1d7bKwJSytwd9wFNZoOrbrbfZtnv
        Hme7EWHLEF7Zl61SWZFoASaCm81HRPdPDFkIJpo=
X-Google-Smtp-Source: ABdhPJxBHaM2ADWHiLcbn0AwuEkmmSyxSY4gA361sgkVgEqpE9S7UIZMvYwAfeKyIriTNj+5T7szv6BdAgT6a183YRU=
X-Received: by 2002:a63:7f55:: with SMTP id p21mr5736397pgn.338.1641957199936;
 Tue, 11 Jan 2022 19:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com> <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
 <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com>
 <e41913010e61429bbd2980a5c5ccfb39@AcuMS.aculab.com> <CAFUsyfLUQLj5py1AQ+4NptM6htWxV5i0qxkeXDUdFPfAnqRY2w@mail.gmail.com>
 <CAFUsyfKrGhTHoC+MXiA3zFY-dT0wqPRxoJwMY=+uPbj0p0dDAg@mail.gmail.com>
In-Reply-To: <CAFUsyfKrGhTHoC+MXiA3zFY-dT0wqPRxoJwMY=+uPbj0p0dDAg@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Tue, 11 Jan 2022 21:13:09 -0600
Message-ID: <CAFUsyfJQq5n12L-fCsagk5LOqLYXL+3BAORHDCXY-Ud1t2CVDg@mail.gmail.com>
Subject: Re: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
To:     David Laight <David.Laight@aculab.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:35 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Fri, Nov 19, 2021 at 6:05 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Fri, Nov 19, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Noah Goldstein
> > > > Sent: 17 November 2021 22:45
> > > >
> > > > On Wed, Nov 17, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > > > >
> > > > > From: Noah Goldstein
> > > > > > Sent: 17 November 2021 21:03
> > > > > >
> > > > > > Add check for "short distance movsb" for forwards FSRM usage and
> > > > > > entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> > > > > > modes" that are an order of magnitude slower than usual.
> > > > > >
> > > > > > 'rep movsb' has some noticeable VERY slow modes that the current
> > > > > > implementation is either 1) not checking for or 2) intentionally
> > > > > > using.
> > > > >
> > > > > How does this relate to the decision that glibc made a few years
> > > > > ago to use backwards 'rep movs' for non-overlapping copies?
> > > >
> > > > GLIBC doesn't use backwards `rep movs`.  Since the regions are
> > > > non-overlapping it just uses forward copy. Backwards `rep movs` is
> > > > from setting the direction flag (`std`) and is a very slow byte
> > > > copy. For overlapping regions where backwards copy is necessary GLIBC
> > > > uses 4x vec copy loop.
> > >
> > > Try to find this commit 6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
> > >
> > > Or follow links from https://www.win.tue.nl/~aeb/linux/misc/gcc-semibug.html
> > > But I can't find the actual patch.
> > >
> > > The claims were a massive performance increase for the reverse copy.
> > >
> >
> > I don't think that's referring to optimizations around `rep movs`. It
> > appears to be referring to fallout from this patch:
> > https://sourceware.org/git/?p=glibc.git;a=commit;h=6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
> >
> > which broken programs misusing `memcpy` with overlapping regions
> > resulting in this fix:
> > https://sourceware.org/git/?p=glibc.git;a=commit;h=0354e355014b7bfda32622e0255399d859862fcd
> >
> > AFAICT support for ERMS was only added around:
> > https://sourceware.org/git/?p=glibc.git;a=commit;h=13efa86ece61bf84daca50cab30db1b0902fe2db
> >
> > Either way GLIBC memcpy/memmove moment most certainly does not
> > use backwards `rep movs`:
> > https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S;hb=HEAD#l655
> >
> > as it is very slow.
> >
> > > The pdf from www.agner.org/optimize may well indicate why some
> > > copies are unexpectedly slow due to cache access aliasing.
> >
> > Even in the `4k` aliasing case `rep movsb` seems to stay within a
> > factor of 2 of optimal whereas the `std` backwards `rep movs` loses
> > by a factor of 10.
> >
> > Either way, `4k` aliasing detection is mostly a concern of `memcpy` as
> > the direction of copy for `memmove` is a correctness question, not
> > an optimization.
> >
> >
> > >
> > > I'm pretty sure that Intel cpu (possibly from Ivy bridge onwards)
> > > can be persuaded to copy 8 bytes/clock for in-cache data with
> > > a fairly simple loop that contains 2 reads (maybe misaligned)
> > > and two writes (so 16 bytes per iteration).
> > > Extra unrolling just adds extra code top and bottom.
> > >
> > > You might want a loop like:
> > >         1:      mov     0(%rsi, %rcx),%rax
> > >                 mov     8(%rsi, %rcx),%rdx
> > >                 mov     %rax, 0(%rdi, %rcx)
> > >                 mov     %rdx, 8(%rdi, %rcx)
> > >                 add     $16, %rcx
> > >                 jnz     1b
> > >
> > >         David
> >
> > The backwards loop already has 4x unrolled `movq` loop.
> ping.
ping.
> >
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
