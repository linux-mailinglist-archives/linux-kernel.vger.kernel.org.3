Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17815A879A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiHaUii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiHaUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:38:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686EE3956
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:38:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p185so15535288pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CCmnkqfGKHR/ON3gNrTQzrwetbHYAD+7v2zifG9dM50=;
        b=RtSaqcWk+ltgPsCb9uVdNp/i5srYHnIIr55HaWe1QYcKqCb3ZUenJNi7OfXzgb6ZrS
         uBDdvE17sYzjYv3HvRzsTkMTKC03jsXNCMituxFfC9yGWsu+rX69VdkLNn8AH0vLG/QG
         hI7Hfl6Sd4nHoNbJ7B80GuIVIuMgZL08NAlqGL0nzIuu27ru0eK9W07Yk4ZqSj8yxuJQ
         ODaRi7yop03Ww3p5f4fo2j4hNWUNPLy3xQwrO37jJNleyCgjRXU0Ny4IA0mIPi0upB4/
         GgZ1cydKufj+1ZzggMUC4Gp2jCUqRVr583/uYeOgmm8KU2qygiGuKWWFbb76c+66LjSz
         Notg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CCmnkqfGKHR/ON3gNrTQzrwetbHYAD+7v2zifG9dM50=;
        b=qD3nZDJ+fbavQzfEwBsh4fOrgdVq6plEWH7V3u3KS/fYzVmGp/bmVoYhe8QPF/zNN3
         TiR78bOkfCKJQFHAZ9TLqOLVwFFLfqdS363xHDmU+d5rIVDwTvklsv7gYYGQO3lhhIEp
         YCj/PYX2/ozIYrS/1UfJtyyjLZmMQYRzXFOPRlWPlcleSqkqsaD685HuQI7OahhxlK5n
         TPrMzJw5EB0iPBK257M1OjAl2n39SzWvu6BXjKiRvYghnI4urUbxHSBPeGdRTj6U8IKb
         wwrZuxRphG8DSCFjDNzc3bAb9i2KAKB1j/GBiAEBVXWaQFSQakf8lVTx7PAvZXt1JgVl
         +jug==
X-Gm-Message-State: ACgBeo3AC4hoGhwhu1jJw9D9hjlVGavJD6le8xJPzxqE3/nTD3fTNlZi
        xafxEeIVOhNSgehVR2esM+pN3yK4VeUBs1uhigY=
X-Google-Smtp-Source: AA6agR4vskFQkjaeTlcg+3ZueXBytfEkdhsxLidFnFNziE3Do3YDUjjJyob7Mf70s+T4y6fKLNbA+i0ljEyj1T3MlmI=
X-Received: by 2002:a65:6a05:0:b0:42c:87a0:ea77 with SMTP id
 m5-20020a656a05000000b0042c87a0ea77mr9238994pgu.75.1661978314393; Wed, 31 Aug
 2022 13:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220831083024.37138-1-david@redhat.com> <CAHbLzkqeDAnCdt3q4E2RZw64QEzVaO_pseR3VaoHUhB+rZFcZQ@mail.gmail.com>
 <Yw+uASvgWU5+9PvI@xz-m1.local>
In-Reply-To: <Yw+uASvgWU5+9PvI@xz-m1.local>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Aug 2022 13:38:21 -0700
Message-ID: <CAHbLzkpH=a-gbwZYfJx6qD_Rvz6AEP+xwCKDbwJRPNt9W3Anxg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/ksm: update stale comment in write_protect_page()
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:52 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 31, 2022 at 10:55:43AM -0700, Yang Shi wrote:
> > On Wed, Aug 31, 2022 at 1:30 AM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > The comment is stale, because a TLB flush is no longer sufficient and
> > > required to synchronize against concurrent GUP-fast. This used to be true
> > > in the past, whereby a TLB flush would have implied an IPI on architectures
> > > that support GUP-fast, resulting in GUP-fast that disables local interrupts
> > > from completing before completing the flush.
> >
> > Hmm... it seems there might be problem for THP collapse IIUC. THP
> > collapse clears and flushes pmd before doing anything on pte and
> > relies on interrupt disable of fast GUP to serialize against fast GUP.
> > But if TLB flush is no longer sufficient, then we may run into the
> > below race IIUC:
> >
> >          CPU A                                                CPU B
> > THP collapse                                             fast GUP
> >
> > gup_pmd_range() <-- see valid pmd
> >
> > gup_pte_range() <-- work on pte
> > clear pmd and flush TLB
> > __collapse_huge_page_isolate()
> >     isolate page <-- before GUP bump refcount
> >
> >    pin the page
> > __collapse_huge_page_copy()
> >     copy data to huge page
> >     clear pte (don't flush TLB)
> > Install huge pmd for huge page
> >
> > return the obsolete page
>
> Maybe the pmd level tlb flush is still needed, but on pte level it's
> optional (where we can rely on fast-gup rechecking on the pte change)?

Do you mean in khugepaged? It does TLB flush, but some arches may not use IPI.

>
> --
> Peter Xu
>
