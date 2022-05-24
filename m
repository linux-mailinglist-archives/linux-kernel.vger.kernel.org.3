Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A105331CC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbiEXTfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiEXTft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:35:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4871A2F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso2042856wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKr04/qhAYfOWpJdZJZ4WTvOPBDiDY9sF4C4nLhfMw4=;
        b=cqHVg8BLvXqmdeBmnARBYAYfXtNzsso29jtj1oHdY/8hfdRlYGbrV02B9J05VUIjox
         JFY6mfn9cfdJLZnvlwN2qEPUujHS0EjoeXlBuOPA5oz4rEeK2jH+0HHo0IB+lABBOkd5
         OTg4BQiX8FIC9evnJX/AJJx6M+tOiAy4JAFsrnKvj4+XzaMBRdYuZVVPkAmNEiHO7tpc
         Nem3pIy6hGgHLY96LBsJtyRFAT4KLWu/15o/Dk6KiNjajpOoGOM4SerY2/7kh1Shr0OG
         lG9gTW+DeBEx/ojbtK2Y4dXc55QKzunB0NymQJELeusmiQ6wp1NTfGg/I3rbx7rlrkop
         D8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKr04/qhAYfOWpJdZJZ4WTvOPBDiDY9sF4C4nLhfMw4=;
        b=F+FRTpj/Pliv1Ve0gsp4lQ/QBCosuuPDv5M5mbJ1N/OSPCMzBkuGlkQyy4g0Kz/+b/
         oRn5pfZbRC7DaRLit7mxtp/EO7laVp6tgyIyU9FEHPQkXL3p5D/w6MHDb2+RMwLRmCbc
         YyoxGHPoRGtNep2t40Njs6J3tpBGwBBIjQ4DF2YqBNa5XmnZJ4hA1B1IolggzLrKNeBA
         Y/Zwjo1H3oY47P2AUSG37uqzPvbeMAbq0XbZF2Y+ODaptFZ1/aDa3paQujF3eouag1O1
         cfiw6y+eTx3eDWODlsdwFSYrE1We8I77atMFiadZPoZ5r/lWVuF4HENEw9K7YN0anbTz
         mpPw==
X-Gm-Message-State: AOAM5300kfIFxgRl6rVBkEDc5wxNH0i7DVlWmuh3+OFgjJ73pv9Q8ADM
        knOHY6TTG+GTlbVFQAXl2n6HGJrJ3xsRwnIAAx2BiVDzt+oprP/y
X-Google-Smtp-Source: ABdhPJyXb4oAl/2atE0GFounhj4cjoHRwHSSJPhY6CvL9hbQNpy2deAumDmRmGZ48Aze2Ts13/5pcUFyyBpY6nO8WDM=
X-Received: by 2002:a05:600c:48aa:b0:397:55ba:adb3 with SMTP id
 j42-20020a05600c48aa00b0039755baadb3mr5023648wmp.73.1653420944632; Tue, 24
 May 2022 12:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net> <20220524103423.GA13239@axis.com>
In-Reply-To: <20220524103423.GA13239@axis.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 24 May 2022 12:35:33 -0700
Message-ID: <CABVgOSnTX_e+tzR6c3KnGhDidVtEoUdtt_CJ62g2+MQDMp657g@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+dja in case he has any KASAN_VMALLOC thoughts.

On Tue, May 24, 2022 at 3:34 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Wed, Mar 11, 2020 at 11:44:37PM +0100, Johannes Berg wrote:
> > On Wed, 2020-03-11 at 15:32 -0700, Patricia Alfonso wrote:
> > > I'll need some time to investigate these all myself. Having just
> > > gotten my first module to run about an hour ago, any more information
> > > about how you got these errors would be helpful so I can try to
> > > reproduce them on my own.
> >
> > See the other emails, I was basically just loading random modules. In my
> > case cfg80211, mac80211, mac80211-hwsim - those are definitely available
> > without any (virtio) hardware requirements, so you could use them.
> >
> > Note that doing a bunch of vmalloc would likely result in similar
> > issues, since the module and vmalloc space is the same on UML.
>
> Old thread, but I had a look at this the other day and I think I got it
> working.  Since the entire shadow area is mapped at init, we don't need
> to do any mappings later.

Wow -- thanks for looking at this again. It's been on my to-do list
for quite a while, too. I'd somewhat resigned myself to having to
re-implement the shadow memory stuff on top of page allocation
functions, so I'm particularly thrilled to see this working without
needing to do that.

>
> It works both with and without KASAN_VMALLOC.  KASAN_STACK works too
> after I disabled sanitization of the stacktrace code.  All kasan kunit
> tests pass and the test_kasan.ko module works too.

I've got this running myself, and can confirm the kasan tests work
under kunit_tool in most cases, though there are a couple of failures
when built with clang/llvm:
[11:56:30] # kasan_global_oob_right: EXPECTATION FAILED at lib/test_kasan.c:732
[11:56:30] KASAN failure expected in "*(volatile char *)p", but none occurred
[11:56:30] not ok 32 - kasan_global_oob_right
[11:56:30] [FAILED] kasan_global_oob_right
[11:56:30] # kasan_global_oob_left: EXPECTATION FAILED at lib/test_kasan.c:746
[11:56:30] KASAN failure expected in "*(volatile char *)p", but none occurred
[11:56:30] not ok 33 - kasan_global_oob_left
[11:56:30] [FAILED] kasan_global_oob_left

