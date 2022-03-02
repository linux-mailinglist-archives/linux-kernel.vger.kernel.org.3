Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C94CA1D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbiCBKKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiCBKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:10:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEC0DFF5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:09:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j17so1953796wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i3lmfqgkK7OBdnfa+g16DQZSqexmJcfPngJ3iL8JFWQ=;
        b=bzryLYEMc/kLGuQY1ack35QrumDbfAAp12lRcHhGRZeRw3oO5F44yuF7vhUYLtpE0O
         kMy2DU9fhJxiBXZb82oORVE4N1hHhwyuyKYb2gReXiN7L82d0LxDZUQYFnaCX34zzNeh
         splWSun2E5ixCRR0zqN2xYH9MnCS5elMDFCez/Gby3yfYdCdv/8OmcBKUnuvzP0mKJAd
         5xcLDSScqB1vu+Orw8j8tZWytNnFEUqVUB80IpYZPPtQj6rOuZK+WtM8OgpJ3unXtfaL
         WLb7VnIBPAzjxu8re6JZuOfVlEd+mbEcFyPUWFsT5Wvbr+S2xl34QGDWEowrFdvoNNh1
         2XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i3lmfqgkK7OBdnfa+g16DQZSqexmJcfPngJ3iL8JFWQ=;
        b=0wiU4TucDdNn71aJ+29zWei3/X2fWgPKql6CVs4+Jics8e0QkonyEi25ahyjdalKom
         SLb2FicehNjSjsP4PO35ZVMUItWuc9TbIIGmVVrYF/JUO9UbYEtPd8ARh4PYMfSq1LJK
         h5D0OhVh6XWhNkETAR1foCVdG4bktVMKVTk13ODl24m4HivpDAMpxeA7SuNleWtg6mua
         ZU0vO518dyaTclas9FlCu2f82+bJslOkoF6ZWSPOEd3NQeRSzBlOxlqojX4T0deNmLkF
         an2IhBNlkyzuLYwwT6K9PopbLxJbVx9GruPJkHyRnu+7Zfxr3/MKp4k2h9mcqp0PSEcQ
         2XnQ==
X-Gm-Message-State: AOAM533AW42ofsFHfzw/YgfugL2trxDWhFMVS8yMJBe0iE1YHemOzjUM
        XZFjsLTt3hWr4Jl9++PZz5c=
X-Google-Smtp-Source: ABdhPJw7PGmLyGuK3YhzMCMHZQjy8g0xWTjRS30Z/UhRoTnIwz0j4WFk+41wk8fRnLT5sMDQhhToMg==
X-Received: by 2002:adf:b1da:0:b0:1f0:1205:89c1 with SMTP id r26-20020adfb1da000000b001f0120589c1mr5214930wra.27.1646215794139;
        Wed, 02 Mar 2022 02:09:54 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm5165034wmh.33.2022.03.02.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 02:09:53 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:09:49 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: boot flooded with unwind: Index not found
Message-ID: <Yh9CbcrfDvN2Z9Y9@Red>
References: <Yh5ASXVoWoMj7/Rr@Red>
 <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
 <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
 <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
 <Yh8tWdiWPgZLyQtx@Red>
 <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
 <Yh8w7ldudhmbYv4N@Red>
 <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 02, 2022 at 10:45:46AM +0100, Ard Biesheuvel a écrit :
