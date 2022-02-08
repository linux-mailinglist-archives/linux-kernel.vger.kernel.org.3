Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1D4ADAFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377889AbiBHORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351022AbiBHORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:17:38 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F1C03FED0;
        Tue,  8 Feb 2022 06:17:37 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id g14so50150350ybs.8;
        Tue, 08 Feb 2022 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/FE6hmUPURE2i3GPevS9tMynrU15skMhSUEqO7ROt4=;
        b=Zj6YSgTNHhWFU5YsQtmVDBxj7unBXZewQHRDfw/kcADAF4Z6ZEzXKgHBdTd1lYRV/i
         ZdeJSd4gQaPF61rqGVfC0YTCATUINkKpBHGGJw9Z7P+whQQRM486tFytfIf/DPPF6lfm
         LBQSefSp4GS2lUxz9DBwKA4JcyqJEmXUiP1Lk13BKsQ9JcZJKg6o+IZm/nSeiJIKGjpF
         DkE08eLC3Z3Xeii8Oo2lzRG4ZxNpMz3lwomDXWZzb2HiMGtiGtofKDLZKvIxu464R5cs
         2trqHW2vV6D5SVwo2UYLSknkZboAOOQDULCf6FUxLXvBm1ex2zGf2JAkLSaV5sQm6s/f
         h2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/FE6hmUPURE2i3GPevS9tMynrU15skMhSUEqO7ROt4=;
        b=TTCv4a82LsDbXNk2bCfcZmfAu0FaMc9EVny7pV+KuGKdCAINrwr45rJRJztnRzBIlc
         ElNERRgES8k5vl6XM8KGGdsIttXx5UhLxoruAJSFTkF6zeWewRvgwdtze7BZ6Iaj3kkF
         oM8juX6LGWtH/APzeknbRlb/1DLH+U5tevJA6fFcYEk9TFBG/TwrjsCFZCUhWvzxYGqi
         GC5dCx0N4qlpCnsm7PVDIamZgvQZlnjEpBNbujpqZLI/4viyfhjJ/7VZpSqP7RJYro9+
         T/yTNdkx/fBHhe5gDMMuZH1biTOA4pBnad1w2NiIfSYvj83wIDWa8R3JMqa+U2LX6Ry7
         327w==
X-Gm-Message-State: AOAM5319WybRT1aHLzxBJPQM9yLi73UWt3lDfKCDyieO6wsOTd5kF6Va
        mJYz6NY9/hpe5SWTxy5FO+EzZRu/mDGMgY/nKaE=
X-Google-Smtp-Source: ABdhPJwYhAgwHyZnl0slapiFYcBS/AzPy7Nq6zVIJXkharwaHYzW5eGKUPywo4sm9iQpLAfIRtF3vAyOK97Br+zd2Q4=
X-Received: by 2002:a81:4319:: with SMTP id q25mr4866506ywa.369.1644329856283;
 Tue, 08 Feb 2022 06:17:36 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com> <875ypt5zmz.fsf@defensec.nl>
In-Reply-To: <875ypt5zmz.fsf@defensec.nl>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 8 Feb 2022 08:17:25 -0600
Message-ID: <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Demi Marie Obenour <demiobenour@gmail.com>,
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

<snip>

This is getting too long for me.

> >
> > I don't have a strong opinion either way.  If one were to allow this
> > using a policy rule, it would result in a major policy breakage.  The
> > rule would turn on extended perm checks across the entire system,
> > which the SELinux Reference Policy isn't written for.  I can't speak
> > to the Android policy, but I would imagine it would be the similar
> > problem there too.
>
> Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
> xperm checks across the entire system.

It doesn't as you state below its target + class.

>
> If i am not mistaken it will turn on xperm checks only for the
> operations that have the same source and target/target class.

That's correct.

>
> This is also why i don't (with the exception TIOSCTI for termdev
> chr_file) use xperms by default.
>
> 1. it is really easy to selectively filter ioctls by adding xperm rules
> for end users (and since ioctls are often device/driver specific they
> know best what is needed and what not)

> >>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
>
> 2. if you filter ioctls in upstream policy for example like i do with
> TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
> (0xXXXX)))) then you cannot easily exclude additional ioctls later where source is
> foo and target/tclass is bar/chr_file because there is already a rule in
> place allowing the ioctl (and you cannot add rules)

Currently, fcntl flag F_SETFD is never checked, it's silently allowed, but
the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote policy
to block the FIO*CLEX flags, it would be bypassable through F_SETFD and
FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
F_SETFD. Which means upstream policy users could drop this allow, which
could then remove the target/class rule and allow all icotls. Which is easy
to prevent and fix you could be a rule in to allowx 0 as documented in the
wiki: https://selinuxproject.org/page/XpermRules

The questions I think we have here are:
1. Do we agree that the behavior between SETFD and the FIO flags are equivalent?
  I think they are.
2. Do we want the interfaces to behave the same?
  I think they should.
3. Do upstream users of the policy construct care?
  The patch is backwards compat, but I don't want their to be cruft
floating around with extra allowxperm rules.
