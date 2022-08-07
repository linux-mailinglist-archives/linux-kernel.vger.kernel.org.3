Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278158B9D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiHGGoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHGGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:44:09 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668611A25
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:44:07 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10e6bdbe218so7311876fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rykXABvf/RBgGvjVsxphBq8Vy12g5+wYwiONLOxb11Y=;
        b=jOVPMWuszYFDr4/i17H8OsSMDqKOmyM7j82OwYGMMq/TV3dxAE/iACec26LE+4Fyjl
         L07jMWpGFHQXf/wnNkHvZruHnu4NjPFrad7YcLbhAv7Y/YYRwr/7Z+0d99LbGeOem7fK
         MiyYeTZULzoBkf7lMvISanBx4NHM4RLoIV26wj5gQlhddfeJCIFnpAQbe2b5yTShb9Gc
         j7lBR7ovBet/p4pCNz5n9Xyz03x2/J9EsKQ6pwbfa1vjtC0afq1muyAI/2gk8K9S32Xo
         YtF5PwyE4/hZ3w9rgKEdQmCooJamFcO4l0/WuLlVXSDEEAOQx4FXlkOvQBA22OPtkR+U
         yvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rykXABvf/RBgGvjVsxphBq8Vy12g5+wYwiONLOxb11Y=;
        b=mjrnUbzUlGZLekgFQYqfRVcth7F0SlrueHphhczHKhvLquT1zpkhjIIuS17sAYC0hZ
         /tiur6C/uhLzsEOI9L43lrlmANGn4GmOLB18kD6T/tcngXww5KeQ7laDZAXSgJqwSqns
         oIe7n5Tht96ocbbtcCndthhRhsxC8CcqE4eSgBeJ0TBxjqoOGJdR0z4Vxtilm6WqFuT3
         tph1RWeFFUHKkiBimalwB8xlPY2wsjY6XJJ3ASDyGcXaH0qu+pFrvoUTJKk7HgMKZW2y
         sZD6BEsxn+5A/mgEmaGwaGJDfHF+ufFfAhwX7zHljJcjytBcsm7q/9FIpcnoinsRF77u
         sUOg==
X-Gm-Message-State: ACgBeo3z2UxRnVYpfoCamQSdFnXKzJ/2Bo+xuIjJHNIyPYnJditVJQ8E
        I0i7CLxKF3jRK2sNgvWPE+p+5Ejv6tjlMH8esPQ=
X-Google-Smtp-Source: AA6agR5vXfbyiu5FDHn9wTeRxP2BxpIDjYWTtd7gn+zWvvN23ClEVC+H4pjysAjeJ5AaYOeQ/BAFwwagfz+NAH/dByk=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr5968348oaq.166.1659854646756; Sat, 06
 Aug 2022 23:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <YuvctaLwRi+z0Gw4@nvidia.com> <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
 <Yuxi1eRHPN36Or+1@nvidia.com>
In-Reply-To: <Yuxi1eRHPN36Or+1@nvidia.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 7 Aug 2022 09:43:40 +0300
Message-ID: <CAFCwf13QF_JdzNcpw==zzBoEQUYChMXfechotH31qmAfYZUGmg@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 3:22 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Aug 04, 2022 at 08:48:28PM +0300, Oded Gabbay wrote:
>
> > > The flip is true of DRM - DRM is pretty general. I bet I could
> > > implement an RDMA device under DRM - but that doesn't mean it should
> > > be done.
> > >
> > > My biggest concern is that this subsystem not turn into a back door
> > > for a bunch of abuse of kernel APIs going forward. Though things
> > > are
> >
> > How do you suggest to make sure it won't happen ?
>
> Well, if you launch the subsystem then it is your job to make sure it
> doesn't happen - or endure the complaints :)
Understood, I'll make sure there is no room for complaints.
>
> Accelerators have this nasty tendancy to become co-designed with their
> SOCs in nasty intricate ways and then there is a desire to punch
> through all the inconvenient layers to make it go faster.
>
> > > better now, we still see this in DRM where expediency or performance
> > > justifies hacky shortcuts instead of good in-kernel architecture. At
> > > least DRM has reliable and experienced review these days.
> > Definitely. DRM has some parts that are really well written. For
> > example, the whole char device handling with sysfs/debugfs and managed
> > resources code.
>
> Arguably this should all be common code in the driver core/etc - what
> value is a subsystem adding beyond that besides using it properly?

