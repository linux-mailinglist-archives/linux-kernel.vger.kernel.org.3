Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759AD48E49E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiANG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiANG6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:58:04 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E86C06173F;
        Thu, 13 Jan 2022 22:58:03 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id m15so15394595uap.6;
        Thu, 13 Jan 2022 22:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V66zHmkez0RuWEFf+qTPzwvNqSBfY/zkyTbxozCthVE=;
        b=NQrjEJw3RQebuBFZoDc/h/pkNf0tomf3PR8NX+eC4Hwqr3QyCXlBvtf9YLXQNa1ouq
         J18mBOn2qaBJPFyyklGfkAE4k/1zG2GJtGpW0alBci2f3jGTaXwqHqKh3yH+s9JrKbZR
         BWFumjKOVQ8rR+sy5ZVP9cmEbU01wpichLoKAlMjj8d2Cmob6f7pzD3DvkdZeZJY4z/H
         zb9bYLqpv96g3hxOVlO9Zbun1XbyUq/9F4zZ99geeZcTjQW2QKQNnLvT0XYAkwfvXGpP
         Mx5LI4GAvxTBnAx9pHgeyXhNzxcndVkUrWbiH2rGY+zOh4kB0CvwvVKx2HrrYebBtbyN
         FH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V66zHmkez0RuWEFf+qTPzwvNqSBfY/zkyTbxozCthVE=;
        b=Jyxw8jdB5iDWnfySxXmD5BpO3xUBNsCoX/VrvhBPaCGEI1KYq4G7HxIumdR+0R+xAu
         kS3i2O2O306W+77O+1B7H2WPMiNzZDgNaDmmNdMbnFkrXwFkBVS6BOZa7FJEd4Kos3N1
         baa6UiEnk6B3PlPKfRWsIsfVhOQyf6nMfWebQZKj47wY74eW2ge/SJCvmuG6OJGRRvRr
         CR8Op1SEz28JB/BTUumJGkEH1FIWAjcyc5lAH0d/pUElYY5pn5EeN6+RFIplYJVzPGP0
         Z6xAMKjxtoqNOb0GHXDBFYr7yixbABOkceBaELfxsCppCW8re7FNnhRKJgsLsltZN8Ni
         J01Q==
X-Gm-Message-State: AOAM532Sg1pvgNb+4F8LZ6zBhMIqEGf38zP7Vd4DybxF4YUqUQxg+gUr
        w7uGyb4A6vi9ZlUlefxtxzAFrX0NouUgHx5fCb5sWAaBJTQ=
X-Google-Smtp-Source: ABdhPJz3jPee6qcfnG1aTBmix0GA/S/O0hrGMD1QUTEgBneBZe8kt/rS4ROcpcMkSWLzYofHRE2CXvyVUroStmNZ3/s=
X-Received: by 2002:a67:be18:: with SMTP id x24mr3760656vsq.43.1642143482790;
 Thu, 13 Jan 2022 22:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20220114104547.55e2f188@canb.auug.org.au> <CAMhs-H_u42MSPpkwFEQCVghHWVjMqdJ1aKXXhbhxKWrejZLqRA@mail.gmail.com>
 <20220114175303.07569259@canb.auug.org.au>
In-Reply-To: <20220114175303.07569259@canb.auug.org.au>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 14 Jan 2022 07:57:51 +0100
Message-ID: <CAMhs-H_XqtGPq5Zf4YzSc7BJM0f_7yzrdUgQNV+L1MZWLUe=sw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 7:53 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Sergio,
>
> On Fri, 14 Jan 2022 06:48:08 +0100 Sergio Paracuellos <sergio.paracuellos@gmail.com> wrote:
> >
> > On Fri, Jan 14, 2022 at 12:45 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > diff --cc drivers/pci/controller/Kconfig
> > > index aec8c9a3488b,f7e44d9c6965..000000000000
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@@ -332,8 -332,8 +332,8 @@@ config PCIE_APPL
> > >           If unsure, say Y if you have an Apple Silicon system.
> > >
> > >   config PCIE_MT7621
> > >  -      tristate "MediaTek MT7621 PCIe Controller"
> > >  +      bool "MediaTek MT7621 PCIe Controller"
> >
> > This should be tristate.
> >
> > > -       depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
> > > +       depends on SOC_MT7621 || COMPILE_TEST
> >
> > This is correct,
> >
> > >         select PHY_MT7621_PCI
> > >         default SOC_MT7621
> > >         help
>
> Thanks, I have fixed up my merge resolution for Monday.

Thanks for letting me know, Stephen.

Best regards,
    Sergio Paracuellos
>
> --
> Cheers,
> Stephen Rothwell
