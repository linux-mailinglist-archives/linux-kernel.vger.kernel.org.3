Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB34972C7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbiAWQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:02:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39604 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiAWQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:02:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2DC1B80DC5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BACC340E8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642953740;
        bh=6D/7YE/2+yGPRMlP8GxZOUHR51BdT5V0tU10v0K9Zdw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aHC9trz100sguqPtFpJGkcQLWl3QGJIa/uc3LLOoiY2SbgCpxfTZYp2Mp1KMZpFir
         1EAynF5kUV1SIIyhByvTHaTYUb0e7fchkptLOhYKnOyxd0J1dnQCVp+nJ3qXfnQRiK
         AdFd0JVMItEvmYBn3MArMayrOJFYWFPjTMB4+HzazGz69cbuyiVFIYSCKNj/KiCcqr
         RyZoPhifzcNOyAd7XnA79lm3LLhhbBTEE41WBMGCwKKdF9y1gP1TuBgjqdveV/2+aO
         S8rYJbvK1cZ5YVft7L6gXtQkqcuFxpK+4Fc6JY134DbA5s0ZtOJKyzjIspxsItGr1L
         d3HuQtBBuxLfw==
Received: by mail-yb1-f172.google.com with SMTP id m6so43404538ybc.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:02:20 -0800 (PST)
X-Gm-Message-State: AOAM5320ThnYTqgM7yLyTzHRWmzZIrHJ1ynyU1IrhRhN7sQGL2ouU/bZ
        NLQdPQshF05p6BA91xTNFGCl1B9T7j3NON7RzXQ=
X-Google-Smtp-Source: ABdhPJzmquuBFRgCJPVJKXp5xxKlAiugoYIHNo2wPhk6Ssspaq9Pqy1vmd5t89kqWrhDBSJwvrcWbnE8ziIBUijPN1c=
X-Received: by 2002:a05:6902:34d:: with SMTP id e13mr16880478ybs.155.1642953739693;
 Sun, 23 Jan 2022 08:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111114724.7987-1-cai.huoqing@linux.dev> <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
 <Ye1ua3ixuSfdhiRc@kroah.com>
In-Reply-To: <Ye1ua3ixuSfdhiRc@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 23 Jan 2022 18:01:53 +0200
X-Gmail-Original-Message-ID: <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
Message-ID: <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 5:04 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 23, 2022 at 04:43:15PM +0200, Oded Gabbay wrote:
> > On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> > >
> > > The driver don't support the SRAM-to-SRAM translation of DMA,
> > > so remove 'DMA_SRAM_TO_SRAM'.
> > >
> > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > ---
> > >  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > index ef54bad20509..25fbebdc6143 100644
> > > --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > @@ -36,7 +36,6 @@ enum goya_dma_direction {
> > >         DMA_SRAM_TO_HOST,
> > >         DMA_DRAM_TO_HOST,
> > >         DMA_DRAM_TO_DRAM,
> > > -       DMA_SRAM_TO_SRAM,
> > >         DMA_ENUM_MAX
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
> >
> > This is a general spec file in our s/w stack, and therefore a change
> > in it in the driver will cause our driver to be out of sync with our
> > user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
> > the driver and in the user-space stack. I don't know if there will be
> > any consequences but I prefer not to risk it.
>
> If this is synced to userspace, shouldn't it be in a uapi file with a
> specific value associated with it?
>
> thanks,
>
> greg k-h

Yes, it was a mistake from day 1. A mistake we didn't repeat in future ASICs.
I take great care of putting anything that is synced between driver
and userspace in our uapi file.

Having said that, after almost 3 years of having this mistake, I feel
it is not too disastrous to leave it as is.
Our Goya s/w stack is pretty much stable and I don't want to make
changes without good reason.

wdyt ?

Oded
