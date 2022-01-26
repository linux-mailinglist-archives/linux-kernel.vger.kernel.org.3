Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2823149CEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbiAZPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbiAZPjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:39:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72644C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:39:03 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso91073wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHxS+DJpUBFAAnV+u0ez1J+tivPxC9xjAyNBWfmM5Zk=;
        b=sMUA35AhONrC/tVISWC7DrvY6paq2NRV6Q1z8YYDO7FDgmU5fxZI5UOZ6deD1tCz8F
         C+OaaLF33jhqsx/525tqOqAzy6q33TNOBsZ4GUrRXE1I/Q1wB3+jEXDd5R8WYV7U+8ZJ
         Q1BmpwaiSDfTWv4cs7bHuNbucFwBNpg8SqMxq6NgGAv6CGgZBpbTklZFujfEPIKQaN94
         YxphirkSC/YtvnFtAAEbHwa51TbtoQRZOfrobJjPW6u8ryeO3e7b8xW6P63bJHcjhP99
         F6r1sgcYhkA1MarTsDqGBWSD3l1QWK+E6KO4rbMwvfT2PEMXoac9xTaG06b8lwpSJtC0
         /uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHxS+DJpUBFAAnV+u0ez1J+tivPxC9xjAyNBWfmM5Zk=;
        b=eFasYmKUk8xh6UeSP0pAwPIFScbIEnMPY6lsMaPwjZfyLkDODi/QWuL9iZS3O29TCv
         QyyO39W4i+fDBz9VgAy4qh3T8F8uIKPdEf55jYQIaKlZVhuyhTitx1CCTM23Z+/pynyg
         WhfSQwXChZYiU//pvmyc+HIjF1nwahmpcu1QhD2387bL5gj+xzj419VwdrGEZ1Q3CM3i
         t9w81sZlVdCC0/AQqCuST2I3FdX3Cdemb9ezTGg63qknm3hnE7Z9oIbhqIzh/avDeFP1
         NKtlq1Osp5oXPBOkVxqXnun3xwCooi9r7X4y+JntCuxHMi9Q8aECpan+lHUaYSlyjl2b
         7nDg==
X-Gm-Message-State: AOAM531bb30dD3mTaa5uZ4NGDnAcSNmVB18YM9o6c1v6htcym49xyvpi
        M4SSaLGdun3VhAklkn+EMoVSr2LtxTBkLe2/2H55aw==
X-Google-Smtp-Source: ABdhPJzJj/I98aySS2nD1osu2R5yO/TDDcW51ihId1siNsdmg9fh8t8M9FY9DvqOLpkOP1NOz2zK/2iEge2uXXROPs8=
X-Received: by 2002:a05:600c:3392:: with SMTP id o18mr7972026wmp.59.1643211541722;
 Wed, 26 Jan 2022 07:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20220125054217.383482-1-apatel@ventanamicro.com>
 <20220125054217.383482-3-apatel@ventanamicro.com> <87lez37k8h.wl-maz@kernel.org>
 <CAAhSdy0NrB4Q-mYtMH_HCtbfm5OXi-cxXhiu1AxKdCkTv4cskQ@mail.gmail.com>
 <87ilu67tvw.wl-maz@kernel.org> <CAK9=C2Xi60XqzPxTOO+gT3B+-1v4i0QT-9nkhN7hLFX9SchQng@mail.gmail.com>
 <87fspa7p0e.wl-maz@kernel.org>
