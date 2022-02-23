Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91734C1DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiBWVoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiBWVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:44:06 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34B35240
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:43:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gb39so249176ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bJacL1gK1myHV6cmtvqCkNpKIOqEyVm+DidPJT3PKU=;
        b=sF8l6ITl0deyEMbxKkVIBrcWScHYUlwGQ8IQ5KmZ0HCOlbjdfOy9WsrDyQj6LWGhcv
         XHvcMFnlKmcsJSmgsY1rmpKshkAg8cYruw0wsuugbnkkzHD7MgPdOC6tAdEgHg45WR+3
         m2k4uZAbXdat+d3aXBzZTuFw6/XegOEvHgQR0tzcTRKAFhVFLNB2IjLo9pHyoUtVqGMB
         UOAT9gfzUxBjmOblb6206DPGuu+3UnRppOf3g1ywhHao8I/RF1TKAzOGE12ktriKt6mU
         Ml+BO4wJnQjK5FTt9k1MqxRe7WHHjEMoa10RhXV7MpH16ah7JM3J00tfLRBaLWVSYivY
         JAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bJacL1gK1myHV6cmtvqCkNpKIOqEyVm+DidPJT3PKU=;
        b=aEyFKg1RPwVkucm5bUYa1u3Tdz0Ive24yUWEk9qrds/Y5KXU5UDo5YAX3xAangqPXe
         UXIOCnVYqBm5CYhSupMQS+4MFZQQkwvrKysejFUslk8rF0wT2qhdX2p5VRygL4oWcQMn
         mbThKN+Bp6fk0gj0CzMmyb8gAF7y5XjYQk9oaM52MWnuDBq3D+DoHnUH3ThROleGrBPx
         7BoqGKV4HPNsjnqyjRRUJ9Nhx4/hjrOumntyB4pW5CB8nibnVjzKO1MvjS8NpE3xDkrM
         EqaNVpbsloq9AgYEdhDHrfBDzvWXbE068acFPnvbZXXImKYjE306IaMQE5vHv88XKwyJ
         BD/Q==
X-Gm-Message-State: AOAM533+o9h66RMC8anSV145XIvO/XDZGUjL23hBv9tedF7drXOPl1kQ
        vSKJrV91/ue/kJwlInm1EOtuZcf0mnTVbKEEKyKY
X-Google-Smtp-Source: ABdhPJwBa5BiAlhVuYVNXrJfYpf/d2rqSaNKp6tkpVo7n2CjOE9eD8xGwRxxfeJ3qiugJDqV0tr235dYcrvqaLu+QZo=
X-Received: by 2002:a17:906:6b8f:b0:6cd:7984:26fc with SMTP id
 l15-20020a1709066b8f00b006cd798426fcmr1203566ejr.701.1645652616571; Wed, 23
 Feb 2022 13:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
 <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
 <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
 <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com>
 <2b45951fceea5f535550f8ab3f3d25c3ff12a8c5.camel@btinternet.com> <CAHC9VhSDavBRxWEp2frY_dkSaxSBHfiCZ1zF2YNNoq6+-+GTjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSDavBRxWEp2frY_dkSaxSBHfiCZ1zF2YNNoq6+-+GTjA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Feb 2022 16:43:25 -0500
Message-ID: <CAHC9VhQ6kVroFZri+=DTewcecZASsH9VGZKi_zY4MzbbSmkEng@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 4:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 23, 2022 at 7:43 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Wed, 2022-02-23 at 13:12 +0100, Ondrej Mosnacek wrote:
> > > On Wed, Feb 23, 2022 at 12:58 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> > > > > On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> > > > > <richard_c_haines@btinternet.com> wrote:
> > > > > >
> > > > > > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > > > > > SELinux
> > > > > > always allows too.  Furthermore, a failed FIOCLEX could result
> > > > > > in a
> > > > > > file
> > > > > > descriptor being leaked to a process that should not have
> > > > > > access to
> > > > > > it.
> > > > > >
> > > > > > As this patch removes access controls, a policy capability
> > > > > > needs to
> > > > > > be
> > > > > > enabled in policy to always allow these ioctls.
> > > > > >
> > > > > > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > > > ---
> > > > > > V2 Change: Control via a policy capability. See this thread for
> > > > > > discussion:
> > > > > > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > > > > >
> > > > > > With this patch and the polcap enabled, the selinux-testsuite
> > > > > > will
> > > > > > fail:
> > > > > > ioctl/test at line 47 - Will need a fix.
> > > > > >
> > > > > >  security/selinux/hooks.c                   | 7 +++++++
> > > > > >  security/selinux/include/policycap.h       | 1 +
> > > > > >  security/selinux/include/policycap_names.h | 3 ++-
> > > > > >  security/selinux/include/security.h        | 7 +++++++
> > > > > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > Thanks Richard for putting together the v2 of this patch.
> > > > >
> > > > > As far as the test is concerned, it seems like the quick-n-dirty
> > > > > fix
> > > > > is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> > > > > everyone okay with that?  At least that is what I'm going to do
> > > > > with
> > > > > my local copy that I use to validate the kernel-secnext builds
> > > > > unless
> > > > > someone has a better patch :)
> > > >
> > > > To fix this I was planning to submit a patch that would change the
> > > > ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would
> > > > continue
> > > > to test the xperms.
> > >
> > > That one seems to be implemented only by some filesystems. Is there
> > > any more generic one we could use?
> >
> > What about  FS_IOC_GETFLAGS
>
> Unless I'm mistaken, FIGETBSZ should be largely fs independent.

Bah, nevermind, FIGETBSZ ends up in a FILE__GETATTR check.
FS_IOC_GETFLAGS has the same problem.

How about FIOQSIZE?

-- 
paul-moore.com
