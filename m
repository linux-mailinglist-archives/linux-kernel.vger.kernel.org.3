Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF94BC879
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 14:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiBSNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 08:04:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiBSNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 08:04:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0549F8E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 05:03:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id f3so18861535wrh.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 05:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xt347mLimiyCriqepYPm5hTYnZWiY7Hkr7OzAlrAYKI=;
        b=o7nlV+f3xWUtte87tViOiw8Bkgi1LVZqvdjfkBMM+AvIuDeAW7ewWpJpfAtJJ7Zznh
         iDZJbU7yLco8MES7Se1bpuVtNyCgniucZ+buUYyBtemKUEgAm+LAwGRZzZ+0y6yNwLWX
         8LKp3BdUFsYIMZZPgxwPE30UODAgDjul9Qc0GLjE1cwI0T1m/Cj7bW1dkLToxM4pTWhD
         Dhaqzn/WwFJOYBPlVc5Z6YDI1GpJNCZjEnEunPXEwDM0K3up4RJ11Mob1l3ASK4QBfUQ
         D61gzZXheBS+JTAxZeA2vA6NE3R6tWvQyp4hJDZP3aDqpDttnqFN+d7h1g67Szw0od/L
         ztoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xt347mLimiyCriqepYPm5hTYnZWiY7Hkr7OzAlrAYKI=;
        b=ZDmyap0/JaJ3dtYnqwlDp2tk2lUj2TulkNa1EvLj6EaQF/Ut1Q+LHxMogTMGZqLgAE
         2J4cZhRrmYuvmewQBduks/szWFcqreY4NBGAsv5d7j27Ec8+N+/R62ytwLqjNwwiuv5e
         QkwUnkGQ6BV9zgxJgXlorTWF6UkKnWF/ewS6nS+PXMaAdL9k/5DKIQmJOCAVWuQvvRfY
         N5E7qDrzceZbxXz6FYjHjg5qBjsGhtu0MlqOFA7tCRznl7uW213ZQQduM71qfgWV/Z9Y
         xJ4Nl8HvrXQA5Xu0r/LVXc78/CYSeEewp5uSrOZfmUVwmj0Id4gX2Dabo9nYvzp2Ctdg
         xu8w==
X-Gm-Message-State: AOAM5300KOGc4LlEzDdR74MHDgQ+8y9fGz1nTZEAoAd1SauyqbawtxGj
        b+bPCvvhzk7gNj4UNFuID/f1PgCQptaAHIPAgAHEiQ==
X-Google-Smtp-Source: ABdhPJx+/uT24Y0y1TFlDPUibFVWD8idICZvsFz63xvRmW+ySDjyRge4XGQuVXinT3FiktMPBRwy7UBJ2xcrq4znbEc=
X-Received: by 2002:adf:b645:0:b0:1e3:bab:7594 with SMTP id
 i5-20020adfb645000000b001e30bab7594mr9241465wre.346.1645275828602; Sat, 19
 Feb 2022 05:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20220128052505.859518-1-apatel@ventanamicro.com>
 <20220128052505.859518-3-apatel@ventanamicro.com> <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
 <CAAhSdy387r314f=YjvXJCxqxkvjm5q-EBOVu420giFzaVr_NYw@mail.gmail.com> <31fea18e51a5021b79adb17973f9528e@kernel.org>
