Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4234AC6E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384463AbiBGRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383646AbiBGRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:01:07 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6FC0401DD;
        Mon,  7 Feb 2022 09:01:06 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y129so5612841ybe.7;
        Mon, 07 Feb 2022 09:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTRuVaqajpl8oLymDUpg7WFzxX4FDWJYRUOPK7U1Ir0=;
        b=GPI7ziLCc6ZtVQOuo09my9y/hwGNdQCx4CP5HjEMybPGq2fmV+fz0x5Gr6wv/0TwB+
         EJxSErw4x8m0AkDxvtNGK1HCQqp2x8Vmwmw0t4E/mnA9uu1aX3riv2olLzUlq55iBw0s
         GWBieOozgZsmvXljYXyMOaVwnNjGg77StHLM5mSU03y0PZ6Ee4IDGOF1Awna7P5aN2WI
         fA9Ylv9lSpp5R0ezUJYxOCT5VIF46h9+1oF2YKipHGZWr6sJNNwqZideX+hghYrc69Pr
         eU+3y7Wt3UQluaWWQ+riBI+o7EG+ZNRprzfM5CkuZY/xgZ1api51FTlLfOF+Rwm+OJaD
         EfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTRuVaqajpl8oLymDUpg7WFzxX4FDWJYRUOPK7U1Ir0=;
        b=UH9VvAoVA87Hep9vJzBWt1rJzhAzfTVta8IIrMPWHR2PWDga7wv0UhpNNJH3zPYq9B
         f53ijvJH1wzyDrMiDMPHqdxxS5LWXHCpi1pIPDWMUk6aSGEFyao6ogVxBYUYNepvda2J
         5ACKN6SzoSLi1EgyNuCynU+JpZZEpk4JZm8Gl2KC1LfZqaOjGRyABnRmulKaq60lrjsl
         bxmqDv+pf8KDPFE5uYidjk/ziB4rD89JuA/OPMds5v84acvvicySklcKp6MImCdSMKq0
         N8+rU7//17U3Y5WJcgEXrw15BIYm6VIIgi8HlLmKxFc2FdB48JZV6OWJvLxPE+wbuAlF
         i1yA==
X-Gm-Message-State: AOAM532VIKRhTwhqdMBlK41SR2IwB3Pstmog24iv2FcqKS/4NmPMVr44
        ZYPieUsYYQkvAqTDjcEUzMxm40/3IRFRVcRK7QcnYHSNHyE=
X-Google-Smtp-Source: ABdhPJxZMU7f9Y2KkBbyTjQzngxXX0OwWbkE98XQLx6Dr07oRQkpXKfVL2L3MT8cE9rRLYd2IZ2H3M1D8v26/jQ+bqA=
X-Received: by 2002:a25:b58:: with SMTP id 85mr681517ybl.182.1644253265193;
 Mon, 07 Feb 2022 09:01:05 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
