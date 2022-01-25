Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252F49AC29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358400AbiAYGIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiAYGDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:03:08 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884F1C061744
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:21:16 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id n14so11527021vkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 20:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BVAMq9GRKYiZni2C1DYbJu82DtncqP/nDFyPD+aovCw=;
        b=e5CkqIGcdixXlWQEdLDqofUhbG7SDHyJUqj4Ax1VIBXZlMEIBv3ExR9f5IHBgGHdeU
         GNggMSsSfSRnAX7/mfN7VynjngrT2HeMmuueegIBVYFXnVl1a1UhY9AAbhv5QPc+dhZk
         /g28OpgWAezz67gU9k22USRpLb0DrNwcqJGwW7q/YFCPQEuNPMFDkF7kEzuwNzh5Gq05
         xFT43opxBeMP3gP3agQGQohJebV/m4C1rS4OvVaTCN0eVah8rlFINlYjPGB/9UaUfgQd
         V3caZVDXeegwzMnsUH1pwONeGwy4IMQuAomFb8Altt0ZvlGe+clKdwh94f0DcPJI+U8A
         7ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BVAMq9GRKYiZni2C1DYbJu82DtncqP/nDFyPD+aovCw=;
        b=leqvgVlJ+n6qIVkMF3UkHdt8FBZ0t2Co4OtAD7cWQ8ybuUJaE3LPf7ARYAkLLSfNEM
         pQouNnsEKBvyjPO7WHXRzoeTToxk4eXfHYZfa1H1eTcJEGBbeRxiN5BVGFkTGUU3Mef0
         wi6gfvaKsU7YNoVmH1199x0prr+BUelor/NpYMUp/znV3KUwxYfugty6eYhnNLhuGnJ5
         ejoCclUwOlfXy7OR89NudFqXXI+83s1JmNKT7X7AUe1oTSiiLH0/1AfId6RSWS64bfLs
         JeObNf+nsbx6PtzmfQREL/iOUO20vwZ/0BnlgwTBtR/Po7AV/GypE5cc8Ah4fdZKnOzr
         GNDg==
X-Gm-Message-State: AOAM531/XmLZ7EY1PocDMMCFBZqNlulPCVTGc23t2e/9C+x/E2DU8Gj/
        yKiYF7mhZZg+VG9LmyaVT9KssVBKfWKywuacsTziu5TapO5lMi57
X-Google-Smtp-Source: ABdhPJz2VrElZsxccwpEn/n75+2hy/f8HeARaOgFCMw6IouglGVvbMU33LG9o3Csl//Ri2h1KSsc6qaALyXLZTdoWEE=
X-Received: by 2002:a1f:a086:: with SMTP id j128mr7222321vke.17.1643084475611;
 Mon, 24 Jan 2022 20:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20211216125157.631992-1-chenhuacai@loongson.cn>
 <20211216125356.632067-1-chenhuacai@loongson.cn> <20211216125356.632067-2-chenhuacai@loongson.cn>
 <87pmpwwpw5.wl-maz@kernel.org> <CAAhV-H75SwqWiRjey_9MiRQtY-_Wjm7Tppx31XM8EfLDb_YUhQ@mail.gmail.com>
 <87czlrwk2k.wl-maz@kernel.org> <CAAhV-H6VFaRtiyhgq-vDQPUbiAtf9L1M6ZNyeApTu11O9JCXnw@mail.gmail.com>
 <87wnjuz5xr.wl-maz@kernel.org>
In-Reply-To: <87wnjuz5xr.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 25 Jan 2022 12:21:10 +0800
Message-ID: <CAAhV-H6P2xXutw8vz5xQp5bhs9AFtiLgDHQPHBDRc-sxjSnBtg@mail.gmail.com>
Subject: Re: [PATCH V8 02/10] irqchip/loongson-pch-pic: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Fri, Dec 24, 2021 at 5:51 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 24 Dec 2021 07:31:53 +0000,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Marc,
> >
> > On Mon, Dec 20, 2021 at 8:13 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Fri, 17 Dec 2021 04:45:24 +0000,
> > > Huacai Chen <chenhuacai@gmail.com> wrote:
> > > >
> > > > Hi, Marc,
> > > >
> > > > On Thu, Dec 16, 2021 at 11:06 PM Marc Zyngier <maz@kernel.org> wrot=
e:
> > > > >
> > > > > On Thu, 16 Dec 2021 12:53:48 +0000,
> > > > > Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > >
> > > > > > We are preparing to add new Loongson (based on LoongArch, not c=
ompatible
> > > > > > with old MIPS-based Loongson) support. LoongArch use ACPI other=
 than DT
