Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BA4D51EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343594AbiCJTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiCJTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:33:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AB13C9E8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:32:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso7203788pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sr3SX+mGHTgqjkBw1Uo/W0bQ5BGSr7vLQugK0O3LT2E=;
        b=Xcj1FwZrk4lcSoGUxFDc0q8x0zHopLJ9GfqF9bDR9iCF9ecyA8Bey+E11iybuB+l+2
         2ahfw9c+z9etE/a6rwI4LJgfiwLtRHdjCYc2jmIj0/UJKLH5/v9eChBT/juu5/XUR6u3
         uQKKwUy7ap/o0OnTWQhmTmEwHwTzVNDqw/frqrea41bws+WcohYBWF5UxrNc8SIHV4n2
         aNxB4f5mnxu7ZfG/btmGUHV4rKn3LBOyTfC8srd2WJ9Jq+ek68LirzA+uXlkXCd1qPGB
         5Eq/FoXlrokACZ8ffNFM796MiIaUGLKxYE3FPGjdibJUsYaHehTiTNkzjEPEw55uPuUe
         +M7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sr3SX+mGHTgqjkBw1Uo/W0bQ5BGSr7vLQugK0O3LT2E=;
        b=lj4G7QZC206jM3X3ZtlsJ1yw0/tsKjza+zTVK/3AZHNS1HjeQNprtIWprbYpD4WdMt
         BXggGbZXjQKS20UqaT0Igdc8uF8ubH+lXIeh9NEkrpLlGl3GqZNFCxzjXt3ir5uQgLqR
         gP+7OAa601Z5Noz9Q3unsb+p+ugrNb07x0xRZtaMEDcVQPeRdb8K4OgtU2ocuThte3/g
         GczEHyUSuJDe+3AjeU3mQnZ9eDJKCKs9B3/GdBLCPpkFXYr0OpoB8pnOA9uIQiYR6yRH
         UPpNgSx2AosZ7WC9W7yxVHUV+RfU24En0TKVxZma3YFTeTqyoTeKsjR17JxskPVOCtZf
         nZew==
X-Gm-Message-State: AOAM531LZYlS3fXR15YoU3RpKz7rf6KNIF/HJ+gyZs7rAjSA2RLxzDWs
        CufVoCno9WW9g0p9ghIrDRWR/Y6CLWjj+rID9ps+JKpG7lk=
X-Google-Smtp-Source: ABdhPJxbG7VpTq0KFgDmrq4D1beszby6aE9wHDYQ1dh/4YKRcIJj1WB8jCEMa18vh3/OqWtLH0GlnM1XpCw3dBULecc=
X-Received: by 2002:a17:90a:3906:b0:1bf:a0a6:d208 with SMTP id
 y6-20020a17090a390600b001bfa0a6d208mr13163189pjb.21.1646940740594; Thu, 10
 Mar 2022 11:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20220228140245.24552-1-linmiaohe@huawei.com> <20220228140245.24552-5-linmiaohe@huawei.com>
 <20220304082804.GC3778609@hori.linux.bs1.fc.nec.co.jp> <2311bee4-cc11-93fc-6992-6c327a150e3d@huawei.com>
 <CAHbLzkrOfcJvv8Vy8jcKWc7QX=1Y9e=EW9+p78sp1xhac645-w@mail.gmail.com>
 <e7f1977e-2f6a-cffa-a75f-9665a908ca21@huawei.com> <CAHbLzkpOZTkvBECpKrOtSjV1ZVoDHnr0z33tFDka=_CZYq5JAQ@mail.gmail.com>
 <dc5fa8b3-4fa8-0e12-e4d2-f9b24fd2bf87@huawei.com>
In-Reply-To: <dc5fa8b3-4fa8-0e12-e4d2-f9b24fd2bf87@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 10 Mar 2022 11:32:08 -0800
Message-ID: <CAHbLzkpkkFEXhKZtSHYhY61WMKtQHeqY5x+FJhUG8H5_FDS4Cg@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 3:46 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/9 2:47, Yang Shi wrote:
> > On Tue, Mar 8, 2022 at 4:36 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> On 2022/3/8 3:53, Yang Shi wrote:
> >>> On Sun, Mar 6, 2022 at 11:07 PM Miaohe Lin <linmiaohe@huawei.com> wro=
te:
> >>>>
> >>>> On 2022/3/4 16:28, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=
=B9=9F) wrote:
> >>>>> On Mon, Feb 28, 2022 at 10:02:45PM +0800, Miaohe Lin wrote:
> >>>>>> The huge zero page could reach here and if we ever try to split it=
, the
> >>>>>> VM_BUG_ON_PAGE will be triggered in split_huge_page_to_list(). Als=
o the
> >>>>>> non-lru compound movable pages could be taken for transhuge pages.=
 Skip
