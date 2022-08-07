Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFA58B9DB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiHGGvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 02:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiHGGvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 02:51:04 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F342AC9
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 23:51:03 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10ec41637b3so7346084fac.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EiRzVeypDLqjukzgf6iPX2b/MdoDSPrXUwydmAaPBNI=;
        b=ED7K+KhvdVGJGvdJ09bzRo9yLCld9L+T4nMDpRcNd7ScBb58Y9UoYatqTwKvNQ2btA
         PaLYb8pzG+mwHK9942wS3iISv1F82RL65+F+T33tSTqGy8lVx17AhR5sEIh2zk5Q7Wp+
         ox1SAA52oF5D/XUUndg+boIZBYv7SS/eerpEFzkHqKwP6WA4FkxlTWqIqnbd1s/u59YB
         Uz5B0/36kmYvehCzL+zmBHAlx7IB6xVXlhypqlG5u5zx/7Hcj0XezL+Aa2xxzTt+ZU7K
         pCS2cXNvSAk3/c+iNpb4HbvyKNbGnUGHBrxNorfo1wxSzEDQ8zahq9LMlUNu58Cl6yfJ
         dvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EiRzVeypDLqjukzgf6iPX2b/MdoDSPrXUwydmAaPBNI=;
        b=bqZfOiJElvjF+2sqI38lTriXMAVUv7G58GsmMJk9f1bD+W0bIPn4Ma/CtqJY2OdA9H
         rW/plYkuHzK7Sv2TvK2EmrwKqFyl/KC00KMS+cUXJICqHs1Hni4yX53k0UCoKnQ3yapn
         xoXOv6mAw0BYCo2B821NaBO0LmYlX90iOQH7o25kpn2IbuuEExYsy5kSi7adgBXrN4kj
         Mr3jfSoXQ4s+/BCWsS34pvQqaPEYEXJzUdJNRVF7Ny2wZz4ZqkDeIPRg1vw1pFM1dR5F
         2UQCvo8LgaXUsakvGdYX4U4H8VV+5ZXXr1hjvWkMscVY9wvc21jrnh0HohgWZHePc/qG
         5NOQ==
X-Gm-Message-State: ACgBeo0yFY2lxBL2PtDh9d1PlECtTAIQp1aHm8/nq3LSn+UtVx3D8Qvb
        I+zIJj00T3fhPUmxk5Dlhk/g/Rzc7f0y82Cdo+k=
X-Google-Smtp-Source: AA6agR6sbWFxXP5h8M895+SO9oU2pluE0JjudvrRoYSSVANsB5kRCEcLzhZ4eUnbD+Y+/Zk73NOWiJCk0fRx4wpUHf8=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr5973437oaq.166.1659855062791; Sat, 06
 Aug 2022 23:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com> <CAPM=9txme2dQD9kyM6gnYyXL34hYP8wcGMbduOUcFsKe+4zTcQ@mail.gmail.com>
In-Reply-To: <CAPM=9txme2dQD9kyM6gnYyXL34hYP8wcGMbduOUcFsKe+4zTcQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 7 Aug 2022 09:50:35 +0300
Message-ID: <CAFCwf11TPKTF_Ndi60FneWp5g3SoawJvfJoKVWJ-QjxjpawMmg@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
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

