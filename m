Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEA24616C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbhK2NlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377872AbhK2NjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:39:14 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CAC061373
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:18:23 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id n6so33569885uak.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6AJSyYmOE29Kis57XXwB/KAGNXo+najMwXcREnkLC4U=;
        b=TWXuZvzWkc7VoPtSMPStGQoZ+6leV7j4oi/ye5d4MdJIyKWDfTwazePeiK8CFjHYBD
         Giu1VUMZeRib5z0LyXSzihVOmzZzCn93J1wjIp9ntyqSAKG47xIdod1PLE2IEjqR1l9j
         X6f1jshcWdjio1wO1GSoxr+hkcSesxmpTotiHCtUqS0UxcgB8PETkL6Z+mPdajQ9b5I4
         15FORIXl2nAKg5oOLFucvP6jw0O+1q38n3bJ2qzGmWPQHpgpwMzOXT4F+CgvmQU0s5We
         MnjPLSGiaLvB0kzEpkupePvD4PCXvEEu5EY71ZRAaAbZBe7aF/J1GO5hU9HfkYryGisX
         E/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6AJSyYmOE29Kis57XXwB/KAGNXo+najMwXcREnkLC4U=;
        b=Urkc4oFjGlCCO857WC3HgUBosqB4Ub1mMmeV3ThRS29mO38GbDGY/xwlIel/YtntmV
         5Uws5yS0d9xN0UBS4n7/shSOUc6o2Jc2fB3ZwNvV8LwqsvLqU9oRGp0FLXG8sBfcmCqx
         keg1ARP9abNQP5tN1ZInJkAofnmxm2xgZiIK9ksa+yY+i9iirb1o8WifQz9UznwU1s3G
         LKmzbOkiVaxQG08Z0Mvt97zRmv1WT+j1cYrvRh8Nzp1L5PHFX+WODytXS7e6CHjJUfJR
         zC+Rfq9suTanfGP4EYDvdMvCjUqNiFefDJckhBQDTcNOHBYi0N7grydDqrBVpLCTmyXc
         C+EA==
X-Gm-Message-State: AOAM5336yC6w5ze1zqZ1esADQKavWi697PCWxk4tuhTPouJvS2rkNaEz
        SMWY2FwY496jqQvmZTpK+fosi5vpKARJB7F3EhI=
X-Google-Smtp-Source: ABdhPJzmXtxUUOYsnyujthFLXNT1K4EsoGGj1gulH/Pfr0N+lmFNSdy+YEPgl6P/cQ5fdutVaa8Hxe/YtOzMeEShdoo=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr48292053uar.66.1638188302516;
 Mon, 29 Nov 2021 04:18:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
 <20211129015909.GA921717@roeck-us.net> <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
 <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net>
In-Reply-To: <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 29 Nov 2021 13:18:12 +0100
Message-ID: <CAMhs-H-nm1-B8tZejcZPN3jxF_HGr2tWMWmYJUJnz0jau=QcfQ@mail.gmail.com>
Subject: Re: Linux 5.16-rc3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, Nov 29, 2021 at 5:17 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/28/21 7:07 PM, Randy Dunlap wrote:
> >
> >
> > On 11/28/21 17:59, Guenter Roeck wrote:
> >> On Sun, Nov 28, 2021 at 02:21:20PM -0800, Linus Torvalds wrote:
> >>> So rc3 is usually a bit larger than rc2 just because people had some
> >>> time to start finding things.
> >>>
> >>> So too this time, although it's not like this is a particularly big
> >>> rc3. Possibly partly due to the past week having been Thanksgiving
> >>> week here in the US. But the size is well within the normal range, so
> >>> if that's a factor, it's not been a big one.
> >>>
> >>> The diff for rc3 is mostly drivers, although part of that is just
> >>> because of the removal of a left-over MIPS Netlogic driver which make=
s
> >>> the stats look a bit wonky, and is over a third of the whole diff jus=
t
> >>> in itself.
> >>>
> >>> If you ignore that part, the statistics look a bit more normal, but
> >>> drivers still dominate (network drivers, sound and gpu are the big
> >>> ones, but there is noise all over). Other than that there's once agai=
n
> >>> a fair amount of selftest (mostly networking), along with core
> >>> networking, some arch updates - the bulk of it from a single arm64
> >>> uaccess patch, although that's mostly because it's all pretty small -
> >>> and random other changes.
> >>>
> >>> Full shortlog below.
> >>>
> >>> Please test,
> >>>
> >>
> >> Build results:
> >>     total: 153 pass: 152 fail: 1
> >> Failed builds:
> >>     mips:allmodconfig
> >> Qemu test results:
> >>     total: 482 pass: 482 fail: 0
> >>
> >> Building mips:allmodconfig ... failed
> >> --------------
> >> Error log:
> >> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pci=
e-mt7621.o
> >> ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt=
7621.ko] undefined!
> >> ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko=
] undefined!
> >> ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt76=
21.ko] undefined!
> >> ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko]=
 undefined!