> >>>>>> these pages by checking PageLRU because huge zero page isn't lru p=
age as
> >>>>>> non-lru compound movable pages.
> >>>>>
> >>>>> It seems that memory_failure() also fails at get_any_page() with "h=
wpoison:
> >>>>> unhandlable page" message.
> >>>>>
> >>>>>   [16478.203474] page:00000000b6acdbd1 refcount:1 mapcount:0 mappin=
g:0000000000000000 index:0x0 pfn:0x1810b4
> >>>>>   [16478.206612] flags: 0x57ffffc0801000(reserved|hwpoison|node=3D1=
|zone=3D2|lastcpupid=3D0x1fffff)
> >>>>>   [16478.209411] raw: 0057ffffc0801000 fffff11bc6042d08 fffff11bc60=
42d08 0000000000000000
> >>>>>   [16478.211921] raw: 0000000000000000 0000000000000000 00000001fff=
fffff 0000000000000000
> >>>>>   [16478.214473] page dumped because: hwpoison: unhandlable page
> >>>>>   [16478.216386] Memory failure: 0x1810b4: recovery action for unkn=
own page: Ignored
> >>>>>
> >>>>> We can't handle errors on huge (or normal) zero page, so the curren=
t
> >>>>
> >>>> Sorry for confusing commit log again. I should have a coffee before =
I make this patch.
> >>>> Huge or normal zero page will fail at get_any_page because they're n=
either HWPoisonHandlable
> >>>> nor PageHuge.
> >>>>
> >>>>> behavior seems to me more suitable than "unsplit thp".
> >>>>>
> >>>>> Or if you have some producer to reach the following path with huge =
zero
> >>>>> page, could you share it?
> >>>>>
> >>>>
> >>>> What I mean is that non-lru movable compound page can reach here une=
xpected because __PageMovable(page)
> >>>> is handleable now. So get_any_page could succeed to grab the page re=
fcnt. And since it's compound page,
> >>>> it will go through the split_huge_page_to_list because PageTransHuge=
 checks PageHead(page) which can also
