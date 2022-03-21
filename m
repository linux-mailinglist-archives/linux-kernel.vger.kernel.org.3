Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175204E2F67
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348830AbiCURxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351031AbiCURxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:53:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A52C6C91E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:51:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g24so19736077lja.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7hXKhWGjeEcs+khpwcGCmvFoDcx/GKGrlZ2jh0BxlI=;
        b=sk+tKRXHM2IngLuoMXbMO5D38y7nm/248UDBbwtMyxArJUXf+mlKvqiFHiVt4ZTDXS
         XseMc+bCUW1A4/PpVfEcGmTob9SjNAEG+Siy2anofSZJzgzDGcjIR1eOTW61J8MVQdql
         W+cVKOunhCc1qG2s8VO6JSV3wu7/jCaA2KhKuRKhMDKMZTDOFHPztOvsllMG1YS4RtDX
         Vl/LjZSEv89CmBiXKrslGApiy0qrp/WlsN4dI0HE3WDhO1K+4b+Ok7uid7Hiw9h3GeOA
         IWWA7qcZbvpO3oiKz8uHh0c9YeAJzs9HiS2eN0OIPlogqVyt2JtO0MwCZvhXAjt4GpYK
         wScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7hXKhWGjeEcs+khpwcGCmvFoDcx/GKGrlZ2jh0BxlI=;
        b=ow5gbsmOlwvoe7/gLoHyijWGTD9OaLeH1P5BMoRNnwKU4b4Prt0FYiCdlHF0hfdl+w
         +qdU6neHmIGdX5hoRkiNZMpyLyEQ2f6zo754xQH3ZodfjMWdgXTO3T8NLNX7xqvVi6uT
         gndiZl3w5i3MLWqWvOh47+bv/WwTIMKftmxoYIse/oSAoNa1B14ATwcPLn2SiFuIdwE2
         IQ7fm1ClD8XdMZveO/TKLyXl16mczFijG3xOXX/ZBoDYvkJP48JSZ29L1ea2bx1ftjIF
         IkjH/rdz2dwG5i4n7DbrcIkxkXSa8u08dNRL99d/wj0OhLQD3+8W8mvbUTeWdBIcfMJM
         XbUA==
X-Gm-Message-State: AOAM530eVgIkwNNKv8l0Y9UfRdwKNZ6KX7YXcBUJMJ4oNy8fhXbUqoWA
        VcCR47KzY0VuWZOPmcSqFkXMYsBoEwyNebtRRJD+kyCc6MbU4Lua
X-Google-Smtp-Source: ABdhPJwc4g1+tnNgptkpnh7MDkBXPuU8MLqJs8gmUyYZJKI5J8K5reugeGbV1rdIbF/ovznFDHZzxwctW+/8mjNcfvM=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr15912234ljw.408.1647885101104; Mon, 21
 Mar 2022 10:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <202203191213.tC0sjaY7-lkp@intel.com>
In-Reply-To: <202203191213.tC0sjaY7-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Mar 2022 10:51:29 -0700
Message-ID: <CAKwvOdnEyGLi14b0qsc2=aSRafCrQD-Zyh+Oq+E-vx+c1viErg@mail.gmail.com>
Subject: Re: [peterz-queue:locking/core 17/19] arch/x86/kvm/x86.h:29:30:
 error: too many arguments to function call, expected 0, have 1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
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

