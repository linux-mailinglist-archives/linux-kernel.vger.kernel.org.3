Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8AC50710F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353275AbiDSOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiDSOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:55:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5553B3A702;
        Tue, 19 Apr 2022 07:52:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v15so21556179edb.12;
        Tue, 19 Apr 2022 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9miRFKI8HpeTjKhQV0kwqkHza82kni0Fcqrauzfvhk=;
        b=Rs4rRVvxkvSiuqorFqHiCO8vwuTdsgmzICb+KvvmUR+ewKfUGicOVVVkrjfZK22Emv
         /rJci9Y+WqbtWOEl3yw6qchXcmhnzmhPXjQtcMy8HFmwxPGbh46Uy/0GK1HcKlVIaFr1
         +DdpohyjN8GAlXfeRTC81Bxyr0mlMunp27Iaa0LcfiSDta/9nXKKSPqhW8oDDtiB1lyc
         IPPhqP+n6xxrTuxLtGZ6K7tgyKRa0oLyOjTYmIpR95hHg6yYCamXdsz0BZMMVQtX6eYO
         26VBUb6J2OBdhrtCfXjBQHf3kxfwWIwPjzI2Dlk/2QYhn1v/zTnAnKxBNKgeDtmq+1Nz
         nupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9miRFKI8HpeTjKhQV0kwqkHza82kni0Fcqrauzfvhk=;
        b=0HQxSsBOnkTseiDnT6Y4o3XfulPs8Rauf278NKq6Ulh8KaF7/8jk/IGJUqL1IAS/Wl
         amicr76OpANFpCWw0fTfV/JSvzqYMGvfCNou6lGAcDhW2IUG1Oa08It+W+wZENRODVML
         Fi1wN28piAUPmC5zDY0HgUroCetmBdkUPKNIgSzTHcvgGO/S/3LCM+lNsDI3T2KGF2gh
         kn7YykZ/ysnVZ/3lWR3mslC8m5G97a7UnYUuN7gXz3q96gNo/IaCOYpNqlxZFOcPu/lA
         MARiO+N5UScVLckP1TYeIo2FKyGlJrDWwk5ZVDgSeX5ZBZ/HzvLWfUzjBT7BbomZHtNB
         kwOA==
X-Gm-Message-State: AOAM53288PZmE9OIp69K2MOGTVUp4DWD60RLJ01ogwCJOq507DuEPTN2
        At3ptW7X4Y74oN7nu0qdCiM=
X-Google-Smtp-Source: ABdhPJyS/UDMttqqume7Dd/JLEuzFC6ME8Ri3VQHnvYbHwfgws3WjAqDda4Et8ZgZ3gy7ARuBlxPYQ==
X-Received: by 2002:aa7:dcd3:0:b0:41d:70e4:bf4d with SMTP id w19-20020aa7dcd3000000b0041d70e4bf4dmr17791087edu.223.1650379933681;
        Tue, 19 Apr 2022 07:52:13 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id i21-20020aa7c9d5000000b0042402440fc3sm853261edt.26.2022.04.19.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:52:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Documentation/vm: Extend "Temporary Virtual Mappings" section
Date:   Tue, 19 Apr 2022 16:52:11 +0200
Message-ID: <2455960.4XsnlVU6TS@leap>
In-Reply-To: <Yl3YZN1ex7smhYHS@iweiny-desk3>
References: <20220415231917.25962-1-fmdefrancesco@gmail.com> <20220415231917.25962-2-fmdefrancesco@gmail.com> <Yl3YZN1ex7smhYHS@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 18 aprile 2022 23:30:12 CEST Ira Weiny wrote:
> On Sat, Apr 16, 2022 at 01:19:16AM +0200, Fabio M. De Francesco wrote:
> > Extend and rework the "Temporary Virtual Mappings" section of the=20
highmem.rst
> > documentation.
> >=20
> > Do a partial rework of the paragraph related to kmap() and add a new=20
paragraph
> > in order to document the set of kmap_local_*() functions. Re-order=20
paragraphs
> > in decreasing order of preference of usage.
> >=20
> > Despite the local kmaps were introduced by Thomas Gleixner in October=20
2020,
> > documentation was still missing information about them. These additions=
=20
rely
> > largely on Gleixner's patches, Jonathan Corbet's LWN articles, comments=
=20
by
> > Ira Weiny and Matthew Wilcox, and in-code comments from
> > ./include/linux/highmem.h.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  Documentation/vm/highmem.rst | 67 ++++++++++++++++++++++++++++++------
> >  1 file changed, 56 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/
highmem.rst
> > index 0f69a9fec34d..12dcfbee094d 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -52,24 +52,69 @@ Temporary Virtual Mappings
> > =20
> >  The kernel contains several ways of creating temporary mappings:
> > =20
> > -* vmap().  This can be used to make a long duration mapping of=20
multiple
> > -  physical pages into a contiguous virtual space.  It needs global
> > -  synchronization to unmap.
> > -
> > -* kmap().  This permits a short duration mapping of a single page.  It=
=20
needs
> > -  global synchronization, but is amortized somewhat.  It is also prone=
=20
to
> > -  deadlocks when using in a nested fashion, and so it is not=20
recommended for
> > -  new code.
> > +* kmap_local_*().  These provide a set of functions that are used to=20
require
> > +  short term mappings. They can be invoked from any context (including
> > +  interrupts) but the mappings can only be used in the context which=20
acquired
> > +  it.
> > +
> > +  These mappings are per thread, CPU local (i.e., migration from one=20
CPU to
> > +  another is disabled - this is why they are called "local"), but they=
=20
don't
> > +  disable preemption. It's valid to take pagefaults in a local kmap=20
region,
> > +  unless the context in which the local mapping is acquired does not=20
allow
> > +  it for other reasons.
> > +
> > +  If a task holding local kmaps is preempted, the maps are removed on=
=20
context
> > +  switch and restored when the task comes back on the CPU. As the maps=
=20
are
> > +  strictly CPU local, it is guaranteed that the task stays on the CPU=
=20
and
> > +  that the CPU cannot be unplugged until the local kmaps are released.
> > +
> > +  Nesting kmap_local.*() and kmap_atomic.*() mappings is allowed to a=
=20
certain
>=20
> NIT: Throughout this doc why say 'kmap_local.*'?  There is only one call=
=20
named
> kmap_local_page().