> On Wed, 2 Mar 2022 at 09:55, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> >
> > Le Wed, Mar 02, 2022 at 09:44:52AM +0100, Ard Biesheuvel a écrit :
> > > On Wed, 2 Mar 2022 at 09:40, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> > > >
> > > > Le Tue, Mar 01, 2022 at 05:52:30PM +0100, Ard Biesheuvel a écrit :
> > > > > On Tue, 1 Mar 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, 1 Mar 2022 at 16:52, Russell King (Oracle)
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > >
> > > > > > > On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > > > > > > > Hello
> > > > > > > >
> > > > > > > > I booted today linux-next (20220301) and my boot is flooded with:
> > > > > > > > [    0.000000] unwind: Index not found c0f0c440
> > > > > > > > [    0.000000] unwind: Index not found 00000000
> > > > > > > > [    0.000000] unwind: Index not found c0f0c440
> > > > > > > > [    0.000000] unwind: Index not found 00000000
> > > > > > > >
> > > > > > > > This happen on a sun8i-a83t-bananapi-m3
> > > > > > >
> > > > > > > Have you enabled vmapped stacks?
> > > > > > >
> > > > > >
> > > > > > This is probably related to
> > > > > >
> > > > > > 538b9265c063 ARM: unwind: track location of LR value in stack frame
> > > > > >
> > > > > > which removes a kernel_text_address() check on frame->pc as it is
> > > > > > essentially redundant, given that we won't find unwind data otherwise.
> > > > > > Unfortunately, I failed to realise that the other check carries a
> > > > > > pr_warn(), which may apparently fire spuriously in some cases.
> > > > > >
> > > > > > The 0x0 value can easily be filtered out, but i would be interesting
> > > > > > where the other value originates from. We might be able to solve this
> > > > > > with a simple .nounwind directive in a asm routine somewhere.
> > > > > >
> > > > > > I'll prepare a patch that disregards the 0x0 value - could you check
> > > > > > in the mean time what the address 0xcf0c440 coincides with in your
> > > > > > build?
> > > > >
> > > > > Something like the below should restore the previous behavior, while
> > > > > taking the kernel_text_address() check out of the hot path.
> > > > >
> > > > > --- a/arch/arm/kernel/unwind.c
> > > > > +++ b/arch/arm/kernel/unwind.c
> > > > > @@ -400,7 +400,8 @@ int unwind_frame(struct stackframe *frame)
> > > > >
> > > > >         idx = unwind_find_idx(frame->pc);
> > > > >         if (!idx) {
> > > > > -               pr_warn("unwind: Index not found %08lx\n", frame->pc);
> > > > > +               if (frame->pc && kernel_text_address(frame->pc))
> > > > > +                       pr_warn("unwind: Index not found %08lx\n", frame->pc);
> > > > >                 return -URC_FAILURE;
> > > > >         }
> > > >
> > > > Hello
> > > >
> > > > This is a more detailed trace from my follow up after your patch:
> > >
> > > So the log below is from a kernel that has the above patch applied?
> > > Could you please share the .config?
> > >
> >
> > Yes this is a kernel with above patch applied (this board do not boot without it).
> 
> It's not entirely clear to me how (or whether) the recent changes to
> unwind.c cause this issue, but one thing that stands out in the
> current code is the unguarded dereference of a value pulled of the
> stack as a memory address.
> 
> It is worth noting that the only unwind entries in vmlinux that load
> SP from the stack directly (as opposed to unwinding it by moving from
> the frame pointer or by addition/subtraction) are the
> __irq_svc/__pabt_svc/__dabt_svc entry routines, and given that the
> bogus address 60000013 looks suspiciously like a PSR value (which is
> stored in the vicinity of SP on the exception stack), my suspicion is
> that some unwinder annotations are out of sync with the actual code.
> 
> So while the below does not fix the root cause, i.e., that the
> unwinder unwinds SP incorrectly causing us to dereference a bogus
> pointer, it should avoid the subsequent crash. Please give it a go.
> 
> --- a/arch/arm/kernel/unwind.c
> +++ b/arch/arm/kernel/unwind.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/uaccess.h>
>  #include <linux/list.h>
> 
>  #include <asm/sections.h>
> @@ -236,10 +237,11 @@ static int unwind_pop_register(struct
> unwind_ctrl_block *ctrl,
>                 if (*vsp >= (unsigned long *)ctrl->sp_high)
>                         return -URC_FAILURE;
> 
> -       /* Use READ_ONCE_NOCHECK here to avoid this memory access
> -        * from being tracked by KASAN.
> +       /* Use get_kernel_nofault() here to avoid this memory access
> +        * from causing a fatal fault, and from being tracked by KASAN.
>          */
> -       ctrl->vrs[reg] = READ_ONCE_NOCHECK(*(*vsp));
> +       if (get_kernel_nofault(ctrl->vrs[reg], *vsp))
> +               return -URC_FAILURE;
>         if (reg == 14)
>                 ctrl->lr_addr = *vsp;
>         (*vsp)++;

The crash disappeared (but the suspicious RCU usage is still here).