In-Reply-To: <87fspa7p0e.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 26 Jan 2022 21:08:49 +0530
Message-ID: <CAAhSdy3Pb2JTYnughe+cK0C0kNUqG7vnzZMi+EHpKJs_hZ2Gjg@mail.gmail.com>
Subject: Re: [PATCH 2/6] irqchip/riscv-intc: Set intc domain as the default host
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 4:17 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 26 Jan 2022 10:12:25 +0000,
> Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > On Wed, Jan 26, 2022 at 2:31 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 26 Jan 2022 03:16:55 +0000,
> > > Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Tue, Jan 25, 2022 at 11:47 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Tue, 25 Jan 2022 05:42:13 +0000,
> > > > > Anup Patel <apatel@ventanamicro.com> wrote:
> > > > > >
> > > > > > We have quite a few RISC-V drivers (such as RISC-V SBI IPI driver,
> > > > > > RISC-V timer driver, RISC-V PMU driver, etc) which do not have a
> > > > > > dedicated DT/ACPI fwnode. This patch makes intc domain as the default
> > > > > > host so that these drivers can directly create local interrupt mapping
> > > > > > using standardized local interrupt numbers
> > > > > >
> > > > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > > > ---
> > > > > >  drivers/clocksource/timer-riscv.c | 17 +----------------
> > > > > >  drivers/irqchip/irq-riscv-intc.c  |  9 +++++++++
> > > > > >  2 files changed, 10 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > > > > > index 1767f8bf2013..dd6916ae6365 100644
> > > > > > --- a/drivers/clocksource/timer-riscv.c
> > > > > > +++ b/drivers/clocksource/timer-riscv.c
> > > > > > @@ -102,8 +102,6 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
> > > > > >  static int __init riscv_timer_init_dt(struct device_node *n)
> > > > > >  {
> > > > > >       int cpuid, hartid, error;
> > > > > > -     struct device_node *child;
> > > > > > -     struct irq_domain *domain;
> > > > > >
> > > > > >       hartid = riscv_of_processor_hartid(n);
> > > > > >       if (hartid < 0) {
> > > > > > @@ -121,20 +119,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> > > > > >       if (cpuid != smp_processor_id())
> > > > > >               return 0;
> > > > > >
> > > > > > -     domain = NULL;
> > > > > > -     child = of_get_compatible_child(n, "riscv,cpu-intc");
> > > > > > -     if (!child) {
> > > > > > -             pr_err("Failed to find INTC node [%pOF]\n", n);
> > > > > > -             return -ENODEV;
> > > > > > -     }
> > > > > > -     domain = irq_find_host(child);
> > > > > > -     of_node_put(child);
> > > > > > -     if (!domain) {
> > > > > > -             pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
> > > > > > -             return -ENODEV;
> > > > > > -     }
> > > > > > -
> > > > > > -     riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
> > > > > > +     riscv_clock_event_irq = irq_create_mapping(NULL, RV_IRQ_TIMER);
> > > > > >       if (!riscv_clock_event_irq) {
> > > > > >               pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
> > > > > >               return -ENODEV;
> > > > > > diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> > > > > > index b65bd8878d4f..9f0a7a8a5c4d 100644
> > > > > > --- a/drivers/irqchip/irq-riscv-intc.c
> > > > > > +++ b/drivers/irqchip/irq-riscv-intc.c
> > > > > > @@ -125,6 +125,15 @@ static int __init riscv_intc_init(struct device_node *node,
> > > > > >               return rc;
> > > > > >       }
> > > > > >
> > > > > > +     /*
> > > > > > +      * Make INTC as the default domain which will allow drivers
> > > > > > +      * not having dedicated DT/ACPI fwnode (such as RISC-V SBI IPI
> > > > > > +      * driver, RISC-V timer driver, RISC-V PMU driver, etc) can
> > > > > > +      * directly create local interrupt mapping using standardized
> > > > > > +      * local interrupt numbers.
> > > > > > +      */
> > > > > > +     irq_set_default_host(intc_domain);
> > > > >
> > > > > No, please. This really is a bad idea. This sort of catch-all have
> > > > > constantly proven to be a nuisance, because they discard all the
> > > > > topology information. Eventually, you realise that you need to know
> > > > > where this is coming from, but it really is too late.
> > > > >
> > > > > I'd rather you *synthesise* a fwnode (like ACPI does) rather then do
> > > > > this.
> > > >
> > > > In absence of INTC as the default domain, currently we have various
> > > > drivers looking up INTC irq_domain from DT (or ACPI). This is quite a
> > > > bit of duplicate code across various drivers.
> > > >
> > > > How about having a irq_domain lookup routine (riscv_intc_find_irq_domain())
> > > > exported by the RISC-V INTC driver or arch/riscv ?
> > > > OR
> > > > Do you have an alternative suggestion ?
> > >
> > > But *why* don't you provide an interrupt controller node for DT? I
> > > really don't think that's outlandish to require.
> >
> > Historically, all RISC-V SBI related drivers never had any DT/ACPI
> > node because we can always query/discover the SBI functionality
> > at runtime.
> >
> > The mechanism to query/discover SBI IPI, Timer and PMU is
> > through SBI base functions. Also, local interrupts used by these
> > drivers are specified by the RISC-V specification. This means having
> > a DT/ACPI node for these drivers doesn't provide any info.
> >
> > We will be having KVM RISC-V AIA support in future which will not
> > have a DT/ACPI node as well because this can be discovered as a
> > CPU capability and the local interrupt to be used is specified by the
> > RISC-V hypervisor specification.
> >
> > >
> > > For ACPI, we already have an interface that allows a fwnode to be
> > > registered (acpi_set_irq_model) and interrupts mapped
> > > (acpi_register_gsi).
> >
> > The ACPI specification being proposed for RISC-V does not have
> > any details for SBI IPI, Timer, and PMU for the same reasons
> > mentioned above.
>
> Neither does it on the other architectures.
>
> And yet we are able to synthesise fwnodes and use the whole of the
> infrastructure as intended without having to resort to this crap that
> was only introduced to cope with 20 year old PPC board files.
>
> Only dead architectures are using irq_set_default_host().

Okay, I will drop the idea of using irq_set_default_host() in INTC driver.

>
> >
> > >
> > > You should already have all the required tools you need.
> >
> > Are you okay if arch/riscv exports riscv_intc_find_irq_domain() ?
> > OR
> > Maybe export riscv_intc_find_irq_domain() from INTC driver ?
>
> Neither. That's just papering over the core problem.
>
> Either you start creating fwnodes out of thin air, which is what we do
> for both x86 and arm64 when using ACPI, or you add support for SBI (or
> whatever new spec the RISC-V people come up with) as a provider of
> fwnodes.
>
> Anything else looks like a pretty bad regression.

Actually, SBI spec has been used for quite a few years in RISC-V now.
It can be compared with the ARM PSCI spec so it's not a HW description
format like DT or ACPI.

How about arch/riscv creating an exported riscv_intc_fwnode ?
(This riscv_intc_fwnode can be used by various drivers to obtain
the INTC irq_domain)

Regards,
Anup

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
