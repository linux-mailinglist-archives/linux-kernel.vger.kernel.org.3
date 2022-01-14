Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E748E772
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbiANJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:25:19 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:34732 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiANJZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:25:17 -0500
Received: by mail-ua1-f45.google.com with SMTP id y4so15941388uad.1;
        Fri, 14 Jan 2022 01:25:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bxurfSnefwvuGlvIe52KLQlFm8qMyU98wpaPUiPCsK8=;
        b=4jK5wWlingT2iFJ5t5HgSMhej4G/CE4D0LjVde/eZNHgOdckfdAqoOQW9q+eM3pthU
         nvW1WMRsQokZvjGgTV1Kh6LlT6L7cgyF83UV+2bh7BvMs4s41DAEBeqz0+lkhJnr1yCu
         Q1sd9aaWZyTm3ptYr14eY8dXsG8Vmh4wBVYp1Q0VCz7hG1YZPx6B8NOa/mMKPdsvjXs2
         xAmqpRdQQcCBOZCN5riX589XlPnkCAXe7eeYjTLoXKQS9Q6549yaqnRGpPAgjuRwwka4
         JVYulutFtQcgmAIjh9kGj4+WCqghEDb1J12hTHMs4futi1x9su78tmbmnZjmN89WVba2
         PUIA==
X-Gm-Message-State: AOAM53036EpgR9DMtkn8Bmxjh1n1gkWvYEDpeqUJ8qYsQrNy0r03H76n
        oxK1QC1BEjdE/n/XxCSyMzN89O2mFWwItw==
X-Google-Smtp-Source: ABdhPJzqu0BufWb47qhMYEDFE5M2Esozekweek1kon1fJzgK3zhoGveltAfY2B8A/khkbYqEvS9FGQ==
X-Received: by 2002:a67:e10e:: with SMTP id d14mr196787vsl.42.1642152315837;
        Fri, 14 Jan 2022 01:25:15 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 41sm2120062uag.18.2022.01.14.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 01:25:15 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id m90so15974268uam.2;
        Fri, 14 Jan 2022 01:25:15 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr3958505uai.89.1642152314942;
 Fri, 14 Jan 2022 01:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20210324223713.1334666-1-frowand.list@gmail.com>
 <20210327174035.GA291160@robh.at.kernel.org> <3e6710e7-08ac-7d1b-aa69-bcd36f0d932a@gmail.com>
 <CAMuHMdXpGKMi-xv6hZQmmEw0JO=Q0WuvUzwJ2v0O28Tx5uW+sg@mail.gmail.com>
 <d1aefaae-7b12-b5fb-4b97-7230bd52c1be@gmail.com> <20210526061144.yvoaurpz75a3bsjr@vireshk-i7>
 <f651e95b-feef-5c86-edba-d6008bc80b34@gmail.com> <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko> <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com> <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
In-Reply-To: <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 10:25:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
Message-ID: <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

Hi Rob,

On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
> On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > Patient Geert has pinged again.
>
> If it's not a patch to be reviewed, then I'm not going to see it most
> likely. I don't read the DT list regularly...

Fair enough...

> > If I remember correctly you guys were not thrilled with this idea, but
> > also did not seem strongly against it.  Are you willing to go along
> > with .dtso for overlay source files?  If so, I will revive this patch
> > series.
> >
> > David, if you are against supporting .dtso in the dtc compiler then
> > the kernel can still support it through make rules.
>
> I'm not really interested in diverging from dtc. I'd suggest moving
> the discussion to dtc list and/or devicetree-spec if you want to get
> more attention on this.

What needs to be supported in the dtc compiler?
The fallback passed to guess_input_format() is "dts".
So this has been working out-of-the-box since forever?

> Also, keep in mind that extensions also affect MIME types which
> someone was also asking about recently.

You mean "MIME type of Devicetree Blobs and Sources"[1]?
According to [2](2022-01-13), none of that has happened.

[1] https://www.spinics.net/lists/devicetree-spec/msg00938.html
[2] https://www.iana.org/assignments/media-types/media-types.xhtml

