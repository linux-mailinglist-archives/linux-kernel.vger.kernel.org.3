Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B288C4B0927
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiBJJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:08:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiBJJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:08:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C60C38
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:08:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i6so7212371pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piScQxlxRdoRBmtbVJxqHKS4101vt9jal70V/sVv6CE=;
        b=j6+cxBJ5l5i2Pz3zXTe0q51kyHeBtuHJ22oVGtMOKRBM3P1XBL29sZCo1W9r0UZiw/
         kDn8/X78HiAmNkdJn1GHsIg60r8e+sz7nWIX1iDH4ClYzuTk9o6UnglWg9ss//+9d6Pu
         3R7CqSvk4M6YGFYN/SFjsh9T6+P9+p6I4UrYOFCpWqYiOzMKXMKcMi9VZeDr5N4b6md+
         1KM+OLRLb/3MVcBxI4bwh09W6zxE/UnPGxI7tazVXU51Th9zk9tCERbW4T5kX6Fo1N7f
         5j1er1F4nIoLVh9QHQ8a1ev4ukDR4z2VU8FwuBjWvWNqKZuVAcj9A0gCdSkjDttin9vU
         A2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piScQxlxRdoRBmtbVJxqHKS4101vt9jal70V/sVv6CE=;
        b=C3UR0DBSuoFyyXtK9t05WVwlBJI5i7kY+Dn/ggO53lPW907iYmEeSFW3Yd/SixB01f
         9ZzkdV+BSB0vBTa7xV+vqLerheTA0LRsCltdz62S3JQk1A5HVKfDd9HQVDEkfP+pVhMw
         HuyvbwUefUPgtfY89k12xr2jIKkpWxqfRi3zm1uj+Par068wkzLU2JWQ7F9GoTfDcfE4
         fLj+tXx6vrBE7dNs2Cg46zfrf4TTDLf0IdU777rva2GwDcc5chN8+890TtA8mteAgcuN
         Pf90eSbBUP4XlSDqYH6bjr/WidT3zq/5R2mqNjLxoUava9eIYM4254NazhePdSc6tRnm
         iOxQ==
X-Gm-Message-State: AOAM532fy226WlmXJiN/hCuzUQC0EEQ5O/kHXCLfMF8KlKEuUKAZ41J4
        rkhRl/kS5iNP+nqzWkMRcItPOabL87Y6uf3CU8A=
X-Google-Smtp-Source: ABdhPJzrd8MGws6n2JUZyAaOLmq5x4+vBMaws1lv+oTfs9w5MCA1ZJTVqR9j/Lb9+WhWsStFxN8qi/ddpcksFuiZmNU=
X-Received: by 2002:a62:b40e:: with SMTP id h14mr6448020pfn.79.1644484116439;
 Thu, 10 Feb 2022 01:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20211101044955.2295495-1-goldstein.w.n@gmail.com>
 <20211117210245.843374-1-goldstein.w.n@gmail.com> <bc0297a1b97a4b129fa3ea1b155f6062@AcuMS.aculab.com>
 <CAFUsyfJTuFjVXHMgYi0uggVNW=1WW1uVYa7avVjW5VBb2cmAkQ@mail.gmail.com>
 <e41913010e61429bbd2980a5c5ccfb39@AcuMS.aculab.com> <CAFUsyfLUQLj5py1AQ+4NptM6htWxV5i0qxkeXDUdFPfAnqRY2w@mail.gmail.com>
 <CAFUsyfKrGhTHoC+MXiA3zFY-dT0wqPRxoJwMY=+uPbj0p0dDAg@mail.gmail.com> <CAFUsyfJQq5n12L-fCsagk5LOqLYXL+3BAORHDCXY-Ud1t2CVDg@mail.gmail.com>
