Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1759A48759C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiAGKfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:35:08 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:41825 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237395AbiAGKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:35:07 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1383F3202F07;
        Fri,  7 Jan 2022 05:35:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jan 2022 05:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=bV78w93f3Jpvnt1lqEA+8fwIG75
        TX8Nvw0pfghkREGs=; b=PnFIGEYa02ZZAnlo48HJjZXis5Y0hJniToTmwsSu6N0
        Qgt2aCZGU3Ztns91xGxa9mRxT736y0hTJCNk9MC9FZeNBXGowmyI7cWGU5U1Zbm4
        aD9vaj9SOf4JrfWP7hvF3ya4aSRz4gmd5SVtSypskc18MdY1yKGiGUQIXUvliJKO
        FLLqgHe5dyqjv60Jga8RS7IvqwDkamejmiqElwH1NDBVe2zKa4gR/b0ReauCTT+m
        8bUWVQ3oedh571iXseqofQUGoH8eGZqZwHeJsG88Xgub7yQrekI1/wgMbyErK5zx
        HE1da8WI/Oyad1QaHbJsirvV1jCtTKlleQdY2pa2enw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bV78w9
        3f3Jpvnt1lqEA+8fwIG75TX8Nvw0pfghkREGs=; b=jHQ1sQzdVUP7OOdSeGif35
        ifR4+WmxzRrh4G+kE0wq1c0P3MDimvts7LMBMYwhoGmD3qBRE7a9D4f7DYUxIhMg
        EQwd/0KFyHA+fMfJ0Kx5aK9HRKuVGlO3c2uqaw2LC1R+yLMi5PZr6S7TyrS4Eabo
        nC3n2JjUUdFJbHMFQEvkF9Fy8s95mr5BBVPrnZstR9xIN3lIdaV8IiyuTUHDX+Oq
        wstPRZiOJJvSOck+XaHOQlq7w+L1Fc3nMTyKQQmmeMxzS4WdciL2RCASANlJovBb
        rgr30YcA+Ok+avCFKyE/Xu1yF1jNPlt3OndYlWFdBZLLb7jp2G4W5SunRBuP+N1w
        ==
X-ME-Sender: <xms:WRfYYbuzAC7eBD9-BabW_tZz7EyMR4oKousTZgEz_onTSJMhmAvVaw>
    <xme:WRfYYcekIFqm8j2Hl3ZoB28q79crGN8-SP0AtBCeohPbqctjW900nDxjQxZyg903M
    W102Uv0ewvkMw>
X-ME-Received: <xmr:WRfYYexKxSR-l5z-JhjoRXoazAV5m-PoTvYlTWB7rg1XEnaMko_GBWHAVBgDuPqnz1PihYi_9E-AQbuVNCK_g_uQvfzbfX30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:WRfYYaNaxOf6b1f-URJxgkOgJ7fhfzSLu2li0a8mGy_j4SZOC42oQA>
    <xmx:WRfYYb_NkDyVN9wu5HdVXDErP7BGDksejCOLvNUeQPieRHbwnWEA_Q>
    <xmx:WRfYYaXQe7GzDJPHARsty-yk2QhzOM9H7gGiyb_xPEqksbMvq8YF6A>
    <xmx:WRfYYbx9vuumEt5WO8gTd7j_LO4SMKppTbdO_vjRzHD4aEmMjZvN8g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 05:35:04 -0500 (EST)
Date:   Fri, 7 Jan 2022 11:35:03 +0100
From:   Greg KH <greg@kroah.com>
To:     Pavel Hofman <pavel.hofman@ivitera.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <YdgXV49BdOHVxW6h@kroah.com>
References: <20220107024815.15dc7e04@canb.auug.org.au>
 <YdcUd19eAmI1MwNT@kroah.com>
 <8e3fe4fb-335e-58f5-84f4-3db224525fd0@ivitera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3fe4fb-335e-58f5-84f4-3db224525fd0@ivitera.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 11:02:34AM +0100, Pavel Hofman wrote:
> 
> Dne 06. 01. 22 v 17:10 Greg KH napsal(a):
> > On Fri, Jan 07, 2022 at 02:48:15AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the usb tree, today's linux-next build (htmldocs) produced
> > > this warning:
> > > 
> > > Documentation/ABI/testing/configfs-usb-gadget-uac2:2: WARNIN
> > > G: Malformed table.
> > > Text in column margin in table line 27.
> > > 
> > > =====================   =======================================
> > > c_chmask                capture channel mask
> > > c_srate                 capture sampling rate
> > > c_ssize                 capture sample size (bytes)
> > > c_sync                  capture synchronization type
> > >                          (async/adaptive)
> > > c_mute_present          capture mute control enable
> > > c_volume_present        capture volume control enable
> > > c_volume_min            capture volume control min value
> > >                          (in 1/256 dB)
> > > c_volume_max            capture volume control max value
> > >                          (in 1/256 dB)
> > > c_volume_res            capture volume control resolution
> > >                          (in 1/256 dB)
> > > fb_max                  maximum extra bandwidth in async mode
> > > p_chmask                playback channel mask
> > > p_srate                 playback sampling rate
> > > p_ssize                 playback sample size (bytes)
> > > p_mute_present          playback mute control enable
> > > p_volume_present        playback volume control enable
> > > _volume_present        playback volume control enable
> > > p_volume_min            playback volume control min value
> > >                          (in 1/256 dB)
> > > p_volume_max            playback volume control max value
> > >                          (in 1/256 dB)
> > > p_volume_res            playback volume control resolution
> > >                          (in 1/256 dB)
> > > req_number      the number of pre-allocated requests for both capture
> > >                          and playback
> > > =====================   =======================================
> > > 
> > > Introduced by commit
> > > 
> > >    e3088ebc1b97 ("docs: ABI: added missing num_requests param to UAC2")
> > > 
> > 
> > Pavel, can you send a follow-on patch to fix this up?
> > 
> 
> Greg, sorry for the inconvenience, of course I will do so. Please can you
> point me to some doc describing the correct ABI format? There are varying
> numbers of tabs in those files.

I don't know, try the build yourself and see what works!

greg k-h
