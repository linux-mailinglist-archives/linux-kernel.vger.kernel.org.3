Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281354D20BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiCHSx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiCHSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:53:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AE653B4B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:51:55 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so134658pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u1p9VkaRsYgNkd67QLKnk5cpxdtjrQ6aNDZQpYpVvsc=;
        b=J6EVgz0NDd+InNzOsaYvbkrDycQ0vbgC6lYZ/WcONobGx5spk0HF3omZyHgOKcOCq5
         PvfvU0Q0M7Iopk/HampRKl7NG30b2av5v5L30gavJr+ywffnT808t1ha+0cC1/3BlFg+
         Szvg2sfY8OhLtAFT5s4nwh+8q8fvhb3iWU/yyuw0bkRyFXly+OgBWH+e24SFCk7lIc7I
         ROcjBUUUEwtumbnrSZVwcYf1a+hXbVwK7JklUrhrGygZaCzh4FV40l8hUcEEl0y0bAPY
         JmPRJPFlG4c5kwwgU4MeITcO3tYf8HUBIR0KnKvNcTvJMAEMpjsQBGMmEjO1uZ6URf+J
         mFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u1p9VkaRsYgNkd67QLKnk5cpxdtjrQ6aNDZQpYpVvsc=;
        b=rXdqvp+y3apGADhBXT5+HxFoPvxqFmQjjMhuDM/SVeTeO84+2au/ihFTpln8rRkJMS
         QghXERNa9nypqNPaXeB4VeYvzHOHEP+wCecfbfQFzWvWiGMFSGPoq3LBZHJceXJRMQhn
         UPLfF8rLqNFk2mLjUOiS97au6cMuXLeu234VhpmTUuxXNYQlz+HcJzKmeCD8B+7x+7So
         QxxcNXK8ghhFCoRpOdaqPGYxfWK+qSwoEmOaWd3yoUk7Ofk0JYlGOSAs/G7zmI0sCMhx
         MBfbvuaayczerxwpu3zpdwjCFBm/jyvkxp2jpRXSeUh3E2Xn90Ajo2TygTgw+JJpvV0k
         NT+Q==
X-Gm-Message-State: AOAM531xB6qmf1X8UdzwuABhLwcvy2CP/e6pYWfs1vcLnc4p5BhrvjPb
        EYme4YDmJ6i5uQYzEQ323YQo+AJUawCn2nSP/dA=
X-Google-Smtp-Source: ABdhPJyWA/G0duxVcYWid97/IpWsMXXt4Gr7CytCMkgaGBJnJlnILEkctcgtFteFPwsIAHz3v0r45tlOc8PDALRt54g=
X-Received: by 2002:a05:6a00:b44:b0:4f7:1043:a72d with SMTP id
 p4-20020a056a000b4400b004f71043a72dmr8919091pfo.23.1646765514526; Tue, 08 Mar
 2022 10:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20220228140245.24552-1-linmiaohe@huawei.com> <20220228140245.24552-3-linmiaohe@huawei.com>
 <20220304082714.GB3778609@hori.linux.bs1.fc.nec.co.jp> <227af111-9264-02fd-9e46-744d39ecfed0@huawei.com>
 <CAHbLzkom__59_RCpJCZDA+ray-t5qAWatujXWha8BX2-x8GiMA@mail.gmail.com> <8a35d8d8-3078-89ad-4061-358a500c5d61@huawei.com>
In-Reply-To: <8a35d8d8-3078-89ad-4061-358a500c5d61@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 8 Mar 2022 10:51:42 -0800
Message-ID: <CAHbLzkqjoQgXZDUnuLkVABLbPx-=yfgZ-Akt26rgALyQP07dbA@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/memory-failure.c: fix wrong user reference report
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

