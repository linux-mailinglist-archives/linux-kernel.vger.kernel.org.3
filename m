Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5A49C7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiAZKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiAZKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:47:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC5BC06161C;
        Wed, 26 Jan 2022 02:47:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F5BFB81C9F;
        Wed, 26 Jan 2022 10:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E1C340E3;
        Wed, 26 Jan 2022 10:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643194044;
        bh=vuGn7JXm7Q//svSIDLaXfwhNKeFJcdxV3WEobVbBShQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgK7lt4FcNv7BSji1XFLc3DLwHJ1umL0GveV3ODU/2pHbloy8y3Xgo7UD4tDdw1ds
         S7cI4b9ThCYR0kbYgBCgv+KqXLgfTPFHY6C4TsuyyDaWlw6hMhrxn5B7UE2c/xQjkK
         js+j51u54uPqImPVcqBUC/ovBAi3QD+djkfMTG9k=
Date:   Wed, 26 Jan 2022 11:47:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfEmuGVQ+IlhdQDh@kroah.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:02:36PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 10:52 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi
> >
> > Am 25.01.22 um 21:21 schrieb Andy Shevchenko:
> > > Since we got a maintainer for fbdev, I would like to
> > > unorphan fbtft (with the idea of sending PRs to Helge)
> > > and move it out of staging since there is no more clean
> > > up work expected and no more drivers either.
> > >
> > > Thoughts?
> 
> Thanks for sharing yours, my answers below.
> 
> > But why? We already have DRM drivers for some of these devices.
> 
> No, we do not (only a few are available).
> 
> > Porting
> > the others to DRM is such a better long-term plan.  OTOH, as no one has
> > shown up and converted them, maybe they should be left dead or removed
> > entirely.
> 
> As I mentioned above there are devices that nobody will take time to
> port to a way too complex DRM subsystem. But the devices are cheap and
> quite widespread in the embedded world. I'm in possession of 3 or 4
> different models and only 1 is supported by tiny DRM.

Great, then let's just move the 2 models that you do not have support
for in DRM, not the whole lot.  When we have real users for the drivers,
we can move them out of staging, but until then, dragging all of them
out does not make sense.

thanks,

greg k-h
