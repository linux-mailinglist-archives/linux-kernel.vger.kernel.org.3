Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EFA485171
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiAEKvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:51:03 -0500
Received: from infomag.iguana.be ([185.87.124.46]:46966 "EHLO
        infomag.iguana.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiAEKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:51:01 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 05:51:01 EST
Received: by infomag.iguana.be (Postfix, from userid 1001)
        id 86175603CACE; Wed,  5 Jan 2022 11:43:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 infomag.iguana.be 86175603CACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iguana.be;
        s=infomag-20180602; t=1641379426;
        bh=lw3p1ytN1IY1ZXpUMw/aZ08wl5V0Hg0ZBj+0zckFgx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLDonfFx2tWB6gqkECmAW0I1FJMpMchAN27njhV8lzX5hjlQ4P0WaKUPHN5VRNiYp
         W3R4h6hVCgdavChZZfpIEj10pAFVuskoHVIxVtx7Ny8FcuHUkOEzPKTBRNtsv6sK5H
         k2aGbcBhfPwl3YTQekgqdbShp0+hvuDLsm2+J5ZA=
Date:   Wed, 5 Jan 2022 11:43:46 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tags need some work in the watchdog tree
Message-ID: <20220105104346.GA15162@infomag.iguana.be>
References: <20220104083659.4e5f2754@canb.auug.org.au>
 <432b6c61-f8c6-368d-2386-590bed2aee7a@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432b6c61-f8c6-368d-2386-590bed2aee7a@norik.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> Hi Stephan,
> 
> On 3. 01. 22 22:36, Stephen Rothwell wrote:
> >Hi all,
> >
> >In commit
> >
> >   02d04e694fa3 ("watchdog: s3c2410: Fix getting the optional clock")
> >
> >Fixes tag
> >
> >   Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")
> >
> >has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> >Maybe you meant
> >
> >Fixes: e249d01b5e8b ("watchdog: s3c2410: Support separate source clock")
> >
> >In commit
> >
> >   ce3401c72f01 ("watchdog: da9063: Add hard dependency on I2C")
> >
> >Fixes tag
> >
> >   Fixes: 5ea29919c294 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
> >
> >has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> >Maybe you meant
> >
> >Fixes: 968011a291f3 ("watchdog: da9063: use atomic safe i2c transfer in reset handler")
> >
> 
> Yes, that's probably right for my patch, sorry for that.
> 
> I was puzzled on where to get the SHA1 of not-yet applied commit,
> because this patches ("watchdog: da9063: use atomic safe i2c
> transfer in reset handler" and the fix "watchdog: da9063: Add hard
> dependency on I2C") followed quite closely together. Is there any
> way that I can get the SHA1 of the commit that was applied? It
> should be a part of some branch right? I'm asking because I couldn't
> find a repo or a branch that this two commits are a part of.
> 
> Anyway should I send a v2, or what is the procedure here?

I'll fix that.

Kind reards,
Wim.

