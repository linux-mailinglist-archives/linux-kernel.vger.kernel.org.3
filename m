Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC75AC28D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiIDEkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDEkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:40:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AF20183
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:40:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z6so8829342lfu.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=C+MS/rLzegvRZFnaDUJAp+enUiI0lNSEcdyO2eVVcK8=;
        b=G4gAsMuv0P8H+nBLOqzCRSWqbhtTbBSkz/95S9yAjWf3yZYsRsbqvkZTzOmJvyvhv/
         pVrq5fotce93LD67GojA0A49rdFv0wD0DaH1UmFUQT11HcZ/oS7cpQVbr7n8ntJ07oLR
         ql5hlk/Rx5lkEPV8XxlV0+Yp3SObDekEvWibgX3o1uKXRMKmFc2GU4idGIBwOMmfc+Ro
         wfXPVUTsBQMPySyjRqhNH2Q+ZUbUFPwvzQpAg+NNWoSoEyox+G33/iSon+8myWWlUs49
         NjzAKgS+QiSL6UPgnHAFKHDc7BzRTA2TjPIy8l5VljJlMhGcBRa88rk9WEn2ICUnPXAQ
         aG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C+MS/rLzegvRZFnaDUJAp+enUiI0lNSEcdyO2eVVcK8=;
        b=0wT3aN4Uh3qiy5QRLj2nHxJpG2CQ/5CO9Bx7TAXJLa5inyUdcCzMRQg1zTt3q3oxFA
         bgvkrHIwROwwq5VaIsV2jWll4p2+i2/yJjGCrpfYdDSS1tiLg7xToTgaCzVXcsfDQVwt
         ZAOt3VeNLi6wvo5ZA5b55g2YkdevPxwD/4GDlceHnBcrW5FA6DbhCCNJj9SdtuDkRmdX
         jSK6mztFIhzvi7jePYmjpxGpN3vwwRjYvpt4TwTm8Y3UhOqtuY9szUgeZmHdOg2beSZr
         fiPs5VzXgZKCdk5s+wFfpG7CsnVB/WwAnxlDCxjpZc8S8yttntDsMPs72zcHSxSrOHdB
         jzng==
X-Gm-Message-State: ACgBeo0D4dZl9V2vzx+Ezv4KMWZ66LkcDim0SZTcNcEFTt9NQDUK63yY
        +UZksfQAlFtDJMTMERLRuCUL/+C+ijVWf7b+8Fq9is7DIYVPkw==
X-Google-Smtp-Source: AA6agR7ckTj8b5QhYpebuLxLKt59X4YF2FXMEDbWQ6L1sRSUtKCxlaVrahea05qZGmgZmOqEIG6a6BAiIb8atqq4LWQ=
X-Received: by 2002:a05:6512:158b:b0:48b:38:cff8 with SMTP id
 bp11-20020a056512158b00b0048b0038cff8mr13497279lfb.100.1662266409662; Sat, 03
 Sep 2022 21:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220903161309.32848-1-apatel@ventanamicro.com>
 <20220903161309.32848-2-apatel@ventanamicro.com> <6ABE254E-C7DA-468B-9A6B-D10FF32E0E89@jrtc27.com>
In-Reply-To: <6ABE254E-C7DA-468B-9A6B-D10FF32E0E89@jrtc27.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Sun, 4 Sep 2022 10:09:57 +0530
Message-ID: <CAK9=C2U5MjF+qv9z=_cSS4iN66dCY_goF0D_-ujcPPG9VrReDw@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] RISC-V: Clear SIP bit only when using SBI IPI operations
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 1:46 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> ]On 3 Sept 2022, at 17:13, Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
> > S-mode but read-only for M-mode so we clear this bit only when using
> > SBI IPI operations.
>
> Uh, where is this specified? I don=E2=80=99t see that, and that would be =
odd.
> The spec clearly says that if supervisor software interrupts are
> implemented then the bit is writeable, with no caveats on when (beyond
> the permissions required to access the CSR in general).

For mip.MSIP, refer the below text from section 3.1.9 of the RISC-V privile=
ged
specification:

"MSIP is read-only in mip, and is written by accesses to memory-mapped
control registers, which are used by remote harts to provide machine-level
interprocessor interrupts."

For sip.SSIP, refer the below text from section 4.1.3 of the RISC-V privile=
ged
specification:

"If implemented, SSIP is writable in sip and may also be set to 1 by a
platform-specific interrupt controller."

>
> This patch does make sense for a different reason though: that IPIs may
> not be using software interrupts at all (in the IMSIC case).

Sure, let me help you understand this better.

The IPI support in Linux RISC-V does not assume any particular IPI
mechanism. In fact, we will be supporting multiple IPI mechanism in
Linux RISC-V and one of these will be selected at boot-time based
on platform capabilities:

1) Linux RISC-V NoMMU (M-mode) kernel will use IPIs provided by
the CLINT timer driver (refer, drivers/clocksource/timer-clint.c). This
mechanism uses the CLINT MMIO registers to update the state of
mip.MSIP bit. The M-mode kernel cannot directly modify the mip.MSIP
bit without going through the CLINT MMIO registers.

2) Linux RISC-V MMU (S-mode) kernel without IMSIC will use IPIs
provided by the SBI IPI calls (refer, arch/riscv/kernel/sbi.c). This
mechanism uses the SBI SEND_IPI call which sets the sip.SSIP
bit from M-mode firmware and kernel itself will clear sip.SSIP bit
after handling IPI on target HART.

3) Linux RISC-V MMU (S-mode) kernel with IMSIC will use IPIs
as software injected MSIs (refer,
https://github.com/avpatel/linux/blob/riscv_aia_v1/drivers/irqchip/irq-risc=
v-imsic.c).
This mechanism does not use "Software Interrupt" bits defined in
the mip/sip CSR. Instead IPIs are regular external interrupts injected
via IMSIC and imsic_handle_irq() of the IMSIC driver clears the
IPI pending through stopei CSR.

Currently, we were blindly clearing mip.[M|S]SIP bit in riscv_clear_ipi()
which is a common function for all three mechanisms above which
is not right considering the diversity in IPI mechanisms supported
by Linux RISC-V.

This patch moves the clearing of SSIP bit to SBI IPI code so that it is
only done for mechanism #2 (described above) and not done for
mechanisms #1 & #3 (described above).

Regards,
Anup

>
> Jess
>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> > arch/riscv/kernel/sbi.c | 8 +++++++-
> > arch/riscv/kernel/smp.c | 2 --
> > 2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 775d3322b422..fc614650a2e3 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct cpum=
ask *target)
> >       sbi_send_ipi(target);
> > }
> >
> > +static void sbi_ipi_clear(void)
> > +{
> > +     csr_clear(CSR_IP, IE_SIE);
> > +}
> > +
> > static const struct riscv_ipi_ops sbi_ipi_ops =3D {
> > -     .ipi_inject =3D sbi_send_cpumask_ipi
> > +     .ipi_inject =3D sbi_send_cpumask_ipi,
> > +     .ipi_clear =3D sbi_ipi_clear
> > };
> >
> > void __init sbi_init(void)
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index 760a64518c58..c56d67f53ea9 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
> > {
> >       if (ipi_ops && ipi_ops->ipi_clear)
> >               ipi_ops->ipi_clear();
> > -
> > -     csr_clear(CSR_IP, IE_SIE);
> > }
> > EXPORT_SYMBOL_GPL(riscv_clear_ipi);
> >
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
