Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FF46D368
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhLHMjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhLHMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:39:18 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B293C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 04:35:47 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 14so2601661ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 04:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BGELNsFyoDgwcncbtGABFzj/JFF5sXZuONj0OzMW4bM=;
        b=H9aiRvODe0vHHHIrYGNALS0wpsMJ1AX6T7TUWx4MCAsbZ45M9SMEc8e1l16oM9b6l5
         fc1W50YQElBI2E3guVAQWFjV+mDwhj/YqDAVGPdrOeeFoDUxD/K+n/urQuYSXYYdcwc0
         v3c5rK093YbhQjEDcepL0FrwzeWFN1Cde3oIQqlQ5Ap4kFQrpxNKzByaMqm8keS+FApP
         ONe4TvB0pxfK+R913pmOme8qdHo/CEv7zR8hwZRfIeRjfvqsxXFqr+MA0VL7fUWg/qKN
         iDtiPmFM0vclrSxnuHdcWWcRG7Bi5tFVMx6RvcB5lE/Y1lrblN2vpXhzwwYDLPBlJtbi
         s3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGELNsFyoDgwcncbtGABFzj/JFF5sXZuONj0OzMW4bM=;
        b=hIWBRWWzdHoPjbfuEE3J7QNELguwzvJaCFLP9AtgCz5wr0KrqMy/6JkBWMVxxibHB9
         wtpu6OvMDSYZFZpqIXgIouODdG/4QVb1LeblaHzboEMlEWuKTMirg+HQMRFW/hqBj/PJ
         UiOuLp5KSpmISSOMXprIsIE3vzo4NUAiB6L+PzoxEzvprly7/ZDkvrf/Wze0MGZ8UW7o
         faX+kUdef8FQKEOg5YkfPHbodGZKpBq2A6Hx9YVMfOBCs+89XDcvwVzrLWexO2NbdAGH
         dTEX7nKwMMJ5KaBI7rarWK5nwaQ0UO0Wp6VNWyfMDa2DsEPtaonzS82zBIrvMZKMKvev
         tVTw==
X-Gm-Message-State: AOAM532iiYPekfcBNNOFMplLJYV3JIVAiISU7iZ9atYnmZfBLRpB4Pwe
        5E/aJX+G1YabCJSnZ3UdHaApoyrDG0r7jnETKvU=
X-Google-Smtp-Source: ABdhPJzFS8DJObIpKJW0Ydpe/O8gHGS+92jvF2gQGK8VLOStppRoGBAnRUikQGm5KUTfT3L7B4D4a05O3sjpM3m9X00=
X-Received: by 2002:a05:6638:2727:: with SMTP id m39mr58565004jav.75.1638966946730;
 Wed, 08 Dec 2021 04:35:46 -0800 (PST)
MIME-Version: 1.0
References: <20211207083222.401594-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211207083222.401594-1-chi.minghao@zte.com.cn>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 8 Dec 2021 13:35:35 +0100
Message-ID: <CAM9Jb+hfa7fejFqmg3A07kjrZTf++QKCYx=0oArBNBqNsMrv1A@mail.gmail.com>
Subject: Re: [PATCH] mm:remove unneeded variable
To:     cgel.zte@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> return value form directly instead of
> taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>  mm/truncate.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/truncate.c b/mm/truncate.c
> index cc83a3f7c1ad..41b8249b3b4a 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -205,7 +205,6 @@ static void truncate_cleanup_page(struct page *page)
>  static int
>  invalidate_complete_page(struct address_space *mapping, struct page *page)
>  {
> -       int ret;
>
>         if (page->mapping != mapping)
>                 return 0;
> @@ -213,9 +212,7 @@ invalidate_complete_page(struct address_space *mapping, struct page *page)
>         if (page_has_private(page) && !try_to_release_page(page, 0))
>                 return 0;
>
> -       ret = remove_mapping(mapping, page);
> -
> -       return ret;
> +       return remove_mapping(mapping, page);
>  }
>
>  int truncate_inode_page(struct address_space *mapping, struct page *page)

 Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>
