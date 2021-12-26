Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F093547F829
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 16:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhLZPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 10:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhLZPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 10:46:16 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8562BC06173E;
        Sun, 26 Dec 2021 07:46:16 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id g5so10256812ilj.12;
        Sun, 26 Dec 2021 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BryQMJZXYoms+UGfMnL+xv5Mi1tPHhDUFCjz4zjH2WA=;
        b=OMofkxelneGV9O87DozVyolUMLbZIc9ofJhs5ZPuX9MEuxbzY0CpyhnvLr+awwZ82M
         BIT4WlrHawkHAqKnbv0xsgmiVP1tp0dDrCL+wnp9n+k2cFHVg8NmXCUu/yYsql5+nbm7
         fNzG/d4YOx8IBwUWHaS49XlioXPa1ke3gW8IrX0TVuEv6roY0oHT5smLgIXVR1hEpTyh
         /eJ9tPg2f2jJw/itwbQMLvR3LdDdMIarG2Cp39YILqcysF+YDeLsgk7fiJhrjyTHedDU
         UenHIZO+rdhWmxJab30y6rN608SEzVB4P0Vjrk5+5Ar5mS29jgX120QilALK3xnm2vFQ
         eD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BryQMJZXYoms+UGfMnL+xv5Mi1tPHhDUFCjz4zjH2WA=;
        b=1D0YC+xu4XJNOKCEcqTq7DZEj/NOKb8D9FyI3QVVT7brBxFTTC2UQqh3v/ER6w8ri8
         r20fkpTNa/VeObBnHaTyd37jor3MkkEQTZw4UTpr5xfhpO91ZfNJilsFiavxVNYNyXF6
         duf/4TfLSweIXt8PJAA/acTURBXfWqYSaYtUhvS8loO/RQtAPXPhs6ASw2B8Du6NOcjp
         Q83jVOIFh+rlFbWzjwgeFe5X/Q7f/X43eTt0eAXoPUOGOnHR5YmfEmLGWdFu+vMvBeXN
         pHuUp1Ta9tE8XfGjH6vK4Af4t6p4hCiSCy1wPxO28KJfBLj6VB6gvGQmOdCpFRdB+Gja
         mwHw==
X-Gm-Message-State: AOAM5324bhbk8sL05i2O2HpcTr0vj236tIqKgQaXYCRLPC9sWTsNwePH
        zrFNK4CfdDY5RD0mFnHzWoAhwOmDoKN5zboudgk=
X-Google-Smtp-Source: ABdhPJwChIt10bSVqcuy29//L+D4EwgVfCjZ/oYCUJPSImsvao24EVM4I6Ld1q9DAZnDjQGjqsAOk29LcgZi7fYve/8=
X-Received: by 2002:a92:1e0a:: with SMTP id e10mr6162133ile.28.1640533575329;
 Sun, 26 Dec 2021 07:46:15 -0800 (PST)
MIME-Version: 1.0
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
 <Ycgi7GiU2udbjF2f@kroah.com> <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
 <796577bb0052f4f08f58882dfc86734d72f2aa29.camel@perches.com>
 <CA+fCnZcwkmw-phG2nHW=4-dxwxUy3AGFsppk==x96uwJRSEG2Q@mail.gmail.com> <YciH1Z69O85elZ/c@kroah.com>
In-Reply-To: <YciH1Z69O85elZ/c@kroah.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 26 Dec 2021 16:46:04 +0100
Message-ID: <CA+fCnZe5vdz3VSg54To5-zN-xVh8rcYaNXvxLpbL364BBskvow@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: upgrade license identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        andrey.konovalov@linux.dev, Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 4:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Dec 26, 2021 at 03:50:43PM +0100, Andrey Konovalov wrote:
> > On Sun, Dec 26, 2021 at 3:02 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Sun, 2021-12-26 at 14:19 +0100, Andrey Konovalov wrote:
> > > > I wonder if checkpatch could alert about considering GPL-2.0+ when
> > > > adding new files.
> > >
> > > No. Licensing is up to the author/submitter.
> >
> > You're right. However, knowingly choosing a license requires that the
> > author doesn't forget to look into the difference and understand it.
> >
> > When I contributed this code, I didn't realize that GPL-2.0 and
> > GPL-2.0+ are different things. I was focused on the excitement of
> > contributing a new USB gadget driver.
> >
> > What would have allowed my to not overlook this, is that if throughout
> > the _process_ of contributing a new module, something would _ask_ me:
> > "Is this really the license you want to use?".
>
> I normally try to do that when I see GPL-2.0+, sorry I didn't do that
> this time.

Do you mean GPL-2.0+ or GPL-2.0? The code wasn't under GPL-2.0+, so
you would not have said anything, AFAIU.

Anyway, no worries. The only reason I sent the SPDX change was because
of noticing that the tag doesn't match most of the other drivers.

> But really, your open-source training at your employer should have
> covered all of that.  If not, then something went wrong there :(

This is a weird statement for the general case.

Employers' processes exist to cover their legal bases. They have
nothing to do with the processes to guide Linux kernel contributors.

Legally, you're right: contributing requires accepting the rules under
which the contribution happens. Which means that contributors need to
read and understand all of the licensing documents before sending
patches. And it's on them, if they forget to do this or make a
mistake.

This is, however, poor from a contributor experience perspective.
Especially for independent contributors, who don't have a legal team
approving each of their actions.
