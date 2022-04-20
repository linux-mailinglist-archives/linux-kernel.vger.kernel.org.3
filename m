Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4712509260
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382689AbiDTVyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357179AbiDTVyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:54:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6EA403C5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:51:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so2134692wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rP5OWtrk4WktWLxKaOlM9djXhcx1PFOBsoG0vk8ejJ4=;
        b=IsIFYApUU0Ui4KekTPmRGr3ZeeQ6LFZW58iPNtRFHIdkWqkpazH/3PBI2H9j4xODGo
         yeto18wxSYb5ugdm7IdeP8jGmcSvKcDVJOTBELz870GpPOJ666CGkJPy9sLxDaTuktFY
         xCOfOimswxqF5K+eZrWyGXah1s826WKqxyZYZz3OTINFe6EXkkOT4pI9iY5ibMzZwYpx
         E6ZrPEYCqUQ1KA6ovQQ3fY4PezQSEm+xmse+M+WWD8f2I3WluGBCMLVOjcQSvf1t+81y
         T3d+QGfCtHfgvB9+vgeUCtciDXP1XcuJFvSPL4ojn+03j9LWdglXlCOIoD8C1frT0KiH
         j5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rP5OWtrk4WktWLxKaOlM9djXhcx1PFOBsoG0vk8ejJ4=;
        b=LJndifcc0lRum5+f891JN+Ntdyaum0iu/iSxfsuSucVgENybxuVH5TcfVUAk3CzPFU
         oYEGSLABuENWoChJlSYDVkGXSDIVZQZB3Aw3bl/HVqBWPxslyS0bGGg4Yh4CsibI17vd
         WaB5aNPvf12twcxIpxoG+UkcIfR+idJATNiRP3ebyA9c5mnVTNdNOBV3RfdIi7No/JLa
         XF9aL31/m0/31ZpvP4A3XioyKH/DSnh1qTNesa70x+hU/khKeHiT9wZG3CESVQWhCfzh
         UU0w5b1MiJQwqV6aVaDOOy42BX39C8I1pplSA4lTxkg4+GyXYR0ITs/wjW6jOSXFVRyP
         r0jg==
X-Gm-Message-State: AOAM5335Pevv8mEemsaVZrmXlbwmSbcIr2U6fnz5otRdwn2/QxGY6vqG
        JweKjsNlkhBWaHesvqEu6s25aE1UdV02oHx8C/Nqcw==
X-Google-Smtp-Source: ABdhPJwPjeINIU8CHmBNAe17pDAu6Ngpj5ab0xFuVeaOMxuTV2W3WzInKm3hX/Q/Wnmh0WyECF668faVm90Xu6UAEfc=
X-Received: by 2002:a05:600c:4f87:b0:392:9236:3c73 with SMTP id
 n7-20020a05600c4f8700b0039292363c73mr5637940wmq.158.1650491483628; Wed, 20
 Apr 2022 14:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-6-kaleshsingh@google.com> <87v8v6aek0.wl-maz@kernel.org>
 <CAC_TJvd=ubTMM+BRdELFokbxiKqaePAprG-pq3fR1vjKV9L6aA@mail.gmail.com>