On Fri, Aug 5, 2022 at 6:03 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 4 Aug 2022 at 17:44, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Thu, Aug 4, 2022 at 2:54 AM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Thu, 4 Aug 2022 at 06:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 3, 2022 at 10:04 PM Dave Airlie <airlied@gmail.com> wrote:
> > > > >
> > > > > On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > > Greg and I talked a couple of months ago about preparing a new accel
> > > > > > subsystem for compute/acceleration devices that are not GPUs and I
> > > > > > think your drivers that you are now trying to upstream fit it as well.
> > > > >
> > > > > We've had some submissions for not-GPUs to the drm subsystem recently.
> > > > >
> > > > > Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.
> > > > >
> > > > > why is creating a new subsystem at this time necessary?
> > > > >
> > > > > Are we just creating a subsystem to avoid the open source userspace
> > > > > consumer rules? Or do we have some concrete reasoning behind it?
> > > > >
> > > > > Dave.
> > > >
> > > > Hi Dave.
> > > > The reason it happened now is because I saw two drivers, which are
> > > > doing h/w acceleration for AI, trying to be accepted to the misc
> > > > subsystem.
> > > > Add to that the fact I talked with Greg a couple of months ago about
> > > > doing a subsystem for any compute accelerators, which he was positive
> > > > about, I thought it is a good opportunity to finally do it.
> > > >
> > > > I also honestly think that I can contribute much to these drivers from
> > > > my experience with the habana driver (which is now deployed in mass at
> > > > AWS) and contribute code from the habana driver to a common framework
> > > > for AI drivers.
> > >
> > > Why not port the habana driver to drm now instead? I don't get why it
> > > wouldn't make sense?
> >
> > imho, no, I don't see the upside. This is not a trivial change, and
> > will require a large effort. What will it give me that I need and I
> > don't have now ?
>
> The opportunity for review, code sharing, experience of locking
> hierarchy, mm integration?
>
> IMHO The biggest thing that drm has is the community of people who
> understand accelerators, memory management, userspace command
> submissions, fencing, dma-buf etc.
>
> It's hard to have input to those discussions from the outside, and
> they are always ongoing.
>
> I think one of the Intel teams reported dropping a lot of code on
> their drm port due to stuff already being there, I'd expect the same
> for you.
>
> The opposite question is also valid, what does moving to a new
> subsystem help you or others, when there is one with all the
> infrastructure and more importantly reviewers.
>
> I'd be happy to have accelerator submaintainers, I'd be happy to even
> create an ACCELERATOR property for non-gpu drivers, so they can opt
> out of some of the GPUier stuff, like multiple device node users etc,
> or even create a new class of device nodes under /dev/dri.
>
I'm taking all what you wrote seriously, these are all good points.
As I wrote to Jason, I don't want to jump the gun here. I think we
should discuss this and explore the possibilities that you suggested
because I would like to reach consensus if possible.
Maybe this is something we can discuss in LPC or in the kernel summit ?

Oded

>
> > I totally agree. We need to set some rules and make sure everyone in
> > the kernel community is familiar with them, because now you get
> > different answers based on who you consult with.
> >
> > My rules of thumb that I thought of was that if you don't have any
> > display (you don't need to support X/wayland) and you don't need to
> > support opengl/vulkan/opencl/directx or any other gpu-related software
> > stack, then you don't have to go through drm.
> > In other words, if you don't have gpu-specific h/w and/or you don't
> > need gpu uAPI, you don't belong in drm.
>
> What happens when NVIDIA submit a driver for just compute or intel?
> for what is actually a GPU?
> This has been suggested as workaround for our userspace rules a few times.
>
> If my GPU can do compute tasks, do I have to add an accelerator
> subsystem driver alongside my GPU one?
>
> > After all, memory management services, or common device chars handling
> > I can get from other subsystems (e.g. rdma) as well. I'm sure I could
> > model my uAPI to be rdma uAPI compliant (I can define proprietary uAPI
> > there as well), but this doesn't mean I belong there, right ?
>
> Good point, but I think accelerators do mostly belong in drm or media,
> because there is enough framework around them to allow them to work,
> without reinventing everything.
>
> > >
> > > I think the one area I can see a divide where a new subsystem is for
> > > accelerators that are single-user, one shot type things like media
> > > drivers (though maybe they could be just media drivers).
> > >
> > > I think anything that does command offloading to firmware or queues
> > > belongs in drm, because that is pretty much what the framework does. I
> > I think this is a very broad statement which doesn't reflect reality
> > in the kernel.
>
> I think the habanalabs driver is one of the only ones that is outside
> this really, and in major use. There might be one or two other minor
> drivers with no real users.
>
> Dave.
