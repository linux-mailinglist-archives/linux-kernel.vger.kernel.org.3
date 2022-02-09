Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F94B005C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiBIWb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:31:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiBIWbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:31:52 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC049E0186D9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:31:50 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f17so7942000edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY7hhO1bC5lbho8ZpFz/uvNbjMguzN7sAedEp2sBebU=;
        b=rssUS/acb+BxW1zvWepfle4TqIv68o7OqDJBLW54+XnxrX6lIoxQqMMLaak5tJLF3j
         IC2BJ9Y2G9PEcNX//DaHZug3E+XVSsLMxZ9cSVpfqVA4GukP6YhgJYxraSnEKcUgeC71
         EBT3275a/kRyY0HyocxQ2m5b7XsVxvvC8Bkkxz4bxDOJ40RvYmmKe+8KohJacm4gLbsu
         gAUmEoxHIoP5RPOfNI9f0u1stWph8rcNdIWZHBKCguVKqI1KmbakVLelmZlX2Oqm+soo
         2fwvodZm4ZZEPCmbc4bWqQfPV+fSyQwFWRwObaLiVgFjZKH682bDblTKRPCMf2iIw9ux
         2dag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY7hhO1bC5lbho8ZpFz/uvNbjMguzN7sAedEp2sBebU=;
        b=JrVoyQT1TWfohERLG1YYlHF/zGIp/4XVG0dxokhFUdv/0A/WRzkdo9g3KlHyx+tbIc
         HcU0nkkoic40nrlAxoriZuvhRxGxy4VGJcZEXcPAMY3HdyOWCLatbuGA32WL/AgXCKco
         tG3/BvuAAkekfLeeDI2BBt1x5+HdoTXxSQLQ3NprXbRkmkqM4wykA5KQ5XLzC85cZRJ2
         sZk/D9Mr8iTzMtAJ+TywAvkGONjfkZwOSqzfIQbCRTDil6R8OJusC35jIgnKMD+BPkko
         /PG7Dus5LofT9E3785YE2CKmS3ROep6yfL4lF7jLAjYHeiFHiM0fWzBs+sbSzb24xHcU
         yTgw==
X-Gm-Message-State: AOAM530s/2005VfIb+3U85I1vQwqKrWyaoIMISowrlXapCUxQ1HESXjL
        LpIomlaCyIvamv5LcCWKWLTFZoHCZyfcUm9CMfcL
X-Google-Smtp-Source: ABdhPJwUNfjZCGfPkj27TA/J7q2UqoS1q9fubbNKT1mgH9jGEz3c/HLfBuBOOF3m+LSj/E70I6YdHGqH0gyxSIBVG7k=
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr5291750edy.427.1644445909356;
 Wed, 09 Feb 2022 14:31:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
 <c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com> <CAHC9VhSHJwwG_3yy4bqNUuFAz87wFU8W-dGYfsoGBG786heTNg@mail.gmail.com>
 <CAHC9VhRCBMtWWscTFWe4W_F_KNdfLys7e5Ged+N_xddD2tkuRQ@mail.gmail.com> <20220209221352.GG1708086@madcap2.tricolour.ca>
In-Reply-To: <20220209221352.GG1708086@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Feb 2022 17:31:38 -0500
Message-ID: <CAHC9VhRn7MGRqww2M28i8eD_EK3-OVtyqiMeT72Y7N_=f0MM9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, Tony Jones <tonyj@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 5:14 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2022-02-09 16:18, Paul Moore wrote:
> > On Wed, Feb 9, 2022 at 10:57 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Feb 8, 2022 at 10:44 PM Jeff Mahoney <jeffm@suse.com> wrote:
> > > >
> > > > Hi Richard -
> > > >
> > > > On 5/19/21 16:00, Richard Guy Briggs wrote:
> > > > > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > > > > ("open: introduce openat2(2) syscall")
> > > > >
> > > > > Add the openat2(2) syscall to the audit syscall classifier.
> > > > >
> > > > > Link: https://github.com/linux-audit/audit-kernel/issues/67
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> > > > > ---
> > > >
> > > > [...]
> > > >
> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index d775ea16505b..3f59ab209dfd 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -76,6 +76,7 @@
> > > > >  #include <linux/fsnotify_backend.h>
> > > > >  #include <uapi/linux/limits.h>
> > > > >  #include <uapi/linux/netfilter/nf_tables.h>
> > > > > +#include <uapi/linux/openat2.h>
> > > > >
> > > > >  #include "audit.h"
> > > > >
> > > > > @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> > > > >               return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> > > > >       case AUDITSC_EXECVE:
> > > > >               return mask & AUDIT_PERM_EXEC;
> > > > > +     case AUDITSC_OPENAT2:
> > > > > +             return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
> > > > >       default:
> > > > >               return 0;
> > > > >       }
> > > >
> > > > ctx->argv[2] holds a userspace pointer and can't be dereferenced like this.
> > > >
> > > > I'm getting oopses, like so:
> > > > BUG: unable to handle page fault for address: 00007fff961bbe70
> > >
> > > Thanks Jeff.
> > >
> > > Yes, this is obviously the wrong thing to being doing; I remember
> > > checking to make sure we placed the audit_openat2_how() hook after the
> > > open_how was copied from userspace, but I missed the argv dereference
> > > in the syscall exit path when reviewing the code.
> > >
> > > Richard, as we are already copying the open_how info into
> > > audit_context::openat2 safely, the obvious fix is to convert
> > > audit_match_perm() to use the previously copied value instead of argv.
> > > If you can't submit a patch for this today please let me know.
> >
> > I haven't heard anything from Richard so I put together a patch which
> > should fix the problem (link below).  It's currently untested, but
> > I've got a kernel building now with the patch ...
>
> Well, the day wasn't over yet...  I've compiled and tested it.

Yes, I tested my patch too and everything looks good on my end.

For future reference, while I didn't explicitly ask you to acknowledge
this thread and that you were working on a patch (I probably should
have), it would have been nice if you could have sent a quick note to
the list.

-- 
paul-moore.com
