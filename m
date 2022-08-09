Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB358E1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiHIVnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiHIVmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:42:53 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815916AA13
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:42:52 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10dc1b16c12so15600682fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=c2RVyEFSA9umN2pgK4UBtCL863gZQQ033iSr6QAmH+E=;
        b=az1vVJEsplucgk/ZS+3cAJxh/HVR+kLON51jWB+2aC4MDW8jXKDBeoQ0fhpKKrhliV
         cfocKinTRGdFQCBNWXujrRak+ckGtUR1hg7jrobOkhScE5Lqp1RQ7s4MDu6lqvu4lXzW
         3xlqyZDO4JpqH6EEUh7HeQ4jzdIPb8CRVe7rcMdjW0+OVJ8S77pcZag62FL5ItVy91FG
         2NPbKvXb5ME4CXLyo6nAxMzo1GiK5SrADCA773JbIOQqitKqqmTkTY/jbblYtbqB2RO0
         VjYx+pZJLFuxufd4LhnBSn0RpsTXCCKhZaKoYadvBLdxa48v2qZrrGl7wgKVmEJAc2rj
         ztVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=c2RVyEFSA9umN2pgK4UBtCL863gZQQ033iSr6QAmH+E=;
        b=uOQII+hjCvtr5ExwgvZ77mDjfenZf/aFmOG/YBLZ5LDB+1HNnySZqN5uIq6OhTzxo2
         qBWajFz4r13wXagb6UNPlKI5DLi1efDMlFC6JnhKqTpY8Zl3L9THvsoF/JXb1bID0OAu
         ZZt3qhgXZQulNQ10aq1hp370At1pqBIQIZyPsWaDS6OCGpOR4bYK8G2mdEM7NEKA+jDy
         mzNlDaQJGTy+ePOnz/dBAVgMUUGXTZo9IcEcu218L2wV+MqjB8fvrSpUu76/8x1yQk/j
         RNN98M+0p+z2rzbjHsuZSiB4JMC+mEAglvJBvoxlqUXa0bdEOZKMd5XFGAYzb0i/i84k
         us7Q==
X-Gm-Message-State: ACgBeo0L3pMryoEjUklU53umYUYb9Cm+hOVkXX+fqaAUV69ioIyuPh4N
        J6NMupFa3iI4uUzXHr1fyHp0kNNOUClLC8kmfJCfORy92Of+ew==
X-Google-Smtp-Source: AA6agR6BJFUtUMOAIRYK9SI/NdE94nRmhOJ6YKpw3JSmHP+Z/QTPjjPhdG5BWq2aKlrY3NljyldR9sVIK3KK8wNTR+E=
X-Received: by 2002:a05:6870:961d:b0:10d:7606:b212 with SMTP id
 d29-20020a056870961d00b0010d7606b212mr204056oaq.166.1660081371704; Tue, 09
 Aug 2022 14:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com>
 <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
 <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
 <CAFCwf10CsLgt+_qT7dT=8DVXsL0a=w=uXN6HC=CpP5EfitvLfQ@mail.gmail.com>
 <CAPM=9txme2dQD9kyM6gnYyXL34hYP8wcGMbduOUcFsKe+4zTcQ@mail.gmail.com> <CAFCwf11TPKTF_Ndi60FneWp5g3SoawJvfJoKVWJ-QjxjpawMmg@mail.gmail.com>
In-Reply-To: <CAFCwf11TPKTF_Ndi60FneWp5g3SoawJvfJoKVWJ-QjxjpawMmg@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 10 Aug 2022 00:42:24 +0300
Message-ID: <CAFCwf13WU3ZEjurEaEnVC56zorwKr-uuQn-ec10r301Fh+XEtA@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
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