Let me explain why throughout this text I used "kmap_local.*()"... As I=20
wrote, I relied largely also on Thomas Gleixner's series. He used that way=
=20
of referring to local kmaps.

I think that this was probably due to his introduction of several local=20
kmaps related functions: kmap_local_page(), kmap_local_page_prot(),=20
kmap_local_pfn().=20

However, I understand your "NIT" and I'll use a plain kmap_local_page() in=
=20
the next version of this patch /series. After all, this paragraph is only=20
talking about kmap_local_page().

>=20
> > +  extent (up to KMAP_TYPE_NR). Nested kmap_local.*() and=20
kunmap_local.*()
> > +  invocations have to be strictly ordered because the map=20
implementation is
> > +  stack based.
>=20
> This type of documentation should (and I believe is, in the kdoc of
> kmap_local_page().  Why not just add this text (or enhance what is there)=
=20
and
> include that here?
>=20
> Ah I see that patch 2/2 does add the kdocs for the functions... ah ok =20
:-/
>=20
> Perhaps this section should focus on why to use each of the kmap calls=20
and not
> how?  Leave the how to the kdoc?  Although all this information would be=
=20
nice
> inside the header for programmers who are looking at using these=20
functions.

As I wrote in another email I sent yesterday, I agree with you.

In the next version, highmem.rst file will only have a little introduction=
=20
about why we need to differentiate High Memory (Highmem) and the=20
permanently mapped Low Memory (Normal), a brief description of the set=20
functions we have to map Highmem, why we have them and which of them=20
developers should avoid to use in new code.

Most of the information, especially how to use them, will be moved to=20
highmem.h and highmem-internal.h.

Of course highmem.rst will automatically include this information as the=20
kdoc directives are processed.

> Here is an example of how I dealt with this on a recent auxiliary bus
> documentation update:
>=20
> https://lore.kernel.org/lkml/20211202044305.4006853-8-ira.weiny@intel.com/

Thanks for this link. I have already skimmed through it. I think I=20
understand the overall design. I'll rework this series taking into account=
=20
what I read in your patch.

>=20
> > =20
> >  * kmap_atomic().  This permits a very short duration mapping of a=20
single
> >    page.  Since the mapping is restricted to the CPU that issued it, it
> >    performs well, but the issuing task is therefore required to stay on=
=20
that
> >    CPU until it has finished, lest some other task displace its=20
mappings.
> > =20
> > -  kmap_atomic() may also be used by interrupt contexts, since it is=20
does not
> > -  sleep and the caller may not sleep until after kunmap_atomic() is=20
called.
> > +  kmap_atomic() may also be used by interrupt contexts, since it does=
=20
not
> > +  sleep and the caller too can not sleep until after kunmap_atomic()=20
is called.
> > +  Each call of kmap_atomic() in the kernel creates a non-preemptible=20
section and
> > +  disable pagefaults.
> > +
> > +  This could be a source of unwanted latency, so it should be only=20
used if it is
> > +  absolutely required, otherwise the corresponding kmap_local_*()=20
variant should
> > +  be used if it is feasible.
> > +
> > +  On 64-bit systems, calls to kmap() and kmap_atomic() have no real=20
work to do
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^
> What about kmap_local_page()?

Yes, correct. I overlooked it.

> > +  because a 64-bit address space is more than sufficient to address=20
all the
> > +  physical memory, so all of physical memory appears in the direct=20
mapping.
> > +
> > +  It is assumed that k[un]map_atomic() won't fail.
> > =20
> > -  It may be assumed that k[un]map_atomic() won't fail.
> > +* kmap().  This should be used to make short duration mapping of a=20
single
> > +  page with no restrictions on preemption or migration. It comes with=
=20
an
> > +  overhead as mapping space is restricted and protected by a global=20
lock
> > +  for synchronization. When mapping is no more needed, the address=20
that
> > +  the page was mapped to must be released with kunmap().
> > +
> > +  Mapping changes must be propagated across all the CPUs. kmap() also
> > +  requires global TLB invalidation when the kmap's pool wraps and it=20
might
> > +  block when the mapping space is fully utilized until a slot becomes
> > +  available. Therefore, kmap() is only callable from preemptible=20
context.
> > +
> > +  All the above work is necessary if a mapping must last for a=20
relatively
> > +  long time but the bulk of high-memory mappings in the kernel are
> > +  short-lived and only used in one place. This means that the cost of
> > +  kmap() is mostly wasted in such cases. kmap() was not intended for=20
long
> > +  term mappings but it has morphed in that direction and its use is
> > +  strongly discouraged in newer code and the set of the preceding=20
functions
> > +  should be preferred.
>=20
> I like this paragraph especially the last sentence!  Nicely put!

Thanks!

> But this is another reason I think this text in the code next to the kmap
> calls.  Then it is more readily available to programmers who are looking=
=20
at the
> functions.

As I wrote above, I will be reworking this series with your suggestions in=
=20
mind, but probably (due to other commitments) I will not be able to submit=
=20
the next version before the weekend.

> Thanks for the great work so far!
> Ira

Thanks to you for this review and all the suggestions you have provided me,

=46abio


=46abio


