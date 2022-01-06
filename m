Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF874861C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiAFJBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:01:06 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:39851 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236715AbiAFJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:01:05 -0500
Received: by mail-vk1-f178.google.com with SMTP id m200so1240084vka.6;
        Thu, 06 Jan 2022 01:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QU3Ur2CmPi/TF3kAiyTRTu3i4WmgJ57z8oX/+Qc28Rw=;
        b=2b90iL09kydKf+UockwBG8nmqaHLIGkicAlDntbdWAtn60GHMBhmF/gP/SKNH2EY1h
         2a7Nz1es0c5Kq6xKURI3V+mzx3UY6N8fvc8adoB6mC+tGICTxNsawVpoqjV0tNKvl+hX
         s4bpTi2OARh91j7ZFu7lhm5eC/z2N5J3hCa9hc5wKIJbXp7XsVYQFmUOzUhK1RrBslwk
         PRljSl6WrEc/IQ/AufFz5JAO4t7odxqSxqnXbemQHpah9ryZbruUEhPSb4fYkAks8DPz
         Cf8zmkmg5j5upq+NYUnPl4qtN2s9NNbPnECz/o/8M1p/w+9CCDK/CSzaDUlr5Jk9vW+U
         2Stw==
X-Gm-Message-State: AOAM530KRsbTK7Nal2XMAu2Rhun600eWYbYvjy0VxFJyXl4/ejPuHX4I
        GeZTj5gdV1XiLUyncFzLfuDYIfORAOs92w==
X-Google-Smtp-Source: ABdhPJyjP1nfFftqL/6BSUIzSQ9NlCkOKgeMo/lxPu/8EFaWzFqFPr1432Hrk7BX0f4x+xGJoxnfCw==
X-Received: by 2002:a05:6122:1347:: with SMTP id f7mr20837509vkp.40.1641459664812;
        Thu, 06 Jan 2022 01:01:04 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id c14sm839113vsl.22.2022.01.06.01.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 01:01:04 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id x33so1705645uad.12;
        Thu, 06 Jan 2022 01:01:03 -0800 (PST)
X-Received: by 2002:ab0:7450:: with SMTP id p16mr6332975uaq.14.1641459663365;
 Thu, 06 Jan 2022 01:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20210324223713.1334666-1-frowand.list@gmail.com>
 <20210327174035.GA291160@robh.at.kernel.org> <3e6710e7-08ac-7d1b-aa69-bcd36f0d932a@gmail.com>
 <CAMuHMdXpGKMi-xv6hZQmmEw0JO=Q0WuvUzwJ2v0O28Tx5uW+sg@mail.gmail.com>
 <d1aefaae-7b12-b5fb-4b97-7230bd52c1be@gmail.com> <20210526061144.yvoaurpz75a3bsjr@vireshk-i7>
 <f651e95b-feef-5c86-edba-d6008bc80b34@gmail.com> <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko> <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com> <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
