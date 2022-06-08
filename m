Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76E542BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiFHJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiFHJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:43:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6691BE65B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:10:18 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b12so11030643ljq.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIdEQ9GgTo7L4hZfFiBTIR2/OA2rdyeN+UhLWoIfLWk=;
        b=TruMZg+IB+JTUrIHIFO0HG06n3TBPglCkVvdD3ylPaEWpqsj7kyc4nPRTdla//gwWR
         du5+HW2i/oGO3QtbkZZXF66GlzFTJ11q8dOmidi0t4TZH37RBqPzFG8MVgSgOG7Pu09h
         EdIVbDLaxFNw08qt1UchQ+GrwezMBMX9eNnHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIdEQ9GgTo7L4hZfFiBTIR2/OA2rdyeN+UhLWoIfLWk=;
        b=Yd2Lw21pzECaY1Cr3fmDM3+sdo7pxDdonm2EsuV4+bXeRpHcMQ8y4r7Xx/+M1/zXy9
         NcfH0rqOexst1yc5SCy8kiE6sR/xkk1zxaUUV9sUX+d2V7qan/H261vc4j2An2ph59zI
         SrpwriSxgAcOGDjGvu+3o6Tt36x2eD2ZRUbq1I88Pzym+NJgTs9uPogWK0xR++NDyngh
         uPekOPUU0hIqmztxEaQXWPkv3KiXrejR762FZuXuaFktyuLzu6zTrmz5h0eZevLx3bhj
         uFqeCTzm1rSayORKc4xJXppcVS57Ei+qw1b03kcZzjuN9mwiJJ/0fJPJOvQYPQgek4nJ
         1wTQ==
X-Gm-Message-State: AOAM531cHBoBZpcP7ECBCabZY5dOQMnn/PYlfrAP3i5QB8a2DYR5X8iG
        0irrHQBxlO0ghcUtr3bmNqVCbBvQ63EzGFypQQr+bQ==
X-Google-Smtp-Source: ABdhPJzICcDbbvZFlVJmVKakhAuq35deYSV2Gk3ld3ZpZGch17tuOF63nNdF++DqTL0LuoRnEJhvBEbY1hOdfzVNQH8=
X-Received: by 2002:a2e:b0ed:0:b0:255:a37b:8391 with SMTP id
 h13-20020a2eb0ed000000b00255a37b8391mr6059995ljl.214.1654679415961; Wed, 08
 Jun 2022 02:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
 <74fdda90-f015-5cb9-a2d2-137baf090c59@citrix.com> <20220608005956.hzvx3fapdmp25oun@treble>
In-Reply-To: <20220608005956.hzvx3fapdmp25oun@treble>
From:   Joe Damato <jdamato@fastly.com>
Date:   Wed, 8 Jun 2022 12:10:04 +0300
Message-ID: <CALALjgxsPMzK3TgkAjvc=fHseEzB7SYkZsCidFWkXZJMBra-6A@mail.gmail.com>
Subject: Re: 5.19-rc1 x86 build failure
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "bp@suse.de" <bp@suse.de>, "brgerst@gmail.com" <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:59:56PM -0700, Josh Poimboeuf wrote:
> On Tue, Jun 07, 2022 at 12:42:33PM +0000, Andrew Cooper wrote:
> > On 07/06/2022 13:19, Joe Damato wrote:
> > >   96                            .pushsection .brk_reservation,"aw",@nobits
> > >   97                            .brk.early_pgt_alloc:
> > >   98 ???? 00000000              .skip ((2 * 3) * ((1UL) << 12))
> > > ****  Error: missing ')'
> > > ****  Error: missing ')'
> > > ****  Error: missing ')'
> > > ****  Error: junk at end of line, first unrecognized character is `U'
> > >   98      0000
> > >  100                            .popsection
> > >
> > > This comes from arch/x86/mm/init.c, which has the following code:
> > >
> > > RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
> > >
> > > wherein INIT_PGT_BUF_SIZE (via PAGE_SIZE) has a "1UL" which makes the
> > > assembler unhappy.
> > >
> > > I don't really know what the correct way to fix this is; it seems that the
> > > macro _AC should handle this if ASSEMBLY is defined, IIUC, but that does
> > > not seem to be the case at this point in init.c.
> > >
> > > Perhaps I am doing something incorrect during the build process causing
> > > this to happen?
> >
> > The problem is that _AC() is evaluated in C context (so gains the UL/ULL
> > suffix), and the C'd string is fed directly into the assembler (where
> > older binutils doesn't tolerate the suffix).
> >
> > Short of having a _PAGE_SIZE which is an explicitly non-AC()'d constant,
> > I'm not sure what to suggest.  Ideally, you'd want to temporarily define
> > __ASSEMBLY__ around the expansion of __stringify(), but I don't think
> > that's possible as RESERVE_BRK() is a macro itself.
>
> Joe, what version of binutils do you have?

I am using binutils: 2.26.1-1ubuntu1~16.04.8+esm4.

> We can fix this by taking a completely different approach: define the
> variable in C and just do the "nobits" in the linker script, like below.
> I can work up a proper patch tomorrow.

The change below makes sense to me. I applied it locally and was able to
build the kernel again.

Let me know if you'd like me to try building the next patch you write up.
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index 7590ac2570b9..4704184a2d78 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -108,19 +108,11 @@ extern unsigned long _brk_end;
>  void *extend_brk(size_t size, size_t align);
>
>  /*
> - * Reserve space in the brk section.  The name must be unique within the file,
> + * Reserve space in the .brk section.  The name must be unique within vmlinux,
>   * and somewhat descriptive.  The size is in bytes.
> - *
> - * The allocation is done using inline asm (rather than using a section
> - * attribute on a normal variable) in order to allow the use of @nobits, so
> - * that it doesn't take up any space in the vmlinux file.
>   */
>  #define RESERVE_BRK(name, size)                                              \
> -     asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"          \
> -         ".brk." #name ":\n\t"                                       \
> -         ".skip " __stringify(size) "\n\t"                           \
> -         ".size .brk." #name ", " __stringify(size) "\n\t"           \
> -         ".popsection\n\t")
> +     char __brk_##name[size] __section(".brk_reservation");
>
>  extern void probe_roms(void);
>  #ifdef __i386__
> @@ -133,12 +125,16 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
>
>  #endif /* __i386__ */
>  #endif /* _SETUP */
> -#else
> -#define RESERVE_BRK(name,sz)                         \
> -     .pushsection .brk_reservation,"aw",@nobits;     \
> -.brk.name:                                           \
> -1:   .skip sz;                                       \
> -     .size .brk.name,.-1b;                           \
> +
> +#else  /* __ASSEMBLY */
> +
> +#define RESERVE_BRK(name, size)                              \
> +     .pushsection .brk_reservation, "aw";            \
> +__brk_##name:                                                \
> +1:   .skip size;                                     \
> +     .size __brk_##name, . - 1b;                     \
>       .popsection
> +
>  #endif /* __ASSEMBLY__ */
> +
>  #endif /* _ASM_X86_SETUP_H */
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 91831b9d8aa8..f105b8aa055e 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -392,7 +392,7 @@ SECTIONS
>       __end_of_kernel_reserve = .;
>
>       . = ALIGN(PAGE_SIZE);
> -     .brk : AT(ADDR(.brk) - LOAD_OFFSET) {
> +     .brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
>               __brk_base = .;
>               . += 64 * 1024;         /* 64k alignment slop space */
>               *(.brk_reservation)     /* areas brk users have reserved */
