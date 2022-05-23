Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3158B5308FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiEWFuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiEWFt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:49:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB8F2AE0E
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:49:54 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id x2so23192992ybi.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 22:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwC5QQGi/RwlldZWVkMNteflbAkL+jLDxrVZ/7sdTFs=;
        b=ZtOkIZ84R1vXKoMYcIcH/R3JHRpOeXFkHN5RMBGubWC93CPtVjTEhpYyfHeLRF7LYf
         MUX3sN9FsA39zWskA6NoYYNlUrI7YGbLNABvPfwrOv+8wiORZ25kfSsJ6YAnBbRz2Wmc
         kOKXAJZbgDgSPVafeg0edLj1rpidRLlTsBA3rAORGj1qdvGA7Pvvyy0vS2ulkOFSUig3
         89w37JS91GDOGBwzinnVdzb+OkBZZRNgpkdumF3RBufn3QcwtNx6rXwZnQyMRDkInrgr
         Vc8ogNtijt2ayD2Ce6qLVMB68s60ETf6K5Phqb2SnA7PGMJHXDTYAj90uNxFoGehGf7s
         HICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwC5QQGi/RwlldZWVkMNteflbAkL+jLDxrVZ/7sdTFs=;
        b=Tgv8NWP4WDB+8DVkwj5k79+Ue552Ve5MjiXx3ZSlwaPy/aK5rhOKm7h65JfRATqGNY
         FJSlDSKoeQnOPWr4uB4CRun6swF/2tNj+TYkdmN7NPmhzijVUuFjwO6Hh/aG93NZq5mo
         qmQcWku2R2DnHNOQdCWrb4HZcY12oGuzCAsLsaao/h3KsDHVlv5VlSJmKvaim5VzokP8
         GgaAjpO+Ow830jNVd1HQ+2H2xq1UQRhJSWHhaGhYYME8QXxGCX/8yQiZBDL2mwjKZ7Tk
         IlKC3+p+gHtYOZ7o52VmZP2u7oevym6BTqZIrji93VHUcsKCgfThue/xqHZ29k3R4b0g
         bZRA==
X-Gm-Message-State: AOAM531IKeEeb2G8XfO0gh4v8mAraeBb7yUHCz2oAzoX1odygY9J/zW7
        4xCYuzd77Tk01cVmAWDxaZRdF5upSvSIlxkcSfQZAQ==
X-Google-Smtp-Source: ABdhPJw06RNDX+RfVK9zAYMFdvIxjdxqt0oRtTzUPXmnLtm6NJVTSuhbJa4NUsbz8A6skUym4vj01qOjnpNDwY8qlLg=
X-Received: by 2002:a05:6902:1004:b0:64f:4748:e8be with SMTP id
 w4-20020a056902100400b0064f4748e8bemr17911740ybt.537.1653284993871; Sun, 22
 May 2022 22:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <202205201624.A4IhDdYX-lkp@intel.com> <Yoe4WQCV9903aQRP@dev-arch.thelio-3990X>
In-Reply-To: <Yoe4WQCV9903aQRP@dev-arch.thelio-3990X>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 23 May 2022 11:19:42 +0530
Message-ID: <CA+G9fYtaz2MO_-yxwtqQx+Gxm460mr2S++fFCYAqObacEL1X-Q@mail.gmail.com>
Subject: Re: [linux-next:master 12308/12886] arch/x86/kvm/hyperv.c:1983:22:
 warning: shift count >= width of type
To:     Nathan Chancellor <nathan@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 at 21:18, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Yury,
>
> On Fri, May 20, 2022 at 04:24:32PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   21498d01d045c5b95b93e0a0625ae965b4330ebe
> > commit: 81db71a60292e9a40ae8f6ef137b17f2aaa15a52 [12308/12886] KVM: x86: hyper-v: replace bitmap_weight() with hweight64()
> > config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220520/202205201624.A4IhDdYX-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=81db71a60292e9a40ae8f6ef137b17f2aaa15a52
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout 81db71a60292e9a40ae8f6ef137b17f2aaa15a52
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> arch/x86/kvm/hyperv.c:1983:22: warning: shift count >= width of type [-Wshift-count-overflow]
> >                    if (hc->var_cnt != hweight64(valid_bank_mask))
> >                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/asm-generic/bitops/const_hweight.h:29:49: note: expanded from macro 'hweight64'
> >    #define hweight64(w) (__builtin_constant_p(w) ? __const_hweight64(w) : __arch_hweight64(w))
> >                                                    ^~~~~~~~~~~~~~~~~~~~
> >    include/asm-generic/bitops/const_hweight.h:21:76: note: expanded from macro '__const_hweight64'
> >    #define __const_hweight64(w) (__const_hweight32(w) + __const_hweight32((w) >> 32))
> >                                                                               ^  ~~
> >    include/asm-generic/bitops/const_hweight.h:20:49: note: expanded from macro '__const_hweight32'
> >    #define __const_hweight32(w) (__const_hweight16(w) + __const_hweight16((w) >> 16))
> >                                                    ^
> >    note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> >    include/asm-generic/bitops/const_hweight.h:10:9: note: expanded from macro '__const_hweight8'
> >             ((!!((w) & (1ULL << 0))) +     \
> >                   ^
> >    include/linux/compiler.h:56:47: note: expanded from macro 'if'
> >    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
> >                                                  ^~~~
> >    include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
> >    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> >                                                       ^~~~

LKFT build system found these build warnings / errors on Linux next-20220520.

> I think this is the proper fix, as valid_bank_mask is only assigned u64
> values. Could you fold it into that patch to clear this warning up?

The proposed patch below was tested and it fixed the reported problem on 32-bit

> Cheers,
> Nathan
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index b652b856df2b..e2e95a6fccfd 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -1914,7 +1914,7 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
>         struct hv_send_ipi_ex send_ipi_ex;
>         struct hv_send_ipi send_ipi;
>         DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> -       unsigned long valid_bank_mask;
> +       u64 valid_bank_mask;
>         u64 sparse_banks[KVM_HV_MAX_SPARSE_VCPU_SET_BITS];
>         u32 vector;
>         bool all_cpus;

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org
