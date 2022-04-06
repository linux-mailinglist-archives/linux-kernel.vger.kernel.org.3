Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA644F6E24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiDFXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiDFXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:02:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D0B393D9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:00:38 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f38so6669436ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=REjKncLjp1nMKQiEVjK+/uhj8//u0cu6B7KXtRM9r0I=;
        b=MJPDFk9xgUfUcoxyHGRS04ucddscvQEz6AdsQIvm761bw9DkU77tscCfmzvO8eMGEw
         hPOQ+KzEf58oJ57iItjoMirP1fti/p1Zxx2SlFFhcSxaO0Meql0WcuaIGuIZdl2rJT++
         TEh4SJH8up9i4QL7p/UZQZJBUXXvb6rk2R/jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REjKncLjp1nMKQiEVjK+/uhj8//u0cu6B7KXtRM9r0I=;
        b=thK4Gbo8ky/XQCfUomKl5O6eOPDSbJbJdxoAuzICpiXJ7yMdBlckmEEQ/hpASR3kYd
         R5JFTq7M2iDFxkWORKaAkY1YTma7A9hYtPQa8+MtQYkPOnz7Eu3PuVOOG+Qfs55oEF0G
         oirqUeK8QmK0r+s3Yi8+tAo2U7qGJPPGl/v+kasSyhmhBO5xnqu1gOSvdf6hMolFJgED
         UYIbHgOsM1Bx+PCUjFiokkzMQbzPNQsyRcS+DdeVBH4m30KSBsdTayxw0tKaUQc4WbnK
         A2L9wJ3sQ4G19dJl0gPpoISNR56ZNTmIA601PwlqDeEoLT2nw/czeoh7SUvRoe/rceu/
         Y8zA==
X-Gm-Message-State: AOAM532p9hTq+W90pxbfj6kptKXxYofuAvqw6kcTAM7n1QQZXBH+O852
        E2XXtRRryXDR+I8Plpbw5GygCGoXKIIB93tzEKS/
X-Google-Smtp-Source: ABdhPJx7Chr0rGxiUnrjypds2chKs2NOIkH2YmsqX59fMJZsjyQFVpluGZPATnKXNHyatQVrQDsVUDosstbC6rqlzeI=
X-Received: by 2002:a5b:803:0:b0:633:749f:9acd with SMTP id
 x3-20020a5b0803000000b00633749f9acdmr8257311ybp.236.1649286037416; Wed, 06
 Apr 2022 16:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014> <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com>
In-Reply-To: <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 6 Apr 2022 16:00:26 -0700
Message-ID: <CAOnJCUKDWBhphwvOc=waPiwFr5nT7otohJKr-yhoLYM=UBubQA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 2:55 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 3/31/22 21:42, Palmer Dabbelt wrote:
> > On Sat, 19 Mar 2022 05:12:06 PDT (-0700), apatel@ventanamicro.com wrote:
> >> Currently, the range and default value of NR_CPUS is too restrictive
> >> for high-end RISC-V systems with large number of HARTs. The latest
> >> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> >> restrictive for QEMU as well. Other major architectures (such as
> >> ARM64, x86_64, MIPS, etc) have a much higher range and default
> >> value of NR_CPUS.
> >>
> >> This patch increases NR_CPUS range to 2-512 and default value to
> >> XLEN (i.e. 32 for RV32 and 64 for RV64).
> >>
> >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> ---
> >> Changes since v1:
> >>  - Updated NR_CPUS range to 2-512 which reflects maximum number of
> >>    CPUs supported by QEMU virt machine.
> >> ---
> >>  arch/riscv/Kconfig | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> index 5adcbd9b5e88..423ac17f598c 100644
> >> --- a/arch/riscv/Kconfig
> >> +++ b/arch/riscv/Kconfig
> >> @@ -274,10 +274,11 @@ config SMP
> >>        If you don't know what to do here, say N.
> >>
> >>  config NR_CPUS
> >> -    int "Maximum number of CPUs (2-32)"
> >> -    range 2 32
> >> +    int "Maximum number of CPUs (2-512)"
> >> +    range 2 512
>
> For SBI_V01=y there seems to be a hard constraint to XLEN bits.
> See __sbi_v01_cpumask_to_hartmask() in rch/riscv/kernel/sbi.c.
>
> So shouldn't this be something like:
>
> range 2 512 !SBI_V01
> range 2 32 SBI_V01 && 32BIT
> range 2 64 SBI_V01 && 64BIT
>

Yes. In addition to that, we should disable RISCV_BOOT_SPINWAIT as well
so that you don't end up in  case where -smp argument in Qemu < NR_CPUs

Palmer already has a patch for that.
https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=riscv-spinwait

> >>      depends on SMP
> >> -    default "8"
> >> +    default "32" if 32BIT
> >> +    default "64" if 64BIT
> >>
> >>  config HOTPLUG_CPU
> >>      bool "Support for hot-pluggable CPUs"
> >
> > I'm getting all sorts of boot issues with more than 32 CPUs, even on the
> > latest QEMU master.  I'm not opposed to increasing the CPU count in
> > theory, but if we're going to have a setting that goes up to a huge
> > number it needs to at least boot.  I've got 64 host threads, so it
> > shouldn't just be a scheduling thing.
>
> Currently high performing hardware for RISC-V is missing. So it makes
> sense to build software via QEMU on x86_64 or arm64 with as many
> hardware threads as available (128 is not uncommon).
>
> OpenSBI currently is limited to 128 threads:
> include/sbi/sbi_hartmask.h:22:
> #define SBI_HARTMASK_MAX_BITS 128
> This is just an arbitrary value we can be modified.
>
> U-Boot v2022.04 qemu-riscv64_smode_defconfig has a value of
> CONFIG_SYS_MALLOC_F_LEN that is to low. This leads to a boot failure for
> more than 16 harts. A patch to correct this is pending:
> [PATCH v2 1/1] riscv: alloc space exhausted
> https://lore.kernel.org/u-boot/CAN5B=eKt=tFLZ2z3aNHJqsnJzpdA0oikcrC2i1_=ZDD=f+M0jA@mail.gmail.com/T/#t
>
> With QEMU 7.0 and the U-Boot fix booting into a 5.17 defconfig kernel
> with 64 virtual cores worked fine for me.
>

For me, OpenSBI -> Linux path works for 128 harts for bunch of configs from here

https://github.com/palmer-dabbelt/riscv-systems-ci/tree/master/configs/linux

with RISCV_BOOT_SPINWAIT disabled.

> Best regards
>
> Heinrich
>
> >
> > If there was some hardware that actually boots on these I'd be happy to
> > take it, but given that it's just QEMU I'd prefer to sort out the bugs
> > first.  It's probably just latent bugs somewhere, but allowing users to
> > turn on configs we know don't work just seems like the wrong way to go.
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>


-- 
Regards,
Atish
