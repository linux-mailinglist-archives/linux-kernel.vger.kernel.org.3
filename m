Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820D84E442B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbiCVQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiCVQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:25:42 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C57193DA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:24:14 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j15so2628230ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOeOIvGimB6HO5RmhYqpUb1uM8S1rPxVjA+0/EvkfKw=;
        b=owyVl78YQ+Y63SYzSiKlBjJPFLxA83xdtqRuFwvnVTP8gVWYD6/0kckErOApwJSGzZ
         5bw28tJizVDvr8Es1fnQPR1Bm61VpXmAv6e4oq6LmXqc1ubrpiIr+PEIis+26PJt9Lf3
         s7RhXD4WDFERhJM39t/BaUkdOwB9xBSxf9Nuqa85xxVoaKMSiggRA1OOA/WWASTihzep
         22kneOF0rEr+sFjkeQWy3axpf7XQmCf/R2X865T5cAf5zUxjMwvt7VFDnn2ciM12v6a+
         TIheepShD3J9LTsVwOS455jrqv3UQ/vcKTmC5SFbzQixITy2gYFq3Go0zzzY6C5vTbig
         Anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOeOIvGimB6HO5RmhYqpUb1uM8S1rPxVjA+0/EvkfKw=;
        b=a1oHO1SCtosIkBC+J7ARmbphd2Ea4Ksyg9S/MxRfZidm+D2FyliusemrnCDS1LcgTY
         TD/5hZAUNLhDu/iP5OXDjrWXWbvq6K+XbTN0FetrUOtFhBJTors8UN/926vE8KuTYsx3
         6E63Pf/cjx1LnW+Fid78sH9U6IsKDdz6q7H1eRzY0162Evas2wRca+awtG3eyebQtOrZ
         N9IyXU5IgIMjL4Ahspe/ouFV43qg3RFE9aTYTA1IY+jiSmkN18jBybbyBvpqJqB/06Mo
         AARzSyUrfiLccWQMevEL3xJzHpGEH1EJDwJjoPNASMG8/u2QatAmrE7HQHJFuhf6QPLd
         apBA==
X-Gm-Message-State: AOAM530zkfMGsTchRJAvtunzLvTbwnfY+3SB/V1vBnihGQo0J/vpzi+p
        FN2GylrtNXjPuUB5Dz7GREK+Qdy5sJIWT2h8cI7ExQ==
X-Google-Smtp-Source: ABdhPJyhriwKRUl/v7OIFOTFmrToxKZ8KiV8cyTOgLM6GNRCif1UqxhqJZUginQD8NuQ5qhFsMQPaaJxGp9YcECPw8A=
X-Received: by 2002:a05:6e02:1a82:b0:2c8:1ce0:6f64 with SMTP id
 k2-20020a056e021a8200b002c81ce06f64mr6453658ilv.239.1647966254082; Tue, 22
 Mar 2022 09:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220318191343.72812-1-abbotti@mev.co.uk> <YjgW7L77+Y2fylcR@xz-m1.local>
 <a2380fac-d173-50e3-963a-d7fc22b2da5d@gmail.com>
In-Reply-To: <a2380fac-d173-50e3-963a-d7fc22b2da5d@gmail.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 22 Mar 2022 09:23:38 -0700
Message-ID: <CAJHvVch=vO6gwyn+swyeHEQ4mUccL6T+Vt3G9akeEjXZ6XKM-A@mail.gmail.com>
Subject: Re: [PATCH] ioctl_userfaultfd.2: Corrections for returned .ioctls members
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Ian Abbott <abbotti@mev.co.uk>,
        linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 5:32 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hi Ian and Peter,
>
> On 3/21/22 07:10, Peter Xu wrote:
> > On Fri, Mar 18, 2022 at 07:13:43PM +0000, Ian Abbott wrote:
> >> Support for the `UFFDIO_WRITEPROTECT` operation is not indicated in the
> >> `ioctls` member of `struct uffdio_api`.  It is indicated in the `ioctls`
> >> member of `struct uffdio_register` along with indications of support for
> >> the `UFFDIO_COPY`, `UFFDIO_WAKE` and `UFFDIO_ZEROPAGE` operations (and
> >> also the `UFFDIO_CONTINUE` operation supported since Linux 5.13 but
> >> that is not documented by this man page yet.)
> >
> > I thought it should have landed but indeed it's not.  Copying Axel.

Ah, I mistakenly thought it got merged, but there were a few remaining
issues Alejandro wanted addressed first. I'll send a v3 of it later
today.

For what it's worth, as part of adding minor fault handling, we pretty
significantly change the ioctl field's behavior, and I rewrote a lot
of the documentation around it. So, it may conflict with this patch.
:/ Sorry about that.

> >
> >>
> >> Fixes: f559fa36a678 ("ioctl_userfaultfd.2: Add write-protect mode docs")
> >> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>
> Patch applied.
>
> >
> > The patch looks correct to me, thanks for fixing it.
> >
> > Acked-by: Peter Xu <peterx@redhat.com>
>
> And tag appended.
>
> Thank you both!
>
> Alex
>
> >
> >> ---
> >>   man2/ioctl_userfaultfd.2 | 27 ++++++++++++++++++++-------
> >>   1 file changed, 20 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> >> index 504f61d4b..e930af520 100644
> >> --- a/man2/ioctl_userfaultfd.2
> >> +++ b/man2/ioctl_userfaultfd.2
> >> @@ -235,11 +235,6 @@ operation is supported.
> >>   The
> >>   .B UFFDIO_UNREGISTER
> >>   operation is supported.
> >> -.TP
> >> -.B 1 << _UFFDIO_WRITEPROTECT
> >> -The
> >> -.B UFFDIO_WRITEPROTECT
> >> -operation is supported.
> >>   .PP
> >>   This
> >>   .BR ioctl (2)
> >> @@ -333,8 +328,26 @@ If the operation is successful, the kernel modifies the
> >>   bit-mask field to indicate which
> >>   .BR ioctl (2)
> >>   operations are available for the specified range.
> >> -This returned bit mask is as for
> >> -.BR UFFDIO_API .
> >> +This returned bit mask can contain the following bits:
> >> +.TP
> >> +.B 1 << _UFFDIO_COPY
> >> +The
> >> +.B UFFDIO_COPY
> >> +operation is supported.
> >> +.TP
> >> +.B 1 << _UFFDIO_WAKE
> >> +The
> >> +.B UFFDIO_WAKE
> >> +operation is supported.
> >> +.TP
> >> +.B 1 << _UFFDIO_WRITEPROTECT
> >> +The
> >> +.B UFFDIO_WRITEPROTECT
> >> +.TP
> >> +.B 1 << _UFFDIO_ZEROPAGE
> >> +The
> >> +.B UFFDIO_ZEROPAGE
> >> +operation is supported.
> >>   .PP
> >>   This
> >>   .BR ioctl (2)
> >> --
> >
>
> --
> Alejandro Colomar
> Linux man-pages comaintainer; http://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/