On Sun, Aug 7, 2022 at 9:50 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Fri, Aug 5, 2022 at 6:03 AM Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Thu, 4 Aug 2022 at 17:44, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > On Thu, Aug 4, 2022 at 2:54 AM Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > On Thu, 4 Aug 2022 at 06:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > >
> > > > > On Wed, Aug 3, 2022 at 10:04 PM Dave Airlie <airlied@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > > Greg and I talked a couple of months ago about preparing a new accel
> > > > > > > subsystem for compute/acceleration devices that are not GPUs and I
> > > > > > > think your drivers that you are now trying to upstream fit it as well.
> > > > > >
> > > > > > We've had some submissions for not-GPUs to the drm subsystem recently.
> > > > > >
> > > > > > Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.
> > > > > >
> > > > > > why is creating a new subsystem at this time necessary?
> > > > > >
> > > > > > Are we just creating a subsystem to avoid the open source userspace
> > > > > > consumer rules? Or do we have some concrete reasoning behind it?
> > > > > >
> > > > > > Dave.
> > > > >
> > > > > Hi Dave.
> > > > > The reason it happened now is because I saw two drivers, which are
> > > > > doing h/w acceleration for AI, trying to be accepted to the misc
> > > > > subsystem.
> > > > > Add to that the fact I talked with Greg a couple of months ago about
> > > > > doing a subsystem for any compute accelerators, which he was positive
> > > > > about, I thought it is a good opportunity to finally do it.
> > > > >
> > > > > I also honestly think that I can contribute much to these drivers from
> > > > > my experience with the habana driver (which is now deployed in mass at
> > > > > AWS) and contribute code from the habana driver to a common framework
> > > > > for AI drivers.
> > > >
> > > > Why not port the habana driver to drm now instead? I don't get why it
> > > > wouldn't make sense?
> > >
> > > imho, no, I don't see the upside. This is not a trivial change, and
> > > will require a large effort. What will it give me that I need and I
> > > don't have now ?
> >
> > The opportunity for review, code sharing, experience of locking
> > hierarchy, mm integration?
> >
> > IMHO The biggest thing that drm has is the community of people who
> > understand accelerators, memory management, userspace command
> > submissions, fencing, dma-buf etc.
> >
> > It's hard to have input to those discussions from the outside, and
> > they are always ongoing.
> >
> > I think one of the Intel teams reported dropping a lot of code on
> > their drm port due to stuff already being there, I'd expect the same
> > for you.
> >
> > The opposite question is also valid, what does moving to a new
> > subsystem help you or others, when there is one with all the
> > infrastructure and more importantly reviewers.
> >
> > I'd be happy to have accelerator submaintainers, I'd be happy to even
> > create an ACCELERATOR property for non-gpu drivers, so they can opt
> > out of some of the GPUier stuff, like multiple device node users etc,
> > or even create a new class of device nodes under /dev/dri.
> >
> I'm taking all what you wrote seriously, these are all good points.
> As I wrote to Jason, I don't want to jump the gun here. I think we
> should discuss this and explore the possibilities that you suggested
> because I would like to reach consensus if possible.
> Maybe this is something we can discuss in LPC or in the kernel summit ?
>
> Oded

Hi Jiho, Yuji.

I want to update that I'm currently in discussions with Dave to figure
out what's the best way to move forward. We are writing it down to do
a proper comparison between the two paths (new accel subsystem or
using drm). I guess it will take a week or so.

In the meantime, I'm putting the accel code on hold. I have only
managed to do the very basic infra and add a demo driver that shows
how to register and unregister from it.
You can check the code at:
https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/log/?h=accel

It has two commits. The first adds the subsystem code and the second
adds the demo driver.
The subsystem code is basically drm code copied and renamed and
slightly modified, but I really only worked on it for a couple of
hours so take that into consideration.

The important thing is that the demo driver shows the basic steps are
really simple. You need to add two function calls in your probe and
one function call in your release. Of course you will need to supply
some function callbacks, but I haven't got to fill that in the demo
driver. Once you register, you get /dev/accel/ac0 and
/dev/accel/ac_controlD64 (if you want a control device). If I were to
continue this, the next step is to do the open and close part.

I will update once we know where things are heading. As I said, I
imagine it can take a few weeks.

Thanks,
Oded


Oded

>
> >
> > > I totally agree. We need to set some rules and make sure everyone in
> > > the kernel community is familiar with them, because now you get
> > > different answers based on who you consult with.
> > >
> > > My rules of thumb that I thought of was that if you don't have any
> > > display (you don't need to support X/wayland) and you don't need to
> > > support opengl/vulkan/opencl/directx or any other gpu-related software
> > > stack, then you don't have to go through drm.
> > > In other words, if you don't have gpu-specific h/w and/or you don't
> > > need gpu uAPI, you don't belong in drm.
> >
> > What happens when NVIDIA submit a driver for just compute or intel?
> > for what is actually a GPU?
> > This has been suggested as workaround for our userspace rules a few times.
> >
> > If my GPU can do compute tasks, do I have to add an accelerator
> > subsystem driver alongside my GPU one?
> >
> > > After all, memory management services, or common device chars handling
> > > I can get from other subsystems (e.g. rdma) as well. I'm sure I could
> > > model my uAPI to be rdma uAPI compliant (I can define proprietary uAPI
> > > there as well), but this doesn't mean I belong there, right ?
> >
> > Good point, but I think accelerators do mostly belong in drm or media,
> > because there is enough framework around them to allow them to work,
> > without reinventing everything.
> >
> > > >
> > > > I think the one area I can see a divide where a new subsystem is for
> > > > accelerators that are single-user, one shot type things like media
> > > > drivers (though maybe they could be just media drivers).
> > > >
> > > > I think anything that does command offloading to firmware or queues
> > > > belongs in drm, because that is pretty much what the framework does. I
> > > I think this is a very broad statement which doesn't reflect reality
> > > in the kernel.
> >
> > I think the habanalabs driver is one of the only ones that is outside
> > this really, and in major use. There might be one or two other minor
> > drivers with no real users.
> >
> > Dave.
