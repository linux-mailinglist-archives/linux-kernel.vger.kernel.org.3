Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B556D430
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiGKFHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:07:22 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B126B15FF3;
        Sun, 10 Jul 2022 22:07:19 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 26B56iTN026750;
        Mon, 11 Jul 2022 14:06:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 26B56iTN026750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657516005;
        bh=fyp5FXcZZigbLKAx2ghuI1TbzZARYBAe7D9xWaMRqL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BR8GZz8vSEzJQqd87jgC46rd1CRKCimWfhAfFuP4FrypSi+xblRNAkjEXZ0LC/Zqx
         3P3ZmDMwBXwZ1drrHRh0gUGv0dpRF5hlMiOgFzT6KgaATf2yKGKkpvpMTQ8ocwy+Pf
         Q6DXI8Air7QldI3ENSwhA9VYIhYfJBuBtRvLjEfp3d4QA6369B2h5k7dsrN6cGFT+P
         y/pJaLVVob018gudKK2PPjsBtSFKf+3WKG96x6bK3/XI7E+rQGo/0b+FWNsyrcJumZ
         1x77+w0YcipmlyO0Cu9tHrWvi8udBLcW7K58wttTAM5rZTZGfCiJT7yj0HCOtELrPU
         eykq4HGiSkrwg==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id q9so5472965wrd.8;
        Sun, 10 Jul 2022 22:06:44 -0700 (PDT)
X-Gm-Message-State: AJIora8+i3aA8wLRevU5Rb/o8oZOHuimgrJc6NokAuPfB6iWV3VnYJMm
        s+SDJdxNYgN/0lF1al6aMuqlJlICmn+gJJVL58g=
X-Google-Smtp-Source: AGRyM1vH2mAKjm/+YtdYA3vNeuFN0FRcC3oNUo39kg5xyzY4axcOTlWQf/cdEYTMoNEQzv0WR+O0YzuGFeDu6TEmGMY=
X-Received: by 2002:adf:e104:0:b0:21b:9938:b07a with SMTP id
 t4-20020adfe104000000b0021b9938b07amr15442314wrz.682.1657516003430; Sun, 10
 Jul 2022 22:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com>
 <20220628210407.3343118-1-ndesaulniers@google.com>
