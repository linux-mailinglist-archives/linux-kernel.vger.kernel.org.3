Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168F4F5FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiDFNWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiDFNWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:22:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262025DA91
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:10:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h7so3252325lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5bDixyu2P+1amMqXVInPRQZcEo1D+KNKXvuVBZxtRQ=;
        b=OAKVuoE8oiVQ4UPGV07GOSeUOsXTrgaJRg7NWGdn7EbTAlaFUO1pkDW2WiLN3fiwBZ
         6ol1TcyZnld8fKDdQMPzHG6sMXb4L17Z3i+HSVZKoEhe0JhYHDBZAg3Ds8PWOqeFN8te
         mU4w5+5R52iiY+9uwvnHVdXDTwsVPWp3pryhsJSOhDCk1TftYIVSbp5OS3pXslJ7JIFL
         8g8T48WPe0jThVfCVYYcXR0IebOR4rDs5+vDRJDbBRkzB11UhGchhHwjylruuwFwOolO
         LY14zHVmw/F6nrj9qYMu+V+RKnkijG6QDsrKcSLHNKdApUeZ3wcDcjih57jBwz25xuym
         OxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5bDixyu2P+1amMqXVInPRQZcEo1D+KNKXvuVBZxtRQ=;
        b=MhvfZsYFZI8hi0dDzLSIAw6RLuPihEmTMm10PLjVr6yEqK8wtaawISI+H6iAZEircA
         mD4N82dJ+M392hKeKwQ61DynA9aueqIPxzGLGgFAh/6MpdiSwH3UjrT2poSHp2GNLf7l
         9Je+0f+QSMFSwF2CGtyysKMkVyeeWLx4XjQDdRjZQowdiF9mhapmfFIGU5bWofrJ8Dj7
         onmOu1cT4RVvVM/XJjgrBJo0gh/gFNFtVquAUowfljPUwoV9M7fp4pldqIXZnxzH6vrw
         I9jDv61UgAjwpdjnwcaN1B76ZRcU00AWJBUwpzdLpR1qbGpRfZomQ8qWEddAEqvPfthk
         m06Q==
X-Gm-Message-State: AOAM530ZVq0MUPIxKVoMsFfVoacu3rB5PVhpDIFB1a5fLGnUDeUpnm3b
        //AkFVZynohxdIsP1RfEomfY4dBhgvB1eD/vvccugg==
X-Google-Smtp-Source: ABdhPJx7JE7Jpx1P7bpAdpKWrnifJThRxU1P01A3vMAYKwbWmoTYyvmJ+YWHcdrtf108eXEmPOyLNj3/+iSw9OAtOWo=
X-Received: by 2002:a05:6512:e89:b0:44a:86e0:2294 with SMTP id
 bi9-20020a0565120e8900b0044a86e02294mr5737802lfb.130.1649239812934; Wed, 06
 Apr 2022 03:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014> <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com>
In-Reply-To: <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 6 Apr 2022 15:40:01 +0530
Message-ID: <CAK9=C2Xh_DQ3ybj7nAE-LNrSc9sPy0H8jq_FU09io+wE_yypRg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
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

On Wed, Apr 6, 2022 at 3:25 PM Heinrich Schuchardt
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

This is just making it unnecessarily complicated for supporting
SBI v0.1

How about removing SBI v0.1 support and the spin-wait CPU
operations from arch/riscv ?

>
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

Yes, this limit will be gradually increased with some improvements
to optimize runtime memory used by OpenSBI.

>
> U-Boot v2022.04 qemu-riscv64_smode_defconfig has a value of
> CONFIG_SYS_MALLOC_F_LEN that is to low. This leads to a boot failure for
> more than 16 harts. A patch to correct this is pending:
> [PATCH v2 1/1] riscv: alloc space exhausted
> https://lore.kernel.org/u-boot/CAN5B=eKt=tFLZ2z3aNHJqsnJzpdA0oikcrC2i1_=ZDD=f+M0jA@mail.gmail.com/T/#t
>
> With QEMU 7.0 and the U-Boot fix booting into a 5.17 defconfig kernel
> with 64 virtual cores worked fine for me.

Thanks for trying this patch.

Regards,
Anup

>
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
