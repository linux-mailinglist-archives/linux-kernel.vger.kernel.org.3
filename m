Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028D656C367
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiGHT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiGHT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:28:17 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A089153D06;
        Fri,  8 Jul 2022 12:28:16 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id h132so8660553ybb.4;
        Fri, 08 Jul 2022 12:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Adq262FqgbHF8RrsXNyOZR99yv/bgTrTtDi82M2Lai8=;
        b=uMlKL0MvMx61bWaHIU9GTSc4KoaGqsoB2Xt7kgysYmO99916zTMo7ifyWJfKA7P8JN
         s7m1nt+ZD9LenKM+hOga8l+V17vJXcBpmx5vZuZeWoM2QRgG4lNAVblr/yOCSFP7wCqV
         U/Sg6UIi9fKgPYDrdwOf7x/qkwXcmuSdU/XNJbhY4sauo+l4qIKLypJ8WZ3XF6oW8lIo
         dGhqbOnNauTu7Txme3F//HQp0Kra+7SUprpQAR1TIHXepjpLarj30RUNfP2HjqyS/3B2
         7PSymvfVEArjqwND+060hagkONDV+B/himgDID/zXX8N4oalJ0dxPGnuFhq7zJK5wODY
         79jg==
X-Gm-Message-State: AJIora91XhAOmpcCrzeuqZwdvTiXAFxGLnctbselzzFUlVDfXnU4qAPJ
        78QQ5Ff9fztXUmGe1C+JYoB2HsyuDCKJHYjCaUc=
X-Google-Smtp-Source: AGRyM1uNOen2w4MD2F36UQSnxq6oGUS88nJifcsvzfTMSipLjWrvOecHgD4zbExkeIYYVyX0xKAMBRsgMyjM2cB5Ow0=
X-Received: by 2002:a05:6902:1108:b0:66e:a9b1:3e48 with SMTP id
 o8-20020a056902110800b0066ea9b13e48mr5547856ybu.153.1657308495710; Fri, 08
 Jul 2022 12:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220602163330.317-1-mario.limonciello@amd.com>
 <20220608222922.GA429328@bhelgaas> <MN0PR12MB610188F2F289EFA12872D8E2E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610188F2F289EFA12872D8E2E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jul 2022 21:28:02 +0200
Message-ID: <CAJZ5v0jzJBABqsbxNwhjojdkgQdreuU5+SVnenm48GOyLioZQg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: PM: Drop pme_interrupt reference
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay.

On Mon, Jun 13, 2022 at 5:57 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Wednesday, June 8, 2022 17:29
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <len.brown@intel.com>;
> > Pavel Machek <pavel@ucw.cz>; Bjorn Helgaas <bhelgaas@google.com>; Mika
> > Westerberg <mika.westerberg@linux.intel.com>; open list:SUSPEND TO RAM
> > <linux-pm@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] Documentation: PM: Drop pme_interrupt reference
> >
> > On Thu, Jun 02, 2022 at 11:33:30AM -0500, Mario Limonciello wrote:
> > > `pme_interrupt` was dropped from `struct pci_dev` as part of commit
> > > 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev"),
> > > but the Documentation still includes this member.
> > >
> > > Remove it from the documentation as well and update it to have the missing
> > > `pme_poll` member instead.
> > >
> > > Fixes: 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >  Documentation/power/pci.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
> > > index b04fb18cc4e2..a125544b4cb6 100644
> > > --- a/Documentation/power/pci.rst
> > > +++ b/Documentation/power/pci.rst
> > > @@ -315,7 +315,7 @@ that these callbacks operate on::
> > >                                        configuration space */
> > >     unsigned int    pme_support:5;  /* Bitmask of states from which PME#
> > >                                        can be generated */
> > > -   unsigned int    pme_interrupt:1;/* Is native PCIe PME signaling used?
> > */
> > > +   unsigned int    pme_poll:1;     /* Poll device's PME status bit */
> > >     unsigned int    d1_support:1;   /* Low power state D1 is supported */
> > >     unsigned int    d2_support:1;   /* Low power state D2 is supported */
> > >     unsigned int    no_d1d2:1;      /* D1 and D2 are forbidden */
> >
> > I'm OK with this patch if Rafael wants to take it.
> >
> > But I'm not sure how much value this section of the doc really adds.
> > The doc basically says "the PCI PM callbacks operate on several of
> > these fields of the struct pci_dev" and goes on to quote part of the
> > struct pci_dev.
>
> The reason that the patch came up is that someone who doesn't normally look
> at kernel code but looked at documentation reached out asking questions about
> these variables at the time a bug was occurring.  I was baffled how they were referring
> to pme_interrupt until I found that it's only mentioned in documentation since the linked
> Fixes tag.  So I figured we should make the documentation match the code.
>
> >
> > But "pm_cap" is the only one of those fields that is mentioned
> > elsewhere in the doc, and that one is only incidental.
> >
> > For example, is it really useful to say "the PCI PM callbacks use
> > pci_dev.pme_poll" without any other details about pme_poll?
> >
> > I think I would consider just removing everything from "The structure
> > representing a PCI device ..." to the end of the section, i.e., lines
> > 308-329 at [1].
> >
>
> That's perfectly fine to me too.

I've decided to apply the patch, because it is fine as is and the
cleanup mentioned above can be done on top of it just fine.

Applied as 5.20 material, thanks!
