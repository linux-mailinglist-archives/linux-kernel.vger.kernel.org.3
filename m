Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2A4D2063
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349422AbiCHSsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349234AbiCHSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:48:10 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C11532C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:47:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v4so165653pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hIwF+lY7kJ6NozwbsWb4SYYIfoetXpADXYLDjjCjbPE=;
        b=c+NTwWe0/Bve3kozv2LkBOVhg5smOKJsM/0B+sR8BSSccAhPUYrJ0UuT2BhohkWTGW
         H9l9wqTrNHmdMyGBlVwepmNNpgDPQFk7Ow51W/MVlp+5iKODBbHYYySsWvDT/49Pke3Z
         8dzRgxLsC3BAMNsD76Z9V3VTnowZY4vDQiOvGFHfT7EqSsUvcc/4UxkM2Kz4UsLHuFJq
         oWPwyK6kxzKcU/NzCRIu0nNo9903/qzUX7XLOGvvNlgBPAK4t8FPQNGDnsxLqXz05o7G
         A4MtKKais65XXgMn9wFUXedsvOxtR7FOvHSQ/SjM1qkyY3hKKhie04EvaQcubyPE2huK
         P5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hIwF+lY7kJ6NozwbsWb4SYYIfoetXpADXYLDjjCjbPE=;
        b=yh+XB/+6tNuMaRCiktxcBrlyWYGlitqyCm1DVsIw4oNMYU2l+SKvYe6UsfALykHpTI
         pcfO8IgLC3b1+qCrkEmbwYH1rXK/fBkdQtx6tX1R7km2/tHS3iSSjvWHbywzIWnfIHHL
         B9dX11EiEomqB7Ig4dwc4bzxt5Rjsdli/z8JRT0It8esaMDqzD3UtLqKB7uOW/kU87b6
         hPc+jKzDRv8GaDZ07JuqyBQ/DpZq9tEhTZAHXlJtXdNqCxYxIst7sDxmr+4hCLRNvz7/
         CO0UvL4WFlUtVUdoWULnDt40xFLyM/7TF+AxbwKuTjSm+SVRd+K5rYJLFDl0qVRHgp1q
         R7MQ==
X-Gm-Message-State: AOAM532uIUn5N4QsI2N+lrqhlyLqyZA9fv5R1N2n8PMyDsn5ih8sk3Dy
        J2pSVDaNryvTW/t5Yt1K0GjDXfH368Yq1Nxgp8o=
X-Google-Smtp-Source: ABdhPJwUZR3T/oMvuu+qhS2wtkVOLIIF4/w+G6AmTHToqd9bPVWsSt1ROnsrPyycUgg72kWCZ9TvJOt2ZcBM8fo+sL8=
X-Received: by 2002:a17:90a:3906:b0:1bf:a0a6:d208 with SMTP id
 y6-20020a17090a390600b001bfa0a6d208mr1712251pjb.21.1646765232502; Tue, 08 Mar
 2022 10:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20220228140245.24552-1-linmiaohe@huawei.com> <20220228140245.24552-5-linmiaohe@huawei.com>
 <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp> <2311bee4-cc11-93fc-6992-6c327a150e3d@huawei.com>
 <CAHbLzkrOfcJvv8Vy8jcKWc7QX=1Y9e=EW9+p78sp1xhac645-w@mail.gmail.com> <e7f1977e-2f6a-cffa-a75f-9665a908ca21@huawei.com>
