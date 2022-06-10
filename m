Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6347545B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbiFJExS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240448AbiFJExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:53:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E99317518
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:53:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso545556wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 21:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yT2dY1CxLSVJ5jM9XqmB8hnkuELf74CsmsabBpi5suY=;
        b=AWO8jA8jbizmFTZ2iKFOurF6Q+l71eaS9jhDiXhwP1Qvx+Rj98w8QYl3ulywOvgtv6
         t5SQx1gDPX8B4Ijs0PmiEepDNZOLPrpkK5KNnw6CIgQAq7372hQrSJga4evSuejWB1Mq
         huhBQeeEQeakxBKZzpEN7Pg/RFD9OA+a9XMsmmVMT5Wv6bku3CHe/hMlPrs31emgAeyI
         0zSaG8XP8kKpm+bGI2jierEB2C96vJwv/UEMrOJdE7iOfiFySytQSA/R2RCsDMO1JMBF
         4vK7EQ3fJRvz4E3Y8Zgb36zCnnM8ypbwB/RzBCyuAWk1VoPc8bVfuYN5KB1DZ/q/1wLy
         shEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yT2dY1CxLSVJ5jM9XqmB8hnkuELf74CsmsabBpi5suY=;
        b=yd2Wj2oZSQg1TQzrxcERz3yDuLqyI7iwJ6iJpTtbjTCey54ucFV1bfb9U5l0VPxewb
         Wt7NMK6n5D+w3KWiui9+sxHXm8GwulFvOnc4xfV9sMUrOpoGrmPRkllDdZKoup1Luxqg
         bJUe0ca0MjrYYmyGvo52FoKFYzWu/1K7DXGDdlJfdZywSGazK4VcU7zEFrqijHQqdAaI
         qKZQvZxxforDlsq577ZzAbdAat4lCHxObK7DtEgFMdkoG9OkMvpH+hd0lSBRKmsEvS5H
         tjvi2HcScpkxDv/nmu1VD/IpoOJPwbYgK3s5tgraZ/ZRkT3uJQqFuaUiMsvT0QgS5Nfh
         wWgA==
X-Gm-Message-State: AOAM532fVy7/YSR1ZP8okpGPx0LKfdLRx8kjxnAJBkvkd7AvnJK4gsTl
        SUJ7iw7JXv1fsVa34VYAvPwo3mqfbFiA0eHGQG1QrA==
X-Google-Smtp-Source: ABdhPJx7L9vYUBmxUCqXUtntwUrlJZQwSghvc/QDikd0/b7LAKguXcB4xG4bOm9Dl/IKGYBBF8t/AOpZDshmumSVaJs=
X-Received: by 2002:a7b:c10d:0:b0:39c:4a17:1e90 with SMTP id
 w13-20020a7bc10d000000b0039c4a171e90mr6532508wmi.108.1654836790199; Thu, 09
 Jun 2022 21:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220527042937.1124009-1-atishp@rivosinc.com>
In-Reply-To: <20220527042937.1124009-1-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 10 Jun 2022 10:22:58 +0530
Message-ID: <CAAhSdy3jpXO_a+ZWNCW_n28GQd9JGJdCsNruL7spC_aork6iqA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add Sstc extension support
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 9:59 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> This series implements Sstc extension support which was ratified recently.
> Before the Sstc extension, an SBI call is necessary to generate timer
> interrupts as only M-mode have access to the timecompare registers. Thus,
> there is significant latency to generate timer interrupts at kernel.
> For virtualized enviornments, its even worse as the KVM handles the SBI call
> and uses a software timer to emulate the timecomapre register.
>
> Sstc extension solves both these problems by defining a stimecmp/vstimecmp
> at supervisor (host/guest) level. It allows kernel to program a timer and
> recieve interrupt without supervisor execution enviornment (M-mode/HS mode)
> intervention.
>
> KVM directly updates the vstimecmp as well if the guest kernel invokes the SBI
> call instead of updating stimecmp directly. This is required because KVM will
> enable sstc extension if the hardware supports it unless the VMM explicitly
> disables it for that guest. The hardware is expected to compare the
> vstimecmp at every cycle if sstc is enabled and any stale value in vstimecmp
> will lead to spurious timer interrupts. This also helps maintaining the
> backward compatibility with older kernels.
>
> Similary, the M-mode firmware(OpenSBI) uses stimecmp for older kernel
> without sstc support as STIP bit in mip is read only for hardware with sstc.
>
> The PATCH 1 & 2 enables the basic infrastructure around Sstc extension while
> PATCH 3 lets kernel use the Sstc extension if it is available in hardware.
> PATCH 4 implements the Sstc extension in KVM.
>
> This series has been tested on Qemu(RV32 & RV64) with additional patches in
> Qemu[2]. This series can also be found at [3].
>
> Changes from v3->v4:
> 1. Rebased on 5.18-rc6
> 2. Unified vstimemp & next_cycles.
> 3. Addressed comments in PATCH 3 & 4.
>
> Changes from v2->v3:
> 1. Dropped unrelated KVM fixes from this series.
> 2. Rebased on 5.18-rc3.
>
> Changes from v1->v2:
> 1. Separate the static key from kvm usage
> 2. Makde the sstc specific static key local to the driver/clocksource
> 3. Moved the vstimecmp update code to the vcpu_timer
> 4. Used function pointers instead of static key to invoke vstimecmp vs
>    hrtimer at the run time. This will help in future for migration of vms
>    from/to sstc enabled hardware to non-sstc enabled hardware.
> 5. Unified the vstimer & timer to 1 timer as only one of them will be used
>    at runtime.
>
> [1] https://drive.google.com/file/d/1m84Re2yK8m_vbW7TspvevCDR82MOBaSX/view
> [2] https://github.com/atishp04/qemu/tree/sstc_v3
> [3] https://github.com/atishp04/linux/tree/sstc_v4
>
> Atish Patra (4):
> RISC-V: Add SSTC extension CSR details
> RISC-V: Enable sstc extension parsing from DT
> RISC-V: Prefer sstc extension if available
> RISC-V: KVM: Support sstc extension

Please don't forget to CC kvm-riscv mailing list for KVM RISC-V patches.

We have a patchwork setup for KVM RISC-V will also miss a series if
patches are not CCed.

Regards,
Anup

>
> arch/riscv/include/asm/csr.h            |  11 ++
> arch/riscv/include/asm/hwcap.h          |   1 +
> arch/riscv/include/asm/kvm_vcpu_timer.h |   8 +-
> arch/riscv/include/uapi/asm/kvm.h       |   1 +
> arch/riscv/kernel/cpu.c                 |   1 +
> arch/riscv/kernel/cpufeature.c          |   1 +
> arch/riscv/kvm/main.c                   |  12 +-
> arch/riscv/kvm/vcpu.c                   |   5 +-
> arch/riscv/kvm/vcpu_timer.c             | 144 +++++++++++++++++++++++-
> drivers/clocksource/timer-riscv.c       |  24 +++-
> 10 files changed, 198 insertions(+), 10 deletions(-)
>
> --
> 2.25.1
>
