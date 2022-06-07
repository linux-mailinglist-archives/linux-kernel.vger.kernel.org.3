Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0335B54217A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390809AbiFHBvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444026AbiFGXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:01:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E40527CD44
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:10:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso3633261wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PLD8bMvN51Cij4xdm7K//UbBPopjl8IHgVt7TPHocZY=;
        b=i2kaYQ6j5Q8SFA4O5Y3knelSOyr95qvMEWqsg29kMrTB8PQiNOrW1HRsCY0v9REmUA
         MNnKCXpGrmr8D7QexF3moz6L5iuMd8l0FTkbqhLRp9QxBQGVBe5LGE+DngOXpbQ4nww3
         Wqj82xBn8bye0OsYOcmrN7MAU43F5L73GrSpnM9BEnREQ3yUW7+Y4RtVEJvawoK1TVmG
         KDlhsp2EQmehusDg2ubUvtXKe4RhIwrl2QTJWx3/Ak+80wjoOQjkOY4jdj+2Ft54GtSK
         m6l5rpqDgdvNoh0XKRLtkEBAokvaVGkzqAgRX8uGk/gxtUkMhKVTqvkK/W+JyI4JYSJY
         L63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PLD8bMvN51Cij4xdm7K//UbBPopjl8IHgVt7TPHocZY=;
        b=j6ts+ecQb44sJpOcSBJ0sPTSsxZ6f1rZ27Bf6kRJ6N8x2RHWCKXldM9RCmZwLJEyLi
         onnV71a55T71xfQaBdSRSbmdZofsQJb3Uu9NPNlQ3jAv3d4IXt6BykdIdzNT7P9HXKQd
         tMI2aSZtjjTvPjK/f7qCtJipLOh7jhdFKo2wDU9aKeu8LD3swGr+IkuDxzPfqY4gby8Z
         DwDEwOiWywqsM9Jn+LtAtwMObsqyZo/PGmc2wky1o0pWNlHc3jqUtOZnKr12GrhT/FvG
         ZU99t6SjK7ENojR2oiob38T0KRMjlI+5oHpj3IjryJe3oXtGNUxUg40OWr7H5yVhXx25
         nYFQ==
X-Gm-Message-State: AOAM531oVJCAsMV70i38P6tOG6BEQuDdrzbTfLZD0NNZpq3uJpt13UQT
        gWj3+1mUleXnZN1x1wQv8b03E6iTgH4N9cYRpSr6nfTN9Q==
X-Google-Smtp-Source: ABdhPJwyFkl5Wu37OltnZgyQnBX2dD7guis4PxRqva+UdiTXRjPsIzjBlv+N77/IeKSH93JcMAUzMvIjfEltCOeIf0g=
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id
 h14-20020a05600c414e00b0039755aaccc0mr61318457wmm.51.1654632638942; Tue, 07
 Jun 2022 13:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
 <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
 <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com>
 <CAHC9VhRRBrLVtvmbJSTZ7fOkD-8AN4iM0WRmeL4ND001d3viJg@mail.gmail.com> <CAJ2a_DeT6AG0jp4gTdsEy7nh=s6cLR7QCsYXAz2+3vsdRKxddg@mail.gmail.com>
In-Reply-To: <CAJ2a_DeT6AG0jp4gTdsEy7nh=s6cLR7QCsYXAz2+3vsdRKxddg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jun 2022 16:10:28 -0400
Message-ID: <CAHC9VhQXdNieG8_uWBfCCFSow6AVaxNBhB3GNU8ea1j5rjgZiA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 9:45 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 17 Feb 2022 at 23:32, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Feb 17, 2022 at 9:24 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > On Thu, 27 Jan 2022 at 00:01, Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
> > > > <cgzones@googlemail.com> wrote:
> > > > >
> > > > > Create a security context for the inodes created by memfd_secret(=
2) via
> > > > > the LSM hook inode_init_security_anon to allow a fine grained con=
trol.
> > > > > As secret memory areas can affect hibernation and have a global s=
hared
> > > > > limit access control might be desirable.
> > > > >
> > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > > ---
> > > > > An alternative way of checking memfd_secret(2) is to create a new=
 LSM
> > > > > hook and e.g. for SELinux check via a new process class permissio=
n.
> > > > > ---
> > > > >  mm/secretmem.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > >
> > > > This seems reasonable to me, and I like the idea of labeling the an=
on
> > > > inode as opposed to creating a new set of LSM hooks.  If we want to
> > > > apply access control policy to the memfd_secret() fds we are going =
to
> > > > need to attach some sort of LSM state to the inode, we might as wel=
l
> > > > use the mechanism we already have instead of inventing another one.
> > >
> > > Any further comments (on design or implementation)?
> > >
> > > Should I resend a non-rfc?
> >
> > I personally would really like to see a selinux-testsuite for this so
> > that we can verify it works not just now but in the future too.  I
> > think having a test would also help demonstrate the usefulness of the
> > additional LSM controls.
> >
>
> Any comments (especially from the mm people)?
>
> Draft SELinux testsuite patch:
> https://github.com/SELinuxProject/selinux-testsuite/pull/80
>
> > > One naming question:
> > > Should the anonymous inode class be named "[secretmem]", like
> > > "[userfaultfd]", or "[secret_mem]" similar to "[io_uring]"?
> >
> > The pr_fmt() string in mm/secretmem.c uses "secretmem" so I would
> > suggest sticking with "[secretmem]", although that is question best
> > answered by the secretmem maintainer.

I think this patchset has been posted for long enough with no
comments, and no objections, that I can pull this into the
selinux/next tree.  However, I'll give it until the end of this week
just to give folks one last chance to comment.  If I don't hear any
objections by the end of day on Friday, June 10th I'll go ahead and
merge this.

--=20
paul-moore.com
