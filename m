Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4744C8962
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiCAKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiCAKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:36:06 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3756C13;
        Tue,  1 Mar 2022 02:35:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 0F9902B00092;
        Tue,  1 Mar 2022 05:35:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 01 Mar 2022 05:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=ysRpXoSkUBqFNe0diSr30u/oZ9ovPoPLQJ+x+S
        shXy4=; b=LL/FiTvDraDFXmTwJJXQoj3uX8vifSN3X+NdzHjgEut6RWRri/6Fuu
        BBQtcUiHJZ9Z58tH2qGOB2keYCEMRbmXAPrwb8khMeEX3sqhQna/EKpjRMHo+PCM
        auUI8NeEcEiqfVXU2ytmUSsDugvJpqyxTMEOBtBAt+pRxQFuS5NGYt6i82ZYoJGM
        dX2SIWmcUdw3kUWnomNZpensPv3/MIjK7JLvy43NqzaCg2GxRFJUJWqKDjF3ibIq
        xqDfBjrOgugVoCBUvemeywXHgQN061S2CX/8icTB72ZRRWJFnXzN2DGZz58cXDOI
        wdJBXHhMUhzuY9MvINt5v9Ms1Qb4QeWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ysRpXoSkUBqFNe0di
        Sr30u/oZ9ovPoPLQJ+x+SshXy4=; b=gebClrELORVqYBDgZn5+bZgsjjQEpsKVS
        Ka6JPKE1tUqAZqy5pc+UH8fc5jjAACFOp+892+zJ9vm6di9foTDFxJXdjn4wcbYp
        a2HY0c39Zy0k3o7D8efxmLau/VJ6RmVvWXb3mCwdH9Np+3IZfWTCNsE5DBcVpm+v
        ++yaR8dQWrulgviJKi5MDUeAR/9aqpG/W2mAu0Yobg2J1GEksVh4rvXnryLR5Uk5
        WFibuvrvZJ3PwndItJLzBEsT5IJRtxcTa2tPojHPpDWsE7R9nUZUu55RY38M45Ps
        qxMV0PRIKa+5PMFwcmZsaNAM5NeXsRbHuHE15OEA9PG5CPhKuz9+w==
X-ME-Sender: <xms:6PYdYunB4kqylP5S5BS93NseSw0zTl_gn_9Gm1lOdGyUsu8COcxpFw>
    <xme:6PYdYl0ChrVs3hbj6ypsCclN6uY8BFoAfUHg7fr7mr7xh8wDbDW_eaNQXNqzoNCdk
    LGnsUE__2dZ8w>
X-ME-Received: <xmr:6PYdYsrnSntjFVn9m97YSRz4h-TBHDQswReCOvGduE8gVZrezLoK5ibAmC69Ca81Bt2HRV6tjJ5sc7gkS6EJ5Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuleeltd
    ehkeeltefhleduuddvhfffuedvffduveegheekgeeiffevheegfeetgfenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:6PYdYimZP-plN_TuooYyEArYlBIw74yeWoG5Oi4qSSt8ps8K41058w>
    <xmx:6PYdYs3Qvtx5KNjYCk5HgZjzGCQERQZ8mS4MYwvjfqwZY7VlElgXxg>
    <xmx:6PYdYpuxuTCirwc00aQciyaRXUQF6MqKRlrVCaRIvpOLla48xeOEcA>
    <xmx:6PYdYiMe1ebt3xGqtaJnfYKocKutSwi64TO2hq-x_wSadIEhW3IawxtU3vU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 05:35:20 -0500 (EST)
Date:   Tue, 1 Mar 2022 11:35:17 +0100
From:   Greg KH <greg@kroah.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh325S5PyPiJf4F5@kroah.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
 <Yh3pZXQPP9kmcSSx@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh3pZXQPP9kmcSSx@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 09:37:41AM +0000, Lee Jones wrote:
> On Mon, 28 Feb 2022, Greg KH wrote:
> 
> > On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > 
> > > > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > > 
> > > > > I did ask for this *not* to be merged when it was in -testing.
> > > > 
> > > > Sorry, I missed that, I saw your ack on the patch so that's why I took
> > > > it.
> > > > 
> > > > > I'll follow-up with Greg.
> > > > 
> > > > Should I revert this from my tree?
> > > 
> > > I did try to catch it before a revert would have been required.
> > 
> > My fault.
> > 
> > > But yes, please revert it.
> > 
> > Will go do so now.
> 
> Thank you.
> 
> > > The Ack is not standard and should not be merged.
> > 
> > I do not understand this, what went wrong here?
> 
> The "Ack" you saw was just a placeholder.
> 
> When I provided it, I would have done so like this:
> 
>     "For my own reference (apply this as-is to your sign-off block):
> 
>      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>"
> 
> REF: https://lore.kernel.org/all/YQ0fYe531yCyP4pf@google.com/
> 
> The majority of maintainers I regularly work with know this to mean
> that the set is due to be routed via MFD (with a subsequent
> pull-request to an immutable branch to follow), since MFD is often
> the centre piece (parent) of the patch-sets I deal with.
> 
> I appreciate that this could cause confusion, but I'm not sure of a
> better way to convey this information such that it survives through
> various submission iterations.

But what else is another maintainer supposed to think if they see that
ack on the patch?  Ignore it?  I took that to mean "this is good from a
mfd-point-of-view" which meant it can go through whatever tree it is
supposed to.

Are you wanting this individual patch to go through your tree now only?
If so, you should say that by NOT acking it :)

How do you want to see this merged?

thanks,

greg k-h
