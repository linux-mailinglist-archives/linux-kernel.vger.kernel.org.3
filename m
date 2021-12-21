Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B11A47BC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbhLUJM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:12:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39426 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhLUJMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:12:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 436E1B81213
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE93C36AE7;
        Tue, 21 Dec 2021 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640077973;
        bh=wkhRxl9n22YupsA9jjJKul8RUNbxzKsgD3EJZzsBKaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjCSsyGYhbRPIf45cDi3PJ+NHpx3ethdjzD60gd1fCzJ6r/OxcrpkMH0eQOTF6+Hr
         T2bZG5M2lnHuKYK4tvLOfVNUa7fWEdddVlPrQ3rkv75M8doVLjijzlHH62rpJ8c/EY
         EQlI1RHeA6zWLeNkzalJJfpEoknTk/HaRfREDruM=
Date:   Tue, 21 Dec 2021 10:12:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Julius Werner <jwerner@chromium.org>,
        Thierry Escande <thierry.escande@collabora.com>,
        linux-kernel@vger.kernel.org,
        Paul Menzel <pm.debian@googlemail.com>,
        Mike Waychison <mikew@google.com>
Subject: Re: [PATCH v2] firmware: Update Kconfig help text for Google firmware
Message-ID: <YcGakjioHqAFpLlE@kroah.com>
References: <20180618225540.GD14131@decadent.org.uk>
 <Yb8u44SLN25A3ONT@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb8u44SLN25A3ONT@eldamar.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 02:08:51PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Jun 18, 2018 at 11:55:40PM +0100, Ben Hutchings wrote:
> > The help text for GOOGLE_FIRMWARE states that it should only be
> > enabled when building a kernel for Google's own servers.  However,
> > many of the drivers dependent on it are also useful on Chromebooks or
> > on any platform using coreboot.
> > 
> > Update the help text to reflect this double duty.
> > 
> > Fixes: d384d6f43d1e ("firmware: google memconsole: Add coreboot support")
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > v2: Mention coreboot, and don't touch GSMI help text
> > 
> >  drivers/firmware/google/Kconfig | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> > index f16b381a569c..ca049ecf5cfd 100644
> > --- a/drivers/firmware/google/Kconfig
> > +++ b/drivers/firmware/google/Kconfig
> > @@ -2,9 +2,9 @@ menuconfig GOOGLE_FIRMWARE
> >  	bool "Google Firmware Drivers"
> >  	default n
> >  	help
> > -	  These firmware drivers are used by Google's servers.  They are
> > -	  only useful if you are working directly on one of their
> > -	  proprietary servers.  If in doubt, say "N".
> > +	  These firmware drivers are used by Google servers,
> > +	  Chromebooks and other devices using coreboot firmware.
> > +	  If in doubt, say "N".
> >  
> >  if GOOGLE_FIRMWARE
> 
> Prompted by a question downstream in Debian it looks that this patch
> never go applied.
> 
> Is there anything missing for having it applied?
> 
> Do you want a fresh resent of it?

I've picked it up now, thanks.

greg k-h