In-Reply-To: <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jan 2022 10:00:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
Message-ID: <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:20 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Jun 22, 2021 at 11:44 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Sat, May 29, 2021 at 12:16 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Sat, May 29, 2021 at 7:16 AM David Gibson
> > > <david@gibson.dropbear.id.au> wrote:
> > > > On Thu, May 27, 2021 at 09:21:05AM +0200, Geert Uytterhoeven wrote:
> > > > 65;6401;1c> On Thu, May 27, 2021 at 3:48 AM David Gibson
> > > > > <david@gibson.dropbear.id.au> wrote:
> > > > > > On Wed, May 26, 2021 at 04:21:48PM -0500, Frank Rowand wrote:
> > > > > > > On 5/26/21 1:11 AM, Viresh Kumar wrote:
> > > > > > > > On 22-04-21, 13:54, Frank Rowand wrote:
> > > > > > > >> On 4/22/21 3:44 AM, Geert Uytterhoeven wrote:
> > > > > > > >>> On Mon, Mar 29, 2021 at 9:23 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > > > > >>>> On 3/27/21 12:40 PM, Rob Herring wrote:
> > > > > > > >>>>> On Wed, Mar 24, 2021 at 05:37:13PM -0500, frowand.list@gmail.com wrote:
> > > > > > > >>>>>> From: Frank Rowand <frank.rowand@sony.com>
> > > > > > > >>>>>>
> > > > > > > >>>>>> Add Makefile rule to build .dtbo.o assembly file from overlay .dtso
> > > > > > > >>>>>> source file.
> > > > > > > >>>>>>
> > > > > > > >>>>>> Rename unittest .dts overlay source files to use .dtso suffix.
> > > > > > > >>>>>
> > > > > > > >>>>> I'm pretty lukewarm on .dtso...
> > > > > > > >>>>
> > > > > > > >>>> I was originally also, but I'm warming up to it.
> > > > > > > >>>
> > > > > > > >>> What's the status of this?
> > > > > > > >>
> > > > > > > >> I was planning to resend on top of the upcoming -rc1.
> > > > > > > >
> > > > > > > > Ping.
> > > > > > > >
> > > > > > >
> > > > > > > Thanks for the prod...
> > > > > > >
> > > > > > > The .dtso convention was added to the dtc compiler, then a patch was
> > > > > > > accepted to revert one mention of .dtso ,though there still remains
> > > > > > > two location where .dtbo is still recognized (guess_type_by_name() in
> > > > > > > dtc and the help text of the fdtoverlay program).
> > > > > > >
> > > > > > > It seems that the general .dtso and .dtbo were not popular, so I'm
> > > > > > > going to drop this patch instead of continuing to try to get it
> > > > > > > accepted.
> > > > > >
> > > > > > AFAICT .dtbo is moderately well established, and I think it's a good
> > > > > > convention, since it matters whether a blob is an overlay or base
> > > > > > tree, and it's not trivial to tell which is which.
> > > > >
> > > > > Indeed.
> > > > >
> > > > > > .dtso is much more recent,
> > > > >
> > > > > Is it?
> > > >
> > > > Well, I wouldn't bet money on it, I just seem to remember encountering
> > > > .dtbo for some time before .dtso was mentioned.
> > > >
> > > > > The oldest reference I could find is from May 2015:
> > > > > "[PATCH/RFC] kbuild: Create a rule for building device tree overlay objects"
> > > > > https://lore.kernel.org/linux-devicetree/1431431816-24612-1-git-send-email-geert+renesas@glider.be/
> > > >
> > > > Hm, I think .dtbo is even older than that, but again, I wouldn't swear
> > > > to it.
> > >
> > > Sure. My work is based on Pantelis' work for BeagleBoard capes.
> > > His code (from 2013?) used .dtbo and .dts:
> > >
> > >     overlay/v3.10/merge:firmware/Makefile:$(obj)/%.dtbo: $(obj)/%.dts
> > > | $(objtree)/$(obj)/$$(dir %)
> > >
> > > So I might be the one who introduced .dtso...
> > >
> > > > > I have always used dtbo/dtso in my published overlays branches,
> > > > > referred from https://elinux.org/R-Car/DT-Overlays, and used by
> > > > > various people.
> > > > >
> > > > > > and I think there's much less value to it.
> > > > >
> > > > > IMHO the same reasoning as for dtb vs. dtbo applies to dts vs. dtso.
> > > > > It matters if the resulting blob will be an overlay or base tree,
> > > > > as the blob will have to be called .dtb or .dtbo.
> > > > > As dtc outputs to stdout by default, the caller has to provide the
> > > > > output filename, and thus needs to know.
> > > > > Even if dtc would name the output file based on the presence of
> > > > > "/plugin/" in the input file, the build system still needs to know
> > > > > for dependency tracking.
> > > >
> > > > Hm, fair point.  I was thinking of the the /plugin/ tag as the
> > > > distinction, whereas dtb is binary and the distinction isn't even
> > > > marked in the header.  But you're right that even readable text labels
> > > > inside the file don't really help make(1).  So, I retract that
> > > > assertion.
> > >
> > > Thanks!
> > >
> > > > > We also do have .dts vs. .dtsi.
> >
> > In the mean time, we're at rc7 again?
>
> That was v5.13-rc7. Now we're at v5.14-rc7...
>
> Will we live with the inability to e.g. let make distinguish between
> DT includes and overlays forever?

I guess this is not gonna happen, so I'll convert all my overlays
from .dtso to .dts....

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
