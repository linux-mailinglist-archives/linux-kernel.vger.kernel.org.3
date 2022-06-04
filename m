Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE453D658
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiFDKAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiFDKAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:00:34 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A92613C;
        Sat,  4 Jun 2022 03:00:30 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 650075C0182;
        Sat,  4 Jun 2022 06:00:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 04 Jun 2022 06:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654336827; x=1654423227; bh=bH1AVYCxSS
        6C23tOBcztUST5We++a60WbF4bhknazcI=; b=OSSKb616WVnx2hBL6UP6QpBiRs
        E/sD/ciPVSiJp9tmhuwEqIE1GY6cfjzJEBWkavQoLK0a8QOrg0KV2rj6Z5+l2/sm
        0vkVC0ij4lP39cSsODqA7ZDXKigM/bj6PrxH96RH+tKDZs9CaUyL7sFM/TwSq3iK
        DX0b/J6AgGxCe4OoK6pOJ+eqxNm41hPpxoIaUgA8xWQugO75AN7D3VpC0AybTVae
        Ivc4H8Imbl8G7R1bhbEEM+HL87HGHGX3OpFz7PPW9J78bVkx91qXhrta8TM0luSZ
        4NUuZyeI+VXWpQh0h6/KO/KOxwu5fCIbnlvt28UoWFyEqyeRRfEIXW2hmdlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1654336827; x=1654423227; bh=bH1AVYCxSS6C23tOBcztUST5We++
        a60WbF4bhknazcI=; b=n1AcBgOZA43Xxx5RWYBLicLSR5hhLxPjGJ+epU8MTkWg
        2nz9kq68DvkmYgfp8sledmcX4axFifbl9Vog3JFoE1bDCb8sm49YJla6w+Yavgi5
        w+xir/+xes6CmUScpLcHdNdZEGER9Cm0Tf/WxypuVBXC94+M7RXEfZclhSOguz4t
        mjmUd3sHuu1WVyZk9oKTU/GmZ2iFTqeS+VJs1VkpRlb6eus3mqL9zyUN9pyYzIh/
        VZYsVwKxDVHyzAxUv8ED3vezjW6gRtpwQKB8XZ18FSyK1dW3gXCZg04V4WgRxkdL
        2tl6lkFyHuxmyblOdeZXOeiGWImf/8Kk4aEtdmRx0A==
X-ME-Sender: <xms:Oi2bYojPbHNfgQ_R2PTW6XiKLaRSC2teRsJ_tAGVMIpnXeEyNH64uQ>
    <xme:Oi2bYhCpHnGfeZVbBQtovbrvUKg3lZ6IgeFw1VS4uzTOM21fpfMNrFTIpah8wTu_B
    lrlRX8ODljj3Q>
X-ME-Received: <xmr:Oi2bYgG0EmhdwUxtpPmDDq-ug_C5DQxdFlAjI5X4Y45Fl-SSxtec0UyXHRGVC6PcU2l4-3hh2F1Z9uROKge6SFl25fgUeTEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleekgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:Oi2bYpT2fjExXfhGnBMM8_FOYa6ZL9UARcPT9aBLsBMcd2pMbvVXjg>
    <xmx:Oi2bYly5SwnVDsfk5aIdCpi_oYHnemdiM3OPa2m_5av3LEOhZ8bZOw>
    <xmx:Oi2bYn4wfSc2nwRESn6yAYmAi_O7fIaK9kIopiTK6n6jOTbd5Q5GFw>
    <xmx:Oy2bYoqOMd36-74VBEg1oOjRyJ_2KzhhSvGTe8IOrsR81FvRJkS5kw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jun 2022 06:00:25 -0400 (EDT)
Date:   Sat, 4 Jun 2022 12:00:22 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the extcon tree with the usb tree
Message-ID: <YpstNtMr6VwU51+a@kroah.com>
References: <20220426152739.62f6836e@canb.auug.org.au>
 <20220523184254.4e657cd1@canb.auug.org.au>
 <20220604111841.3887bf65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604111841.3887bf65@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Sorry about that, I'll queue it up after -rc1 is out.

greg k-h
