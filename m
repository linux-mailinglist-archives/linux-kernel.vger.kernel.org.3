Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67A1478C66
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhLQNek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:34:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22099 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhLQNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639748078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L/4V3fSn58a1gWnecg4Vr8ZqaKf1a0EGk12hvBWCTkM=;
        b=bQFKbefwUZRi7ZvmpqruxJ5vhyyhdfdCz9MVaAlaQ9SjoJ8kGAEasvwhKx0LRhHFvo77Ju
        vN/9mRzl8LFibP2iZOVLgkS+zfgLuRcij79u4iRHhXWQt/JQZfkrwgFOkAxa80ivG9Fo38
        ilHe7D35xcR5X7Zwgrilb8Yk7umF8Vk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-QiLFJxz0NkK6df9JjcSFzw-1; Fri, 17 Dec 2021 08:34:37 -0500
X-MC-Unique: QiLFJxz0NkK6df9JjcSFzw-1
Received: by mail-ed1-f70.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso1943851edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 05:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/4V3fSn58a1gWnecg4Vr8ZqaKf1a0EGk12hvBWCTkM=;
        b=Pq8kOUohpfZfi7z2m4sX1IuWfdWepQADIxTgxQboUIWqDD0uMEEtSzWmriPEi+5gqF
         lJlKJYVTDX5/nK14Q2doaYP6XeBpT9yEJpkyv8gDjtB2efMwZdQaUNRFd6zowZli8NdS
         bqUCoEUdso4Uy8Jl9CnlI5qfgfakh+n8xd4MtqRSnCbqdVg5QHnt8mOGXTVX6ggj3tTv
         q1qnBcewDJ+mYf/lBpX4hBZgbXUeo8rOKIg5HN1U9/B3q/DS1NiBPQvtSaHXTS1qNOD6
         AYdZT1vPb6r4Lm41Vu3MEI2c03cdE1m5S7T2rc+GKV3nQpUe861PaWcfI4kgm8LX3Kda
         cBKA==
X-Gm-Message-State: AOAM530Uflv2WiXLqRqMFTPFMbxHofqqS7ZTlG4wlqvfWqrxC9j0q62m
        zoMxzteJaaUhqGlCrgv1j4TbWW0E68NuHoHAdhfrhZqYmOM06RXtgPXfyPRA048r4ldxK1GozF9
        x0wiHuPrTp1zJeJbhvAHwIEamLcLOFyg2Bdu80UWU
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr2717201ejs.540.1639748075944;
        Fri, 17 Dec 2021 05:34:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfCuAPtEgHBTr7q3MGwDVaFX/Fg0EWtDvOdr4UgrWss0B7EdpNUGmjSmVfPvodIYtapCLIGbKSCqQwhQUojqQ=
X-Received: by 2002:a17:906:58d5:: with SMTP id e21mr2717185ejs.540.1639748075730;
 Fri, 17 Dec 2021 05:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20211217113507.76f852f2@canb.auug.org.au> <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com>
 <1957083.1639746671@warthog.procyon.org.uk>
In-Reply-To: <1957083.1639746671@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Dec 2021 08:33:59 -0500
Message-ID: <CALF+zOnZ4v7DaZ6ymh28MPeeDYDLg06mWKxhB0xOVE2P8LGZ+w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the fscache tree
To:     David Howells <dhowells@redhat.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 8:11 AM David Howells <dhowells@redhat.com> wrote:
>
> David Wysochanski <dwysocha@redhat.com> wrote:
>
> > Anna, feel free to drop these from your tree to avoid the conflicts
> > with the rest of your tree and dhowells fscache-rewrite patchset.
>
> Would it help to take some bits through my tree?  (Or, at least, alter my NFS
> patches)
>

I think so.  If Anna is ok with it, she can drop them from her tree.
And I'm looking at these 7 patches to see which ones make sense on top
of your tree (the v3 patches you just sent).

Mainly my patches were cleanups, plus converting from dfprintk to tracepoints.
Some patches may no longer be needed.
As one example, this may be better done with tracepoints inside
__fscache_use_cookie and __fscache_unuse_cookie

3b779545aa01 ("NFS: Convert NFS fscache enable/disable dfprintks to
tracepoints")