> >> ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko=
] undefined!
> >>
> >> There is still no fix for the mips:allmodconfig build problem as far
> >> as I can see. It is a bit odd, because the fix would be as simple as
> >>
> >>   config PCIE_MT7621
> >> -    tristate "MediaTek MT7621 PCIe Controller"
> >> -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> >> +    bool "MediaTek MT7621 PCIe Controller"
> >> +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> >>       select PHY_MT7621_PCI
> >>       default SOC_MT7621
> >>       help
> >>
> >> Context: tristate doesn't make sense here because both RALINK and
> >> SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
> >> already depends on it. The compile failure is due to missing exported
> >> symbols, and it is only seen if PCIE_MT7621=3Dm - which is only possib=
le
> >> if COMPILE_TEST=3Dy. In other words, the dependencies above are set su=
ch
> >> that test builds, and only test builds, fail.
> >>
> >> The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
> >> Add MediaTek MT7621 PCIe host controller driver"). Copying some of
> >> those responsible to see if we can expect a solution sometime soon.
> >
> >
> > I sent a patch for this a couple of weeks ago and Sergio replied to it
> > here:
> >
> > https://lore.kernel.org/linux-pci/CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivL=
QoFuy_fSVJOPXw@mail.gmail.com/
> >
> > saying that is a different patch out there but that it had not
> > been reviewed yet.
> >
>
> All proposals I have seen assume that PCIE_MT7621=3Dm. As I said, I think
> that it is pointless to do that because the driver can only be built
> as module if COMPILE_TEST=3Dy. We should not [have to] export symbols
> because of that.

The proposal I sent when this error was reported in rc1 [0] does not
need to do any export of symbol at all since moves all MIPS related
code inside the driver into ralink architecture mt7621 specific site
making use of core api 'pcibios_root_bridge_prepare()'. The only
problem that seems to be is with PATCH 1 of the series because it
seems that nobody remember why already parsed addresses from device
tree which are stored in 'bridge->windows' are temporary moved into an
internal 'resources' variable at the beginning of
'pci_register_host_bridge()' function and also moved back again at the
end. I do think the approach in this series is correct and really want
a reason for why it is not, since for me passing around an incomplete
'bridge' pointer to 'pcibios_root_bridge_prepare()' when things are
supposed to be parsed already is a bit odd, but I don't have all the
problems of that code along the time... With the approach of this
series we:
- avoid MIPS architecture specific code in PCI controller driver.
- Allow the driver to be compile tested for any single architecture
for all yes* and mod* configurations.

Other ralink drivers have also been asked to be compiled as modules.
See for example, commit fef532ea0cd8 ("MIPS: ralink: export
rt_sysc_membase for rt2880_wdt.c") (here an export symbol was
needed...). Also I was advised in the past that new drivers don't have
to be 'bool' but 'tristate'. See this is commit 15692a80d949 ("phy:
Revert "phy: ralink: Kconfig: convert mt7621-pci-phy into 'bool'"")
where my 'bool' was reverted to 'tristate' and phy subsystem pull
request refused to be applied in first try because of this commit [1].

[0]: https://marc.info/?l=3Dlinux-pci&m=3D163696011110084&w=3D3=C3=A7
[1]: https://www.spinics.net/lists/kernel/msg3986821.html

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

>
> Guenter
