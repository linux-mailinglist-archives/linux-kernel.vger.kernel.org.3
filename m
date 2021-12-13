Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4A747239F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhLMJSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:18:15 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:53563 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhLMJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:18:13 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id BC27E2B00168;
        Mon, 13 Dec 2021 04:18:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 Dec 2021 04:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=sIjmqWHlFwhHFDMolO/IbparUtL
        jFiC2vzdR01zGYyk=; b=dZQT5PnqVcWOdEMUFq4fP3+RF2WsEYtf7cxZu1nKgal
        XcnToPIqy4yIA8Yd171ym2b+YzwSYYRGWjlj0hQrD43A28B5EApNWIOu+sIVFuQ+
        BsYnrrVuYTQ3SeTCGFsnMbFCTV/IgOFnuRRhPql2w8bbkMldnM9DupHX83YY5504
        qL4ZPI10ze+52v/Wuo0M+EitQgYZh+tqH4vD23mukV6P5cJHno53JWKwV3sKgQpK
        85iQRyGyRPfw5ZIPK3WhmenVtwvYIDrXxfMvciQHNgdZKPT0W/8hoeojR5XRA9iT
        4u8UpzD58F3wvEJS3IRvT9nJANY/zpk3V5D2Ra8gsNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sIjmqW
        HlFwhHFDMolO/IbparUtLjFiC2vzdR01zGYyk=; b=SwnQ67OVAqOs+NxVPxVBmc
        JKjj71Mk0t0oRTDyKvMnx2pLZB5M3niO2mojNx+SFeHvK4aN+pzVK74O4X3V/Sm6
        07c+WC//dhKbNtfTQcr4LLT0KQ6KDMbj8bCddManlIJZcrA0RAznmhCLCTzhq8rK
        9sZPiSicp8+g0PVwRvCN64dtWHi0/CqAS4wK/38V3f3WbkBIYo1aWL+bpPR5Uayv
        PQrC3yugVqytOmqZKN9Uly3VYZUZnBidxOCq3v68jMMxmzQTCo65gh98BWwe1XUU
        QvT/JwDsFNFUu9ZnMUNDnrkwIAPUeCgI2HiHoFLvOmWwot9AO4Cdb2YXJJ71jmhA
        ==
X-ME-Sender: <xms:0g-3YcgYKFz7-MM0kSktEByXT4B10TKWri8m1ytYq-o520Omvv52cQ>
    <xme:0g-3YVBZrNMii1ci7fpXrG1GHDz0xf_BedMvMkfhLmc0DiL17NEnMNHiVDdV3lkT5
    hYZJqVdG8z3rw>
X-ME-Received: <xmr:0g-3YUE_wKX906IoYDfZaTl0Oi7lCsOt2VXbVBMLz5yzwLYklf1DX1R-ESklO8Rj1dDgFQUcrxLyIzl0CAgzgTRKeEj_ovJF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeekgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:0g-3YdTAfj6NH2K5mu8C_0FB0F7vTiNZgMZ1EPRZhYVYg6zjg6mIuQ>
    <xmx:0g-3YZxW6lQQGbwfPJl3oeLJCMu_pQEvaBUC2QYGWRdaIg3RB4LbPQ>
    <xmx:0g-3Yb6kTVII0AXTYfbpNnbDOZ67G7ztzlZ1EgPAYlC9Tv7c85e35w>
    <xmx:0w-3YerHQ7PGmLWlVLQFJouTbQJ39cHK6xJIo7b3Z57I07uCSA-k2IMEUNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Dec 2021 04:18:09 -0500 (EST)
Date:   Mon, 13 Dec 2021 10:18:07 +0100
From:   Greg KH <greg@kroah.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ralph Siemsen <ralph.siemsen@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <YbcPz0SyzSlp8YGU@kroah.com>
References: <20211206144901.63529ac9@canb.auug.org.au>
 <Ya4Tb9NUj33UdxmI@smile.fi.intel.com>
 <20211206161734.GA4141317@maple.netwinder.org>
 <Ya491Dtj7HqoMhvW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya491Dtj7HqoMhvW@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 06:44:04PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 06, 2021 at 11:17:34AM -0500, Ralph Siemsen wrote:
> > On Mon, Dec 06, 2021 at 03:43:11PM +0200, Andy Shevchenko wrote:
> > > On Mon, Dec 06, 2021 at 02:49:01PM +1100, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > 
> > > >   drivers/misc/eeprom/at25.c
> > > > 
> > > > between commit:
> > > > 
> > > >   9a626577398c ("nvmem: eeprom: at25: fix FRAM byte_len")
> > 
> > This was my original patch from Nov 8th.
> > 
> > > >   5b557298d7d0 ("misc: at25: Make driver OF independent again")
> > > >   a692fc39bf90 ("misc: at25: Don't copy garbage to the at25->chip in FRAM case")
> > > >   58589a75bba9 ("misc: at25: Check proper value of chip length in FRAM case")
> > > >   51902c1212fe ("misc: at25: Use at25->chip instead of local chip everywhere in ->probe()")
> > > > (and probably more)
> > 
> > These are newer versions and some cleanups from Andy. I was not aware of
> > this work going on. I'm surprised at25 is getting so much attention ;-)
> 
> Me neither. :-)
> 
> > > > I fixed it up (I just used the latter version) and can carry the fix as
> > > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > > non trivial conflicts should be mentioned to your upstream maintainer
> > > > when your tree is submitted for merging.  You may also want to consider
> > > > cooperating with the maintainer of the conflicting tree to minimise any
> > > > particularly complex conflicts.
> > > 
> > > The result from char-misc.current should be used as is and I guess it's
> > > what you have done, thanks!
> > 
> > Agreed - Andy's version is cleaner, and includes my fixes. I've run some
> > quick tests locally and all seems to be working as expected.
> 
> Thanks, Ralph!

This should now be resolved in my tree, thanks.

greg k-h
