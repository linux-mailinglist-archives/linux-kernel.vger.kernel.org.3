Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB62577698
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiGQOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGQOIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A78A13E35
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D853611FA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086BDC341C0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658066903;
        bh=kqjy2M0sfvu/znr0s/7jq6FyGkpAU3MVfKEHp3dOWTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hw6DQFCgo7mXtNuvJFNubMeDgOiFI9ZZ+/b6krl0vFlA+fmPHbdND9RoJfv8FbFic
         YyhIvtJ2vmwGYC0vuaQGEbhpVPhSuZtNTZNMLjoS6bzS+cN1LJJ3/azOmNURhnjkJm
         606t2nxxsQbf/U6zZ0omvRaFh+y+a/gysqduAP/TjUIJW65BSgYC7krq4SE4yDdjW2
         zy3t232DpVIrXJUTz3I7g6L5OQf+eAltvitpNVt40MwOQ6cyKf0I7Gkxx66wMTFp2P
         0bvCZpRpZD/MGvaRGWjnFpvi8sO04LBpR4wODWSovB/v12MGG+pyAh57QciyS3tg0M
         bJBYhpyBVGgUQ==
Received: by mail-ua1-f53.google.com with SMTP id t21so4322142uaq.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:08:22 -0700 (PDT)
X-Gm-Message-State: AJIora/MrKAj8i3RbTII8KUHr8XdsPmSpDr0kM1fIUq0nTSS5RmNl31c
        AeeL2e2KV5g7T7ssLz0QuR9XKEGNX+vGmFDQqTo=
X-Google-Smtp-Source: AGRyM1vP1r+UwliYXMIkAfw8PDx2rqu2B1uP4KbzclIbVvVtfhLS6hiOfz5Dqytc4NMmLcJxSIJmNp9Z/dcr6kFcIYI=
X-Received: by 2002:ab0:1393:0:b0:383:26e8:7bf3 with SMTP id
 m19-20020ab01393000000b0038326e87bf3mr8259258uae.22.1658066901953; Sun, 17
 Jul 2022 07:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <87less52bx.wl-maz@kernel.org> <6e9def1e-31fe-787d-1b2b-a328424352f0@loongson.cn>
 <87ilnw3vlg.wl-maz@kernel.org> <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
In-Reply-To: <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 17 Jul 2022 22:08:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6CJ-aF2s9D4QJ5zYZGt_=C4QHFCzKByT6urcFMgWv+4g@mail.gmail.com>
Message-ID: <CAAhV-H6CJ-aF2s9D4QJ5zYZGt_=C4QHFCzKByT6urcFMgWv+4g@mail.gmail.com>
Subject: Re: [PATCH V15 00/15] irqchip: Add LoongArch-related irqchip drivers
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc, Jianmin,

