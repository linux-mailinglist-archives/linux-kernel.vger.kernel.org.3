Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D085746922A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhLFJTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239396AbhLFJTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638782155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T9q7LeQhf5AWVhUvL8JVu2PpakFvFX7rnL+ohMu0p0I=;
        b=XzNr5UnNfK2z3hN66mPsOjjE5YKrdQOjw7SBEpkW5nYf5IVeaA60lpXjfC8X5lDzmUGNmG
        smff1jixDi5RHiXkIcbDZhO9BY8fhJnCj/1INi2Qu/JV7EVFvAWZWHILGSE8DePlSHv4Nc
        QdPMu06Rj8lADAvCYxqLB3pEGeTO16s=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-ZaWOt2IYMJqjdZVXygfc_w-1; Mon, 06 Dec 2021 04:15:52 -0500
X-MC-Unique: ZaWOt2IYMJqjdZVXygfc_w-1
Received: by mail-yb1-f197.google.com with SMTP id t1-20020a5b03c1000000b005f6ee3e97easo18476139ybp.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 01:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9q7LeQhf5AWVhUvL8JVu2PpakFvFX7rnL+ohMu0p0I=;
        b=e/6/7x8JKgcHodTVussfpxE+AdhIowlzWUyO0mRQfwo516rYU0Y/L5DbUhZbWLygTb
         uEi+sLXXy0ocf1GCo1RRIvpgFC5ZBDrWPv38gWIv/VfAvrL/u4Zqn7b9rnqB6t4u9duG
         QXEdYORL+dlR1dnUC67VaZFmTxWVFf8XUfO/ZTLOduZNfS9kT1LuekWsVH7k09ntydly
         jiE+I4by8j2rbuH9ZIF1qiflBwXU/mkGviw0UpwA/LN1Fpj1a8XEMd1q2vN+13VtVdx/
         1P2rGqg7dSbr8GHx+8hFqoa1Q9ef8UquzCrY/pWigDPeuqAdHOjpla7oAYAUdfnOIkoM
         6fPw==
X-Gm-Message-State: AOAM533fiqYUSn8fehAoMSNrjPBWcmVmaUqc6a/J6GIcFgqQlq85hC5p
        rWKQ/7hgt++F2xcmYloURFpQjOWxcDeHWgNS2IIFe3F0a/BJ8SVxEdKoub55GGlMMu0xlmn/qUX
        13SrI9X0hJnyVx9RnLaRlXkgrX2at32JG62ETzTcp
X-Received: by 2002:a25:3b04:: with SMTP id i4mr39004986yba.767.1638782151904;
        Mon, 06 Dec 2021 01:15:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygOXN5DwxETcg+8zbuZINwEZOW6aA//EFeTffc5Z0ZA70SNru1sXcy/iQRJW6bMBWX+q1r447ibczC/XIWykY=
X-Received: by 2002:a25:3b04:: with SMTP id i4mr39004938yba.767.1638782151340;
 Mon, 06 Dec 2021 01:15:51 -0800 (PST)
MIME-Version: 1.0
References: <20211202033447.253596-1-bernard@vivo.com> <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
In-Reply-To: <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Dec 2021 10:15:41 +0100
Message-ID: <CAFqZXNvScVVconffdqAue-m5Ub119Pw+rdSZ2TXHt-BFeVa-GQ@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: fix potential memleak
To:     Paul Moore <paul@paul-moore.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 4:12 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Dec 1, 2021 at 10:35 PM Bernard Zhao <bernard@vivo.com> wrote:
> >
> > This patch try to fix potential memleak in function
> > selinux_fs_context_dup`s error branch.
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > ---
> >  security/selinux/hooks.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 62d30c0a30c2..36d7fc373839 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2856,24 +2856,38 @@ static int selinux_fs_context_dup(struct fs_context *fc,
> >         if (src->fscontext) {
> >                 opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
> >                 if (!opts->fscontext)
> > -                       return -ENOMEM;
> > +                       goto err_fscontext;
> >         }
> >         if (src->context) {
> >                 opts->context = kstrdup(src->context, GFP_KERNEL);
> >                 if (!opts->context)
> > -                       return -ENOMEM;
> > +                       goto err_context;
> >         }
> >         if (src->rootcontext) {
> >                 opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
> >                 if (!opts->rootcontext)
> > -                       return -ENOMEM;
> > +                       goto err_rootcontext;
> >         }
> >         if (src->defcontext) {
> >                 opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
> >                 if (!opts->defcontext)
> > -                       return -ENOMEM;
> > +                       goto err_defcontext;
> >         }
> >         return 0;
> > +
> > +err_defcontext:
> > +       if (src->rootcontext)
> > +               kfree(opts->rootcontext);
> > +err_rootcontext:
> > +       if (src->context)
> > +               kfree(opts->context);
> > +err_context:
> > +       if (src->fscontext)
> > +               kfree(opts->fscontext);
> > +err_fscontext:
> > +       kfree(fc->security);

Also here you need to be careful to not double-free fc->security.
(Paul's pseudocode below already correctly resets it to NULL after
freeing.)

> > +
> > +       return -ENOMEM;
> >  }
>
> Thanks for catching this a providing a patch, however I think the
> memory cleanup can be made simpler, see the pseudo code below:
>
> static int selinux_fs_context_dup(...)
> {
>
>   fc->security = kzalloc(...);
>   if (!fc->security)
>     return -ENOMEM;
>
>   opts = fc->security;
>
>   if (src->fscontext) {
>     opts->fscontext = kstrdup(...);
>     if (!opts->fscontext)
>       goto err;
>   }
>
>   /* ... */
>
>   return 0;
>
>   err:
>     kfree(opts->fscontext);
>     kfree(opts->context);
>     kfree(opts->rootcontext);
>     kfree(opts->defcontext);
>     kfree(opts);
>     fc->security = NULL;
>     return -ENOMEM;
> }
>
> --
> paul moore
> www.paul-moore.com
>

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