> > On 1/6/22 3:00 AM, Geert Uytterhoeven wrote:
> > > On Tue, Aug 24, 2021 at 11:20 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > >> On Tue, Jun 22, 2021 at 11:44 AM Geert Uytterhoeven
> > >> <geert@linux-m68k.org> wrote:
> > >>> On Sat, May 29, 2021 at 12:16 PM Geert Uytterhoeven
> > >>> <geert@linux-m68k.org> wrote:
> > >>>> On Sat, May 29, 2021 at 7:16 AM David Gibson
> > >>>> <david@gibson.dropbear.id.au> wrote:
> > >>>>> On Thu, May 27, 2021 at 09:21:05AM +0200, Geert Uytterhoeven wrote:
> > >>>>> 65;6401;1c> On Thu, May 27, 2021 at 3:48 AM David Gibson
> > >>>>>> <david@gibson.dropbear.id.au> wrote:
> > >>>>>>> On Wed, May 26, 2021 at 04:21:48PM -0500, Frank Rowand wrote:
> > >>>>>>>> On 5/26/21 1:11 AM, Viresh Kumar wrote:
> > >>>>>>>>> On 22-04-21, 13:54, Frank Rowand wrote:
> > >>>>>>>>>> On 4/22/21 3:44 AM, Geert Uytterhoeven wrote:
> > >>>>>>>>>>> On Mon, Mar 29, 2021 at 9:23 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >>>>>>>>>>>> On 3/27/21 12:40 PM, Rob Herring wrote:
> > >>>>>>>>>>>>> On Wed, Mar 24, 2021 at 05:37:13PM -0500, frowand.list@gmail.com wrote:
> > >>>>>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Add Makefile rule to build .dtbo.o assembly file from overlay .dtso
> > >>>>>>>>>>>>>> source file.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Rename unittest .dts overlay source files to use .dtso suffix.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> I'm pretty lukewarm on .dtso...
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> I was originally also, but I'm warming up to it.
> > >>>>>>>>>>>
> > >>>>>>>>>>> What's the status of this?
> > >>>>>>>>>>
> > >>>>>>>>>> I was planning to resend on top of the upcoming -rc1.
> > >>>>>>>>>
> > >>>>>>>>> Ping.
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> Thanks for the prod...
> > >>>>>>>>
> > >>>>>>>> The .dtso convention was added to the dtc compiler, then a patch was
> > >>>>>>>> accepted to revert one mention of .dtso ,though there still remains
> > >>>>>>>> two location where .dtbo is still recognized (guess_type_by_name() in
> > >>>>>>>> dtc and the help text of the fdtoverlay program).
> > >>>>>>>>
> > >>>>>>>> It seems that the general .dtso and .dtbo were not popular, so I'm
> > >>>>>>>> going to drop this patch instead of continuing to try to get it
> > >>>>>>>> accepted.
> > >>>>>>>
> > >>>>>>> AFAICT .dtbo is moderately well established, and I think it's a good
> > >>>>>>> convention, since it matters whether a blob is an overlay or base
> > >>>>>>> tree, and it's not trivial to tell which is which.
> > >>>>>>
> > >>>>>> Indeed.
> > >>>>>>
> > >>>>>>> .dtso is much more recent,
> > >>>>>>
> > >>>>>> Is it?
> > >>>>>
> > >>>>> Well, I wouldn't bet money on it, I just seem to remember encountering
> > >>>>> .dtbo for some time before .dtso was mentioned.
> > >>>>>
> > >>>>>> The oldest reference I could find is from May 2015:
> > >>>>>> "[PATCH/RFC] kbuild: Create a rule for building device tree overlay objects"
> > >>>>>> https://lore.kernel.org/linux-devicetree/1431431816-24612-1-git-send-email-geert+renesas@glider.be/
> > >>>>>
> > >>>>> Hm, I think .dtbo is even older than that, but again, I wouldn't swear
> > >>>>> to it.
> > >>>>
> > >>>> Sure. My work is based on Pantelis' work for BeagleBoard capes.
> > >>>> His code (from 2013?) used .dtbo and .dts:
> > >>>>
> > >>>>     overlay/v3.10/merge:firmware/Makefile:$(obj)/%.dtbo: $(obj)/%.dts
> > >>>> | $(objtree)/$(obj)/$$(dir %)
> > >>>>
> > >>>> So I might be the one who introduced .dtso...
> > >>>>
> > >>>>>> I have always used dtbo/dtso in my published overlays branches,
> > >>>>>> referred from https://elinux.org/R-Car/DT-Overlays, and used by
> > >>>>>> various people.
> > >>>>>>
> > >>>>>>> and I think there's much less value to it.
> > >>>>>>
> > >>>>>> IMHO the same reasoning as for dtb vs. dtbo applies to dts vs. dtso.
> > >>>>>> It matters if the resulting blob will be an overlay or base tree,
> > >>>>>> as the blob will have to be called .dtb or .dtbo.
> > >>>>>> As dtc outputs to stdout by default, the caller has to provide the
> > >>>>>> output filename, and thus needs to know.
> > >>>>>> Even if dtc would name the output file based on the presence of
> > >>>>>> "/plugin/" in the input file, the build system still needs to know
> > >>>>>> for dependency tracking.
> > >>>>>
> > >>>>> Hm, fair point.  I was thinking of the the /plugin/ tag as the
> > >>>>> distinction, whereas dtb is binary and the distinction isn't even
> > >>>>> marked in the header.  But you're right that even readable text labels
> > >>>>> inside the file don't really help make(1).  So, I retract that
> > >>>>> assertion.
> > >>>>
> > >>>> Thanks!
> > >>>>
> > >>>>>> We also do have .dts vs. .dtsi.
> > >>>
> > >>> In the mean time, we're at rc7 again?
> > >>
> > >> That was v5.13-rc7. Now we're at v5.14-rc7...
> > >>
> > >> Will we live with the inability to e.g. let make distinguish between
> > >> DT includes and overlays forever?
> > >
> > > I guess this is not gonna happen, so I'll convert all my overlays
> > > from .dtso to .dts....

-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
