Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833064795FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhLQVIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLQVIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:08:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDACC061574;
        Fri, 17 Dec 2021 13:08:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so12593796edb.8;
        Fri, 17 Dec 2021 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYNpYpBKR1zDDv4bK52aJuxv15cY9lkr4toXIMOz8FY=;
        b=jISnVxyo1zZVEFpDhJlYcXthjoYXHbC5n+ko7/eTmjJXZImO8Wkk7Z3WRrD7jtgZLt
         AYvvhc4FOHHjPrdETCQbQNlymFEHNgdIx8MtbSZDTF4/0ZdgWcJAmNNgX0h7p14r11jk
         Q1i8uOLjLw2t9M2cp6a4tV8lYvQWP45zvzrl3tOc2A8EuqGnq1A8JXhYe0dvM8TS9JQn
         SnqfAigtCjxyphRncO3yVul1KoK6rVu2jTRoaDKUIDmP5EYzz8EZAbeU6YafU1b1MO1z
         yiB4bZJTY7ptQP9e+KxGi5QDsCqtOs8jy4OIg/td15VlK+Ry3a310pWoDGl/jP+JyGCl
         VF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYNpYpBKR1zDDv4bK52aJuxv15cY9lkr4toXIMOz8FY=;
        b=bO7UkbF4fi8gNkO/SnO9zpE/8BDMwNYtAoI1z4pi1OkAf41pdXOopM5/7pFaqyzjdT
         FwZO4MVoGAshqdhg7HajUG3yFuiENL7yjam++4BC9ObZo4FOofQgmo64QPsbDu3/3Th6
         VqGUsbIopfmSwdUCkkbC/hkUH3ImkTLBNGTN6hvCYOur07eXOAw62toKkmWyxIZfxpjk
         VTB0hyXKse5d3DFNXcyGqFgCvOCfcraW1sFRDjsP3mM8d1VNFRj3GNV9d3fC9E3+eMsw
         Z2geJhNubmMstHNobx9RlrYM1gztAX+Q6+4HWx/5DIELTr3E2SXSe9bkp5n0nDKaeIQw
         hFog==
X-Gm-Message-State: AOAM533wkt8s/FdV88VndSKPgjBYvrsmnI9Iuo0uzErkVNISvv7QO0Lo
        a70ta22yyA5VEeSslmKwUHcZ7lBM+k9E1OZXrwo=
X-Google-Smtp-Source: ABdhPJxvptOuIWBSwczLxlVUcKo4BLqOeEWQy7lO3OL2bzt+p2LblmpD8W5s1JXOLXjEJYnduO3NC8FqkUDRm3tMh8w=
X-Received: by 2002:a17:906:cec5:: with SMTP id si5mr4151841ejb.17.1639775323779;
 Fri, 17 Dec 2021 13:08:43 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
 <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
In-Reply-To: <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 17 Dec 2021 16:08:32 -0500
Message-ID: <CAN-5tyEKGQu1Y=o8KfsX3q9NkP4XZRos5stwmrT=ZV1hr1fWrQ@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 3:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 17, 2021 at 12:02 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Another small SELinux fix for v5.16 to ensure that we don't block on
> > memory allocations while holding a spinlock.  This passes all our
> > tests without problem, please merge this for the next v5.16-rcX
> > release.
>
> Ugh, pulled.
>
> GFP_NOWAIT can very easily fail, so I'm not convinced your tests would
> catch any of the interesting cases.
>
> There is only one single caller of the new
> security_sb_mnt_opts_compat() callback, and I get the feeling that
> maybe we could parse the options first - into a temporary new
> superblock, and then at "test" time (when we're under that sb_lock) it
> could compare that temporary sb with pre-existing ones?
>
> That would also avoid the need for doing that mount option parsing
> over and over and over again for each sb on the 'fs_supers' lists.
>
> I've pulled this, bit it does smell bad to me, and I think that
> original commit 69c4a42d72eb ("lsm,selinux: add new hook to compare
> new mount to an existing mount") and ec1ade6a0448 ("nfs: account for
> selinux security context when deciding to share superblock") may not
> have been fully thought out.

Can you please elaborate on what is problematic with the two patches
you've highlighted. NFS needs a way to determine if the security mount
options have changed between the two mounts in order to determine if
superblock can be shared.

> It may have *looked* like just adding that check  to
> 'nfs_compare_super' was a simple and good idea, but it really doesn't
> look great.
>
> Adding a few more people to the cc.
>
>                  Linus
