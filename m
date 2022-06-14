Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC654BB61
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357334AbiFNUUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiFNUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:20:16 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E038B7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:20:15 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id t1so17076065ybd.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3fZj/NWjDDDv+AZ8HKgB98ricBLfjxyJuqsjq8uYSg=;
        b=kl0G0cbFopr/Yw+ysfaKHrSTaHYHQMeZSA9tgsHIRwddENxPl2Iwp3izOgKP9Or7ya
         kut8hya66qLSAlT019ROGX7HApuQRFtXcKtIikEU2AkfFqq6wmc0GgquQ06RtZRFw07v
         X/jvkpTTqwjU7ejqlTkjl2jFK9qAM6/ssABIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3fZj/NWjDDDv+AZ8HKgB98ricBLfjxyJuqsjq8uYSg=;
        b=YdyBgWp5fbnTFua0+76hgK7/RREPpkI+XUOogT4YpeFALtKErXrgWF71K0LSmm9f2K
         g9CbE8nn6ixq2WMN95qds7itbvtIDPhEL/HhBoXatYXRg8D/JNnOwajjU29uF/xfpZ0h
         UO4h2An4Jy0IAE/D6yedpV6JrD+OTNVzIerIWc5ffBpLykwQDEcE6OCIVIEbIARkmHyB
         ag2UvlecWtyXFxQ9Sw36hEoDdPp9g8+u0N0Mu1VKZoccBf/UsN/aYv7icFAaObHjei6G
         00As1CT18JuY6B89G1fZARR02E5q5yTcnVGNuXFAY5CZvfjWacIz+k8zFMYd7VZMAIMQ
         wNXA==
X-Gm-Message-State: AJIora8NJeUbmhScnDzmNx+W9dEUWBXLdAcpyabrkNF/7GgzkEkMKlJ2
        Jib2UxYNOV3zpIiCeeKhlqVno2d8YOy9MmtxLapOCAiu9Q==
X-Google-Smtp-Source: AGRyM1v3TfdqMJAe0D16h8xZW51sthHbhKKM4VFPMUVdjlyBpMZEFYzvZDViy0Yv7E7UXlT4WN7BzcIIEvZwbnkx2D8=
X-Received: by 2002:a25:58f:0:b0:664:628a:374b with SMTP id
 137-20020a25058f000000b00664628a374bmr6735810ybf.329.1655238014203; Tue, 14
 Jun 2022 13:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220527042937.1124009-1-atishp@rivosinc.com> <CAAhSdy3jpXO_a+ZWNCW_n28GQd9JGJdCsNruL7spC_aork6iqA@mail.gmail.com>
In-Reply-To: <CAAhSdy3jpXO_a+ZWNCW_n28GQd9JGJdCsNruL7spC_aork6iqA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 14 Jun 2022 13:20:03 -0700
Message-ID: <CAOnJCUKY2hVygfPw0ZO-1j+L-zaoHk_HT=2FDsfoo6r6q77LNg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add Sstc extension support
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
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

On Thu, Jun 9, 2022 at 9:53 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, May 27, 2022 at 9:59 AM Atish Patra <atishp@rivosinc.com> wrote:
> >
> > This series implements Sstc extension support which was ratified recently.
> > Before the Sstc extension, an SBI call is necessary to generate timer
> > interrupts as only M-mode have access to the timecompare registers. Thus,
> > there is significant latency to generate timer interrupts at kernel.
> > For virtualized enviornments, its even worse as the KVM handles the SBI call
> > and uses a software timer to emulate the timecomapre register.
> >
> > Sstc extension solves both these problems by defining a stimecmp/vstimecmp
> > at supervisor (host/guest) level. It allows kernel to program a timer and
> > recieve interrupt without supervisor execution enviornment (M-mode/HS mode)
> > intervention.
> >
> > KVM directly updates the vstimecmp as well if the guest kernel invokes the SBI
> > call instead of updating stimecmp directly. This is required because KVM will
> > enable sstc extension if the hardware supports it unless the VMM explicitly
> > disables it for that guest. The hardware is expected to compare the
> > vstimecmp at every cycle if sstc is enabled and any stale value in vstimecmp
> > will lead to spurious timer interrupts. This also helps maintaining the
> > backward compatibility with older kernels.
> >
> > Similary, the M-mode firmware(OpenSBI) uses stimecmp for older kernel
> > without sstc support as STIP bit in mip is read only for hardware with sstc.
> >
> > The PATCH 1 & 2 enables the basic infrastructure around Sstc extension while
> > PATCH 3 lets kernel use the Sstc extension if it is available in hardware.
> > PATCH 4 implements the Sstc extension in KVM.
> >
> > This series has been tested on Qemu(RV32 & RV64) with additional patches in
> > Qemu[2]. This series can also be found at [3].
> >
> > Changes from v3->v4:
> > 1. Rebased on 5.18-rc6
> > 2. Unified vstimemp & next_cycles.
> > 3. Addressed comments in PATCH 3 & 4.
> >
> > Changes from v2->v3:
> > 1. Dropped unrelated KVM fixes from this series.
> > 2. Rebased on 5.18-rc3.
> >
> > Changes from v1->v2:
> > 1. Separate the static key from kvm usage
> > 2. Makde the sstc specific static key local to the driver/clocksource
> > 3. Moved the vstimecmp update code to the vcpu_timer
> > 4. Used function pointers instead of static key to invoke vstimecmp vs
> >    hrtimer at the run time. This will help in future for migration of vms
> >    from/to sstc enabled hardware to non-sstc enabled hardware.
> > 5. Unified the vstimer & timer to 1 timer as only one of them will be used
> >    at runtime.
> >
> > [1] https://drive.google.com/file/d/1m84Re2yK8m_vbW7TspvevCDR82MOBaSX/view
> > [2] https://github.com/atishp04/qemu/tree/sstc_v3
> > [3] https://github.com/atishp04/linux/tree/sstc_v4
> >
> > Atish Patra (4):
> > RISC-V: Add SSTC extension CSR details
> > RISC-V: Enable sstc extension parsing from DT
> > RISC-V: Prefer sstc extension if available
> > RISC-V: KVM: Support sstc extension
>
> Please don't forget to CC kvm-riscv mailing list for KVM RISC-V patches.
>

Sorry. My scripts did not pick up kvm-riscv for some reason.
Fixed it.

> We have a patchwork setup for KVM RISC-V will also miss a series if
> patches are not CCed.
>
> Regards,
> Anup
>
> >
> > arch/riscv/include/asm/csr.h            |  11 ++
> > arch/riscv/include/asm/hwcap.h          |   1 +
> > arch/riscv/include/asm/kvm_vcpu_timer.h |   8 +-
> > arch/riscv/include/uapi/asm/kvm.h       |   1 +
> > arch/riscv/kernel/cpu.c                 |   1 +
> > arch/riscv/kernel/cpufeature.c          |   1 +
> > arch/riscv/kvm/main.c                   |  12 +-
> > arch/riscv/kvm/vcpu.c                   |   5 +-
> > arch/riscv/kvm/vcpu_timer.c             | 144 +++++++++++++++++++++++-
> > drivers/clocksource/timer-riscv.c       |  24 +++-
> > 10 files changed, 198 insertions(+), 10 deletions(-)
> >
> > --
> > 2.25.1
> >



--
Regards,
Atish
