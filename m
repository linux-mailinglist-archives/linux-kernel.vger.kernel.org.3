Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7A4616D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhK2NqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhK2NoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:44:18 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F81C061375
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:23:58 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id p2so33469699uad.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+C6lqFQXpq/jBKHrpAFiUnubZ8s+JuJUDNNzVeDjZ4=;
        b=bJ7lnH027sYS9Hcnk14viZw5H39eqO+OsdcIXZ9Xh09EuMCanTV4M7Ara2mmpuAI1q
         3gTlu/ZgbmDyAekYdnJA2CB5fg6XmLXg4z6QkpouNaUIu6yeZ57zOnZqdv8nGQlhpywV
         6hyRnItemXE4aAwF0kEPdfdAT0lP0HRQosuOvpuZmdMqXduJV3RzUiFEBj+FXY/FszHf
         f3P3oHWTcNthYBmX73UhrECQzMya0C+7gD0gMPF8SZiLz+3bSUSk8w9qO14Aqluyw0Cx
         KVnaLSJxWEh8zgqHvVAEc+lo8aIze3ouprLxFtvMyeUrFJx4olkYdomKxAWR4JZ3Q0cb
         r8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+C6lqFQXpq/jBKHrpAFiUnubZ8s+JuJUDNNzVeDjZ4=;
        b=hYvRC6/pKzJI3fYGi4TAPRirnhccs3zYzyjjESEa7pszBukof3sArRf+vp1Cafbpyg
         STmCBwcUZQUQ5m+JMhHWiN2DAouD4zMmjBwUsoh4NRUjU6Swzy+6Xd35KgoDolEatJ3O
         TLnutUholE3AEV7Vqkad3gKzVRvdbSxt/5zpZVj50wIWfsq1+HEd5n0c/3islxpk2cW9
         ZcSo5hbEgdjRcxu1ELXE7DTFp/LRcjXakEgpLlR7yT0+Gr6+4b1U4B2gFlTc5L7N8Qwk
         HuQLPmdhqy/IhaD+wI74Ji3WzOsIBTWiIDx+Gl39S3GbGUEMbzQYIPb30+f41TCEwNtp
         aXAw==
X-Gm-Message-State: AOAM530zrCmgrpHWG3WSCcWOom6jqCZWP5/G8pplHzi0HsMgyzx72x+n
        NUOEpP3wGu574k8vRLUMCNL16EQOPiMwfvLWDih/KXov
X-Google-Smtp-Source: ABdhPJxF0VlXwBUWOnkBwdHXK2PzObff3h8kZPykhS7a8jMw8vFdrhiKK+qIoKMEVeYjlc4C3c7YDyw2ucgTiswV9xY=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr49154811uar.98.1638188637709;
 Mon, 29 Nov 2021 04:23:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgtC_D-irsmyC89JPE1mnAAGJTc8qaNwaqcNUrt66TDMw@mail.gmail.com>
 <20211129015909.GA921717@roeck-us.net> <09df5c2a-8e03-8afd-ffe3-628dcd326497@infradead.org>
 <53f0b09c-58b3-bd37-5309-5c43242cbecd@roeck-us.net> <20211129110202.GA23795@lpieralisi>
