Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844415461D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348956AbiFJJWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348824AbiFJJWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:22:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6148B15434A;
        Fri, 10 Jun 2022 02:20:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D93E45C00A4;
        Fri, 10 Jun 2022 05:20:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Jun 2022 05:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1654852817; x=1654939217; bh=f1H+DWhyV6
        bEImtYz7G/ATvgHdFloSPJtVwvi8rl+34=; b=kEt2Z+26Z1Dy0WDBiZZMW8CA1K
        wRLPKsTRa44XnoDqtc4tVZUfysSf4K2Nd2fFY3URZL76g/7i1Nvjwyv001O78Qn2
        2JdDXE9bAQz7w82oBwsi1wl7Gm2PxQ07tJ9GKRw1VZaTI2gYMurnACi1b4HPMt7l
        SKEX0Pob5rqse7x6b2GUVjtabOC1R88MUbgmOGlmB+j5dOyQnptlBAQMrH3LSnwR
        TIT8H7Z+FQmWUog7mT/4592X1/KfczaxRmBhxgHlvoRJnmc35Q7CpKzzzG0zbBIM
        NZ81xyhxSd7qrd8oQ5iq+Q8tZJ6Su3y9ubzkgjCQzdZ2UfUxu3SFtODG5p4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654852817; x=1654939217; bh=f1H+DWhyV6bEImtYz7G/ATvgHdFl
        oSPJtVwvi8rl+34=; b=EBN2OC9WYnd1RqRxhQZOfxvsF7tGI2ix9Um9PazNF78/
        SiuxErPtdzqWx72Z4CaWlNK0LTkCGpYlDZRkmeF2Qpmzv8SqSLyEdWjEChrRxQen
        QVvuH3pjD4xHQhYXQMMYmhE9D0cn580ojl0WAM+yVxxY7Dm8QTbvHUbcp0TpfFHe
        CVmArbAnwORQDLLAMjG5Y3fUzw5n5y2CDFFoDzBPVxVvMKpGlyzlMT8TRngJZuZo
        HFlKI1iBE5ndi+/BqvCgvWonCv9zyOl97woJrxtsBQYEKABKpT8cd+kAOJXuJmTq
        y3Fi86ZwXLMlyc1NWEM+6iHmEDIuXwQP7/bkeaOUOQ==
X-ME-Sender: <xms:0QyjYh4UGmuHsQ1OEfRztzXvh-7XLsAuF8fUNRF5-aWnvQGnTHoyAw>
    <xme:0QyjYu6gy9_QOdf2A7NZu-J4i1WSUYH2s1oG6jFwk7JtssAWf5YOMQxEt_622PUJ_
    KVrndZPFSxkxg>
X-ME-Received: <xmr:0QyjYoexEfOrcP24M8iZLnYJEsmt-VLE-_yi5VNBAesZpF0q_njA0uhx8KhHwAy6OHxe_AybvhnSS25ZR2vYxrpeQTTKdr4B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:0QyjYqJMX2OiARVcy2ojYbZ2zuGAWW3LE8-BObcBOdbsiiFXKgCtIA>
    <xmx:0QyjYlLxCEyYtkPMRNajwlBECFs8X0TmNxGlG66TZcD_XCSkWoNx0A>
    <xmx:0QyjYjwIHX2yF2_-BQU98v1wNJIBbaV8pBTU8O7GL3pqlv03F8CjDw>
    <xmx:0QyjYvDjeCMgy4-_VgYjSw32rT2UXAqxa4MVrb0ivj8kJlOfaKhTyw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jun 2022 05:20:17 -0400 (EDT)
Date:   Fri, 10 Jun 2022 11:20:13 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the extcon tree with the usb tree
Message-ID: <YqMMzfFtWiZM8iOw@kroah.com>
References: <20220426152739.62f6836e@canb.auug.org.au>
 <20220523184254.4e657cd1@canb.auug.org.au>
 <20220604111841.3887bf65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604111841.3887bf65@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2022 at 11:18:40AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 23 May 2022 18:42:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Tue, 26 Apr 2022 15:27:39 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Today's linux-next merge of the extcon tree got a conflict in:
> > > 
> > >   drivers/usb/dwc3/drd.c
> > > 
> > > between commit:
> > > 
> > >   0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> > > 
> > > from the usb tree and commit:
> > > 
> > >   88490c7f43c4 ("extcon: Fix extcon_get_extcon_dev() error handling")  
> > 
> > This is now commit
> > 
> >   58e4a2d27d32 ("extcon: Fix extcon_get_extcon_dev() error handling")
> > 
> > > from the extcon tree.
> > > 
> > > I fixed it up (the former moved the code modified by the latter, so I
> > > used the former version of this files and added the following merge fix
> > > patch) and can carry the fix as necessary. This is now fixed as far as
> > > linux-next is concerned, but any non trivial conflicts should be
> > > mentioned to your upstream maintainer when your tree is submitted for
> > > merging.  You may also want to consider cooperating with the maintainer
> > > of the conflicting tree to minimise any particularly complex conflicts.
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Tue, 26 Apr 2022 15:24:04 +1000
> > > Subject: [PATCH] fixup for "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  drivers/usb/dwc3/core.c | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 2345a54b848b..950e238c65bf 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1649,13 +1649,8 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> > >  	 * This device property is for kernel internal use only and
> > >  	 * is expected to be set by the glue code.
> > >  	 */
> > > -	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> > > -		edev = extcon_get_extcon_dev(name);
> > > -		if (!edev)
> > > -			return ERR_PTR(-EPROBE_DEFER);
> > > -
> > > -		return edev;
> > > -	}
> > > +	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
> > > +		return extcon_get_extcon_dev(name);
> > >  
> > >  	/*
> > >  	 * Try to get an extcon device from the USB PHY controller's "port"
> > > -- 
> > > 2.35.1  
> > 
> > This is now a conflict between the char-misc tree and the usb tree.
> 
> This merge resolution seems to have been lost somewhere along the way
> :-(

I've taken your resolution in the tree now, sorry for the delay.

greg k-h