In-Reply-To: <CAFUsyfJQq5n12L-fCsagk5LOqLYXL+3BAORHDCXY-Ud1t2CVDg@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 10 Feb 2022 03:08:25 -0600
Message-ID: <CAFUsyf+4vgZsM9gdyN1=eP_MzDsuOXOdKitS=1Rj-jBpdFGg9Q@mail.gmail.com>
Subject: Re: [PATCH v4] arch/x86: Improve 'rep movs{b|q}' usage in memmove_64.S
To:     David Laight <David.Laight@aculab.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:13 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Fri, Dec 10, 2021 at 12:35 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Fri, Nov 19, 2021 at 6:05 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> > > On Fri, Nov 19, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > > >
> > > > From: Noah Goldstein
> > > > > Sent: 17 November 2021 22:45
> > > > >
> > > > > On Wed, Nov 17, 2021 at 4:31 PM David Laight <David.Laight@aculab.com> wrote:
> > > > > >
> > > > > > From: Noah Goldstein
> > > > > > > Sent: 17 November 2021 21:03
> > > > > > >
> > > > > > > Add check for "short distance movsb" for forwards FSRM usage and
> > > > > > > entirely remove backwards 'rep movsq'. Both of these usages hit "slow
> > > > > > > modes" that are an order of magnitude slower than usual.
> > > > > > >
> > > > > > > 'rep movsb' has some noticeable VERY slow modes that the current
> > > > > > > implementation is either 1) not checking for or 2) intentionally
> > > > > > > using.
> > > > > >
> > > > > > How does this relate to the decision that glibc made a few years
> > > > > > ago to use backwards 'rep movs' for non-overlapping copies?
> > > > >
> > > > > GLIBC doesn't use backwards `rep movs`.  Since the regions are
> > > > > non-overlapping it just uses forward copy. Backwards `rep movs` is
> > > > > from setting the direction flag (`std`) and is a very slow byte
> > > > > copy. For overlapping regions where backwards copy is necessary GLIBC
> > > > > uses 4x vec copy loop.
> > > >
> > > > Try to find this commit 6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
> > > >
> > > > Or follow links from https://www.win.tue.nl/~aeb/linux/misc/gcc-semibug.html
> > > > But I can't find the actual patch.
> > > >
> > > > The claims were a massive performance increase for the reverse copy.
> > > >
> > >
> > > I don't think that's referring to optimizations around `rep movs`. It
> > > appears to be referring to fallout from this patch:
> > > https://sourceware.org/git/?p=glibc.git;a=commit;h=6fb8cbcb58a29fff73eb2101b34caa19a7f88eba
> > >
> > > which broken programs misusing `memcpy` with overlapping regions
> > > resulting in this fix:
> > > https://sourceware.org/git/?p=glibc.git;a=commit;h=0354e355014b7bfda32622e0255399d859862fcd
> > >
> > > AFAICT support for ERMS was only added around:
> > > https://sourceware.org/git/?p=glibc.git;a=commit;h=13efa86ece61bf84daca50cab30db1b0902fe2db
> > >
> > > Either way GLIBC memcpy/memmove moment most certainly does not
> > > use backwards `rep movs`:
> > > https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S;hb=HEAD#l655
> > >
> > > as it is very slow.
> > >
> > > > The pdf from www.agner.org/optimize may well indicate why some
> > > > copies are unexpectedly slow due to cache access aliasing.
> > >
> > > Even in the `4k` aliasing case `rep movsb` seems to stay within a
> > > factor of 2 of optimal whereas the `std` backwards `rep movs` loses
> > > by a factor of 10.
> > >
> > > Either way, `4k` aliasing detection is mostly a concern of `memcpy` as
> > > the direction of copy for `memmove` is a correctness question, not
> > > an optimization.
> > >
> > >
> > > >
> > > > I'm pretty sure that Intel cpu (possibly from Ivy bridge onwards)
> > > > can be persuaded to copy 8 bytes/clock for in-cache data with
> > > > a fairly simple loop that contains 2 reads (maybe misaligned)
> > > > and two writes (so 16 bytes per iteration).
> > > > Extra unrolling just adds extra code top and bottom.
> > > >
> > > > You might want a loop like:
> > > >         1:      mov     0(%rsi, %rcx),%rax
> > > >                 mov     8(%rsi, %rcx),%rdx
> > > >                 mov     %rax, 0(%rdi, %rcx)
> > > >                 mov     %rdx, 8(%rdi, %rcx)
> > > >                 add     $16, %rcx
> > > >                 jnz     1b
> > > >
> > > >         David
> > >
> > > The backwards loop already has 4x unrolled `movq` loop.
> > ping.
> ping.
ping3.
> > >
> > > >
> > > > -
> > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > > Registration No: 1397386 (Wales)