In-Reply-To: <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 7 Feb 2022 11:00:54 -0600
Message-ID: <CAFftDdpxmf4R9zPVGUUCFinST_2t8iW2SAJYG4e=3JeWtDowJw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Paul Moore <paul@paul-moore.com>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Feb 2, 2022 at 5:13 AM Demi Marie Obenour <demiobenour@gmail.com> wrote:
> > On 2/1/22 12:26, Paul Moore wrote:
> > > On Sat, Jan 29, 2022 at 10:40 PM Demi Marie Obenour
> > > <demiobenour@gmail.com> wrote:
> > >> On 1/26/22 17:41, Paul Moore wrote:
> > >>> On Tue, Jan 25, 2022 at 5:50 PM Demi Marie Obenour
> > >>> <demiobenour@gmail.com> wrote:
> > >>>> On 1/25/22 17:27, Paul Moore wrote:
> > >>>>> On Tue, Jan 25, 2022 at 4:34 PM Demi Marie Obenour
> > >>>>> <demiobenour@gmail.com> wrote:
> > >>>>>>
> > >>>>>> These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which SELinux
> > >>>>>> always allows too.  Furthermore, a failed FIOCLEX could result in a file
> > >>>>>> descriptor being leaked to a process that should not have access to it.
> > >>>>>>
> > >>>>>> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>
> > >>>>>> ---
> > >>>>>>  security/selinux/hooks.c | 5 +++++
> > >>>>>>  1 file changed, 5 insertions(+)
> > >>>>>
> > >>>>> I'm not convinced that these two ioctls should be exempt from SELinux
> > >>>>> policy control, can you explain why allowing these ioctls with the
> > >>>>> file:ioctl permission is not sufficient for your use case?  Is it a
> > >>>>> matter of granularity?
> > >>>>
> > >>>> FIOCLEX and FIONCLEX are applicable to *all* file descriptors, not just
> > >>>> files.  If I want to allow them with SELinux policy, I have to grant
> > >>>> *:ioctl to all processes and use xperm rules to determine what ioctls
> > >>>> are actually allowed.  That is incompatible with existing policies and
> > >>>> needs frequent maintenance when new ioctls are added.
> > >>>>
> > >>>> Furthermore, these ioctls do not allow one to do anything that cannot
> > >>>> already be done by fcntl(F_SETFD), and (unless I have missed something)
> > >>>> SELinux unconditionally allows that.  Therefore, blocking these ioctls
> > >>>> does not improve security, but does risk breaking userspace programs.
> > >>>> The risk is especially great because in the absence of SELinux, I
> > >>>> believe FIOCLEX and FIONCLEX *will* always succeed, and userspace
> > >>>> programs may rely on this.  Worse, if a failure of FIOCLEX is ignored,
> > >>>> a file descriptor can be leaked to a child process that should not have
> > >>>> access to it, but which SELinux allows access to.  Userspace
> > >>>> SELinux-naive sandboxes are one way this could happen.  Therefore,
> > >>>> blocking FIOCLEX may *create* a security issue, and it cannot solve one.
> > >>>
> > >>> I can see you are frustrated with my initial take on this, but please
> > >>> understand that excluding an operation from the security policy is not
> > >>> something to take lightly and needs discussion.  I've added the
> > >>> SELinux refpolicy list to this thread as I believe their input would
> > >>> be helpful here.
> > >>
> > >> Absolutely it is not something that should be taken lightly, though I
> > >> strongly believe it is correct in this case.  Is one of my assumptions
> > >> mistaken?
> > >
> > > My concern is that there is a distro/admin somewhere which is relying
> > > on their SELinux policy enforcing access controls on these ioctls and
> > > removing these controls would cause them a regression.
> >
> > I obviously do not have visibility into all systems, but I suspect that
> > nobody is actually relying on this.  Setting and clearing CLOEXEC via
> > fcntl is not subject to SELinux restrictions, so blocking FIOCLEX
> > and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD) is
> > blocked by seccomp or another LSM.  Clearing close-on-exec can also be
> > implemented with dup2(), and setting it can be implemented with dup3()
> > and F_DUPFD_CLOEXEC (which SELinux also allows).  In short, I believe
> > that unconditionally allowing FIOCLEX and FIONCLEX may fix real-world
> > problems, and that it is highly unlikely that anyone is relying on the
> > current behavior.
>
> I understand your point, but I remain concerned about making a kernel
> change for something that can be addressed via policy.  I'm also
> concerned that in the nine days this thread has been on both the mail
> SELinux developers and refpolicy lists no one other than you and I
> have commented on this patch.  In order to consider this patch
> further, I'm going to need to see comments from others, preferably
> those with a background in supporting SELinux policy.
>

AFAIK/AFAICT Android makes no reference to F_SETFD, and tracing the code
does seem to be ignored, and the code for FIOCLEX FIONCLEX calls into
the same kernel routine set_close_on_exec().
Considering that Android's bionic contains support for "e" flag to
fopen, and it's
used in a lot of places, makes me more sure the check is skipped for F_SETFD

However, Android does make reference to FIOCLEX FIONCLEX and every
domain has it enabled:
domain.te:allowxperm domain { file_type fs_type domain dev_type }:{
dir notdevfile_class_set blk_file } ioctl { FIOCLEX FIONCLEX };
domain.te:allowxperm domain tun_device:chr_file ioctl { FIOCLEX FIONCLEX };

Refpolicy doesn't use xperm AFAICT.

I stayed quiet, I wouldn't ack on this myself, but the premise seems
correct and we
can safely drop this. Note that I didn't review the code. But we need
to ensure we handle
policy correctly and not break anything. I'm not sure what the
compilers are doing
for validation of policy macro values, but we would probably want to
mark it deprecated,
but still allow loading of old compiled policies.

> Also, while I'm sure you are already well aware of this, I think it is
> worth mentioning that SELinux does apply access controls when file
> descriptors are inherited across an exec() boundary.
>
> --
> paul-moore.com
