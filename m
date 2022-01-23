Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04EF4972E5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbiAWQMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:12:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43860 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiAWQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:12:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC94CB80DBE
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ADEC340E5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642954341;
        bh=6NtAXxaOwFwMGUS7pA4qLbB/J3E9TF2I6pwG0CRZGdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kV9U4eEndy8waODpnPzSgx0OPmRS1x/cA4W0KYpLBEFD4Qa5NUG8eyyQuAmNVyLLX
         agdfECE44Cb2m3A0ysbKuzB8DZodBM+bfYSAI61kATLZcM/7e2skZiVb6iEFton629
         Yrmtml0ecSW3OyPKjtCeRHOeml7a44L5KsdDEhU01Ji5kJVaP8uVg17kgQKhergpNi
         kvyaL2tjMN+SV+xXEBRCaKX3GQpNcoem4Iz1w/BgU/4stv/ZwTr0cY+flW0bA+uljd
         wjZNkcAn6EEH4QZ3FvZOJ6pkcOCgvD51POIbePCQRCsBvA3s3kD8bJlkr7Gt5dxKeO
         pHY/X+P350oOA==
Received: by mail-yb1-f178.google.com with SMTP id 23so43441324ybf.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:12:21 -0800 (PST)
X-Gm-Message-State: AOAM530xL4AHedKsscXTKwvuZflpC0BObWvN9v042AKV/lXr+AKQBw9I
        wow5TUrGnKkII4cZekiNsaPDyEO/5Z+qMekXSas=
X-Google-Smtp-Source: ABdhPJyL5MPGHFK035DoTtPlxOvpmiVj/u+utynifDkO2KD4MZGotP0Vtf37ciNLt73kkgmSYTXTTkZSI0IrlR9gxc8=
X-Received: by 2002:a5b:20c:: with SMTP id z12mr17156535ybl.64.1642954340637;
 Sun, 23 Jan 2022 08:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20220111114724.7987-1-cai.huoqing@linux.dev> <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
 <Ye1ua3ixuSfdhiRc@kroah.com> <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
 <Ye19hz9r0poT5wUe@kroah.com>
In-Reply-To: <Ye19hz9r0poT5wUe@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 23 Jan 2022 18:11:54 +0200
X-Gmail-Original-Message-ID: <CAFCwf11ahKse1MYcBFfSBvFf1WnG3rxR6dmJiUhZUu2rZQBB-Q@mail.gmail.com>
Message-ID: <CAFCwf11ahKse1MYcBFfSBvFf1WnG3rxR6dmJiUhZUu2rZQBB-Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 6:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 23, 2022 at 06:01:53PM +0200, Oded Gabbay wrote:
> > On Sun, Jan 23, 2022 at 5:04 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Jan 23, 2022 at 04:43:15PM +0200, Oded Gabbay wrote:
> > > > On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> > > > >
> > > > > The driver don't support the SRAM-to-SRAM translation of DMA,
> > > > > so remove 'DMA_SRAM_TO_SRAM'.
> > > > >
> > > > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > > > ---
> > > > >  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > index ef54bad20509..25fbebdc6143 100644
> > > > > --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > > @@ -36,7 +36,6 @@ enum goya_dma_direction {
> > > > >         DMA_SRAM_TO_HOST,
> > > > >         DMA_DRAM_TO_HOST,
> > > > >         DMA_DRAM_TO_DRAM,
> > > > > -       DMA_SRAM_TO_SRAM,
> > > > >         DMA_ENUM_MAX
> > > > >  };
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > This is a general spec file in our s/w stack, and therefore a change
> > > > in it in the driver will cause our driver to be out of sync with our
> > > > user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
> > > > the driver and in the user-space stack. I don't know if there will be
> > > > any consequences but I prefer not to risk it.
> > >
> > > If this is synced to userspace, shouldn't it be in a uapi file with a
> > > specific value associated with it?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Yes, it was a mistake from day 1. A mistake we didn't repeat in future ASICs.
> > I take great care of putting anything that is synced between driver
> > and userspace in our uapi file.
> >
> > Having said that, after almost 3 years of having this mistake, I feel
> > it is not too disastrous to leave it as is.
> > Our Goya s/w stack is pretty much stable and I don't want to make
> > changes without good reason.
>
> You should just move this to a uapi file to show that it is something
> that can't be changed.  Can't you do that without breaking anything on
> the kernel side?
On the kernel side there isn't any problem with moving it.
What I'm afraid of, is that the userspace will now have a duplicate
definition of this enum.
Both in the original file, which is included in the user space stack
from day 1, and from our uapi file.
In short, I'm afraid of breaking its compilation.
If you think that's acceptable, I don't have a problem moving it.

>
> Otherwise maintaining this is going to be hard as no one has a clue that
> this is a value that userspace uses.

I can document it with a BIG comment in the file.
And as I said, Goya s/w stack is pretty much fixed and I don't believe
is going to change anymore.

Oded

>
> thanks,
>
> greg k-h