In-Reply-To: <CAC_TJvd=ubTMM+BRdELFokbxiKqaePAprG-pq3fR1vjKV9L6aA@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 20 Apr 2022 14:51:12 -0700
Message-ID: <CAC_TJvcWkieK9XQeKi4-nB1ijUZs0csd3wAaWpRE9a375Zx=qw@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] KVM: arm64: Detect and handle hypervisor stack overflows
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrew Jones <drjones@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 7:41 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On Mon, Apr 18, 2022 at 3:09 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Fri, 08 Apr 2022 21:03:28 +0100,
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> > >
> > > The hypervisor stacks (for both nVHE Hyp mode and nVHE protected mode)
> > > are aligned such  that any valid stack address has PAGE_SHIFT bit as 1.
> > > This allows us to conveniently check for overflow in the exception entry
> > > without corrupting any GPRs. We won't recover from a stack overflow so
> > > panic the hypervisor.
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > Tested-by: Fuad Tabba <tabba@google.com>
> > > Reviewed-by: Fuad Tabba <tabba@google.com>
> > > ---
> > >
> > > Changes in v7:
> > >   - Add Fuad's Reviewed-by and Tested-by tags.
> > >
> > > Changes in v5:
> > >   - Valid stack addresses now have PAGE_SHIFT bit as 1 instead of 0
> > >
> > > Changes in v3:
> > >   - Remove test_sp_overflow macro, per Mark
> > >   - Add asmlinkage attribute for hyp_panic, hyp_panic_bad_stack, per Ard
> > >
> > >
> > >  arch/arm64/kvm/hyp/nvhe/host.S   | 24 ++++++++++++++++++++++++
> > >  arch/arm64/kvm/hyp/nvhe/switch.c |  7 ++++++-
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> > > index 3d613e721a75..be6d844279b1 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/host.S
> > > +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> > > @@ -153,6 +153,18 @@ SYM_FUNC_END(__host_hvc)
> > >
> > >  .macro invalid_host_el2_vect
> > >       .align 7
> > > +
> > > +     /*
> > > +      * Test whether the SP has overflowed, without corrupting a GPR.
> > > +      * nVHE hypervisor stacks are aligned so that the PAGE_SHIFT bit
> > > +      * of SP should always be 1.
> > > +      */
> > > +     add     sp, sp, x0                      // sp' = sp + x0
> > > +     sub     x0, sp, x0                      // x0' = sp' - x0 = (sp + x0) - x0 = sp
> > > +     tbz     x0, #PAGE_SHIFT, .L__hyp_sp_overflow\@
> > > +     sub     x0, sp, x0                      // x0'' = sp' - x0' = (sp + x0) - sp = x0
> > > +     sub     sp, sp, x0                      // sp'' = sp' - x0 = (sp + x0) - x0 = sp
> > > +
> > >       /* If a guest is loaded, panic out of it. */
> > >       stp     x0, x1, [sp, #-16]!
> > >       get_loaded_vcpu x0, x1
> > > @@ -165,6 +177,18 @@ SYM_FUNC_END(__host_hvc)
> > >        * been partially clobbered by __host_enter.
> > >        */
> > >       b       hyp_panic
> > > +
> > > +.L__hyp_sp_overflow\@:
> > > +     /*
> > > +      * Reset SP to the top of the stack, to allow handling the hyp_panic.
> > > +      * This corrupts the stack but is ok, since we won't be attempting
> > > +      * any unwinding here.
> > > +      */
> > > +     ldr_this_cpu    x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
> > > +     mov     sp, x0
> > > +
> > > +     bl      hyp_panic_bad_stack
> >
> > Why bl? You clearly don't expect to return here, given that you have
> > an ASM_BUG() right below, and that you are calling a __no_return
> > function. I think we should be consistent with the rest of the code
> > and just do a simple branch.
>
> The idea was to use bl  to give the hyp_panic_bad_stack() frame in the
> stack trace, which makes it easy to identify overflows. I can add a
> comment and drop the redundant ASM_BUG()

Sorry, my mistake here: bl will give us the current frame in the stack
trace (hyp_host_vector) so it doesn't affect hyp_panic_bad_stack (next
frame) being in the strace trace. Addressed in v8:
https://lore.kernel.org/r/20220420214317.3303360-6-kaleshsingh@google.com/

Thanks,
Kalesh

>
> Thanks,
> Kalesh
>
> >
> > It also gives us a chance to preserve an extra register from the
> > context.
> >
> > > +     ASM_BUG()
> > >  .endm
> > >
> > >  .macro invalid_host_el1_vect
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> > > index 6410d21d8695..703a5d3f611b 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > > @@ -347,7 +347,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
> > >       return exit_code;
> > >  }
> > >
> > > -void __noreturn hyp_panic(void)
> > > +asmlinkage void __noreturn hyp_panic(void)
> > >  {
> > >       u64 spsr = read_sysreg_el2(SYS_SPSR);
> > >       u64 elr = read_sysreg_el2(SYS_ELR);
> > > @@ -369,6 +369,11 @@ void __noreturn hyp_panic(void)
> > >       unreachable();
> > >  }
> > >
> > > +asmlinkage void __noreturn hyp_panic_bad_stack(void)
> > > +{
> > > +     hyp_panic();
> > > +}
> > > +
> > >  asmlinkage void kvm_unexpected_el2_exception(void)
> > >  {
> > >       return __kvm_unexpected_el2_exception();
> > > --
> > > 2.35.1.1178.g4f1659d476-goog
> > >
> > >
> >
> > Thanks,
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
