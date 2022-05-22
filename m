Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2331753057B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350077AbiEVTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344757AbiEVTgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 15:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB25140DA
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE13B80CC5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC95C34116
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653248174;
        bh=B4EgzqncuNwezN3jb62S5WPFc/W3Xj0rmEZ9GN8kI+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iYSi7aWHfKaI+7MCp2DSm9X765EMoZyKTk4O6EptRr4mEatqaDW43xPtbO2vg08Ta
         cHJAKBMi6ekvENJRrQLgYVOwteLbuZqsrICGOxrDXNc/piTJyTaN+jDYghp1+HuBIG
         cxdStpZNMm+yGZYvlak/0INYubfJlsv23PwYRTE70EkTNScH4Uvyr82o2pltBAmCIl
         MNgr1ooX4YT3WDE28nUUGogySmU9iemNP2M9ASTFgwh0wBpzRhGfVyrrYd/w5wxpiE
         wC5uYt7e9vHh4ET0h5sBB0IpqTY4vTchwhQJx9T83IrqpINKsMBUh4Du9JLzUkkTGU
         ETkqayKeyxaUQ==
Received: by mail-yb1-f181.google.com with SMTP id x2so21767921ybi.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 12:36:14 -0700 (PDT)
X-Gm-Message-State: AOAM531hzNov+5POtSX5MibBlUZbqb7jVtHoJFi5Nm8o+th72ALIeuki
        sIES90yW6V5SJTMm0QBcoFH8zJfrWpb6Np1C0BY=
X-Google-Smtp-Source: ABdhPJx5Y7tCiwK96fxQtsJ2DcLSWkGxitygcwzkTUxbBtIHCPTlDA95Gmo7S6oVJ90wSpP1qSLrqJWdpPnOrY9iVXo=
X-Received: by 2002:a25:5c1:0:b0:64e:a4aa:e206 with SMTP id
 184-20020a2505c1000000b0064ea4aae206mr18946545ybf.381.1653248173540; Sun, 22
 May 2022 12:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220521115325.GA1965670@ogabbay-vm-u20.habana-labs.com>
 <Yojnof1ekJg3yjwu@kroah.com> <CAFCwf13w+-nORUKePUbJJXPkgW+Pn+83BZMvAEonp185KxeJkw@mail.gmail.com>
 <YoktmqrJXFQLi1yM@kroah.com> <CAFCwf12iMY18BSLj7Cu1Q0SQnCg+1d4hyCLoBe8oJrBv5=ByVQ@mail.gmail.com>
 <YoqKbm3goZOrhZdS@kroah.com>
In-Reply-To: <YoqKbm3goZOrhZdS@kroah.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 22 May 2022 22:35:46 +0300
X-Gmail-Original-Message-ID: <CAFCwf12AmsXO22twzucr1YHPiROW8H1mu_nX_EOvuE7yQg3OgA@mail.gmail.com>
Message-ID: <CAFCwf12AmsXO22twzucr1YHPiROW8H1mu_nX_EOvuE7yQg3OgA@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.19
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 10:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 22, 2022 at 12:07:03AM +0300, Oded Gabbay wrote:
> > On Sat, May 21, 2022 at 9:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, May 21, 2022 at 05:53:52PM +0300, Oded Gabbay wrote:
> > > > On Sat, May 21, 2022 at 4:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sat, May 21, 2022 at 02:53:25PM +0300, Oded Gabbay wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > This is habanalabs pull request for the merge window of kernel 5.19.
> > > > > > We added a few minor features, such as support eventfd registration
> > > > > > for device events, and the ability to scrub the device memory
> > > > > > through debugfs.
> > > > > >
> > > > > > We did some refactoring such as adding a centralized memory
> > > > > > manager inside the driver for allocating mmapable memory and tracking
> > > > > > it, so we can remove different code paths that basically duplicated
> > > > > > that functionality.
> > > > > >
> > > > > > And, as usual, there are multiple bug fixes.
> > > > > >
> > > > > > Full details are in the tag.
> > > > > >
> > > > > > Thanks,
> > > > > > Oded
> > > > > >
> > > > > > The following changes since commit cafada1fe932ce761d6c0bc1d56967e27abe4cff:
> > > > > >
> > > > > >   Revert "speakup: Generate speakupmap.h automatically" (2022-05-20 21:07:05 +0200)
> > > > > >
> > > > > > are available in the Git repository at:
> > > > > >
> > > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-05-21
> > > > > >
> > > > > > for you to fetch changes up to 93f742b13260b070a695f44d6b6ff696cb5cbcd8:
> > > > > >
> > > > > >   habanalabs: use separate structure info for each error collect data (2022-05-21 14:42:17 +0300)
> > > > >
> > > > > Has this been in linux-next already?  It's _really_ late to be adding
> > > > > new commits to my trees as 5.17 is about to come out in a few hours :(
> > > > >
> > > > > greg k-h
> > > >
> > > > Yeah, sorry about that, I got to a computer only yesterday as my wife
> > > > and I had a new baby boy last week :)
> > >
> > > Congratulations!
> > >
> > > And totally understandable about the delay.
> > >
> > > > To your question, no, my branch isn't taken to linux-next. Our driver
> > > > commits are added to linux-next only through your -next.
> > >
> > > Ok, as these are only touching your driver, I'll take them.
> > >
> > > Oops, odd, I get this warning with my scripts:
> > > Commit: ad05bb784ca2 ("habanalabs: hl_ts_behavior can be static")
> > >         Fixes tag: Fixes: 079c2434d6e8 ("habanalabs: convert ts to use unified memory manager")
> > >         Has these problem(s):
> > >                 - Target SHA1 does not exist
> > >
> > > Where did you get that SHA1 from?
> > >
> > > Sorry, I can't take this as is, invalid sha1 shouldn't be in the tree.
> > >
> > > I can export these as patches and fix up the sha1 by hand, want me to do
> > > that?  I'll have some time on Monday.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Yes, that will be a great help. I'm pretty occupied right now as you
> > probably imagine ;)
>
> Now done, go get some rest!

Thanks, I will try...
