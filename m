Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE615479B14
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhLRNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhLRNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:40:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28AC061574;
        Sat, 18 Dec 2021 05:40:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so18709762edb.8;
        Sat, 18 Dec 2021 05:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/UqZ/upQjkHGa9bi+yKS/UZ7AQ0AqXRlMB4Am1SrGQ=;
        b=e/IMQgAemgDsxjxrh8euApfhM10ZNYlxBo5XoHX1FVakKBP33qmVYSm0XAgcf+sGt9
         N+pdVlpVrGCSvQ6RT36/A1wgbAhnh54CRAQM08W1Vf2qs4S6P8VVVlbE9KYzRp7suzKO
         c9JC7HvfyY+C0c1s5kwo16zGXovSE+ExAWKOYpgvZI+Gs3989DGHwoOoC3Uyex5HCp9F
         /2y/bxEriQgKzy2TxsZ5Wjgz1oV2iweJGNqEtDvHh4Uz8gdKEnblAHM9jxe0BKH3Fc5H
         gP8Y3apJlIDw0YsD5JieWdxvbQUHp7M48cnMwVuLqZFs7jpZDRJdHCrNS3nLBASNBASK
         FKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/UqZ/upQjkHGa9bi+yKS/UZ7AQ0AqXRlMB4Am1SrGQ=;
        b=zKWBNNDbWP/5PLooBb+GmtddU4otKquugFExPAGWZ66AjMx4L/8WATo7NYI+vikPF6
         k7YgaqSVhDtsq0dK5MAIAXAidslq6iBN/IiQtEWw6KlwgZJDCsYxOHKvoj31ke2vc4qn
         yhPZLjuq9nsxLeKxC1atP0S1SINQbvp9Li3q+2f32raq5KHO/aVgoCRnS2KDyhBgpoHd
         JfRAVJy6/sSv05oBfGMAvYwJO+gPZS6qYMEeTVK8IGZahUL7N8jIWss+MfkprPi0vUH+
         ysR1vdnyJMB0U58ROlHON6cvpor7UIXnuEJByS9Sb2bXTfXH4R+7YO1rRVNWX7Jyh+b5
         G8Bw==
X-Gm-Message-State: AOAM530A+boLCvF4TzDCa4QYFb5b689pNhJreDfCux60jEPFOK415WFq
        BddWZe4fHiCfCftTNMeo4WYO8ifhYtqmtrrQYdM=
X-Google-Smtp-Source: ABdhPJz6mWnc12+sqhGlOiMgvbp8wGfd4d2dqfrf3Ls2jNpW+376Cl2K3k6X9RT/2x/qLIbTy2HMOHGzuqI6Z/rEm6Y=
X-Received: by 2002:aa7:d593:: with SMTP id r19mr2727512edq.168.1639834818167;
 Sat, 18 Dec 2021 05:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
 <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com>
 <CAN-5tyEKGQu1Y=o8KfsX3q9NkP4XZRos5stwmrT=ZV1hr1fWrQ@mail.gmail.com> <CAHk-=wiDT0aZO6UFnb9sW4rfuxp4xfPTSydnifVgL6H8b5Rb4Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiDT0aZO6UFnb9sW4rfuxp4xfPTSydnifVgL6H8b5Rb4Q@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Sat, 18 Dec 2021 08:40:06 -0500
Message-ID: <CAN-5tyEfuh9zNUsmrNd6kVFuuwmhVdGXM4JboA4OzgQqiqCC_Q@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 4:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 17, 2021 at 1:08 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > Can you please elaborate on what is problematic with the two patches
> > you've highlighted.
>
> Commit ec1ade6a0448 ("nfs: account for selinux security context when
> deciding to share superblock") adds the call to
> security_sb_mnt_opts_compat() from the nfs_compare_mount_options()
> function.
>
> But nfs_compare_mount_options() is called from nfs_compare_super(),
> which is used as the the "test" callback function for the "sget_fc()"
> call:
>
>         s = sget_fc(fc, compare_super, nfs_set_super);
>
> and sget_fc() traverses all the mounted filesystems of this type -
> while holding the superblock lock that protects that list.
>
> So nfs_compare_super() may not sleep. It's called while holding a very
> core low-level lock, and it really is supposed to only do a "test".
> Not some complex operation that may do dynamic memory allocations and
> sleep.
>
> Yet that is exactly what security_sb_mnt_opts_compat() does, as done
> in 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an
> existing mount").
>
> So those two patches are completely broken.
>
> Now, commit cc274ae7763d ("selinux: fix sleeping function called from
> invalid context") that I just merged "fixes" this by making the
> allocations in parse_sid() be GFP_NOWAIT.
>
> That is a *HORRIBLE* fix. It's a horrible fix because
>
>  (a) GFP_NOWAIT can fail very easily, causing the mount to randomly
> fail for non-obvious reasons.
>
>  (b) even when it doesn't fail, you really shouldn't do things like
> this under a very core spinlock.
>
> Also, the original place - nfs_compare_mount_options() is called over
> and over for each mount, so you're parsing those same mount options
> over and over again. So not only was this sequence buggy, it's really
> not very smart to begin with.
>
> That's why I say that a much better approach would have been to parse
> the mount options _once_ at the beginning, saving them off in some
> temporary supoerblock (or whatever - anything that can hold those
> pre-parsed mount options), and then have the "test" callback literally
> just check those parsed options.
>
> That's not necessarily the only way to go about this - there are
> probably other approaches too, I didn't really think too much about
> this. But those two commits on their own are buggy, and the fix is
> somewhat problematic too.

Thank you for the explanation. We will try to accomplish what you
describe. We'll separate the ability to parse mount options without
checking them and then add the ability to compare/check security
contexts (if that's the right term). Then selinux parsing can allocate
without setting GFP_NOWAIT but do it outside of the nfs_compare_super.

>
>                      Linus
