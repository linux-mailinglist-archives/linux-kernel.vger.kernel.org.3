Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95E4C9A48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbiCBBMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCBBME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:12:04 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051D98F50
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:11:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s24so191207edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 17:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BVjhXQ5SNbO/pW5hizdV6mz5H8/dxovfwEQSMmhkzAU=;
        b=BDE3x5UJY+SDX6EudoqgIAwzgA4berHul9/6j7AEMmGHDtbDjJToYSV99AFzkKl55s
         lAf/KtgPvl04/7/fhjJMImPB7CK7DRXZrslXzpNiqZqyUWWS1W09QyLDoT2PWrB7TcMl
         SV72s46dP8bhvQ4mkOebTu9rioLLorOT0ag29vckNmOoXSZzIWc10e6qoHeQG7ZC07uN
         DuiTLBr7PoWW24P4LqSx8+vwzgA1x75uveBla4chuEgbuoxzxjP3+L86R/KD3giaOg0O
         YrFeN9lzWUTcHqWpUMlTh+U9y+3SnAxRMkUEBPQXAWR9RaKPFvTJo2eHk2WidG7gjzIY
         2rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BVjhXQ5SNbO/pW5hizdV6mz5H8/dxovfwEQSMmhkzAU=;
        b=6gVjwX9Sq6kL0eNclOw+thp0x93X/CDTXCu5EBE55iQh9c0+V9KQ0/oiVi0IHfWMbR
         7F1VoGkI8ihGJBiXLvU3c8MUrUpRxDkW5BSZd5amHRMozj8cGLlBVPinRqoUR5qOc0/n
         XGrVkzvIsUm8s4v+JXdZPshP8uULHU8X8Q1XBK/oEO6MNL8DgzN06zv+x3qgVrcUaXDi
         JWuUHMGfzTuRRd81IF2hIA1fr7f9qqE8CbxJJrIO9eJm/PIWwdaPkynYCrjmMwOTr8uX
         llC9/jV7o31pTh8/XBVy4eeuXd6QNvLr2tjfvH6vG7qGtP0vevKa3g/l9rKc+SyB1nE/
         k5EQ==
X-Gm-Message-State: AOAM532YmlFPM91s4RRCMx4eJZ+033nBgDAQNDOp6igbmzllmFUTZX2o
        hvYJFZ6+0xSUT6Rh3NB2vyY4h55cTw1DGOeG3Wk=
X-Google-Smtp-Source: ABdhPJxXRIlLn/L9tVzObJU1m7g2HQIHiyG8p73bYywPy5UoKAvwNBi0PRUT+7lx2VxrfDypf654hz0gXIRyYwgOSk8=
X-Received: by 2002:a50:da4b:0:b0:40f:28f0:c2c0 with SMTP id
 a11-20020a50da4b000000b0040f28f0c2c0mr26884959edk.374.1646183480055; Tue, 01
 Mar 2022 17:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20220215073743.1769979-1-cgel.zte@gmail.com> <1f486393-3829-4618-39a1-931afc580835@oracle.com>
 <d6e74520-88bc-9f57-e189-8e4f389726e@google.com> <Yg5RDDRLVsuT/Rfw@casper.infradead.org>
 <8986d97-3933-8fa7-abba-aabd67924bc2@google.com> <a4f79248-df75-2c8c-3df-ba3317ccb5da@google.com>
In-Reply-To: <a4f79248-df75-2c8c-3df-ba3317ccb5da@google.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Wed, 2 Mar 2022 09:11:08 +0800
Message-ID: <CAOH5QeA4w+CKW+K58k3c5pRWdkx6uT5ouyQ6hepMd1wKF51mcw@mail.gmail.com>
Subject: Re: [PATCH] memfd: fix F_SEAL_WRITE after shmem huge page allocated
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, cgel.zte@gmail.com,
        kirill@shutemov.name, songliubraving@fb.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
this patch does not apply to the 4.19 kernel.
Is it necessary to make corresponding patches for each stable version?

Thanks.