The global_oob_left test doesn't work on gcc either (but fails on all
architectures, so is disabled), but kasan_global_oob_right should work
in theory.

>
> Delta patch against Patricia's is below.  The CONFIG_UML checks need to
> be replaced with something more appropriate (new config? __weak
> functions?) and the free functions should probably be hooked up to
> madvise(MADV_DONTNEED) so we discard unused pages in the shadow mapping.

I'd probably go with a new config here, rather than using __weak
functions. Either have a "shadow already allocated" config like the
CONFIG_KASAN_NO_SHADOW_ALLOC Johannes suggests, or something like
CONFIG_KASAN_HAS_ARCH_SHADOW_ALLOC, and call into an
architecture-specific "shadow allocator", which would just do the
__memset(). The latter would make adding the madvise(MADV_DONTNEED)
easier, I think, though it's more work in general. Ultimately a
question for the KASAN folks, though.

> Note that there's a KASAN stack-out-of-bounds splat on startup when just
> booting UML.  That looks like a real (17-year-old) bug, I've posted a
> fix for that:
>
>  https://lore.kernel.org/lkml/20220523140403.2361040-1-vincent.whitchurch@axis.com/
>

Wow, that's a good catch. And also explains a bit why I was so
confused trying to understand that code when we were originally
looking at this.

> 8<-----------
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index a1bd8c07ce14..5f3a4d25d57e 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -12,6 +12,7 @@ config UML
>         select ARCH_NO_PREEMPT
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_KASAN if X86_64
> +       select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_UID16
> @@ -223,7 +224,7 @@ config UML_TIME_TRAVEL_SUPPORT
>  config KASAN_SHADOW_OFFSET
>         hex
>         depends on KASAN
> -       default 0x7fff8000
> +       default 0x100000000000
>         help
>           This is the offset at which the ~2.25TB of shadow memory is
>           mapped and used by KASAN for memory debugging. This can be any
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 1c2d4b29a3d4..a089217e2f0e 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -27,6 +27,9 @@ obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
>  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
>
> +KASAN_SANITIZE_stacktrace.o := n
> +KASAN_SANITIZE_sysrq.o := n
> +
>  USER_OBJS := config.o
>
>  include arch/um/scripts/Makefile.rules
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 7c3196c297f7..a32cfce53efb 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -33,7 +33,7 @@ void kasan_init(void)
>  }
>
>  static void (*kasan_init_ptr)(void)
> -__section(.kasan_init) __used
> +__section(".kasan_init") __used
>  = kasan_init;
>  #endif
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 1113cf5fea25..1f3e620188a2 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -152,7 +152,7 @@ config KASAN_STACK
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
>         depends on KASAN_GENERIC || KASAN_SW_TAGS
>         depends on !ARCH_DISABLE_KASAN_INLINE
> -       default y if CC_IS_GCC && !UML
> +       default y if CC_IS_GCC
>         help
>           The LLVM stack address sanitizer has a know problem that
>           causes excessive stack usage in a lot of functions, see
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index a4f07de21771..d8c518bd0e7d 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -295,8 +295,14 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>                 return 0;
>
>         shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> -       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>         shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> +
> +       if (IS_ENABLED(CONFIG_UML)) {
> +               __memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> +               return 0;
> +       }
> +
> +       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>         shadow_end = ALIGN(shadow_end, PAGE_SIZE);

Is there a particular reason we're not doing the rounding under UML,
particularly since I think it's happening anyway in
kasan_release_vmalloc() below. (I get that it's not really necessary,
but is there an actual bug you've noticed with it?)

>
>         ret = apply_to_page_range(&init_mm, shadow_start,
> @@ -466,6 +472,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>
>         if (shadow_end > shadow_start) {
>                 size = shadow_end - shadow_start;
> +               if (IS_ENABLED(CONFIG_UML)) {
> +                       __memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> +                       return;
> +               }
>                 apply_to_existing_page_range(&init_mm,
>                                              (unsigned long)shadow_start,
>                                              size, kasan_depopulate_vmalloc_pte,
> @@ -531,6 +541,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>         if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
>                 return -EINVAL;
>
> +       if (IS_ENABLED(CONFIG_UML)) {
> +               __memset((void *)shadow_start, KASAN_SHADOW_INIT, shadow_size);
> +               return 0;
> +       }
> +
>         ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
>                         shadow_start + shadow_size,
>                         GFP_KERNEL,
> @@ -554,6 +569,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
>
>  void kasan_free_module_shadow(const struct vm_struct *vm)
>  {
> +       if (IS_ENABLED(CONFIG_UML))
> +               return;
> +
>         if (vm->flags & VM_KASAN)
>                 vfree(kasan_mem_to_shadow(vm->addr));
>  }

In any case, this looks pretty great to me. I still definitely want to
play with it a bit more, particularly with various module loads -- and
it'd be great to track down why those global_oob tests are failing --
but I'm definitely hopeful that we can finish this off and get it
upstream.

It's probably worth sending a new rebased/combined patch out which has
your fixes and applies more cleanly on recent kernels. (I've got a
working tree here, so I can do that if you'd prefer.)

Cheers,
-- David