On Sun, Jul 17, 2022 at 7:29 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/7/17 =E4=B8=8B=E5=8D=886:02, Marc Zyngier wrote:
> > On Sun, 17 Jul 2022 02:06:12 +0100,
> > Jianmin Lv <lvjianmin@loongson.cn> wrote:
> >>
> >>
> >>
> >> On 2022/7/17 =E4=B8=8A=E5=8D=882:39, Marc Zyngier wrote:
> >>> On Fri, 15 Jul 2022 08:05:36 +0100,
> >>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
> >>>>
> >>>> LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
> >>>> LoongArch includes a reduced 32-bit version (LA32R), a standard 32-b=
it
> >>>> version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as i=
ts
> >>>> boot protocol LoongArch-specific interrupt controllers (similar to A=
PIC)
> >>>> are already added in the ACPI Specification 6.5(which may be publish=
ed in
> >>>> early June this year and the board is reviewing the draft).
> >>>>
> >>>> Currently, LoongArch based processors (e.g. Loongson-3A5000) can onl=
y
> >>>> work together with LS7A chipsets. The irq chips in LoongArch compute=
rs
> >>>> include CPUINTC (CPU Core Interrupt Controller), LIOINTC (Legacy I/O
> >>>> Interrupt Controller), EIOINTC (Extended I/O Interrupt Controller),
> >>>> HTVECINTC (Hyper-Transport Vector Interrupt Controller), PCH-PIC (Ma=
in
> >>>> Interrupt Controller in LS7A chipset), PCH-LPC (LPC Interrupt Contro=
ller
> >>>> in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> >>>
> >>> [...]
> >>>
> >>> Compiling this series for loongarch with loongson3_defconfig on top o=
f
> >>> 5.19-rc3 results in the following:
> >>>
> >>> loongarch64-linux-ld: drivers/irqchip/irq-loongson-eiointc.o: in func=
tion `.L60':
> >>> irq-loongson-eiointc.c:(.init.text+0x4c): undefined reference to `pch=
_msi_acpi_init'
> >>> loongarch64-linux-ld: drivers/irqchip/irq-loongson-htvec.o: in functi=
on `pch_msi_parse_madt':
> >>> irq-loongson-htvec.c:(.init.text+0x14): undefined reference to `pch_m=
si_acpi_init'
> >>> make: *** [Makefile:1164: vmlinux] Error 1
> >>>
> >>> I *really* would have expected this series to be in a better shape
> >>> after over 15 rounds, but it looks like I'm expecting too much. I
> >>> haven't investigated the breakage, but this should (at the very least=
)
> >>> pass the defconfig test and optional drivers not being selected.
> >>>
> >>> The corresponding MIPS configuration seems to build fine.
> >>>
> >>>     M.
> >>>
> >>
> >> Hi, Marc
> >>
> >> Sorry for that first, pch_msi_acpi_init is defined in pch_msi driver
> >> which is compiled depend on CONFIG_PCI, and I test the patches each
> >> time with PCI patches and other(or else, kernel can not be boot), so
> >> I'm ok for testing the patches. The PCI patches has been accepted by
> >> PCI maintainers and will be merged in this merge window.
> >
> > But each series *must* at the very least compile in isolation.
> >
> >>
> >> I don't know how to deal with this situation. Should I add *#ifdef
> >> CONFIG_PCI* at position of calling pch_msi_acpi_init or some other
> >> way?
> >
> > You could try something like this, which results in a kernel that
> > fully links with defconfig and no additional patch:
> >
> > diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/=
asm/irq.h
> > index ca468564fc85..4479d95867ec 100644
> > --- a/arch/loongarch/include/asm/irq.h
> > +++ b/arch/loongarch/include/asm/irq.h
> > @@ -99,8 +99,17 @@ int htvec_acpi_init(struct irq_domain *parent,
> >                                       struct acpi_madt_ht_pic *acpi_htv=
ec);
> >   int pch_lpc_acpi_init(struct irq_domain *parent,
> >                                       struct acpi_madt_lpc_pic *acpi_pc=
hlpc);
> > +#if IS_ENABLED(CONFIG_LOONGSON_PCH_MSI)
> >   int pch_msi_acpi_init(struct irq_domain *parent,
> > -                                     struct acpi_madt_msi_pic *acpi_pc=
hmsi);
> > +                   struct acpi_madt_msi_pic *acpi_pchmsi);
> > +#else
> > +static inline int pch_msi_acpi_init(struct irq_domain *parent,
> > +                                 struct acpi_madt_msi_pic *acpi_pchmsi=
)
> > +{
> > +     return 0;
> > +
> > +}
> > +#endif
> >   int pch_pic_acpi_init(struct irq_domain *parent,
> >                                       struct acpi_madt_bio_pic *acpi_pc=
hpic);
> >   int find_pch_pic(u32 gsi);
> >
>
> Ok, thanks, I'll add this into that patch.
>
>
> > But the other issue is that you seem to call this function from two
> > different locations. This cannot be right, as there should be only one
> > probe order, and not multiple.
> >
>
> As we described two IRQ models(Legacy and Extended) in this cover
> letter, the parent domain of MSI domain can be htvec domain(Legacy) or
> eiointc domain(Extended). In MADT, only one APIC(HTPIC for htvec or
> EIOPIC for eiointc) is allowed to pass into kernel, and then in the
> irqchip driver, only one kind APIC of them can be parsed from MADT, so
> we have to support two probe order for them.

I have an idea but I don't know whether it is acceptable: Marc gives
an Acked-by for the whole series, then this irqchip series goes
through the loongarch tree together with the PCI patches, then we
don't need other hacks except the ACPI definitions.

Huacai
>
> >       M.
> >
>
>