In-Reply-To: <e7f1977e-2f6a-cffa-a75f-9665a908ca21@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Mar 2022 10:47:00 -0800
Message-ID: <CAHbLzkpOZTkvBECpKrOtSjV1ZVoDHnr0z33tFDka=_CZYq5JAQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/memory-failure.c: fix potential VM_BUG_ON_PAGE in split_huge_page_to_list
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 4:36 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/8 3:53, Yang Shi wrote:
> > On Sun, Mar 6, 2022 at 11:07 PM Miaohe Lin <linmiaohe@huawei.com> wrote=
:
> >>
> >> On 2022/3/4 16:28, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=B9=
=9F) wrote:
> >>> On Mon, Feb 28, 2022 at 10:02:45PM +0800, Miaohe Lin wrote:
> >>>> The huge zero page could reach here and if we ever try to split it, =
the
> >>>> VM_BUG_ON_PAGE will be triggered in split_huge_page_to_list(). Also =
the
> >>>> non-lru compound movable pages could be taken for transhuge pages. S=
kip
> >>>> these pages by checking PageLRU because huge zero page isn't lru pag=
e as
> >>>> non-lru compound movable pages.
> >>>
> >>> It seems that memory_failure() also fails at get_any_page() with "hwp=
oison:
> >>> unhandlable page" message.
> >>>
> >>>   [16478.203474] page:00000000b6acdbd1 refcount:1 mapcount:0 mapping:=
0000000000000000 index:0x0 pfn:0x1810b4
> >>>   [16478.206612] flags: 0x57ffffc0801000(reserved|hwpoison|node=3D1|z=
one=3D2|lastcpupid=3D0x1fffff)
> >>>   [16478.209411] raw: 0057ffffc0801000 fffff11bc6042d08 fffff11bc6042=
d08 0000000000000000
> >>>   [16478.211921] raw: 0000000000000000 0000000000000000 00000001fffff=
fff 0000000000000000
> >>>   [16478.214473] page dumped because: hwpoison: unhandlable page
> >>>   [16478.216386] Memory failure: 0x1810b4: recovery action for unknow=
n page: Ignored
> >>>
> >>> We can't handle errors on huge (or normal) zero page, so the current
> >>
> >> Sorry for confusing commit log again. I should have a coffee before I =
make this patch.
> >> Huge or normal zero page will fail at get_any_page because they're nei=
ther HWPoisonHandlable
> >> nor PageHuge.
> >>
> >>> behavior seems to me more suitable than "unsplit thp".
> >>>
> >>> Or if you have some producer to reach the following path with huge ze=
ro
> >>> page, could you share it?
> >>>
> >>
> >> What I mean is that non-lru movable compound page can reach here unexp=
ected because __PageMovable(page)
> >> is handleable now. So get_any_page could succeed to grab the page refc=
nt. And since it's compound page,
> >> it will go through the split_huge_page_to_list because PageTransHuge c=
hecks PageHead(page) which can also
> >> be true for compound page. But this type of pages is unexpected for sp=
lit_huge_page_to_list.
> >
> > Can we really handle non-LRU movable pages in memory failure
> > (uncorrectable errors)? Typically they are balloon, zsmalloc, etc.
> > Assuming we run into a base (4K) non-LRU movable page, we could reach
> > as far as identify_page_state(), it should not fall into any category
> > except me_unknown. So it seems we could just simply make it
> > unhandlable.
>
> There is the comment from memory_failure:
>         /*
>          * We ignore non-LRU pages for good reasons.
>          * - PG_locked is only well defined for LRU pages and a few other=
s
>          * - to avoid races with __SetPageLocked()
>          * - to avoid races with __SetPageSlab*() (and more non-atomic op=
s)
>          * The check (unnecessarily) ignores LRU pages being isolated and
>          * walked by the page reclaim code, however that's not a big loss=
.
>          */
>
> So we could not handle non-LRU movable pages.
>
> What do you mean is something like below?
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5444a8ef4867..d80dbe0f20b6 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1784,6 +1784,13 @@ int memory_failure(unsigned long pfn, int flags)
>                 }
>         }
>
> +       if (__PageMovable(hpage)) {
> +               put_page(p);
> +               action_result(pfn, MF_MSG_MOVALBE_PAGE, MF_IGNORED);
> +               res =3D -EBUSY;
> +               goto unlock_mutex;
> +       }
> +
>         if (PageTransHuge(hpage)) {
>                 /*
>                  * The flag must be set after the refcount is bumped
>
>
> i.e. Simply make non-LRU movable pages unhandlable ?

I'd prefer this personally. Something like the below (compile test only):

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5444a8ef4867..789e40909ade 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1176,12 +1176,18 @@ void ClearPageHWPoisonTakenOff(struct page *page)
  * does not return true for hugetlb or device memory pages, so it's assume=
d
  * to be called only in the context where we never have such pages.
  */
-static inline bool HWPoisonHandlable(struct page *page)
+static inline bool HWPoisonHandlable(struct page *page, unsigned long flag=
s)
 {
- return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
+ bool movable =3D false;
+
+ /* Soft offline could mirgate non-LRU movable pages */
+ if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
+ movable =3D true;
+
+ return movable || PageLRU(page) || is_free_buddy_page(page);
 }

-static int __get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
  struct page *head =3D compound_head(page);
  int ret =3D 0;
@@ -1196,7 +1202,7 @@ static int __get_hwpoison_page(struct page *page)
  * for any unsupported type of page in order to reduce the risk of
  * unexpected races caused by taking a page refcount.
  */
- if (!HWPoisonHandlable(head))
+ if (!HWPoisonHandlable(head, flags))
  return -EBUSY;

  if (get_page_unless_zero(head)) {
@@ -1221,7 +1227,7 @@ static int get_any_page(struct page *p, unsigned
long flags)

 try_again:
  if (!count_increased) {
- ret =3D __get_hwpoison_page(p);
+ ret =3D __get_hwpoison_page(p, flags);
  if (!ret) {
  if (page_count(p)) {
  /* We raced with an allocation, retry. */
@@ -1249,7 +1255,7 @@ static int get_any_page(struct page *p, unsigned
long flags)
  }
  }

- if (PageHuge(p) || HWPoisonHandlable(p)) {
+ if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
  ret =3D 1;
  } else {
  /*

>
> >
> > But it should be handlable for soft-offline since it could be migrated.
> >
>
> Yes, non-LRU movable pages can be simply migrated.
>
> Many thanks.
>
> >
> >> Does this make sense for you? Thanks Naoya.
> >>
> >>> Thanks,
> >>> Naoya Horiguchi
> >>>
> >>>>
> >>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>> ---
> >>>>  mm/memory-failure.c | 14 ++++++++++++++
> >>>>  1 file changed, 14 insertions(+)
> >>>>
> >>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>> index 23bfd809dc8c..ac6492e36978 100644
> >>>> --- a/mm/memory-failure.c
> >>>> +++ b/mm/memory-failure.c
> >>>> @@ -1792,6 +1792,20 @@ int memory_failure(unsigned long pfn, int fla=
gs)
> >>>>      }
> >>>>
> >>>>      if (PageTransHuge(hpage)) {
> >>>> +            /*
> >>>> +             * The non-lru compound movable pages could be taken fo=
r
> >>>> +             * transhuge pages. Also huge zero page could reach her=
e
> >>>> +             * and if we ever try to split it, the VM_BUG_ON_PAGE w=
ill
> >>>> +             * be triggered in split_huge_page_to_list(). Skip thes=
e
> >>>> +             * pages by checking PageLRU because huge zero page isn=
't
> >>>> +             * lru page as non-lru compound movable pages.
> >>>> +             */
> >>>> +            if (!PageLRU(hpage)) {
> >>>> +                    put_page(p);
> >>>> +                    action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNOR=
ED);
> >>>> +                    res =3D -EBUSY;
> >>>> +                    goto unlock_mutex;
> >>>> +            }
> >>>>              /*
> >>>>               * The flag must be set after the refcount is bumped
> >>>>               * otherwise it may race with THP split.
> >>>> --
> >>>> 2.23.0
> >>
> >>
> > .
> >
>
