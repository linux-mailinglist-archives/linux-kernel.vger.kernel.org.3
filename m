Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94053F223
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiFFW1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFFW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:26:54 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53948AEE3C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:26:52 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id v7so12965356ilo.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7+m4F9TCs6wwlDfh4xzlLWJ0fsAvrpfSsmLzEzUCyW8=;
        b=jEf7G6uOpfiU1hbpTHgk3NId4v+ja1qTHA3pAf/MXR83PREEt8rWvFLIQRwA5OtTIZ
         zS+jXUiY2u8iqWFQ5ps7AUA+Bl6xmoJdUeM0VlFrDgo7gUtDS+Gn5FhBK4saFxCd44CB
         TGA3erXCt4a9he7FBmfseVnex+OBNfpRd0pj60/QAf4G95xZH3G7lHUFI8ghNbnoMRrf
         sMe058SFWLkMj5QOhvSfgCgIK66oAbzbOgrq2pGaTFIBZuHbBqEmohlroeJJEjKHasH/
         /9O2y1fA/PTP6r4XqmIXYm//OmNtD0RvjmneRFxKCFH68de1zKb6kIL7NKaDjciqHPMg
         fsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7+m4F9TCs6wwlDfh4xzlLWJ0fsAvrpfSsmLzEzUCyW8=;
        b=V1ilkFAj4WDeboFlQbCfeZn7sU5PqHxv/EPpJ9gPC1Yr2a2LBxBFNrPfhyaI5cMH1d
         UcgWlYvrSduEa0O9dRYUgCsH/3lD5OeHoBpioKHuL28Fdl5zdVpUabUrRjqZ6x5bkg+3
         z+cGyvnYXMw756b9UWnTlpjHqsTWMYG/bZIckthrRShGCgJodFTZh6b0G3ANYgB17bb7
         JOkc6d1SbgqOF8gGkqkjsEMOTarH5UPmS6xPyDc3/Vrhjw5H+35mWCt8WMs3gjwd8HyE
         j4dHZRS77NVXmLEjKwKo7wjR+GYodfXIbWfaLB1TE1naLVcyS3pflExVUGWJH+UQCVL7
         +JlQ==
X-Gm-Message-State: AOAM533maUME5XSfdwo3N+ThjAzF6PTnXJouLt0Z/xvSys0MSQzc0bn4
        WwP4rUSkdgUQ5Ukg9oFj/aLwei9HI3eay3kEYj0XLw==
X-Google-Smtp-Source: ABdhPJwif0tuHBY2ezEHoAV0rxYUPjDDfNMbghivKRqtgjPmjCFL01jKMjDITTXWLkxOdO+s46uPnG0kQQAd2yN0ZNQ=
X-Received: by 2002:a05:6e02:1d8b:b0:2d3:9914:16f with SMTP id
 h11-20020a056e021d8b00b002d39914016fmr15056338ila.239.1654554411219; Mon, 06
 Jun 2022 15:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220603173736.62581-1-peterx@redhat.com> <7acfdeb8-5dd3-dfe2-5717-b64006281a8f@gmail.com>
 <Yp5YGMFJWLtthc8U@xz-m1.local>
In-Reply-To: <Yp5YGMFJWLtthc8U@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 6 Jun 2022 15:26:15 -0700
Message-ID: <CAJHvVciDcUvKDx=FwhG58spOrERH3x14zEHV43PQtMTrR9V20w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] userfaultfd.2: Update to latest
To:     Peter Xu <peterx@redhat.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-man@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Jun 6, 2022 at 12:40 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jun 06, 2022 at 08:52:25PM +0200, Alejandro Colomar wrote:
> > Hi Peter,
>
> Hi, Alex,
>
> >
> > On 6/3/22 19:37, Peter Xu wrote:
> > > v2:
> > > - Use semantic newlines always in patch 1 [Alex]
> > > - Fix s/.BR/.B/ in patch 2 [Alex]
> > > - Rebased to http://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git
> > >
> > > Add the two missing pieces till latest 5.19-rc1: the UFFD_USER_MODE_ONLY
> > > flag, and also the recent wr-protect support on shmem and hugetlbfs.
> > >
> > > Please review, thanks.
> > >
> > > Peter Xu (2):
> > >    userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
> > >    userfaultfd.2: Update on write-protection support
> > >
> > >   man2/userfaultfd.2 | 23 ++++++++++++++++++-----
> > >   1 file changed, 18 insertions(+), 5 deletions(-)
> > >
> >
> >
> > I think the patch below would improve a little bit the wording (and
> > newlines).  I still have a bit of trouble understanding "When a
> > kernel-originated fault was triggered on the registered range with this
> > userfaultfd".  Did you maybe mean "range registered" instead of "registered
> > range"?
>
> Since I'm not a native speaker I don't immediately see the difference
> between the two..  What I wanted to express is all the memory ranges that
> we registered with UFFDIO_REGISTER ioctl, and further it was trying to
> describe what the kernel will do when there're any page faults that were
> triggered upon those ranges from a kernel context.
>
> It's always challenging for me to grasp how you prefer the newlines are
> made, but anyway below changes looks good to me.  Thanks,

I think "range registered" Alejandro suggested is a bit more natural,
just because that's the way you'd say it if we were slightly more
verbose:

"When a kernel-originated fault was triggered on the range [that was
previously] registered with this userfaultfd, ..."

Of course leaving out "that was previously" is fine, but I think the
ordering "range registered" remains more natural.

Another alternative I find equally natural which keeps the existing
ordering might be something like:

"... on the userfaultfd-registered range ..."

>
> >
> > Thanks,
> >
> > Alex
> >
> >
> > diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> > index 9b5ec0358..0c0a4f687 100644
> > --- a/man2/userfaultfd.2
> > +++ b/man2/userfaultfd.2
> > @@ -62,11 +62,11 @@ flag in
> >  .BR open (2).
> >  .TP
> >  .B UFFD_USER_MODE_ONLY
> > -This is an userfaultfd specific flag that was introduced since Linux 5.11.
> > -When set, the userfaultfd object will only be able to handle page faults
> > -originated from the userspace on the registered regions.
> > -When a kernel originated fault was triggered on the registered range with
> > -this userfaultfd, a
> > +This is an userfaultfd-specific flag that was introduced in Linux 5.11.
> > +When set, the userfaultfd object will only be able to handle
> > +page faults originated from the user space on the registered regions.
> > +When a kernel-originated fault was triggered
> > +on the registered range with this userfaultfd, a
> >  .B SIGBUS
> >  signal will be delivered.
> >  .PP
> > @@ -277,8 +277,9 @@ ioctl against the feature bit
> >  .B UFFD_FEATURE_PAGEFAULT_FLAG_WP
> >  before using this feature.
> >  .PP
> > -Since Linux 5.19, the write-protection mode was also supported on shmem and
> > hugetlbfs
> > -memory types.
> > +Since Linux 5.19,
> > +the write-protection mode was also supported on
> > +shmem and hugetlbfs memory types.
> >  It can be detected with the feature bit
> >  .BR UFFD_FEATURE_WP_HUGETLBFS_SHMEM .
> >  .PP
> >
> >
> > --
> > Alejandro Colomar
> > <http://www.alejandro-colomar.es/>
>
>
>
>
> --
> Peter Xu
>