> >>>> be true for compound page. But this type of pages is unexpected for =
split_huge_page_to_list.
> >>>
> >>> Can we really handle non-LRU movable pages in memory failure
> >>> (uncorrectable errors)? Typically they are balloon, zsmalloc, etc.
> >>> Assuming we run into a base (4K) non-LRU movable page, we could reach
> >>> as far as identify_page_state(), it should not fall into any category
> >>> except me_unknown. So it seems we could just simply make it
> >>> unhandlable.
> >>
> >> There is the comment from memory_failure:
> >>         /*
> >>          * We ignore non-LRU pages for good reasons.
> >>          * - PG_locked is only well defined for LRU pages and a few ot=
hers
> >>          * - to avoid races with __SetPageLocked()
> >>          * - to avoid races with __SetPageSlab*() (and more non-atomic=
 ops)
> >>          * The check (unnecessarily) ignores LRU pages being isolated =
and
> >>          * walked by the page reclaim code, however that's not a big l=
oss.
> >>          */
> >>
> >> So we could not handle non-LRU movable pages.
> >>
> >> What do you mean is something like below?
> >>
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 5444a8ef4867..d80dbe0f20b6 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1784,6 +1784,13 @@ int memory_failure(unsigned long pfn, int flags=
)
> >>                 }
> >>         }
> >>
> >> +       if (__PageMovable(hpage)) {
> >> +               put_page(p);
> >> +               action_result(pfn, MF_MSG_MOVALBE_PAGE, MF_IGNORED);
> >> +               res =3D -EBUSY;
> >> +               goto unlock_mutex;
> >> +       }
> >> +
> >>         if (PageTransHuge(hpage)) {
> >>                 /*
> >>                  * The flag must be set after the refcount is bumped
> >>
> >>
> >> i.e. Simply make non-LRU movable pages unhandlable ?
> >
>
> I think about the below code more carefully and I found that this will ma=
ke
> hwpoison_filter can't handle the non-LRU movable pages now. Because non-L=
RU
> movable pages return early now and thus can't reach the hwpoison_filter. =
This
> results in a inconsistent behavior with previous one. So I think the orig=
in
> fixup of this patch is more suitable. What do you think?

I'm not familiar with hwpoison_filter(), it seems like a test helper
for error injection. I don't think hwpoison_filter() is used to filter
unhandlable page, for example, slab page, IIUC. So the non-LRU movable
pages should be treated the same. If so, the old behavior was simply
wrong.

>
> Thanks.
>
> > I'd prefer this personally. Something like the below (compile test only=
):
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 5444a8ef4867..789e40909ade 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1176,12 +1176,18 @@ void ClearPageHWPoisonTakenOff(struct page *pag=
e)
> >   * does not return true for hugetlb or device memory pages, so it's as=
sumed
> >   * to be called only in the context where we never have such pages.
> >   */
> > -static inline bool HWPoisonHandlable(struct page *page)
> > +static inline bool HWPoisonHandlable(struct page *page, unsigned long =
flags)
> >  {
> > - return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(pag=
e);
> > + bool movable =3D false;
> > +
> > + /* Soft offline could mirgate non-LRU movable pages */
> > + if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> > + movable =3D true;
> > +
> > + return movable || PageLRU(page) || is_free_buddy_page(page);
> >  }
> >
> > -static int __get_hwpoison_page(struct page *page)
> > +static int __get_hwpoison_page(struct page *page, unsigned long flags)
> >  {
> >   struct page *head =3D compound_head(page);
> >   int ret =3D 0;
> > @@ -1196,7 +1202,7 @@ static int __get_hwpoison_page(struct page *page)
> >   * for any unsupported type of page in order to reduce the risk of
> >   * unexpected races caused by taking a page refcount.
> >   */
> > - if (!HWPoisonHandlable(head))
> > + if (!HWPoisonHandlable(head, flags))
> >   return -EBUSY;
> >
> >   if (get_page_unless_zero(head)) {
> > @@ -1221,7 +1227,7 @@ static int get_any_page(struct page *p, unsigned
> > long flags)
> >
> >  try_again:
> >   if (!count_increased) {
> > - ret =3D __get_hwpoison_page(p);
> > + ret =3D __get_hwpoison_page(p, flags);
> >   if (!ret) {
> >   if (page_count(p)) {
> >   /* We raced with an allocation, retry. */
> > @@ -1249,7 +1255,7 @@ static int get_any_page(struct page *p, unsigned
> > long flags)
> >   }
> >   }
> >
> > - if (PageHuge(p) || HWPoisonHandlable(p)) {
> > + if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
> >   ret =3D 1;
> >   } else {
> >   /*
> >
> >>
> >>>
> >>> But it should be handlable for soft-offline since it could be migrate=
d.
> >>>
> >>
> >> Yes, non-LRU movable pages can be simply migrated.
> >>
> >> Many thanks.
> >>
> >>>
> >>>> Does this make sense for you? Thanks Naoya.
> >>>>
> >>>>> Thanks,
> >>>>> Naoya Horiguchi
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>>>> ---
> >>>>>>  mm/memory-failure.c | 14 ++++++++++++++
> >>>>>>  1 file changed, 14 insertions(+)
> >>>>>>
> >>>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>>>> index 23bfd809dc8c..ac6492e36978 100644
> >>>>>> --- a/mm/memory-failure.c
> >>>>>> +++ b/mm/memory-failure.c
> >>>>>> @@ -1792,6 +1792,20 @@ int memory_failure(unsigned long pfn, int f=
lags)
> >>>>>>      }
> >>>>>>
> >>>>>>      if (PageTransHuge(hpage)) {
> >>>>>> +            /*
> >>>>>> +             * The non-lru compound movable pages could be taken =
for
> >>>>>> +             * transhuge pages. Also huge zero page could reach h=
ere
> >>>>>> +             * and if we ever try to split it, the VM_BUG_ON_PAGE=
 will
> >>>>>> +             * be triggered in split_huge_page_to_list(). Skip th=
ese
> >>>>>> +             * pages by checking PageLRU because huge zero page i=
sn't
> >>>>>> +             * lru page as non-lru compound movable pages.
> >>>>>> +             */
> >>>>>> +            if (!PageLRU(hpage)) {
> >>>>>> +                    put_page(p);
> >>>>>> +                    action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGN=
ORED);
> >>>>>> +                    res =3D -EBUSY;
> >>>>>> +                    goto unlock_mutex;
> >>>>>> +            }
> >>>>>>              /*
> >>>>>>               * The flag must be set after the refcount is bumped
> >>>>>>               * otherwise it may race with THP split.
> >>>>>> --
> >>>>>> 2.23.0
> >>>>
> >>>>
> >>> .
> >>>
> >>
> > .
> >
>
>
