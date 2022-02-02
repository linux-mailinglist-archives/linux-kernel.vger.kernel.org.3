Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541934A78E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346965AbiBBTtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiBBTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:49:01 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D81C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:49:01 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b9so1229538lfq.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 11:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4aJfctSbRMZuzvUkpBVrI4wB5MY5G7hf31Xe4XK4b8=;
        b=Us0vtuOBprfLEqvLHQDzrGhm18RE8Rg34BdfzcP2JDopYH2EfoknKFadApKgBKbmj4
         OuLxmwMLKbhxcKaNTvYvI4xCLXWE4WVIFAVmLAgxYDFVcdSLqiY3S+EOmzyW74TBlmU8
         hzCcj4howm1nFBknrv8dOEKf7LNxK4lFIHIfLuwAoN2KclgqVGesFmkIvC1s63zTNFWe
         lXvi6l1MMF5chJOmdpRVdSt8ipQUq2QF848h7cn2MIg2ZqnqCdSQtaXhCznHSz50PJGX
         pw63jbYWejY2CJHfxRO+iEkBlj9MKefB9yx/fz0I5pZ7ExJdmeT7ty5GIZzoAh/ISin2
         AErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4aJfctSbRMZuzvUkpBVrI4wB5MY5G7hf31Xe4XK4b8=;
        b=oY1O5N/PDmr6ILBzUHagrrWaqWqpbx3/k1ekhUKd/ak/dhwhh4cCUg7g6Ph4a1Hu04
         xLS7AL8wQZPGCMYl7UbhOfREC1z4uyqgfmDVAQnRAQLI2vGp6cOhnuOQHr5Q2RE6QI+X
         1fYoPBoW43bp/Aa1eqFjc26bUyK5twSHs3nPPgbn11q8P7Gcx0pxeNavLbkAjtVAw9ns
         5X9ZPs+rzR1iLoGOOTfGyIxIz17UQRmFCcDJjPLQCRDPuQRQFR9b13zAh0PepN2PH8Jn
         F1Zgl60CT+joSxIvLc5xgth4XHACFQy5IcdtgAH64G4pfbkvi+IBLtSgsi1N3zkWjd15
         d9Nw==
X-Gm-Message-State: AOAM530qH8+PGRzzW5bWpPXw1LTz6CcANnX4VmL7lyNqX3CXOnk6zu5t
        hj6QvH9262fWqMU/0yvs1DiMY9WnYR/ydSpe72a10S52w4M=
X-Google-Smtp-Source: ABdhPJybNdXfG7Q/jDBEIa4qm8bUj7hsTpDmd0or0Rg1zB1IW+GIT1q77c3MSDvwG4Li9Ol3dm6ku9x8r73i/umaTBE=
X-Received: by 2002:ac2:5fcd:: with SMTP id q13mr24738604lfg.152.1643831339664;
 Wed, 02 Feb 2022 11:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20220202151734.10418-1-jandryuk@gmail.com> <YfrC/fQvQ1nkIJNJ@grain>
In-Reply-To: <YfrC/fQvQ1nkIJNJ@grain>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Wed, 2 Feb 2022 14:48:48 -0500
Message-ID: <CAKf6xpsfDpEpjSjYbGU5fQOxqjccbu3CAXTxpcKggKYu6qEfNA@mail.gmail.com>
Subject: Re: [PATCH] kcmp: Comment get_file_raw_ptr() RCU usage
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 12:44 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Wed, Feb 02, 2022 at 10:17:34AM -0500, Jason Andryuk wrote:
> > This usage of RCU appears wrong since the pointer is passed outside the
> > RCU region.  However, it is not dereferenced, so it is "okay".  Leave a
> > comment for the next reader.
> >
> > Without a reference, these comparisons are racy, but even with their use
> > inside an RCU region, the result could go stale.
> >
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > ---
> > I was looking for examples of task_lookup_fd_rcu()/files_lookup_fd_rcu()
> > and found this.  It differed from the example given in
> > Documentation/filesystems/files.rst, so I was initially confused.  A
> > comment seemed appropriate to avoid confusion.
> >
> >  kernel/kcmp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/kcmp.c b/kernel/kcmp.c
> > index 5353edfad8e1..4fb23f242e0f 100644
> > --- a/kernel/kcmp.c
> > +++ b/kernel/kcmp.c
> > @@ -63,6 +63,9 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
> >  {
> >       struct file *file;
> >
> > +     /* This RCU locking is only present to silence warnings.  The pointer
> > +      * value is only used for comparison and not dereferenced, so it is
> > +      * acceptable. */
> >       rcu_read_lock();
> >       file = task_lookup_fd_rcu(task, idx);
> >       rcu_read_unlock();
>
> They are not wrong, this is just such a bit weird semantics where
> we fetch the pointers and strictly speaking map them into numbers
> set to compare. But I agree that such tricks might confuse. How about
>
>         /*
>          * Fetching file pointers inside RCU read-lock section
>          * and reuse them as plain numbers is done in a sake
>          * of speed. But make sure never dereference them after.
>          */

I would tweak it a little to "Fetch file pointers inside RCU read-lock
section, but skip additional locking for speed.  The pointer values
will be used as integers, and must not be dereferenced."

One other idea I had was to switch the return value to "void *".  That
way it isn't a struct file, and it isn't readily dereference-able.
But I wasn't sure if that would be overkill.  What do you think?

Thanks,
Jason
