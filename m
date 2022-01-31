Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546AE4A4FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377841AbiAaT6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377819AbiAaT5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:57:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BCDC061741
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:57:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so236526pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxxRAP314jDSGXiVlWBZyKjdy+DN2lrBrDJCppTsFgM=;
        b=WdF4V2p0Y7jszFxrF6/IZtcSS1/fMQSWE4SLUKzohrF0Eiu8PUD2Gsuu4DKOdKctwv
         F0/I2WtBj5j9qyMK2Ud8QJsMKcphaDnL0YcMacaTfmwam7F7WP6s4F4iKO4JhUoUZnST
         S79gZWRdEqg8m1tWf2vNWoVAs+hh/pwEyqR1Z/V9uOC3VEFDLN3iMWqYfkZuplgL7zk3
         O9GbK/PPyVuwrOlhHet3TuEpTGfeXnbq6FkykZEnhhZqnTa0ZVswJkKr5qHH2b40DweJ
         4STK4nP4GCUVJCE+qWSZeMZLlBBvq3YQCz754/ou+jXXgWohdKZfKlw2uKZRKbmH9mG+
         I9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxxRAP314jDSGXiVlWBZyKjdy+DN2lrBrDJCppTsFgM=;
        b=qOfrfNIFTf8YY9DFBK9tSkQdFN7ZzvwRnMUdWVpZcjaILVpTIy6Zoeow/oRmkGZeY5
         LjB7kFtzJcy3aovETzMS+jfvipeRD0iYQkYlc5RXGBiQtcQSX6looa7aM8SnGUcwVazc
         OieTxxd0uPUsiNNwGfXgd/sfc5dObo3p6X2xlISyfsy4lSKXOovRxVN/8chnK9rdxTNE
         buOWIUBKx+aSsBeGVpu+/R54+OAXHUT1+uUn+YULvpS4OQi2pzL4d5G/on4XUOdx0iPB
         VX1ykUGAv3mkkysJkxPnaUAK6MmSGkqF/8MLYsZNrSdZEhG4qbTRqLlO7ju/wUnnSHJE
         uRYQ==
X-Gm-Message-State: AOAM531XFbhjBRAJu8RdLrmbPv8X6aEShstiwv4ZvXHH3IHaEFMK5ByP
        uBojMKLEt0j2PaP8vciTOVEdyHweWmdNs1cRqDgcBonJiPE=
X-Google-Smtp-Source: ABdhPJzqcph7YwhpfF/brZKrrekNHBCzD++nDzmgUTJk0t+y46UMthqiVH1mTjGuZq7aCS+IDc+KBgp+FYh2FgQjMcI=
X-Received: by 2002:a17:90a:348f:: with SMTP id p15mr5931910pjb.173.1643659057200;
 Mon, 31 Jan 2022 11:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20220121214117.GA1154852@bhelgaas> <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna> <Ye/btvA1rLB2rp02@kroah.com> <Ye/zTHR5aCG58z87@lahna>
 <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
 <YfOf2X7Snm7cvDRV@lahna> <CACK8Z6FMgc5UQY-ZGB9sKYR5Wt6L6huTnEKZaFyVRAmDmQt9XQ@mail.gmail.com>
 <CAJZ5v0iuM_qjhPxvhzgvtKM-4pBB2skf9G=R=Qo6NzKnZ2LN=w@mail.gmail.com> <YfeEoF35RPDVMdzD@lahna>
In-Reply-To: <YfeEoF35RPDVMdzD@lahna>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 31 Jan 2022 11:57:00 -0800
Message-ID: <CACK8Z6EBbdPHhMtD+vMWs54GRw-ChCeNNfeKM4Hk5JcAqex6hg@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mika, Rafael,

On Sun, Jan 30, 2022 at 10:42 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Sun, Jan 30, 2022 at 03:30:39PM +0100, Rafael J. Wysocki wrote:
> > > I'm open to doing so if the others also feel the same way. IMHO
> > > though, the semantics of ACPI "DmaProperty" differ from the semantics
> > > of the property I'm proposing here.
> > >
> > > The current (documented) semantics (of "DmaProperty"): *This device
> > > (root port) is trusted*, but any devices downstream are not to be
> > > trusted.
> > >
> > > What I need and am proposing (new "UntrustedDevice"): *This device as
> > > well as any downstream devices* are untrusted.
> > >
> > > Note that there may be firmware implementing "DmaProperty" already out
> > > there (for windows), and if we decide to use it for my purposes, then
> > > there shall be a discrepancy in how Linux uses that property vs
> > > Windows. Is that acceptable?
> >
> > It may be confusing, so I'd rather not do that.
> >
> > The platform firmware will use it with the Windows use case in mind
> > and if it has side effects in Linux, problems are likely to appear in
> > the field.
> >
> > So the question is rather not about it being acceptable, but about
> > whether or not this is generally going to work.
>
> I was kind of implying that we could perhaps contact Microsoft and ask
> them if the wording could be changed to cover all the devices, not just
> PCIe root ports. I think this is something they will also need for
> things like internal WI-FI controllers.

We (Chromeos) do not have a contact at Microsoft, not sure if Intel
does. If someone can point me to a contact I will be happy to initiate
a conversation. However, given that they have already published it,
and changing the semantics might mean they will also have to change
windows implementation. Not sure if we have enough leverage with
Microsoft here, so I wouldn't have any high hopes though. Like Rafael
said, we're on the receiving end here.

Rafael, one last question: is "untrusted-device" an acceptable ACPI
property name, or does it have to be Camel case?

Thanks & Best Regards,

Rajat

>
> If that's not possible then no objections adding "UntrustedDevice". We
> just need to deal with the "DmaProperty" anyway and both end up setting
> pdev->untrusted in the similar manner.