On Fri, Mar 18, 2022 at 9:10 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
> head:   200a79c670d24d4d9a75a6a9cbfd14af2f5d0ad9
> commit: 5c9f3806a4400c2957abeea9419547f856457a20 [17/19] lockdep: Fix -Wunused-parameter for _THIS_IP_
> config: x86_64-randconfig-a014 (https://download.01.org/0day-ci/archive/20220319/202203191213.tC0sjaY7-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=5c9f3806a4400c2957abeea9419547f856457a20
>         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>         git fetch --no-tags peterz-queue locking/core
>         git checkout 5c9f3806a4400c2957abeea9419547f856457a20
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/x86/kvm/x86.c:22:
>    In file included from arch/x86/kvm/mmu.h:7:
>    In file included from arch/x86/kvm/cpuid.h:5:
> >> arch/x86/kvm/x86.h:29:30: error: too many arguments to function call, expected 0, have 1
>            lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>            ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~

Peter, I think you dropped the hunk to include/linux/kvm_host.h when
applying this patch?

Compare:
https://lore.kernel.org/lkml/20220314221909.2027027-1-ndesaulniers@google.com/
vs
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/patch/?id=1923a1429507b15b2061968614a6943365159738

>    include/linux/ftrace.h:879:22: note: expanded from macro 'CALLER_ADDR0'
>    #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/irqflags.h:23:15: note: 'lockdep_hardirqs_on_prepare' declared here
>      extern void lockdep_hardirqs_on_prepare(void);
>                  ^
>    In file included from arch/x86/kvm/x86.c:41:
>    include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
>                   _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
>       : ((x) & (bit1)) / ((bit1) / (bit2))))
>                        ^ ~~~~~~~~~~~~~~~~~
>    1 warning and 1 error generated.
> --
>    In file included from arch/x86/kvm/emulate.c:28:
> >> arch/x86/kvm/x86.h:29:30: error: too many arguments to function call, expected 0, have 1
>            lockdep_hardirqs_on_prepare(CALLER_ADDR0);
>            ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~
>    include/linux/ftrace.h:879:22: note: expanded from macro 'CALLER_ADDR0'
>    #define CALLER_ADDR0 ((unsigned long)ftrace_return_address0)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/irqflags.h:23:15: note: 'lockdep_hardirqs_on_prepare' declared here
>      extern void lockdep_hardirqs_on_prepare(void);
>                  ^
>    1 error generated.
>
>
> vim +29 arch/x86/kvm/x86.h
>
> 65297341d8e15b Uros Bizjak         2021-08-09  12
> bc908e091b3264 Sean Christopherson 2021-05-04  13  static __always_inline void kvm_guest_enter_irqoff(void)
> bc908e091b3264 Sean Christopherson 2021-05-04  14  {
> bc908e091b3264 Sean Christopherson 2021-05-04  15       /*
> bc908e091b3264 Sean Christopherson 2021-05-04  16        * VMENTER enables interrupts (host state), but the kernel state is
> bc908e091b3264 Sean Christopherson 2021-05-04  17        * interrupts disabled when this is invoked. Also tell RCU about
> bc908e091b3264 Sean Christopherson 2021-05-04  18        * it. This is the same logic as for exit_to_user_mode().
> bc908e091b3264 Sean Christopherson 2021-05-04  19        *
> bc908e091b3264 Sean Christopherson 2021-05-04  20        * This ensures that e.g. latency analysis on the host observes
> bc908e091b3264 Sean Christopherson 2021-05-04  21        * guest mode as interrupt enabled.
> bc908e091b3264 Sean Christopherson 2021-05-04  22        *
> bc908e091b3264 Sean Christopherson 2021-05-04  23        * guest_enter_irqoff() informs context tracking about the
> bc908e091b3264 Sean Christopherson 2021-05-04  24        * transition to guest mode and if enabled adjusts RCU state
> bc908e091b3264 Sean Christopherson 2021-05-04  25        * accordingly.
> bc908e091b3264 Sean Christopherson 2021-05-04  26        */
> bc908e091b3264 Sean Christopherson 2021-05-04  27       instrumentation_begin();
> bc908e091b3264 Sean Christopherson 2021-05-04  28       trace_hardirqs_on_prepare();
> bc908e091b3264 Sean Christopherson 2021-05-04 @29       lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> bc908e091b3264 Sean Christopherson 2021-05-04  30       instrumentation_end();
> bc908e091b3264 Sean Christopherson 2021-05-04  31
> bc908e091b3264 Sean Christopherson 2021-05-04  32       guest_enter_irqoff();
> bc908e091b3264 Sean Christopherson 2021-05-04  33       lockdep_hardirqs_on(CALLER_ADDR0);
> bc908e091b3264 Sean Christopherson 2021-05-04  34  }
> bc908e091b3264 Sean Christopherson 2021-05-04  35
>
> :::::: The code at line 29 was first introduced by commit
> :::::: bc908e091b3264672889162733020048901021fb KVM: x86: Consolidate guest enter/exit logic to common helpers
>
> :::::: TO: Sean Christopherson <seanjc@google.com>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
>
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