> > > > > > as its boot protocol, so add ACPI init support.
> > > > > >
> > > > > > PCH-PIC/PCH-MSI stands for "Interrupt Controller" that describe=
d in
> > > > > > Section 5 of "Loongson 7A1000 Bridge User Manual". For more inf=
ormation
> > > > > > please refer Documentation/loongarch/irq-chip-model.rst.
> > > > > >
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > ---
> > > > > >  drivers/irqchip/irq-loongson-pch-pic.c | 108 +++++++++++++++++=
+-------
> > > > > >  1 file changed, 81 insertions(+), 27 deletions(-)
> > > > >
> > > > > [...]
> > > > >
> > > > > >
> > > > > > +#ifdef CONFIG_ACPI
> > > > > > +
> > > > > > +struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent=
,
> > > > > > +                                     struct acpi_madt_bio_pic =
*acpi_pchpic)
> > > > >
> > > > > Who is calling this? This works the opposite way from what the ar=
m64
> > > > > irqchips are doing. Why? I have the ugly feeling that this is cal=
led
> > > > > from the arch code, bypassing the existing infrastructure...
> > > > Yes, this is called from the arch code and a bit ugly, but I can't
> > > > find a better way to do this.
> > > >
> > > > Is the "existing infrastructure" declare the irqchip init function
> > > > with  IRQCHIP_ACPI_DECLARE and the arch code only need to call
> > > > irqchip_init()? Then we have a problem: our irqchips have a 4 level
> > > > hierachy and the parent should be initialized before its children. =
In
> > > > FDT world this is not a problem, because of_irq_init() will sort
> > > > irqchip drivers to ensure the right order. But in ACPI world,
> > > > acpi_probe_device_table just call init functions in the linking ord=
er.
> > > > If we want to control the order, it seems we can only sort the driv=
ers
> > > > in drivers/irq/Makefile. But I don't think this is a good idea...
> > > >
> > > > If there are better solutions, please let me know. Thanks.
> > >
> > > We have the exact same thing on the arm64 side, and we don't need of
> > > this to be arch specific:
> > >
> > > - The MADT table describes the root interrupt controller, and it is
> > >   probed via IRQCHIP_ACPI_DECLARE().
> > >
> > > - Each children controller is declared in ACPI as a *device*, and is
> > >   both an interrupt producer and an interrupt consumer. Normal probe
> > >   deferral rules apply. See irq-mbigen.c for an example of how this i=
s
> > >   done.
> > Thank you for your suggestions, I have tried but failed. It seems
> > there are some differences between irq-mbigen.c and our irqchips.
> > Because our irqchips are mandatory while mbigen is optional.
>
> The fact that this is optional has nothing to do with it. On a system
> that requires mbigen to boot (both mass storage and networking are
> hanging off it), there is a guarantee that the probe order will
> respect the resource dependency.
>
> And if that's not enough, -EPROBE_DEFER is your friend, always.
>
> > If we declare our irqchips as devices, they are initialized in the
> > initcall phase, which is too late for pci devices.
>
> This suggests that your PCIe driver is either not enforcing the
> dependencies on the interrupt controller (bad), or that the core code
> is not made aware of the dependencies (equally bad).
>
> In any case, this needs sorting, because a new architecture should be
> able to boot without resorting to handcrafted dependencies that will
> inevitably result in a larger pile of hacks over time. It is much
> easier to solve it before day-1.

Sorry for the long delay, but we still failed.

- There are several kinds of irq chips(e.g. pchpic=E3=80=81eiointc=E3=80=81=
cpuintc)
for LoongArch. SCI interrupt (Fixed hardware is implemented for
LoongArch in pch such as LS7A1000, and SCI interrupt is used for fixed
event handling.) is an irq input of pch irq chip which routes
interrupts to cpu as following irq chips path:

sci interrupt->|pchpic| ->|eiointc|->|cpuintc|

sci_interrupt will be transferred from gsi to irq through
acpi_gsi_to_irq in acpi_enable_subsystem called from acpi_bus_init
before acpi_scan_init where acpi device namespace is created, so we
should build pch irq domain and related upstream irq domains before
acpi_bus_init.

- PCI bus enumeration is executed from acpi_scan_init, and
pci_set_msi_domain will be called for setting msi_domain of enumerated
pci device. In pci_set_msi_domain, msi domain may be got through
pcibios_device_add, fdt, iort(used for arm64) or inheriting from host
bridge domain. And in each way, the msi domain needs to be found by
calling irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI) to match
one from the registered msi domain before. So we build the msi domain
as x86 and arm64 before acpi_scan_init. The msi domain is hierarchic
as following:

msi interrupt->|msipic| ->|eiointc|->|cpuintc|

- Yes, a driver can be deferred probed when get -EPROBE_DEFER on
probing, but both sci interrupt transfer and pci bus enumeration are
common code (not private driver for LoongArch).

So, declaring pic devices in DSDT for seems not suitable, we can only
select the X86-like way which is a bit ugly.

Huacai

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