On Tue, Mar 8, 2022 at 5:11 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/8 4:14, Yang Shi wrote:
> > On Mon, Mar 7, 2022 at 3:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> On 2022/3/4 16:27, HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3 =E7=9B=B4=E4=B9=
=9F) wrote:
> >>> On Mon, Feb 28, 2022 at 10:02:43PM +0800, Miaohe Lin wrote:
> >>>> The dirty swapcache page is still residing in the swap cache after i=
t's
> >>>> hwpoisoned. So there is always one extra refcount for swap cache.
> >>>
> >>> The diff seems fine at a glance, but let me have a few question to
> >>> understand the issue more.
> >>>
> >>> - Is the behavior described above the effect of recent change on shme=
m where
> >>>   dirty pagecache is pinned on hwpoison (commit a76054266661 ("mm: sh=
mem:
> >>>   don't truncate page if memory failure happens"). Or the older kerne=
ls
> >>>   behave as the same?
> >>>
> >>> - Is the behavior true for normal anonymous pages (not shmem pages)?
> >>>
> >>
> >> The behavior described above is aimed at swapcache not pagecache. So i=
t should be
> >> irrelevant with the recent change on shmem.
> >>
> >> What I try to fix here is that me_swapcache_dirty holds one extra pin =
via SwapCache
> >> regardless of the return value of delete_from_lru_cache. We should try=
 to report more
> >> accurate extra refcount for debugging purpose.
> >
> > I think you misunderstood the code. The delete_from_lru_cache()
> > returning 0 means the page was on LRU and isolated from LRU
> > successfully now. Returning -EIO means the page was not on LRU, so it
> > should have at least an extra pin on it.
> >
> > So MF_DELAYED means there is no other pin other than hwpoison and
> > swapcache which is expected, MF_FAILED means there might be extra
> > pins.
> >
> > The has_extra_refcount() raised error then there is *unexpected* refcou=
nt.
>
> Many thanks for your explanation. It seems you're right. If page is held =
on
> the lru_pvecs when we try to do delete_from_lru_cache, and after that it'=
s
> drained to the lru list( so its refcnt might be 2 now). Then we might hav=
e
> the following complain if extra_pins is always true:
>         "Memory failure: ... still referenced by 0 users\n"
>
> But it seems the origin code can not report the correct reason too becaus=
e
> if we retry, page can be delete_from_lru_cache and we can succeed now.

Retry is ok, but it seems overkilling to me IMHO.

>
> Anyway, many thanks for pointing this out.
>
> >
> >>
> >>> I'm trying to test hwpoison hitting the dirty swapcache, but it seems=
 that
> >>> in my testing memory_faliure() fails with "hwpoison: unhandlable page=
"
> >>
> >> Maybe memory_faliure is racing with page reclaim where page is isolate=
d?
> >>
> >>> warning at get_any_page().  So I'm still not sure that me_pagecache_d=
irty()
> >>> fixes any visible problem.
> >>
> >> IIUC, me_pagecache_dirty can't do much except for the corresponding ad=
dress_space supporting
> >> error_remove_page which can truncate the dirty pagecache page. But thi=
s may cause silent data
> >> loss. It's better to keep the page stay in the pagecache until the fil=
e is truncated, hole
> >> punched or removed as commit a76054266661 pointed out.
> >>
> >> Thanks.
> >>
> >>>> Thanks,
> >>> Naoya Horiguchi
> >>>
> >>>>
> >>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>> ---
> >>>>  mm/memory-failure.c | 6 +-----
> >>>>  1 file changed, 1 insertion(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >>>> index 0d7c58340a98..5f9503573263 100644
> >>>> --- a/mm/memory-failure.c
> >>>> +++ b/mm/memory-failure.c
> >>>> @@ -984,7 +984,6 @@ static int me_pagecache_dirty(struct page_state =
*ps, struct page *p)
> >>>>  static int me_swapcache_dirty(struct page_state *ps, struct page *p=
)
> >>>>  {
> >>>>      int ret;
> >>>> -    bool extra_pins =3D false;
> >>>>
> >>>>      ClearPageDirty(p);
> >>>>      /* Trigger EIO in shmem: */
> >>>> @@ -993,10 +992,7 @@ static int me_swapcache_dirty(struct page_state=
 *ps, struct page *p)
> >>>>      ret =3D delete_from_lru_cache(p) ? MF_FAILED : MF_DELAYED;
> >>>>      unlock_page(p);
> >>>>
> >>>> -    if (ret =3D=3D MF_DELAYED)
> >>>> -            extra_pins =3D true;
> >>>> -
> >>>> -    if (has_extra_refcount(ps, p, extra_pins))
> >>>> +    if (has_extra_refcount(ps, p, true))
> >>>>              ret =3D MF_FAILED;
> >>>>
> >>>>      return ret;
> >>>> --
> >>>> 2.23.0
> >>
> >>
> > .
> >
>
