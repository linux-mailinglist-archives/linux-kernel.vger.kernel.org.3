Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE81478C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhLQNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhLQNfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639748153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ZE5+T9FIA/LsIMrDz4C7mJhlzQ37jyiywuLPjaXdaE=;
        b=QTQgowyvDaEZ/yKgJU8BC5pWHSZfVQANmkaDCODEmCDV6FMmidSrIxxxchyYmJrC20wDy3
        NXyoqy92LoP7/+ptMww0824hXCOVnthq6H1tz6Jak0VaYYQn0Bv9v2VkjyVjCqiwJGCi/c
        MZ+HqfqHU27ml1WXVEeILOFvzDhJJV8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-sHf3MHJbP42MjH8esE7_rQ-1; Fri, 17 Dec 2021 08:35:52 -0500
X-MC-Unique: sHf3MHJbP42MjH8esE7_rQ-1
Received: by mail-ed1-f72.google.com with SMTP id t2-20020a056402524200b003f7ed6cf4f1so1905062edd.21
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 05:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZE5+T9FIA/LsIMrDz4C7mJhlzQ37jyiywuLPjaXdaE=;
        b=2GiayrGbHF1aOaNKrYbUMzpShVLzpowe7FWrzNk4Q5K5dMcNmuV5s7Re1xjzByYUgh
         Bk34nW5YtTGklAeQg5adVVMYizuHcWJvYDZqrEhZjPTzxfrVetH31mh28hi6YRmPHeYi
         BC7FJJVHU9axI9bJ6QX7diHIPZU+lUrxfgtKOkhvuorUSFOLsIEctHrmA74eraAXkcXj
         IGzNOowrAjsOtolLPJ0QW5tqMNrOts5+vuMlPRwpFsbxH2B0UfIIF2LqaELkcmiLJolR
         EKVC/0pw6MtPQR49wuvYowvYbY2ytNf+VsFzc5PlaHFaFnyrdwdsYAqNyfbXaSbPbAtj
         sWIQ==
X-Gm-Message-State: AOAM533QTXeKukRvM/Ajq6ukORNZEwixbsMNnu2M2X0NJ/aax4yaimE4
        +IlfSFqlA9WJEfBSUGgNpD25cw2eym2lQv+URvUUEFgJ84kTmPf4yGIsJHaeP6mCMWgYClf2ef9
        lScE6d21l3PxkQzKwmEM2KK8UPwR+aBd9DhJ3Vqan
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr2721160ejs.540.1639748150915;
        Fri, 17 Dec 2021 05:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoiXFGOR4vgjI+ETFq9+5QOetUKZgoPnG9oL5+z8WVRV0/CPuIW6GrT+M51W3JOyXloa+NW5h0jgzKL/ll9Ps=
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr2721144ejs.540.1639748150663;
 Fri, 17 Dec 2021 05:35:50 -0800 (PST)
MIME-Version: 1.0
References: <163967073889.1823006.12237147297060239168.stgit@warthog.procyon.org.uk>
 <163967182112.1823006.7791504655391213379.stgit@warthog.procyon.org.uk>
 <CALF+zOkvC7kZ9LFQyjsRduQq+-gmaD4bLWc7H=AtVi6=NuC_dA@mail.gmail.com> <1958026.1639747261@warthog.procyon.org.uk>
In-Reply-To: <1958026.1639747261@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Dec 2021 08:35:14 -0500
Message-ID: <CALF+zOnerPWd7wYD0sC_v8rTeN0KHgP2abkDWWVGLr4QVrbSzg@mail.gmail.com>
Subject: Re: [PATCH v3 63/68] nfs: Convert to new fscache volume/cookie API
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs <linux-cachefs@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 8:21 AM David Howells <dhowells@redhat.com> wrote:
>
> David Wysochanski <dwysocha@redhat.com> wrote:
>
> > >
> > >  (4) fscache_enable/disable_cookie() have been removed.
> > >
> > >      Call fscache_use_cookie() and fscache_unuse_cookie() when a file is
> > >      opened or closed to prevent a cache file from being culled and to keep
> > >      resources to hand that are needed to do I/O.
> > >
> > >      Unuse the cookie when a file is opened for writing.  This is gated by
> > >      the NFS_INO_FSCACHE flag on the nfs_inode.
> > >
> > >      A better way might be to invalidate it with FSCACHE_INVAL_DIO_WRITE
> > >      which will keep it unused until all open files are closed.
> > >
> >
> > Comment still out of date here, reference
> > https://marc.info/?l=linux-nfs&m=163922984027745&w=4
>
> Okay, how about:
>
>  (4) fscache_enable/disable_cookie() have been removed.
>
>      Call fscache_use_cookie() and fscache_unuse_cookie() when a file is
>      opened or closed to prevent a cache file from being culled and to keep
>      resources to hand that are needed to do I/O.
>
>      If a file is opened for writing, we invalidate it with
>      FSCACHE_INVAL_DIO_WRITE in lieu of doing writeback to the cache,
>      thereby making it cease caching until all currently open files are
>      closed.  This should give the same behaviour as the uptream code.
>      Making the cache store local modifications isn't straightforward for
>      NFS, so that's left for future patches.
>

Yes, that is more accurate.