I mainly see two things here:

1. If there is a subsystem which is responsible for creating and
exposing the device character files, then there should be some code
that connects between each device driver to that subsystem.
i.e. There should be functions that each driver should call from its
probe and release callback functions.

Those functions should take care of the following:
- Create metadata for the device, the device's minor(s) and the
driver's ioctls table and driver's callback for file operations (both
are common for all the driver's devices). Save all that metadata with
proper locking.
- Create the device char files themselves and supply file operations
that will be called per each open/close/mmap/etc.
- Keep track of all these objects' lifetime in regard to the device
driver's lifetime, with proper handling for release.
- Add common handling and entries of sysfs/debugfs for these devices
with the ability for each device driver to add their own unique
entries.

2. I think that you underestimate (due to your experience) the "using
it properly" part... It is not so easy to do this properly for
inexperienced kernel people. If we provide all the code I mentioned
above, the device driver writer doesn't need to be aware of all these
kernel APIs.

>
> It would be nice to at least identify something that could obviously
> be common, like some kind of enumeration and metadata kind of stuff
> (think like ethtool, devlink, rdma tool, nvemctl etc)
Definitely. I think we can have at least one ioctl that will be common
to all drivers from the start.
A kind of information retrieval ioctl. There are many information
points that I'm sure are common to most accelerators. We have an
extensive information ioctl in the habanalabs driver and most of the
information there is not habana specific imo.
>
> > I think that it is clear from my previous email what I intended to
> > provide. A clean, simple framework for devices to register with, get
> > services for the most basic stuff such as device char handling,
> > sysfs/debugfs.
>
> This should all be trivially done by any driver using the core codes,
> if you see gaps I'd ask why not improve the core code?
>
> > Later on, add more simple stuff such as memory manager
> > and uapi for memory handling. I guess someone can say all that exists
> > in drm, but like I said it exists in other subsystems as well.
>
> This makes sense to me, all accelerators need a way to set a memory
> map, but on the other hand we are doing some very nifty stuff in this
> area with iommufd and it might be very interesting to just have the
> accelerator driver link to that API instead of building yet another
> copy of pin_user_pages() code.. Especially with PASID likely becoming
> part of any accelerator toolkit.
Here I disagree with you. First of all, there are many relatively
simple accelerators, especially in edge, where PASID is really not
relevant.
Second, even for the more sophisticated PCIe/CXL-based ones, PASID is
not mandatory and I suspect that it won't be in 100% of those devices.
But definitely that should be an alternative to the "classic" way of
handling dma'able memory (pin_user_pages()).
>
> > I want to be perfectly honest and say there is nothing special here
> > for AI. It's actually the opposite, it is a generic framework for
> > compute only. Think of it as an easier path to upstream if you just
> > want to do compute acceleration. Maybe in the future it will be more,
> > but I can't predict the future.
>
> I can't either, and to be clear I'm only questioning the merit of a
> "subsystem" eg with a struct class, rigerous uAPI, etc.
>
> The idea that these kinds of accel drivers deserve specialized review
> makes sense to me, even if they remain as unorganized char
> devices. Just understand that is what you are signing up for :)
I understand. That's why I'm taking all your points very seriously.
This is not a decision that should be taken lightly and I want to be
sure most agree this is the correct way forward.
My next step is to talk to Dave about it in-depth. In his other email
he wrote some interesting ideas which I want to discuss with him.

Maybe this is something that should be discussed in the kernel summit ?

>
> Jason
