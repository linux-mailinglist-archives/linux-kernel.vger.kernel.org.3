Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FBE53F145
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiFFU6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiFFU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:58:42 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6099D562CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:47:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u23so25202797lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3H2XZ6dpXzRQfowBHHKO62pzuIO8BSQZsCXIa5yn8Y=;
        b=p4IX49yf/tdUFVdv3V7xqUeuqoDjTqg6prRSrjMqky21BQeURVQ4dGXHZXNZ2UqWN6
         MbRVjsVGXnmloodZODxw/1aHhS8sdGtA8xXmXxof65ZgXrGfdSP7jub4Ws0Pz3a0/EOO
         QlBGSwnrm17a182/HyXG0VGIebPu4Za5WQLPCS7JN6wRE9iixQoZOwAXQHFJ2qK0s+nq
         79Yl04ttCQUI5rdZrpoKW2+EYstHkAXS0wFmCDvwKeHDO7cW8mUxQ1ude95KYWyXwH6Q
         rrhGQa6GWy1HM9Kjaj5eVtlXgUnTsUzuxB9bdJ7IZCJidF6pF1MtLvlOhh2o8bam+u5h
         X+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3H2XZ6dpXzRQfowBHHKO62pzuIO8BSQZsCXIa5yn8Y=;
        b=fyQvfJrxWrl2cMnjBxP04hO0+L4n+XFJ6MP5G5dHZ8H3DWERPhsqzTVFHg7YDTaMn/
         0SsTHmaICzqLGBCfHHaUQCb00tyrC3D1jfrya/QblIvyfr2OG185GxU3vTfCF+dyMH+V
         pLN1e7UUSQRAoIRQgeorU2xcIessryBGn5wr2k8sr8y+RQNEu/g3zqvkT7aYjxWJNknb
         PHY7sxbwS60wPeceWX5GbdDldYoCPw9Pf//gauC9A5DWfELI6cx+OqMQlFJTrXNbsvm3
         XlbLkIbmw/w03Qr+uXtZ/GrSSmReTCtWjAQq4k1fwhUdqFMITJ2eVPkyHUXuVC/E31uK
         R/qw==
X-Gm-Message-State: AOAM532qExs6CwSCGxjSCptAScnkI8bLISdFjv/ao1dtMDcAyiH6YWfj
        gOoyitXq6lOx7JL8MTDhD6w=
X-Google-Smtp-Source: ABdhPJz//47oN347Y2bRuH/pMCem/Sb/J5aclSfxWHZNiT+9OO4kKvOZbzG6t3v1mNnUfR9rCRKXUw==
X-Received: by 2002:a05:6512:1315:b0:474:40c9:41a7 with SMTP id x21-20020a056512131500b0047440c941a7mr66846021lfu.319.1654548457291;
        Mon, 06 Jun 2022 13:47:37 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a05651c141700b00255a17d5bfcsm289618lje.106.2022.06.06.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:47:36 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 6 Jun 2022 22:47:35 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, urezki@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] mm/vmalloc: fix typo in local variable name
Message-ID: <Yp5n58uecTlSro6f@pc638.lan>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606083909.363350-4-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:39:07PM +0800, Baoquan He wrote:
> In __purge_vmap_area_lazy(), rename local_pure_list to local_purge_list.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c7e1634ff2b9..11dfc897de40 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1673,32 +1673,32 @@ static void purge_fragmented_blocks_allcpus(void);
>  static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  {
>  	unsigned long resched_threshold;
> -	struct list_head local_pure_list;
> +	struct list_head local_purge_list;
>  	struct vmap_area *va, *n_va;
>  
>  	lockdep_assert_held(&vmap_purge_lock);
>  
>  	spin_lock(&purge_vmap_area_lock);
>  	purge_vmap_area_root = RB_ROOT;
> -	list_replace_init(&purge_vmap_area_list, &local_pure_list);
> +	list_replace_init(&purge_vmap_area_list, &local_purge_list);
>  	spin_unlock(&purge_vmap_area_lock);
>  
> -	if (unlikely(list_empty(&local_pure_list)))
> +	if (unlikely(list_empty(&local_purge_list)))
>  		return false;
>  
>  	start = min(start,
> -		list_first_entry(&local_pure_list,
> +		list_first_entry(&local_purge_list,
>  			struct vmap_area, list)->va_start);
>  
>  	end = max(end,
> -		list_last_entry(&local_pure_list,
> +		list_last_entry(&local_purge_list,
>  			struct vmap_area, list)->va_end);
>  
>  	flush_tlb_kernel_range(start, end);
>  	resched_threshold = lazy_max_pages() << 1;
>  
>  	spin_lock(&free_vmap_area_lock);
> -	list_for_each_entry_safe(va, n_va, &local_pure_list, list) {
> +	list_for_each_entry_safe(va, n_va, &local_purge_list, list) {
>  		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
>  		unsigned long orig_start = va->va_start;
>  		unsigned long orig_end = va->va_end;
> -- 
> 2.34.1
> 
Makes sense to me: Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
