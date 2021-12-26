Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B947F769
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 16:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhLZPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 10:18:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55390 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhLZPSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 10:18:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F381960DEE;
        Sun, 26 Dec 2021 15:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402DFC36AE8;
        Sun, 26 Dec 2021 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640531929;
        bh=SCpncZYOrIU+XpzJbRS128HV5LHt9hTgta9KVKTKG/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEfKa6BoONwSmRJfD1kuOQFFVuxkVJdx2l81jDBtkNUBrFkqTOL1uoNCHtEmfXqM8
         JHzhxKWTfOT5ISBmRYsZQDwxZxfqFVMaqyFnrFlhPVBpnFnRnoE6E+yaFoVOHyliBW
         0lWqdgPFLSbq4jScPmZCLVDN+aAJwnr1O3nR71OM=
Date:   Sun, 26 Dec 2021 16:18:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        andrey.konovalov@linux.dev, Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] usb: raw-gadget: upgrade license identifier
Message-ID: <YciH1Z69O85elZ/c@kroah.com>
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
 <Ycgi7GiU2udbjF2f@kroah.com>
 <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
 <796577bb0052f4f08f58882dfc86734d72f2aa29.camel@perches.com>
 <CA+fCnZcwkmw-phG2nHW=4-dxwxUy3AGFsppk==x96uwJRSEG2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcwkmw-phG2nHW=4-dxwxUy3AGFsppk==x96uwJRSEG2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 03:50:43PM +0100, Andrey Konovalov wrote:
> On Sun, Dec 26, 2021 at 3:02 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Sun, 2021-12-26 at 14:19 +0100, Andrey Konovalov wrote:
> > > I wonder if checkpatch could alert about considering GPL-2.0+ when
> > > adding new files.
> >
> > No. Licensing is up to the author/submitter.
> 
> You're right. However, knowingly choosing a license requires that the
> author doesn't forget to look into the difference and understand it.
> 
> When I contributed this code, I didn't realize that GPL-2.0 and
> GPL-2.0+ are different things. I was focused on the excitement of
> contributing a new USB gadget driver.
> 
> What would have allowed my to not overlook this, is that if throughout
> the _process_ of contributing a new module, something would _ask_ me:
> "Is this really the license you want to use?".

I normally try to do that when I see GPL-2.0+, sorry I didn't do that
this time.

But really, your open-source training at your employer should have
covered all of that.  If not, then something went wrong there :(

thanks,

greg k-h
