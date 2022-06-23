Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6918A5573DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiFWHYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiFWHYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:24:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C838F46168
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:24:45 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n12so11357720pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V5L4PYUq7nG6vsd/zKr6FHtwDpXOar+I+aRnKcea838=;
        b=kXnFiHXa8TfbhLaMlCxOnGvwSY1BU6I6mhJuUdTkuMY9AVdnY5ptmMhB0vPFKJ8q1e
         oeV4dy0l5AyDTMINIDamw0z6GkG9CJoxtgHgPilt/agLUww5AtIOjvskZJTF+Qw7pSxq
         oHvp3L1DI8fxl1Je77Q06fQ6owNZRmWGZp1p7JcLsG9y3iUkYbmYFW2IEE7XRsMUpjwO
         BT/XKHiOgLeeuzlgnLkcPjsix24yFVhDWNzm3AUUV2JyfGyIMpDTsh53ukBfaxFQesvh
         mzlxIpYVpFei1lEKY1RSz2wMLwT5XFnQavOvwCM0wFHrFAeXHtryf57zXd2v8ktOVA/d
         64Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V5L4PYUq7nG6vsd/zKr6FHtwDpXOar+I+aRnKcea838=;
        b=l/XBGAF54cTz1aeuedH9f23lSpYhRZqhV+HJbvnn9Oo2TEsoHrtoGDFj+5ZwG5f/Hk
         fJCRdSSP2xEZ2Vk8WpcyjU8MJ3xFLCuJP/tfHdMZdXZ0xTznsA8wJV8d+15CqNZG3UR/
         hHygZCxIsM5b06EJ3Sr57dNeNDUvMBpS/y/2b4DBv/5c5vBQymROoUqtfKf9pCiu04A3
         UJ9SX2fZDP59qOBGxyq3NzXGR3ATpZ8xIOKfx4poZ9PZjGf606S4h5WOuKCMZTwqY0Mu
         9IYVBrcnpfIRqwZbeulkVeWlInaNJmQT/4REzV5Joy++ps+h1tblsfJ21jJqHXbWD4lT
         hWcw==
X-Gm-Message-State: AJIora/Ue651C9i+8e7XfRRRnZOnZ5XzKoSlST8d2OkegxaKtgLPGgyM
        YErnEKc+nMxznsod3FxK3tYmRg==
X-Google-Smtp-Source: AGRyM1vzWMhRzAyKQlpGmkzpvA1HBBNwz/FpzCynSYCcP0SEwuq6velzl0QHHGixxYDzMhOnqowOAA==
X-Received: by 2002:a63:b54d:0:b0:40c:5917:964b with SMTP id u13-20020a63b54d000000b0040c5917964bmr6478993pgo.241.1655969085368;
        Thu, 23 Jun 2022 00:24:45 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id p188-20020a62d0c5000000b005251fc16ff8sm8664853pfg.220.2022.06.23.00.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:24:45 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:24:41 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] mm/huge_memory: fix comment of page_deferred_list
Message-ID: <YrQVOcF4PirjGa/M@FVFYT0MHHV2J.usts.net>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-15-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-15-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:25AM +0800, Miaohe Lin wrote:
> The current comment is confusing because if global or memcg deferred list
> in the second tail page is occupied by compound_head, why we still use
> page[2].deferred_list here? I think it wants to say that Global or memcg
> deferred list in the first tail page is occupied by compound_mapcount and
> compound_pincount so we use the second tail page's deferred_list instead.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/huge_mm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 12b297f9951d..2e8062b3417a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -294,8 +294,8 @@ static inline bool thp_migration_supported(void)
>  static inline struct list_head *page_deferred_list(struct page *page)
>  {
>  	/*
> -	 * Global or memcg deferred list in the second tail pages is
> -	 * occupied by compound_head.
> +	 * Global or memcg deferred list in the first tail page is
> +	 * occupied by compound_mapcount and compound_pincount.
>  	 */

The structure of "struct page" seems to have told us the information that
we resue the 2nd tail page to be used as deferred_list. I am not sure the
value of those comments. Maybe better to remove them?

Thanks.

>  	return &page[2].deferred_list;
>  }
> -- 
> 2.23.0
> 
> 