In-Reply-To: <20220628210407.3343118-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 11 Jul 2022 14:05:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpyehuTqiwQD9BPHAR9ZVLYMA6JUxcHUwsTxmtgz7S2A@mail.gmail.com>
Message-ID: <CAK7LNARpyehuTqiwQD9BPHAR9ZVLYMA6JUxcHUwsTxmtgz7S2A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miko Larsson <mikoxyzzz@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, X86 ML <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 6:06 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The difference in most compilers between `-O3` and `-O2` is mostly down
> to whether loops with statically determinable trip counts are fully
> unrolled vs unrolled to a multiple of SIMD width.
>
> This patch is effectively a revert of
> commit 15f5db60a137 ("kbuild,arc: add
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3 for ARC") without re-adding
> ARCH_CFLAGS
>
> Ever since
> commit cfdbc2e16e65 ("ARC: Build system: Makefiles, Kconfig, Linker
> script")
> ARC has been built with -O3, though the reason for doing so was not
> specified in inline comments or the commit message. This commit does not
> re-add -O3 to arch/arc/Makefile.
>
> Folks looking to experiment with `-O3` (or any compiler flag for that
> matter) may pass them along to the command line invocation of make:
>
> $ make KCFLAGS=-O3
>
> Code that looks to re-add an explicit Kconfig option for `-O3` should
> provide:
> 1. A rigorous and reproducible performance profile of a reasonable
>    userspace workload that demonstrates a hot loop in the kernel that
>    would benefit from `-O3` over `-O2`.
> 2. Disassembly of said loop body before and after.
> 3. Provides stats on terms of increase in file size.
>
> Link: https://lore.kernel.org/linux-kbuild/CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Applied to linux-kbuild.
Thanks.


>  Makefile                                   | 2 --
>  arch/arc/configs/axs101_defconfig          | 1 -
>  arch/arc/configs/axs103_defconfig          | 1 -
>  arch/arc/configs/axs103_smp_defconfig      | 1 -
>  arch/arc/configs/haps_hs_defconfig         | 1 -
>  arch/arc/configs/haps_hs_smp_defconfig     | 1 -
>  arch/arc/configs/hsdk_defconfig            | 1 -
>  arch/arc/configs/nsim_700_defconfig        | 1 -
>  arch/arc/configs/nsimosci_defconfig        | 1 -
>  arch/arc/configs/nsimosci_hs_defconfig     | 1 -
>  arch/arc/configs/nsimosci_hs_smp_defconfig | 1 -
>  arch/arc/configs/tb10x_defconfig           | 1 -
>  arch/arc/configs/vdk_hs38_defconfig        | 1 -
>  arch/arc/configs/vdk_hs38_smp_defconfig    | 1 -
>  init/Kconfig                               | 7 -------
>  15 files changed, 22 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 8973b285ce6c..b69f6cd7f2e2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -755,8 +755,6 @@ KBUILD_CFLAGS       += $(call cc-disable-warning, address-of-packed-member)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>  KBUILD_CFLAGS += -O2
> -else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
> -KBUILD_CFLAGS += -O3
>  else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_CFLAGS += -Os
>  endif
> diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
> index 0016149f9583..e31a8ebc3ecc 100644
> --- a/arch/arc/configs/axs101_defconfig
> +++ b/arch/arc/configs/axs101_defconfig
> @@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
> index 5b031582a1cf..e0e8567f0d75 100644
> --- a/arch/arc/configs/axs103_defconfig
> +++ b/arch/arc/configs/axs103_defconfig
> @@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
> index d4eec39e0112..fcbc952bc75b 100644
> --- a/arch/arc/configs/axs103_smp_defconfig
> +++ b/arch/arc/configs/axs103_smp_defconfig
> @@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
> index 7337cdf4ffdd..d87ad7e88d62 100644
> --- a/arch/arc/configs/haps_hs_defconfig
> +++ b/arch/arc/configs/haps_hs_defconfig
> @@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EXPERT=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_COMPAT_BRK is not set
> diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
> index bc927221afc0..8d82cdb7f86a 100644
> --- a/arch/arc/configs/haps_hs_smp_defconfig
> +++ b/arch/arc/configs/haps_hs_smp_defconfig
> @@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
> index aa000075a575..f856b03e0fb5 100644
> --- a/arch/arc/configs/hsdk_defconfig
> +++ b/arch/arc/configs/hsdk_defconfig
> @@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
> index 326f6cde7826..a1ce12bf5b16 100644
> --- a/arch/arc/configs/nsim_700_defconfig
> +++ b/arch/arc/configs/nsim_700_defconfig
> @@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
> diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
> index bf39a0091679..ca10f4a2c823 100644
> --- a/arch/arc/configs/nsimosci_defconfig
> +++ b/arch/arc/configs/nsimosci_defconfig
> @@ -10,7 +10,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
> diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
> index 7121bd71c543..31b6ec3683c6 100644
> --- a/arch/arc/configs/nsimosci_hs_defconfig
> +++ b/arch/arc/configs/nsimosci_hs_defconfig
> @@ -10,7 +10,6 @@ CONFIG_NAMESPACES=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
> diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
> index f9863b294a70..41a0037f48a5 100644
> --- a/arch/arc/configs/nsimosci_hs_smp_defconfig
> +++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
> @@ -8,7 +8,6 @@ CONFIG_IKCONFIG_PROC=y
>  # CONFIG_UTS_NS is not set
>  # CONFIG_PID_NS is not set
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_KPROBES=y
> diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
> index a12656ec0072..d93b65008d4a 100644
> --- a/arch/arc/configs/tb10x_defconfig
> +++ b/arch/arc/configs/tb10x_defconfig
> @@ -14,7 +14,6 @@ CONFIG_INITRAMFS_SOURCE="../tb10x-rootfs.cpio"
>  CONFIG_INITRAMFS_ROOT_UID=2100
>  CONFIG_INITRAMFS_ROOT_GID=501
>  # CONFIG_RD_GZIP is not set
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_KALLSYMS_ALL=y
>  # CONFIG_AIO is not set
>  CONFIG_EMBEDDED=y
> diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
> index d7c858df520c..0c3b21416819 100644
> --- a/arch/arc/configs/vdk_hs38_defconfig
> +++ b/arch/arc/configs/vdk_hs38_defconfig
> @@ -4,7 +4,6 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
> index 015c1d43889e..f9ad9d3ee702 100644
> --- a/arch/arc/configs/vdk_hs38_smp_defconfig
> +++ b/arch/arc/configs/vdk_hs38_smp_defconfig
> @@ -4,7 +4,6 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_BLK_DEV_INITRD=y
> -CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
>  CONFIG_EMBEDDED=y
>  CONFIG_PERF_EVENTS=y
>  # CONFIG_VM_EVENT_COUNTERS is not set
> diff --git a/init/Kconfig b/init/Kconfig
> index c7900e8975f1..1b4d8acc3def 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1401,13 +1401,6 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
>           with the "-O2" compiler flag for best performance and most
>           helpful compile-time warnings.
>
> -config CC_OPTIMIZE_FOR_PERFORMANCE_O3
> -       bool "Optimize more for performance (-O3)"
> -       depends on ARC
> -       help
> -         Choosing this option will pass "-O3" to your compiler to optimize
> -         the kernel yet more for performance.
> -
>  config CC_OPTIMIZE_FOR_SIZE
>         bool "Optimize for size (-Os)"
>         help
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>


-- 
Best Regards
Masahiro Yamada
