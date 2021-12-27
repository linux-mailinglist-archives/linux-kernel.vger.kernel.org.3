Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3847FA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhL0GmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 01:42:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35088 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhL0GmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 01:42:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CECB60F10;
        Mon, 27 Dec 2021 06:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6B5C36AEA;
        Mon, 27 Dec 2021 06:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640587340;
        bh=cgpqhqbjwVyTuD50lymnw0sXhVr79kU8WYUDcf8qhN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLYvdUadZpWjF+ESnedohm+wCDts8hr1kufLl70+trTPD7lfYa35BkTGN8VE2BQoE
         dGtPH0kUwNfVgsj1EAEJ3AWN7JtAbFF7c+Sm5EL4Y28824zh4dPF2JMB8SWXzHB/3C
         TiXeDyQrPsZfDBfonc9l/4aYEtkqlw/NPsfmKiwY=
Date:   Mon, 27 Dec 2021 07:42:15 +0100
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
Message-ID: <YclgRzE1uO/FsPPX@kroah.com>
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
 <Ycgi7GiU2udbjF2f@kroah.com>
 <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
 <796577bb0052f4f08f58882dfc86734d72f2aa29.camel@perches.com>
 <CA+fCnZcwkmw-phG2nHW=4-dxwxUy3AGFsppk==x96uwJRSEG2Q@mail.gmail.com>
 <YciH1Z69O85elZ/c@kroah.com>
 <CA+fCnZe5vdz3VSg54To5-zN-xVh8rcYaNXvxLpbL364BBskvow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZe5vdz3VSg54To5-zN-xVh8rcYaNXvxLpbL364BBskvow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 04:46:04PM +0100, Andrey Konovalov wrote:
> On Sun, Dec 26, 2021 at 4:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Dec 26, 2021 at 03:50:43PM +0100, Andrey Konovalov wrote:
> > > On Sun, Dec 26, 2021 at 3:02 PM Joe Perches <joe@perches.com> wrote:
> > > >
> > > > On Sun, 2021-12-26 at 14:19 +0100, Andrey Konovalov wrote:
> > > > > I wonder if checkpatch could alert about considering GPL-2.0+ when
> > > > > adding new files.
> > > >
> > > > No. Licensing is up to the author/submitter.
> > >
> > > You're right. However, knowingly choosing a license requires that the
> > > author doesn't forget to look into the difference and understand it.
> > >
> > > When I contributed this code, I didn't realize that GPL-2.0 and
> > > GPL-2.0+ are different things. I was focused on the excitement of
> > > contributing a new USB gadget driver.
> > >
> > > What would have allowed my to not overlook this, is that if throughout
> > > the _process_ of contributing a new module, something would _ask_ me:
> > > "Is this really the license you want to use?".
> >
> > I normally try to do that when I see GPL-2.0+, sorry I didn't do that
> > this time.
> 
> Do you mean GPL-2.0+ or GPL-2.0? The code wasn't under GPL-2.0+, so
> you would not have said anything, AFAIU.

Ah, right, good, I didn't mess up then :)

> > But really, your open-source training at your employer should have
> > covered all of that.  If not, then something went wrong there :(
> 
> This is a weird statement for the general case.
> 
> Employers' processes exist to cover their legal bases. They have
> nothing to do with the processes to guide Linux kernel contributors.

Employers _BETTER_ be giving their developers who contribute to open
source projects basic legal training in licenses, copyrights, and other
related things.  If not they are very derelict in their duties.  I had
my first such training way back in 2001 or so, this is something that
most companies have been doing for decades and is nothing new.  Every
company I have worked at since has always had something like this in
place.

I would argue that any company that did NOT do this is not covering
their legal bases well at all, and that's a huge failure on their part.

Heck, the Linux Foundation even provides free training material for this
type of thing, online, if companies don't want to do it themselves.  I
recommend everyone at least glancing at this if they have to do any open
source work:
	https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/

> Legally, you're right: contributing requires accepting the rules under
> which the contribution happens. Which means that contributors need to
> read and understand all of the licensing documents before sending
> patches. And it's on them, if they forget to do this or make a
> mistake.

That's what you agree with with the "Signed-off-by:" line that you added
to your patch.  You did read the Developer's Certificate of Origin (DCO)
that decribes this in our documentation, right?  The DCO is very simple
and should be easy to understand.

> This is, however, poor from a contributor experience perspective.
> Especially for independent contributors, who don't have a legal team
> approving each of their actions.

See the free course information above for what is there for independent
contributors if they are interested in it.

thanks,

greg k-h
