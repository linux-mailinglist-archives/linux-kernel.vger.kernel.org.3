Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED5E58950B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiHCXyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbiHCXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:54:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661CF7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:54:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m8so23279105edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DGbVXvn0p8z6n16D3EkJmoWdnWBBlfc2vbyBDsF6Q28=;
        b=NAnbvqQK6mNA+dzF8+Uu9faxrmdyF6kLS4J+TEN26d99qUrFVu8GaiVn2uKvkZHHQS
         J0D34iOCELARm/Ip/tm3McyR6RjKXauNkPNcNzK/X/xYUli7bLDTwwztFCkx95aVRQJs
         4ewZm7Jtd1kMi5DVodhjw7aPkRHN71wwYXv4LnMyAQ3vNWvGIz4/b/fWFj7mhNITnIZM
         xfC7sUHf1KYOBPzeyQAB5R2+ykXK7oBxVfWwhZSKTWTNPOFtjatOqchrTFwEaVbMJaHp
         jyj8sA1W5mm9Zb/5im88cLhAjyjLW+3gIDJGCnXNV6ML/OJDSGTa8dFToJvYlzv7IpzV
         A70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DGbVXvn0p8z6n16D3EkJmoWdnWBBlfc2vbyBDsF6Q28=;
        b=w2jDq8lWCJo19xRSLSZ3NInWePT1Yo+18rFmr2oSmkG+3nHwM3KJ4o3TiFezkLw7Q0
         HJWiAkgcQ+G59qvIYocILry5ni5PoE8zZpmhtm//fI5ivlbrzJRT6fxz0Nv6r5AniesG
         z3UHqjKPizyoKqWaHSg7eSjEJTjJ/MpRElpGJK/kbeFHt+CSjKPkRCiQBGs4N6rMQpNn
         y0M7bdYDdYyR+3v/QJ02iM/J3smiYxYgVCEJ3yqEp+iQCUIlpJiKP6Uu+tgRz2yDOOTD
         zbQml5bmRMToI0iLVAkwkescJgGnZdg/n0Cs3xbgzGWcMmF3TQ0ns5yd9HG2/eM34U2q
         GB5w==
X-Gm-Message-State: ACgBeo2+PplJ5uc2f2XiBlYwjHmvvmWzxiJDRP7Ij5kCLDkiyhIjmmeb
        U8MjOhc+H1Rj4QdB4oLkrbeuysvwrHf0lyDTwWY=
X-Google-Smtp-Source: AA6agR6u1Qozmw2noaYYlAg3nVjqWSctgEm6XiGd0jNCdGhoeBixL4WyU7qZW0uJcVBSVtOn5eX5KzZ8cwqumjb6iLI=
X-Received: by 2002:a05:6402:249b:b0:43c:8ce6:8890 with SMTP id
 q27-20020a056402249b00b0043c8ce68890mr11142175eda.74.1659570887205; Wed, 03
 Aug 2022 16:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <CAPM=9tzWuoWAOjHJdJYVDRjoRq-4wpg2KGiCHjLLd+OfWEh5AQ@mail.gmail.com> <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
In-Reply-To: <CAFCwf12N6DeJAQVjY7PFG50q2m405e=XCCFvHBn1RG65BGbT8w@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 4 Aug 2022 09:54:35 +1000
Message-ID: <CAPM=9txSKv_xwZJ6SndtqsdQm6aK1KJVF91dB5Odhc_Xv6Qdrw@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, 4 Aug 2022 at 06:21, Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Wed, Aug 3, 2022 at 10:04 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Sun, 31 Jul 2022 at 22:04, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > Hi,
> > > Greg and I talked a couple of months ago about preparing a new accel
> > > subsystem for compute/acceleration devices that are not GPUs and I
> > > think your drivers that you are now trying to upstream fit it as well.
> >
> > We've had some submissions for not-GPUs to the drm subsystem recently.
> >
> > Intel GNA, Intel VPU, NVDLA, rpmsg AI processor unit.
> >
> > why is creating a new subsystem at this time necessary?
> >
> > Are we just creating a subsystem to avoid the open source userspace
> > consumer rules? Or do we have some concrete reasoning behind it?
> >
> > Dave.
>
> Hi Dave.
> The reason it happened now is because I saw two drivers, which are
> doing h/w acceleration for AI, trying to be accepted to the misc
> subsystem.
> Add to that the fact I talked with Greg a couple of months ago about
> doing a subsystem for any compute accelerators, which he was positive
> about, I thought it is a good opportunity to finally do it.
>
> I also honestly think that I can contribute much to these drivers from
> my experience with the habana driver (which is now deployed in mass at
> AWS) and contribute code from the habana driver to a common framework
> for AI drivers.

Why not port the habana driver to drm now instead? I don't get why it
wouldn't make sense?

Stepping up to create a new subsystem is great, but we need rules
around what belongs where, we can't just spawn new subsystems when we
have no clear guidelines on where drivers should land.

What are the rules for a new accel subsystem? Do we have to now
retarget the 3 drivers that are queued up to use drm for accelerators,
because 2 drivers don't?

There's a lot more to figure out here than merge some structures and
it will be fine.

I think the one area I can see a divide where a new subsystem is for
accelerators that are single-user, one shot type things like media
drivers (though maybe they could be just media drivers).

I think anything that does command offloading to firmware or queues
belongs in drm, because that is pretty much what the framework does. I
think it might make sense to enhance some parts of drm to fit things
in better, but that shouldn't block things getting started.

I'm considering if, we should add an accelerator staging area to drm
and land the 2-3 submissions we have and try and steer things towards
commonality that way instead of holding them out of tree.

I'd like to offload things from Greg by just not having people submit
misc drivers at all for things that should go elsewhere.

Dave.


>
> Regarding the open source userspace rules in drm - yes, I think your
> rules are too limiting for the relatively young AI scene, and I saw at
> the 2021 kernel summit that other people from the kernel community
> think that as well.
> But that's not the main reason, or even a reason at all for doing
> this. After all, at least for habana, we open-sourced our compiler and
> a runtime library. And Greg also asked those two drivers if they have
> matching open-sourced user-space code.
>
> And a final reason is that I thought this can also help in somewhat
> reducing the workload on Greg. I saw in the last kernel summit there
> was a concern about bringing more people to be kernel maintainers so I
> thought this is a step in the right direction.
>
> Oded
