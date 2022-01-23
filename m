Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB474972FE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiAWQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:25:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41560 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiAWQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:25:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6563660FA2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3CFC340EA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642955107;
        bh=cPlDL4zZlWCHLe9InWLBMJgkYZnfoK6xzQycvLedwOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DrJ5O2a9a8jY78KP+oIBLMWeXp9gS3QE2oXw4apPzcNNWvkmWyX2ltOhtpTICLits
         Cw5qqQplynG+4piCvhKxg2s5EmjzzAf6aTMZEZnT/MgKaDnpdZ2/uRp/4iw75C6nvj
         alRowWk+itVp5dNp0f0l7mWdsh3MBhOc1qOWBioITBf9zbFrI8X87tB6ibOgcOb/ht
         C4re2O1Nt3JY728GSYuAgk9jgKsildbidYSCRLPPp9OdKgIynxH8J5Z3K6wUK+Oz4W
         kMFJFlbb3VHxwegViSTCEfk2b38thpzAo/Y1TVqYzFLGTIMdIuPzkeqDanKqcLSdzc
         Vr1E/+sI3MWzg==
Received: by mail-yb1-f175.google.com with SMTP id k31so41991398ybj.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:25:07 -0800 (PST)
X-Gm-Message-State: AOAM532ZedSG3DLGPaF1amGufqN8yvy2j0w2Z1RayMGFSIXjIXdWn9NX
        Tf333oORfLEP3O3Jk4Tc8mKbn53mv/w1MA8eN00=
X-Google-Smtp-Source: ABdhPJxQxLlB61nXF6/OIlwYEyu+KgqDOtioKhJ1R7c6L9R7gXSOGWUEY2LP4uMkZQnP7QHkC6U9aHnE/Spp9sKR9dU=
X-Received: by 2002:a25:b851:: with SMTP id b17mr19285353ybm.122.1642955106889;
 Sun, 23 Jan 2022 08:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20220111114724.7987-1-cai.huoqing@linux.dev> <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
 <Ye1ua3ixuSfdhiRc@kroah.com> <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
 <Ye19hz9r0poT5wUe@kroah.com> <CAFCwf11ahKse1MYcBFfSBvFf1WnG3rxR6dmJiUhZUu2rZQBB-Q@mail.gmail.com>
 <Ye1/nECWs9XtUzoJ@kroah.com>
In-Reply-To: <Ye1/nECWs9XtUzoJ@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 23 Jan 2022 18:24:40 +0200
X-Gmail-Original-Message-ID: <CAFCwf10UrVGwGRqwPAfGUsyqqdp8Gxjo1nva3hf8dH8uZszPEg@mail.gmail.com>
Message-ID: <CAFCwf10UrVGwGRqwPAfGUsyqqdp8Gxjo1nva3hf8dH8uZszPEg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 6:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 23, 2022 at 06:11:54PM +0200, Oded Gabbay wrote:
> > On Sun, Jan 23, 2022 at 6:08 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 06:01:53PM +0200, Oded Gabbay wrote:
> > > > On Sun, Jan 23, 2022 at 5:04 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sun, Jan 23, 2022 at 04:43:15PM +0200, Oded Gabbay wrote:
> > > > > > On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> > > > > > >
> > > > > > > The driver don't support the SRAM-to-SRAM translation of DMA,
> > > > > > > so remove 'DMA_SRAM_TO_SRAM'.
> > > > > > >
> > > > > > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > > > > > ---
> > > > > > >  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
> > > > > > >  1 file changed, 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > > > index ef54bad20509..25fbebdc6143 100644
> > > > > > > --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > > > +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > > > @@ -36,7 +36,6 @@ enum goya_dma_direction {
> > > > > > >         DMA_SRAM_TO_HOST,
> > > > > > >         DMA_DRAM_TO_HOST,
> > > > > > >         DMA_DRAM_TO_DRAM,
> > > > > > > -       DMA_SRAM_TO_SRAM,
> > > > > > >         DMA_ENUM_MAX
> > > > > > >  };
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > > >
> > > > > > This is a general spec file in our s/w stack, and therefore a change
> > > > > > in it in the driver will cause our driver to be out of sync with our
> > > > > > user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
> > > > > > the driver and in the user-space stack. I don't know if there will be
> > > > > > any consequences but I prefer not to risk it.
> > > > >
> > > > > If this is synced to userspace, shouldn't it be in a uapi file with a
> > > > > specific value associated with it?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > Yes, it was a mistake from day 1. A mistake we didn't repeat in future ASICs.
> > > > I take great care of putting anything that is synced between driver
> > > > and userspace in our uapi file.
> > > >
> > > > Having said that, after almost 3 years of having this mistake, I feel
> > > > it is not too disastrous to leave it as is.
> > > > Our Goya s/w stack is pretty much stable and I don't want to make
> > > > changes without good reason.
> > >
> > > You should just move this to a uapi file to show that it is something
> > > that can't be changed.  Can't you do that without breaking anything on
> > > the kernel side?
> > On the kernel side there isn't any problem with moving it.
> > What I'm afraid of, is that the userspace will now have a duplicate
> > definition of this enum.
> > Both in the original file, which is included in the user space stack
> > from day 1, and from our uapi file.
> > In short, I'm afraid of breaking its compilation.
> > If you think that's acceptable, I don't have a problem moving it.
> >
> > >
> > > Otherwise maintaining this is going to be hard as no one has a clue that
> > > this is a value that userspace uses.
> >
> > I can document it with a BIG comment in the file.
> > And as I said, Goya s/w stack is pretty much fixed and I don't believe
> > is going to change anymore.
>
> The trick is long-term maintaince for the next 20+ years of this code in
> the kernel.  A huge comment would help, but even better to move this
> where it needs to go in a uapi file so that it makes it obvious we can
> not change this.
>
> thanks,
>
> greg k-h

ok, I'll try to do this internally and see what happens. I'll upstream
either the change or a comment, depending on my check.

Oded
