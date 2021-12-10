Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930F246F852
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhLJBUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLJBUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:20:04 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E902C061746;
        Thu,  9 Dec 2021 17:16:30 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d10so18068494ybn.0;
        Thu, 09 Dec 2021 17:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzF//cxh++7fl5oK5N1nlCJSs8gKOydYYvwI+sG8Nkk=;
        b=oUyCEOYXobkE9c8v7AkpKo03GKXQYNonPFc4GsR6Yd/oozwbufcEPK+xU+PQeGZMcv
         RBhMPr81/0cf7azfxhKN2sAsrb8mZfRMVMjZavfnuHMzZJaZTymHSnh0d5TKy+QnUwsL
         QoDF3W4sruBhDWF5Z8WV2ZNA8U6g3hn93wqWK0GX4aeywJp1rQfB9CjE9gN6Y3YGP1o3
         quMmIENfv7LVmS+Y78+/NHm4M/SCJFCgPOZi0CoM/nAZTFF3hFIF7g0l9nEcJ4+eDHwQ
         QmHDswP3Hr8QUblcWW31k9F8gXRCvT24zB91EABvVLpshoqIHT6548YajmrZ/iEBUyHf
         yA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzF//cxh++7fl5oK5N1nlCJSs8gKOydYYvwI+sG8Nkk=;
        b=IamugYemQX5u1s299FBogY/GAtDezk9oVQny6JosDQ+v3i2PB20AQxQDn+VtQu2+Hj
         rMTs/I3S7DUVpJKj5nXGVbRCI/a/w9HNXa2FlPBd+cnOxEb/Q0u451GSbNqVDtTwFe/4
         Fe06k4NBI/hgFgJYjIvkWPR7JTWZUkdCyGwjjdNL0n1TyAdbq/50nhod4a+l7Iz/fXSV
         CGm7Wkeu+j5bmCF4OIup1uM76NBbfMSUt8z5aANHK7IMsd4DHD8TVrV2lKj13wghpRzv
         968FnBE8wzehI+U8T8LZIiAp7zHnWlU6jmejfjRAJbYLzVyAS/yD5k5wmgUh+SDNdLX7
         DwRA==
X-Gm-Message-State: AOAM533MPju0TREUDVdRiiwW9qY2VbAMO9ZALMcTMZy4MvGWOUSw9v9s
        aWTLaRyczUFctH6xIsJRoGoBPGRalbx8W84FOuk=
X-Google-Smtp-Source: ABdhPJzwFimI1+VRQrsmQwEHXhmAjCTPDBK4hAnThE66/C2wXJhAJNyp5y934A5gGV20vQG7sPvqeXMAcCYd4OGoqrk=
X-Received: by 2002:a25:abe3:: with SMTP id v90mr10236514ybi.315.1639098989622;
 Thu, 09 Dec 2021 17:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <d290850bf95f4bdf0c329f278db458c7@kernel.org> <CA+V-a8vUCXQa38NmYu9znakcq4A=Uedyn8w5+hXQ_WKf58oHRQ@mail.gmail.com>
 <875yry1316.wl-maz@kernel.org> <CA+V-a8vNUhVBFNf-M6s1BmXbdCpdyJOx2g=t=QJf1jQzUA3xow@mail.gmail.com>
 <CAL_Jsq+H54oX8GCHcwPVaUC3brjJa+5+OTU21D-3d7QUqM+jcg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+H54oX8GCHcwPVaUC3brjJa+5+OTU21D-3d7QUqM+jcg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 10 Dec 2021 01:16:03 +0000
Message-ID: <CA+V-a8sifb8zpMB=VwBn6qXob=3JRQdMTh1PWD-M7SquP9S9+g@mail.gmail.com>
Subject: Re: [RFC PATCH] of: platform: Skip mapping of interrupts in of_device_alloc()
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:34 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Dec 9, 2021 at 5:35 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Rob and Marc,
> >
> > On Thu, Dec 9, 2021 at 10:33 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 09 Dec 2021 10:00:44 +0000,
> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > >
> > > > > The root of the issue is that all the resource allocation is done
> > > > > upfront, way before we even have a driver that could potentially
> > > > > deal with this device. This is a potential waste of resource, and
> > > > > it triggers the issue you noticed.
> > > > >
> > > > > If you delay the resource allocation until there is an actual
> > > > > match with a driver, you could have a per-driver flag telling you
> > > > > whether the IRQ allocation should be performed before the probe()
> > > > > function is called.
> > > > >
> > > > As suggested by Rob, if we switch the drivers to use
> > > > platform_get_resource(pdev, IORESOURCE_IRQ, n) call with
> > > > platform_get_irq() this code should go away and with this switch the
> > > > resource allocation will happen demand. Is this approach OK?
> > >
> > > If you get rid of of_irq_to_resource_table() altogether, then yes,
> > > this has a fighting chance to work.
> > >
> > Yes, switching to platform_get_irq() will eventually cause
> > of_irq_to_resource_table() to go away.
> >
> > On second thought, instead of touching all the drivers, if we update
> > platform_get_resource/platform_get_resource_byname to internally call
> > platform_get_irq() internally if it's a IORESOURCE_IRQ resource. Does
> > that sound good or should I just get on changing all the drivers to
> > use platform_get_irq() instead?
>
> Except that platform_get_irq() already internally calls
> platform_get_resource()... I think changing the drivers is the right
> way. Happy to do some if you want to divide it up.
>
Thank you, I think I'll manage.

> Using coccigrep, I think I've found all the places using
> platform_device.resource directly. A large swath are Sparc drivers
> which don't matter. The few that do matter I've prepared patches for
> here[1]. Most of what I found were DT based drivers that copy
> resources to a child platform device. That case will not work with
> platform_get_irq() callers either unless the child device has it's DT
> node set to the parent node which is the change I made.
>
Thank you for getting this done. Do you want me to include those along
with my conversion patches?
Any reason why we dont care for Sparc drivers?

> Rob
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-kernelci

Cheers,
Prabhakar
