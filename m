Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DA563234
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiGALJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiGALJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:09:54 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48314D11;
        Fri,  1 Jul 2022 04:09:53 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id l7so700944ual.9;
        Fri, 01 Jul 2022 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E25TxJtdSgDll1cmrJsw85dXRfaWuA0qiqSEiFOwnjQ=;
        b=SJqZn0PgedDtRnquWWQOptaGeGyKNlod+W1jzCsZGalGuIGiNOdp45taR5OR7VxrxP
         F8wyYpR559ia8fIGK+1QyMlHrHVdidgDXuifvxvVOu7qHFoJzfb0SwT/RoLzkCiQYzmV
         bszhYL0dwbebvCicuQY84YpSMAKcwRHMt8xa8Vj+PHGwNHO0+W71HBFHffJLyytYQnDH
         Uarznh8YBOi5xacPpivY5yWpSIksxmyxq0UoXzVsVYEs61I+TKopXie9iBXE2x8vbRIN
         XFVYEbc5UgBtsLubo9UkmFmfk9OANmtkk1yDTfaZii3tKm+ftc+ZES2e7fM4fWc3rONw
         dtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E25TxJtdSgDll1cmrJsw85dXRfaWuA0qiqSEiFOwnjQ=;
        b=BGBr4+hr0YxGIWLSmkMT4kSyd8I8pl3ZATfWPPSCmg+68OhiPYVScUH8gG3KKmwJK1
         LuY8eI1M84G6R7pnF85UxtxfpMyj/CFKutgNEza3JUTw41rhlh/XZOLIdJ6CM5DkCbBz
         my6fqBcsiGsTRqLOD8P0vrd0d9frG2NnG6YtFudWiB6GGClNvJak+pm318NK9mYpf0Ob
         QR+eG0+37M5c9JCfEZcY5ms21wgD9mEjAepCo6bzKlAQes4XCBh8ZX1rCjjDhMRK3vUf
         XUO9A6IjPwWcCNuVNRPdwUTzslGTwly/LpQqMFRDwornwj0nX3scPb5gULl4cTtWeZou
         pTHw==
X-Gm-Message-State: AJIora9StKIULw2xv1fUlzaOAkzSdonlb3BKsOEqLxVpRbQry3PuWxCq
        n4HnOnLE8uGAfVMbje9X97LOdhSy5yI090lq8OU=
X-Google-Smtp-Source: AGRyM1sXezR+A1T6ayfvYdt08iCCZEmdYbb6Pjt7P2AlLTRl6qvOcPJlJK60rhgdP0CmvjDVHw62Iq6oJKRCj3EH0EI=
X-Received: by 2002:ab0:36d2:0:b0:37f:63c:98b7 with SMTP id
 v18-20020ab036d2000000b0037f063c98b7mr7625755uau.40.1656673792378; Fri, 01
 Jul 2022 04:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220701082250.14935-1-jiaming@nfschina.com>
In-Reply-To: <20220701082250.14935-1-jiaming@nfschina.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 1 Jul 2022 13:09:29 +0200
Message-ID: <CAOi1vP8YpCNCTc0k9+kfbLktCR2+AHXHCM++qPMbyb0Z-Whw2A@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix typo
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Qiong <liqiong@nfschina.com>, renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 10:22 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> There is a typo (writeable) in comments and dout information.
> Fix it.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  fs/ceph/addr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 6dee88815491..083c5b6cae9e 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -565,7 +565,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>
>         dout("writepage %p idx %lu\n", page, page->index);
>
> -       /* verify this is a writeable snap context */
> +       /* verify this is a writable snap context */
>         snapc = page_snap_context(page);
>         if (!snapc) {
>                 dout("writepage %p page %p not dirty?\n", inode, page);
> @@ -573,7 +573,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
>         }
>         oldest = get_oldest_context(inode, &ceph_wbc, snapc);
>         if (snapc->seq > oldest->seq) {
> -               dout("writepage %p page %p snapc %p not writeable - noop\n",
> +               dout("writepage %p page %p snapc %p not writable - noop\n",
>                      inode, page, snapc);
>                 /* we should only noop if called by kswapd */
>                 WARN_ON(!(current->flags & PF_MEMALLOC));
> @@ -860,7 +860,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>         } else if (!ceph_wbc.head_snapc) {
>                 /* Do not respect wbc->range_{start,end}. Dirty pages
>                  * in that range can be associated with newer snapc.
> -                * They are not writeable until we write all dirty pages
> +                * They are not writable until we write all dirty pages
>                  * associated with 'snapc' get written */
>                 if (index > 0)
>                         should_loop = true;
> @@ -1219,7 +1219,7 @@ static int ceph_writepages_start(struct address_space *mapping,
>
>
>  /*
> - * See if a given @snapc is either writeable, or already written.
> + * See if a given @snapc is either writable, or already written.
>   */
>  static int context_is_writeable_or_written(struct inode *inode,
>                                            struct ceph_snap_context *snapc)
> @@ -1265,18 +1265,18 @@ ceph_find_incompatible(struct page *page)
>
>                 /*
>                  * this page is already dirty in another (older) snap
> -                * context!  is it writeable now?
> +                * context!  is it writable now?
>                  */
>                 oldest = get_oldest_context(inode, NULL, NULL);
>                 if (snapc->seq > oldest->seq) {
> -                       /* not writeable -- return it for the caller to deal with */
> +                       /* not writable -- return it for the caller to deal with */
>                         ceph_put_snap_context(oldest);
>                         dout(" page %p snapc %p not current or oldest\n", page, snapc);
>                         return ceph_get_snap_context(snapc);
>                 }
>                 ceph_put_snap_context(oldest);
>
> -               /* yay, writeable, do it now (without dropping page lock) */
> +               /* yay, writable, do it now (without dropping page lock) */
>                 dout(" page %p snapc %p not current, but oldest\n", page, snapc);
>                 if (clear_page_dirty_for_io(page)) {
>                         int r = writepage_nounlock(page, NULL);
> --
> 2.25.1
>

Hi Zhang,

https://en.wiktionary.org/wiki/writeable says that "writeable" is an
alternative spelling of "writable".  It is especially common in computer
science -- there are hundreds of instances just in the kernel sources
along.

Thanks,

                Ilya
