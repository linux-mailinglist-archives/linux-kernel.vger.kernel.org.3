Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3258A006
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiHDRs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiHDRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:48:57 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687AE101EF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:48:56 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10edfa2d57dso412591fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RSuhwQUQ/rtlHZ0/kclF6sR3y8SDjI8wPdFTaAIfmE8=;
        b=pA5TqVCrqsfU3E1QS05RGTU3XdQaYQEL1rIkanyUCosL0FnWxJeieTDvzxMRKpF9LZ
         bcuNTTiH+XvLsEHA19T+IPa7YneFcn2RV9FtCUgLzQ3+SPqeyd0/hhScoCzRwfMncigD
         6odDNfaeIFS1OSBrRXhXp3hyDXwG02jFZ894kdfrwwZhuxDeYNul3r8lwOqTuZnfH17W
         oI2PHJeIESNUPGIlwPUtUnWDhbcqHPzgwjJ/X8Kvz7F+Cd+qhTpa4tj09VOyegKcmHKB
         a5/8yBAWDig6O/f0ubkESsFBPczUHPlT8nK728m/eaa7q/btLXyX+4pkjZlEwdgCutxk
         KA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RSuhwQUQ/rtlHZ0/kclF6sR3y8SDjI8wPdFTaAIfmE8=;
        b=V4vbsecbc7qGV5UH9lXaZ9K1gs3Rhl2/Yqz+bDKWqUc2lIWpDG0UZcVX6srQFApwDn
         RFDbFVOUAZgJP0PePjSmAK04ceV0H6FctLusmPTZo8rDlMZ7DQKofyCsSSjsZD5dWSt7
         uX31uCJh4aLWENY+EiKqJhFu5lPxespicadLcuUQ+j+UQhbXl9rJPuIAIzUMi81Kwsx8
         GH45ISN90wJCbZlRRfGpDVP9AyOmyFhEtFhAmddgMLZDLzhNwWBPavaYzHl4lWnM7eUu
         PuxV8ODcPVuTyJFZK2Y2T/F0Mw7uYNbYGvaUgzeQ/ZF9KID4i6IbSps7kcmS5tCuv3ne
         owvg==
X-Gm-Message-State: ACgBeo0DrNB7aN/bfJaHZipcp+6DhAJ9t+LBxka0N68/nob3KcthCARN
        Dh5OCUk5MzgS7gadh/3OhxjnOWMTNfmuv9z2RVc=
X-Google-Smtp-Source: AA6agR641/SV2Bllh6acKzFzyf8aJ1w6LSNmQ+XzJeUciEYy5SIPAV4FucSy24dkiLjEytsbgNfuIm4AxMvAic576X8=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr1395995oaq.166.1659635335065; Thu, 04
 Aug 2022 10:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com> <YuvctaLwRi+z0Gw4@nvidia.com>
In-Reply-To: <YuvctaLwRi+z0Gw4@nvidia.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 4 Aug 2022 20:48:28 +0300
Message-ID: <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 5:50 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Aug 04, 2022 at 10:43:42AM +0300, Oded Gabbay wrote:
>
> > After all, memory management services, or common device chars handling
> > I can get from other subsystems (e.g. rdma) as well. I'm sure I could
> > model my uAPI to be rdma uAPI compliant (I can define proprietary uAPI
> > there as well), but this doesn't mean I belong there, right ?
>
> You sure can, but there is still an expectation, eg in RDMA, that your
> device has a similarity to the established standards (like roce in
> habana's case) that RDMA is geared to support.
>
> I think the the most important thing to establish a new subsystem is
> to actually identify what commonalities it is supposed to be
> providing. Usually this is driven by some standards body, but the
> AI/ML space hasn't gone in that direction at all yet.
I agree. In the AI-world the standard doesn't exist and I don't see
anything on the horizon. There are the AI frameworks/compilers which
are 30,000 feet above us, and there is CUDA which is closed-source and
I have no idea what it does inside.
>
> We don't need a "subsystem" to have a bunch of drivers expose chardevs
> with completely unique ioctls.
I totally agree with this sentence and this is *exactly* why
personally I don't want to use DRM because when I look at the long
list of common IOCTLs in drm.h, I don't find anything that I can use.
It's simply either not relevant at all to my h/w or it is something
that our h/w implemented differently.

This is in contrast to the rdma, where as you said, we have ibverbs
API. So, when you asked that we write an IBverbs driver I understood
the reasoning. There is a common user-space library which talks to the
rdma drivers and all the rdma applications use that library and once I
will write a (somewhat) standard driver, then hopefully I can enjoy
all that.

>
> The flip is true of DRM - DRM is pretty general. I bet I could
> implement an RDMA device under DRM - but that doesn't mean it should
> be done.
>
> My biggest concern is that this subsystem not turn into a back door
> for a bunch of abuse of kernel APIs going forward. Though things are
How do you suggest to make sure it won't happen ?

> better now, we still see this in DRM where expediency or performance
> justifies hacky shortcuts instead of good in-kernel architecture. At
> least DRM has reliable and experienced review these days.
Definitely. DRM has some parts that are really well written. For
example, the whole char device handling with sysfs/debugfs and managed
resources code. This is something I would gladly either use or
copy-paste into the hw accel subsystem.
And of course more pairs of eyes looking at the code will usually
produce better code.

I think that it is clear from my previous email what I intended to
provide. A clean, simple framework for devices to register with, get
services for the most basic stuff such as device char handling,
sysfs/debugfs. Later on, add more simple stuff such as memory manager
and uapi for memory handling. I guess someone can say all that exists
in drm, but like I said it exists in other subsystems as well.

I want to be perfectly honest and say there is nothing special here
for AI. It's actually the opposite, it is a generic framework for
compute only. Think of it as an easier path to upstream if you just
want to do compute acceleration. Maybe in the future it will be more,
but I can't predict the future.

If that's not enough for a new subsystem, fair enough, I'll withdraw my offer.

Thanks,
Oded

>
> Jason