In-Reply-To: <31fea18e51a5021b79adb17973f9528e@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 19 Feb 2022 18:33:37 +0530
Message-ID: <CAAhSdy0jTTDzoc+3T_8uLiWfBN3AFCWj99Ayc-Yh8FBfzUY2sQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named fwnode
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 3:02 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-02-19 03:38, Anup Patel wrote:
> > On Thu, Feb 17, 2022 at 8:42 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On 2022-01-28 05:25, Anup Patel wrote:
> >> > We should create INTC domain using a synthetic fwnode which will allow
> >> > drivers (such as RISC-V SBI IPI driver, RISC-V timer driver, RISC-V
> >> > PMU driver, etc) not having dedicated DT/ACPI node to directly create
> >> > interrupt mapping for standard local interrupt numbers defined by the
> >> > RISC-V privileged specification.
> >> >
> >> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> > ---
> >> >  arch/riscv/include/asm/irq.h      |  2 ++
> >> >  arch/riscv/kernel/irq.c           | 13 +++++++++++++
> >> >  drivers/clocksource/timer-clint.c | 13 +++++++------
> >> >  drivers/clocksource/timer-riscv.c | 11 ++---------
> >> >  drivers/irqchip/irq-riscv-intc.c  | 12 ++++++++++--
> >> >  drivers/irqchip/irq-sifive-plic.c | 19 +++++++++++--------
> >> >  6 files changed, 45 insertions(+), 25 deletions(-)
> >> >
> >> > diff --git a/arch/riscv/include/asm/irq.h
> >> > b/arch/riscv/include/asm/irq.h
> >> > index e4c435509983..f85ebaf07505 100644
> >> > --- a/arch/riscv/include/asm/irq.h
> >> > +++ b/arch/riscv/include/asm/irq.h
> >> > @@ -12,6 +12,8 @@
> >> >
> >> >  #include <asm-generic/irq.h>
> >> >
> >> > +extern struct fwnode_handle *riscv_intc_fwnode(void);
> >> > +
> >> >  extern void __init init_IRQ(void);
> >> >
> >> >  #endif /* _ASM_RISCV_IRQ_H */
> >> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> >> > index 7207fa08d78f..f2fed78ab659 100644
> >> > --- a/arch/riscv/kernel/irq.c
> >> > +++ b/arch/riscv/kernel/irq.c
> >> > @@ -7,9 +7,22 @@
> >> >
> >> >  #include <linux/interrupt.h>
> >> >  #include <linux/irqchip.h>
> >> > +#include <linux/irqdomain.h>
> >> > +#include <linux/module.h>
> >> >  #include <linux/seq_file.h>
> >> >  #include <asm/smp.h>
> >> >
> >> > +static struct fwnode_handle *intc_fwnode;
> >> > +
> >> > +struct fwnode_handle *riscv_intc_fwnode(void)
> >> > +{
> >> > +     if (!intc_fwnode)
> >> > +             intc_fwnode = irq_domain_alloc_named_fwnode("RISCV-INTC");
> >> > +
> >> > +     return intc_fwnode;
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(riscv_intc_fwnode);
> >>
> >> Why is this created outside of the root interrupt controller driver?
> >> Furthermore, why do you need to create a new fwnode the first place?
> >> As far as I can tell, the INTC does have a node, and what you don't
> >> have is the firmware linkage between PMU (an others) and the INTC.
> >
> > Fair enough, I will update this patch to not create a synthetic fwnode.
> >
> > The issue is not with INTC driver. We have other drivers and places
> > (such as SBI IPI driver, SBI PMU driver, and KVM RISC-V AIA support)
> > where we don't have a way to locate INTC fwnode.
>
> And that's exactly what I am talking about: The INTC is OK (sort of),
> but the firmware is too crap for words, and isn't even able to expose
> where the various endpoints route their interrupts to.

The firmware is always present at a higher privilege-level hence there
is no DT node to discover the presence of firmware. The local interrupts
used by the firmware for IPI, Timer and PMU are defined by the RISC-V
ISA specification.

>
> Yes, this is probably fine today because you can describe the topology
> of RISC-V systems on the surface of a post stamp. Once you get to the
> complexity of a server-grade SoC (or worse, a mobile phone style SoC),
> this *implicit topology* stuff doesn't fly, because there is no
> guarantee
> that all endpoints will always all point to the same controller.

The local interrupts (per-CPU) are always managed by the INTC. The
interrupt controllers to manage device interrupts (such as PLIC) can
vary from platform to platform and have INTC as the parent domain.

We already have high-end interrupt controllers (such as AIA) under
development which are scalable for server-grade SoC, mobile SoC
and various other types of SoCs.

We are able to describe the topology of different types of interrupt
controllers (PLIC as well as AIA) in DT.

The only issue is for drivers which do not have dedicated DT node
(such as SBI IPI, SBI Timer, SBI PMU, or KVM RISC-V) but the
upside is that local interrupt numbers used by these drivers is
clearly defined by the RISC-V ISA specification:

Here are the local interrupts defined by the RISC-V ISA spec:
IRQ13 => PMU overflow interrupt (used by SBI PMU driver)
IRQ12 => S-mode guest external interrupt (to be used by KVM RISC-V)
IRQ11 => M-mode external interrupt (used by firmware)
IRQ9  => S-mode external interrupt (used by PLIC driver)
IRQ7  => M-mode timer interrupt
IRQ5  => S-mode timer interrupt (used by SBI Timer driver)
IRQ3  => M-mode software interrupt (used by firmware)
IRQ1 =>  S-mode software interrupt (used by SBI IPI driver)

>
> >> what you should have instead is something like:
> >>
> >> static struct fwnode_handle *(*__get_root_intc_node)(void);
> >> struct fwnode_handle *riscv_get_root_intc_hwnode(void)
> >> {
> >>          if (__get_root_intc_node)
> >>                  return __get_root_intc_node();
> >>
> >>          return NULL;
> >> }
> >>
> >> and the corresponding registration interface.
> >
> > Thanks, I will follow this suggestion. This is a much better approach
> > and it will avoid touching existing drivers.
> >
> >>
> >> But either way, something breaks: the INTC has one node per CPU, and
> >> expect one irqdomain per CPU. Having a single fwnode completely breaks
> >> the INTC driver (and probably the irqdomain list, as we don't check
> >> for
> >> duplicate entries).
> >>
> >> > diff --git a/drivers/irqchip/irq-riscv-intc.c
> >> > b/drivers/irqchip/irq-riscv-intc.c
> >> > index b65bd8878d4f..26ed62c11768 100644
> >> > --- a/drivers/irqchip/irq-riscv-intc.c
> >> > +++ b/drivers/irqchip/irq-riscv-intc.c
> >> > @@ -112,8 +112,16 @@ static int __init riscv_intc_init(struct
> >> > device_node *node,
> >> >       if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
> >> >               return 0;
> >> >
> >> > -     intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
> >> > -                                         &riscv_intc_domain_ops, NULL);
> >> > +     /*
> >> > +      * Create INTC domain using a synthetic fwnode which will allow
> >> > +      * drivers (such as RISC-V SBI IPI driver, RISC-V timer driver,
> >> > +      * RISC-V PMU driver, etc) not having dedicated DT/ACPI node to
> >> > +      * directly create interrupt mapping for standard local interrupt
> >> > +      * numbers defined by the RISC-V privileged specification.
> >> > +      */
> >> > +     intc_domain = irq_domain_create_linear(riscv_intc_fwnode(),
> >> > +                                            BITS_PER_LONG,
> >> > +                                            &riscv_intc_domain_ops, NULL);
> >>
> >> This is what I'm talking about. It is simply broken. So either you
> >> don't
> >> need a per-CPU node (and the DT was bad the first place), or you
> >> absolutely need
> >> one (and the whole 'well-known/default domain' doesn't work at all).
> >>
> >> Either way, this patch is plain wrong.
> >
> > Okay, I will update this patch with the new approach which you
> > suggested.
>
> But how do you plan to work around the fact that everything is currently
> build around having a node (and an irqdomain) per CPU? The PLIC, for
> example,
> clearly has one parent per CPU, not one global parent.
>
> I'm sure there was a good reason for this, and I suspect merging the
> domains
> will simply end up breaking things.

We can have multiple PLIC instances in a platform and each PLIC
instance targets a subset of CPUs. Further, each PLIC instance has
multiple PLIC contexts for associated CPUs.

The per-CPU INTC DT nodes and the "interrupts-extended" DT
property of PLIC DT node helps us describe the association
between various PLIC contexts and CPUs.

Here's an example PLIC DT node:

    plic: interrupt-controller@c000000 {
      #address-cells = <0>;
      #interrupt-cells = <1>;
      compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
      interrupt-controller;
      interrupts-extended = <&cpu0_intc 11>,
                            <&cpu1_intc 11>, <&cpu1_intc 9>,
                            <&cpu2_intc 11>, <&cpu2_intc 9>,
                            <&cpu3_intc 11>, <&cpu3_intc 9>,
                            <&cpu4_intc 11>, <&cpu4_intc 9>;
      reg = <0xc000000 0x4000000>;
      riscv,ndev = <10>;
    };

In above above example, PLIC has 9 contexts and context
to CPU connections are as follows:
PLIC context0 => CPU0 M-mode external interrupt
PLIC context1 => CPU1 M-mode external interrupt
PLIC context2 => CPU1 S-mode external interrupt
PLIC context3 => CPU2 M-mode external interrupt
PLIC context4 => CPU2 S-mode external interrupt
....

This is just one example and we can describe any kind of
PLIC context to CPU connections using "interrupts-extended"
DT property.

The same level of flexibility is provided by AIA interrupt
controllers which are under development.

Regards,
Anup

>
>          M.
> --
> Jazz is not dead. It just smells funny...
