Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81A5487F4F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiAGXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiAGXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:18:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2D3C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:18:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f8so6907248pgf.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcUcFBxpc9ID4beHj3LZVEpoGIJrtujuPv7fi7OSzeU=;
        b=cYk7v3REj5JT92ymWjoFJHT3nvUrFT1ufcOt5EDo5psuqviVgSgFlZBOb4fIwZshQ0
         rqRva5TUT55YfgPItuSIltXPEolCjz9AbaCrorW6HXhclmDHQg2uNK4fPGdMpwGm6tlW
         Df/DwJs7a1wlf2Kv58iOl5ENTh2ix7UeIWGfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcUcFBxpc9ID4beHj3LZVEpoGIJrtujuPv7fi7OSzeU=;
        b=RtAeYOlAawk3kr1KgdL4Nd8vqIKoToexScMcUDfKcPLsr5LXpIDGfyqvKmik45qO8y
         /4oz86DhuG+V3Dp31nsuMIYj6ak6mqTvmoG7qZc+WpMm8aWxFXpCc1H9+hEDIyfNsZIe
         i0bL3H0paPf+2/qhnPqDZGuzmA/0NV0qMCmg0oe019GETjumSGeCX0lZXd50hHKxyidL
         saJfZzmbWDi0RM7+D7jwlmKdKHmESbpqku+9EdrNgEwvtCf4DFohcy0al9TnuTq528Jf
         XAZO/GJSBHDmXGkg1jMGU9w8Bpm9R1L7S+QXfePB3IPdK5/ouCbfkxQ2LZbuFeMHDSS8
         vrmA==
X-Gm-Message-State: AOAM5312mPNjajVhFJjqLNK0Z95f3iYsnzeTmknPOwD701h6WfRdgLJZ
        u9pKjmycQgdfEd6o+2/A6skwTw==
X-Google-Smtp-Source: ABdhPJxs+kMXb7ewpy7D31H1nn5qFuY3PCAj+JXmXjIwYGSyOYNd18wjlGszqtJqyGxK/x0vBTNrYQ==
X-Received: by 2002:a63:4d17:: with SMTP id a23mr59125871pgb.179.1641597535344;
        Fri, 07 Jan 2022 15:18:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h26sm10892pfn.213.2022.01.07.15.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 15:18:55 -0800 (PST)
Date:   Fri, 7 Jan 2022 15:18:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <greg@kroah.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <202201071517.662B329D39@keescook>
References: <20211206144901.63529ac9@canb.auug.org.au>
 <Ya4Tb9NUj33UdxmI@smile.fi.intel.com>
 <20211206161734.GA4141317@maple.netwinder.org>
 <Ya491Dtj7HqoMhvW@smile.fi.intel.com>
 <YbcPz0SyzSlp8YGU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbcPz0SyzSlp8YGU@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:18:07AM +0100, Greg KH wrote:
> On Mon, Dec 06, 2021 at 06:44:04PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 06, 2021 at 11:17:34AM -0500, Ralph Siemsen wrote:
> > > On Mon, Dec 06, 2021 at 03:43:11PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Dec 06, 2021 at 02:49:01PM +1100, Stephen Rothwell wrote:
> > > > > Hi all,
> > > > > 
> > > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > > 
> > > > >   drivers/misc/eeprom/at25.c
> > > > > 
> > > > > between commit:
> > > > > 
> > > > >   9a626577398c ("nvmem: eeprom: at25: fix FRAM byte_len")
> > > 
> > > This was my original patch from Nov 8th.
> > > 
> > > > >   5b557298d7d0 ("misc: at25: Make driver OF independent again")
> > > > >   a692fc39bf90 ("misc: at25: Don't copy garbage to the at25->chip in FRAM case")
> > > > >   58589a75bba9 ("misc: at25: Check proper value of chip length in FRAM case")
> > > > >   51902c1212fe ("misc: at25: Use at25->chip instead of local chip everywhere in ->probe()")
> > > > > (and probably more)
> > > 
> > > These are newer versions and some cleanups from Andy. I was not aware of
> > > this work going on. I'm surprised at25 is getting so much attention ;-)
> > 
> > Me neither. :-)
> > 
> > > > > I fixed it up (I just used the latter version) and can carry the fix as
> > > > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > > > non trivial conflicts should be mentioned to your upstream maintainer
> > > > > when your tree is submitted for merging.  You may also want to consider
> > > > > cooperating with the maintainer of the conflicting tree to minimise any
> > > > > particularly complex conflicts.
> > > > 
> > > > The result from char-misc.current should be used as is and I guess it's
> > > > what you have done, thanks!
> > > 
> > > Agreed - Andy's version is cleaner, and includes my fixes. I've run some
> > > quick tests locally and all seems to be working as expected.
> > 
> > Thanks, Ralph!
> 
> This should now be resolved in my tree, thanks.

I think something has gone very wrong here. The allocation for "at25" is
now missing in at25_probe():

-       at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
-       if (!at25)
-               return -ENOMEM;
-

This leads to a fair bit of confusion from static analysis which sees
the "at25" as basically empty. :P

-- 
Kees Cook
