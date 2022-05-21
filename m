Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1352FEC2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbiEUSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbiEUSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 14:21:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837704924A
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4072DB80946
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 18:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B47C385A5;
        Sat, 21 May 2022 18:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653157278;
        bh=7Fg9aSgc4Wpo9Y4mIQDcSAQ+xYkxuvfl5+sEjxKQJwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vTGILa+E9BFXUwIIA7cbOQ4XnCsMWqjT9JZM0as93uYoks7gpUuWIHT3Xr3wAWr/n
         HPe+wMkTPGo4FhttKR/C+vvakqlR0SL88U0TCbQUMhN+SNZTPt7Ve9/Ki+f4mgBO6b
         jMQg8BSv0evfpD/gOaIU1o8AETOMu0tLVSDJ799o=
Date:   Sat, 21 May 2022 20:21:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs pull request for kernel 5.19
Message-ID: <YoktmqrJXFQLi1yM@kroah.com>
References: <20220521115325.GA1965670@ogabbay-vm-u20.habana-labs.com>
 <Yojnof1ekJg3yjwu@kroah.com>
 <CAFCwf13w+-nORUKePUbJJXPkgW+Pn+83BZMvAEonp185KxeJkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13w+-nORUKePUbJJXPkgW+Pn+83BZMvAEonp185KxeJkw@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 05:53:52PM +0300, Oded Gabbay wrote:
> On Sat, May 21, 2022 at 4:22 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, May 21, 2022 at 02:53:25PM +0300, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > This is habanalabs pull request for the merge window of kernel 5.19.
> > > We added a few minor features, such as support eventfd registration
> > > for device events, and the ability to scrub the device memory
> > > through debugfs.
> > >
> > > We did some refactoring such as adding a centralized memory
> > > manager inside the driver for allocating mmapable memory and tracking
> > > it, so we can remove different code paths that basically duplicated
> > > that functionality.
> > >
> > > And, as usual, there are multiple bug fixes.
> > >
> > > Full details are in the tag.
> > >
> > > Thanks,
> > > Oded
> > >
> > > The following changes since commit cafada1fe932ce761d6c0bc1d56967e27abe4cff:
> > >
> > >   Revert "speakup: Generate speakupmap.h automatically" (2022-05-20 21:07:05 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-next-2022-05-21
> > >
> > > for you to fetch changes up to 93f742b13260b070a695f44d6b6ff696cb5cbcd8:
> > >
> > >   habanalabs: use separate structure info for each error collect data (2022-05-21 14:42:17 +0300)
> >
> > Has this been in linux-next already?  It's _really_ late to be adding
> > new commits to my trees as 5.17 is about to come out in a few hours :(
> >
> > greg k-h
> 
> Yeah, sorry about that, I got to a computer only yesterday as my wife
> and I had a new baby boy last week :)

Congratulations!

And totally understandable about the delay.

> To your question, no, my branch isn't taken to linux-next. Our driver
> commits are added to linux-next only through your -next.

Ok, as these are only touching your driver, I'll take them.

Oops, odd, I get this warning with my scripts:
Commit: ad05bb784ca2 ("habanalabs: hl_ts_behavior can be static")
	Fixes tag: Fixes: 079c2434d6e8 ("habanalabs: convert ts to use unified memory manager")
	Has these problem(s):
		- Target SHA1 does not exist

Where did you get that SHA1 from?

Sorry, I can't take this as is, invalid sha1 shouldn't be in the tree.

I can export these as patches and fix up the sha1 by hand, want me to do
that?  I'll have some time on Monday.

thanks,

greg k-h