In-Reply-To: <20211129110202.GA23795@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 29 Nov 2021 13:23:46 +0100
Message-ID: <CAMhs-H-_HZQipStBoUtE+bu2QHDTksHytCVTu60+Yju+iqLVsQ@mail.gmail.com>
Subject: Re: Linux 5.16-rc3
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:02 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Sun, Nov 28, 2021 at 08:17:33PM -0800, Guenter Roeck wrote:
> > On 11/28/21 7:07 PM, Randy Dunlap wrote:
> > >
> > >
> > > On 11/28/21 17:59, Guenter Roeck wrote:
> > > > On Sun, Nov 28, 2021 at 02:21:20PM -0800, Linus Torvalds wrote:
> > > > > So rc3 is usually a bit larger than rc2 just because people had some
> > > > > time to start finding things.
> > > > >
> > > > > So too this time, although it's not like this is a particularly big
> > > > > rc3. Possibly partly due to the past week having been Thanksgiving
> > > > > week here in the US. But the size is well within the normal range, so
> > > > > if that's a factor, it's not been a big one.
> > > > >
> > > > > The diff for rc3 is mostly drivers, although part of that is just
> > > > > because of the removal of a left-over MIPS Netlogic driver which makes
> > > > > the stats look a bit wonky, and is over a third of the whole diff just
> > > > > in itself.
> > > > >
> > > > > If you ignore that part, the statistics look a bit more normal, but
> > > > > drivers still dominate (network drivers, sound and gpu are the big
> > > > > ones, but there is noise all over). Other than that there's once again
> > > > > a fair amount of selftest (mostly networking), along with core
> > > > > networking, some arch updates - the bulk of it from a single arm64
> > > > > uaccess patch, although that's mostly because it's all pretty small -
> > > > > and random other changes.
> > > > >
> > > > > Full shortlog below.
> > > > >
> > > > > Please test,
> > > > >
> > > >
> > > > Build results:
> > > >     total: 153 pass: 152 fail: 1
> > > > Failed builds:
> > > >     mips:allmodconfig
> > > > Qemu test results:
> > > >     total: 482 pass: 482 fail: 0
> > > >
> > > > Building mips:allmodconfig ... failed
> > > > --------------
> > > > Error log:
> > > > ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> > > > ERROR: modpost: "mips_cm_unlock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_cpc_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_cm_lock_other" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_cm_is64" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > > ERROR: modpost: "mips_gcr_base" [drivers/pci/controller/pcie-mt7621.ko] undefined!
> > > >
> > > > There is still no fix for the mips:allmodconfig build problem as far
> > > > as I can see. It is a bit odd, because the fix would be as simple as
> > > >
> > > >   config PCIE_MT7621
> > > > -    tristate "MediaTek MT7621 PCIe Controller"
> > > > -    depends on (RALINK && SOC_MT7621) || (MIPS && COMPILE_TEST)
> > > > +    bool "MediaTek MT7621 PCIe Controller"
> > > > +    depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> > > >       select PHY_MT7621_PCI
> > > >       default SOC_MT7621
> > > >       help
> > > >
> > > > Context: tristate doesn't make sense here because both RALINK and
> > > > SOC_MT7621 are bool. Also, RALINK is redundant because SOC_MT7621
> > > > already depends on it. The compile failure is due to missing exported
> > > > symbols, and it is only seen if PCIE_MT7621=m - which is only possible
> > > > if COMPILE_TEST=y. In other words, the dependencies above are set such
> > > > that test builds, and only test builds, fail.
> > > >
> > > > The problem was introduced with commit 2bdd5238e756 ("PCI: mt7621:
> > > > Add MediaTek MT7621 PCIe host controller driver"). Copying some of
> > > > those responsible to see if we can expect a solution sometime soon.
> > >
> > >
> > > I sent a patch for this a couple of weeks ago and Sergio replied to it
> > > here:
> > >
> > > https://lore.kernel.org/linux-pci/CAMhs-H8TA0S23FjSRKGKeKAWWdUxET6YnivLQoFuy_fSVJOPXw@mail.gmail.com/
> > >
> > > saying that is a different patch out there but that it had not
> > > been reviewed yet.
> > >
> >
> > All proposals I have seen assume that PCIE_MT7621=m. As I said, I think
> > that it is pointless to do that because the driver can only be built
> > as module if COMPILE_TEST=y. We should not [have to] export symbols
> > because of that.
>
> Hi Sergio,

Hi Lorenzo,

>
> can we converge to a fix with this thread background in mind please ?

I have just answered Guenter's mail with my reasoning of the already
proposed patch series fix. Don't worry, I will send any patch if
necessary to fix this but I'd like to know why the current proposal is
not valid since it really looks like the correct thing to do...

Best regards,
   Sergio Paracuellos

> Thanks,
> Lorenzo
