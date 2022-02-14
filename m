Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19EC4B4297
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiBNHLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:11:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbiBNHLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:11:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D035583BC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:11:41 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id m18so323471ljp.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6DcfZ92QqbVDkAs+5onWxHYvjv4eWwkjyJIREZ2EHI=;
        b=FuHHJ7d7pv5aBhqmGSDZ49xksdbfDW1/UWVdzf9yzdMEbAxQdda/x670Ojs+8e87vM
         E5fimacLU+KLUtiJ2cK3H3h9q2Od2Wa3HStmrEe4GLWhoJMXtCuXFhb4dqCaGfaGoLfa
         6AVvAon6gw93LvgE/YeBH7tl4vvAbD9rLhRg9ahUi2xDM8DdLqaQhOqJQSk3K11pmDc6
         akX1kWkWmI4lNlIQ2Lsvh0WC+oHthoN4+WS1+MOBsIb8rqYJdkBO4YKpYfOrxvWUrXQv
         aDjJUdJB3QU7x8T+dNg3bPDQFZCSpBPoh+uLjsq8dYnftpAmFy1MGpgcKgD2oMiqkKRR
         VnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6DcfZ92QqbVDkAs+5onWxHYvjv4eWwkjyJIREZ2EHI=;
        b=aUYgB5q2HjAo+/wu55h4G8mp36Euhti+HJ+szH+AnuvYbiDTtm3dG91ch4A7EcbShI
         tQvGKZvJOT6TanRFRnIu7IitF/2fjyvKVwFChJj1yGrMF1Nv4dTKRl7IQfyGPx877x21
         Xc40dt3FSF7qGCAOpG+8ahMrhCQYwvG0X/sLqmD7EUYIQvMMEYVqPVX8T+ma9fazcMan
         akdwYtg2hvRzBCeBJ688oi2dZSugwGyHC5fj6svqOYhaDmrqanXwUGq5sZy/0sZYHi+a
         11NxsX9JJlh/EMRwfwjCm0GW+ehniTFUDqz4j3A0tHWAnpcczE0KGaeUUNNFqZfo09k+
         QyoQ==
X-Gm-Message-State: AOAM530n1VIObc2fTHaYVKiFuy8fzo2SCIYeTQq0dULUso8l0JwMMLOd
        vkO8sO6XCk+5KaqyxvbtClTEXStiFK0fNukeCejAQQ==
X-Google-Smtp-Source: ABdhPJx7slpeRGSxnbPf6rrPFN41+RI0bP5E3hXma5RYfHdtnUcAjBwaynRftHeGXOGFN5zH+jAF0u9+ePiPHEGbbZI=
X-Received: by 2002:a2e:a4ce:: with SMTP id p14mr1611442ljm.124.1644822699006;
 Sun, 13 Feb 2022 23:11:39 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl> <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
In-Reply-To: <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
From:   Jeffrey Vander Stoep <jeffv@google.com>
Date:   Mon, 14 Feb 2022 08:11:28 +0100
Message-ID: <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 3:18 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> <snip>
>
> This is getting too long for me.
>
> > >
> > > I don't have a strong opinion either way.  If one were to allow this
> > > using a policy rule, it would result in a major policy breakage.  The
> > > rule would turn on extended perm checks across the entire system,
> > > which the SELinux Reference Policy isn't written for.  I can't speak
> > > to the Android policy, but I would imagine it would be the similar
> > > problem there too.
> >
> > Excuse me if I am wrong but AFAIK adding a xperm rule does not turn on
> > xperm checks across the entire system.
>
> It doesn't as you state below its target + class.
>
> >
> > If i am not mistaken it will turn on xperm checks only for the
> > operations that have the same source and target/target class.
>
> That's correct.
>
> >
> > This is also why i don't (with the exception TIOSCTI for termdev
> > chr_file) use xperms by default.
> >
> > 1. it is really easy to selectively filter ioctls by adding xperm rules
> > for end users (and since ioctls are often device/driver specific they
> > know best what is needed and what not)
>
> > >>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
> >
> > 2. if you filter ioctls in upstream policy for example like i do with
> > TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
> > (0xXXXX)))) then you cannot easily exclude additional ioctls later where source is
> > foo and target/tclass is bar/chr_file because there is already a rule in
> > place allowing the ioctl (and you cannot add rules)
>
> Currently, fcntl flag F_SETFD is never checked, it's silently allowed, but
> the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote policy
> to block the FIO*CLEX flags, it would be bypassable through F_SETFD and
> FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
> F_SETFD. Which means upstream policy users could drop this allow, which
> could then remove the target/class rule and allow all icotls. Which is easy
> to prevent and fix you could be a rule in to allowx 0 as documented in the
> wiki: https://selinuxproject.org/page/XpermRules
>
> The questions I think we have here are:
> 1. Do we agree that the behavior between SETFD and the FIO flags are equivalent?
>   I think they are.
> 2. Do we want the interfaces to behave the same?
>   I think they should.
> 3. Do upstream users of the policy construct care?
>   The patch is backwards compat, but I don't want their to be cruft
> floating around with extra allowxperm rules.


I think this proposed change is fine from Android's perspective. It
implements in the kernel what we've already already put in place in
our policy - that all domains are allowed to use these IOCLTs.
https://cs.android.com/android/platform/superproject/+/master:system/sepolicy/public/domain.te;l=312

It'll be a few years before we can clean up our policy since we need
to support older kernels, but that's fine.
