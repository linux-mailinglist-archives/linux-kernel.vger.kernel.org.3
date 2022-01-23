Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE234972F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiAWQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiAWQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:17:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AFC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C28960F64
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572CCC340E8;
        Sun, 23 Jan 2022 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642954676;
        bh=8ocM8NfepuzO2PWIYLNWmobi6Q6duWrlTkUf4R4FV0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5IMIFv2wv6h4HftGg4BVqs19rrewU+nA7IM/RpiI5vxOe63/QraPYFDMEexMEZyy
         dzOK9BkLmdthfs3sAj4NVaDmNz6yrQxIGz+MbJbA2yrDQ5tR5T8RMc99fvuKyFMaHE
         NywGfo+TZf2ii3JzjjKJuckjYMShmPbs4N7xizcU=
Date:   Sun, 23 Jan 2022 17:17:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
Message-ID: <Ye1/nECWs9XtUzoJ@kroah.com>
References: <20220111114724.7987-1-cai.huoqing@linux.dev>
 <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
 <Ye1ua3ixuSfdhiRc@kroah.com>
 <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
 <Ye19hz9r0poT5wUe@kroah.com>
 <CAFCwf11ahKse1MYcBFfSBvFf1WnG3rxR6dmJiUhZUu2rZQBB-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11ahKse1MYcBFfSBvFf1WnG3rxR6dmJiUhZUu2rZQBB-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 06:11:54PM +0200, Oded Gabbay wrote:
> On Sun, Jan 23, 2022 at 6:08 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jan 23, 2022 at 06:01:53PM +0200, Oded Gabbay wrote:
> > > On Sun, Jan 23, 2022 at 5:04 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Sun, Jan 23, 2022 at 04:43:15PM +0200, Oded Gabbay wrote:
> > > > > On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> > > > > >
> > > > > > The driver don't support the SRAM-to-SRAM translation of DMA,
> > > > > > so remove 'DMA_SRAM_TO_SRAM'.
> > > > > >
> > > > > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > > > > ---
> > > > > >  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
> > > > > >  1 file changed, 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > > index ef54bad20509..25fbebdc6143 100644
> > > > > > --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > > +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > > @@ -36,7 +36,6 @@ enum goya_dma_direction {
> > > > > >         DMA_SRAM_TO_HOST,
> > > > > >         DMA_DRAM_TO_HOST,
> > > > > >         DMA_DRAM_TO_DRAM,
> > > > > > -       DMA_SRAM_TO_SRAM,
> > > > > >         DMA_ENUM_MAX
> > > > > >  };
> > > > > >
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > >
> > > > > This is a general spec file in our s/w stack, and therefore a change
> > > > > in it in the driver will cause our driver to be out of sync with our
> > > > > user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
> > > > > the driver and in the user-space stack. I don't know if there will be
> > > > > any consequences but I prefer not to risk it.
> > > >
> > > > If this is synced to userspace, shouldn't it be in a uapi file with a
> > > > specific value associated with it?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Yes, it was a mistake from day 1. A mistake we didn't repeat in future ASICs.
> > > I take great care of putting anything that is synced between driver
> > > and userspace in our uapi file.
> > >
> > > Having said that, after almost 3 years of having this mistake, I feel
> > > it is not too disastrous to leave it as is.
> > > Our Goya s/w stack is pretty much stable and I don't want to make
> > > changes without good reason.
> >
> > You should just move this to a uapi file to show that it is something
> > that can't be changed.  Can't you do that without breaking anything on
> > the kernel side?
> On the kernel side there isn't any problem with moving it.
> What I'm afraid of, is that the userspace will now have a duplicate
> definition of this enum.
> Both in the original file, which is included in the user space stack
> from day 1, and from our uapi file.
> In short, I'm afraid of breaking its compilation.
> If you think that's acceptable, I don't have a problem moving it.
> 
> >
> > Otherwise maintaining this is going to be hard as no one has a clue that
> > this is a value that userspace uses.
> 
> I can document it with a BIG comment in the file.
> And as I said, Goya s/w stack is pretty much fixed and I don't believe
> is going to change anymore.

The trick is long-term maintaince for the next 20+ years of this code in
the kernel.  A huge comment would help, but even better to move this
where it needs to go in a uapi file so that it makes it obvious we can
not change this.

thanks,

greg k-h