Hugh Dickins <hughd@google.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=8827=E6=97=A5=
=E5=91=A8=E6=97=A5 14:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Wangyong reports: after enabling tmpfs filesystem to support
> transparent hugepage with the following command:
>
>  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>
> the docker program tries to add F_SEAL_WRITE through the following
> command, but it fails unexpectedly with errno EBUSY:
>
>  fcntl(5, F_ADD_SEALS, F_SEAL_WRITE) =3D -1.
>
> That is because memfd_tag_pins() and memfd_wait_for_pins() were never
> updated for shmem huge pages: checking page_mapcount() against
> page_count() is hopeless on THP subpages - they need to check
> total_mapcount() against page_count() on THP heads only.
>
> Make memfd_tag_pins() (compared > 1) as strict as memfd_wait_for_pins()
> (compared !=3D 1): either can be justified, but given the non-atomic
> total_mapcount() calculation, it is better now to be strict.  Bear in
> mind that total_mapcount() itself scans all of the THP subpages, when
> choosing to take an XA_CHECK_SCHED latency break.
>
> Also fix the unlikely xa_is_value() case in memfd_wait_for_pins(): if a
> page has been swapped out since memfd_tag_pins(), then its refcount must
> have fallen, and so it can safely be untagged.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Reported-by: wangyong <wang.yong12@zte.com.cn>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
> Andrew, please remove
> fix-shmem-huge-page-failed-to-set-f_seal_write-attribute-problem.patch
> fix-shmem-huge-page-failed-to-set-f_seal_write-attribute-problem-fix.patc=
h
> from mmotm, and replace them by this patch against 5.17-rc5:
> wangyong's patch did not handle the case of pte-mapped huge pages, and I
> had this one from earlier, when I found the same issue with MFD_HUGEPAGE
> (but MFD_HUGEPAGE did not go in, so I didn't post this one, forgetting
> the transparent_hugepage/shmem_enabled case).
>
>  mm/memfd.c |   40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> --- 5.17-rc5/mm/memfd.c
> +++ linux/mm/memfd.c
> @@ -31,20 +31,28 @@
>  static void memfd_tag_pins(struct xa_state *xas)
>  {
>         struct page *page;
> -       unsigned int tagged =3D 0;
> +       int latency =3D 0;
> +       int cache_count;
>
>         lru_add_drain();
>
>         xas_lock_irq(xas);
>         xas_for_each(xas, page, ULONG_MAX) {
> -               if (xa_is_value(page))
> -                       continue;
> -               page =3D find_subpage(page, xas->xa_index);
> -               if (page_count(page) - page_mapcount(page) > 1)
> +               cache_count =3D 1;
> +               if (!xa_is_value(page) &&
> +                   PageTransHuge(page) && !PageHuge(page))
> +                       cache_count =3D HPAGE_PMD_NR;
> +
> +               if (!xa_is_value(page) &&
> +                   page_count(page) - total_mapcount(page) !=3D cache_co=
unt)
>                         xas_set_mark(xas, MEMFD_TAG_PINNED);
> +               if (cache_count !=3D 1)
> +                       xas_set(xas, page->index + cache_count);
>
> -               if (++tagged % XA_CHECK_SCHED)
> +               latency +=3D cache_count;
> +               if (latency < XA_CHECK_SCHED)
>                         continue;
> +               latency =3D 0;
>
>                 xas_pause(xas);
>                 xas_unlock_irq(xas);
> @@ -73,7 +81,8 @@ static int memfd_wait_for_pins(struct ad
>
>         error =3D 0;
>         for (scan =3D 0; scan <=3D LAST_SCAN; scan++) {
> -               unsigned int tagged =3D 0;
> +               int latency =3D 0;
> +               int cache_count;
>
>                 if (!xas_marked(&xas, MEMFD_TAG_PINNED))
>                         break;
> @@ -87,10 +96,14 @@ static int memfd_wait_for_pins(struct ad
>                 xas_lock_irq(&xas);
>                 xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINN=
ED) {
>                         bool clear =3D true;
> -                       if (xa_is_value(page))
> -                               continue;
> -                       page =3D find_subpage(page, xas.xa_index);
> -                       if (page_count(page) - page_mapcount(page) !=3D 1=
) {
> +
> +                       cache_count =3D 1;
> +                       if (!xa_is_value(page) &&
> +                           PageTransHuge(page) && !PageHuge(page))
> +                               cache_count =3D HPAGE_PMD_NR;
> +
> +                       if (!xa_is_value(page) && cache_count !=3D
> +                           page_count(page) - total_mapcount(page)) {
>                                 /*
>                                  * On the last scan, we clean up all thos=
e tags
>                                  * we inserted; but make a note that we s=
till
> @@ -103,8 +116,11 @@ static int memfd_wait_for_pins(struct ad
>                         }
>                         if (clear)
>                                 xas_clear_mark(&xas, MEMFD_TAG_PINNED);
> -                       if (++tagged % XA_CHECK_SCHED)
> +
> +                       latency +=3D cache_count;
> +                       if (latency < XA_CHECK_SCHED)
>                                 continue;
> +                       latency =3D 0;
>
>                         xas_pause(&xas);
>                         xas_unlock_irq(&xas);
