Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBD553F151
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiFFVCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiFFVBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:01:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54A13F400
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:50:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s13so17041719ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZjAv5aFwvGTLPhlpRw2+o5abMQEEmcSWSknk+L4bkY4=;
        b=f+kdRpZJxlwjyWP/saEwhC4acrcVKRuqglnbg8a3oSgvgDhOzmJk829LokCpxgeou5
         zqAjGqYyl5eUvOXCsCiHkr88wk+vqokAYMkz9GqwJV9VLq+hQAdVqHmoeD8E1FNnM951
         99ABBYcSx1+mIlZ5it+GwOa2RVq8+mW2uKEqAkRvRdf7AmN/Wfe4q6CA3259wLz0FeKH
         2peT+Ptqqy7xKBQ3T7w19ryQeHs9nM5LKC8ojH411kymIEa1+ZJbCA7XyL6/UJ2vGNSS
         8PNWsHM4m4nrvSZp948KuICdjFZb7rHnc13tU3vTYZFNzOLn2FP7PEruHTS2AW1rhYpZ
         rJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZjAv5aFwvGTLPhlpRw2+o5abMQEEmcSWSknk+L4bkY4=;
        b=cz8C73hQSlYy0cPNs0TK3QkMfggWJpwdsfT8JS6YFhjoxtyyWumnmk4hLijAV7xwca
         VviQE3iFgMN9nIY4bAcrqANZpmyhanfAlymUz0DwnUtHkFITfYpkv/CfK+1jySFECrTK
         KaEVhQfGmQ1oHSooVYs8QcqnmFKWmwrhJfK+cyNcObRqXCI/vebho3JURnPmwkuhZJba
         gB1AMCReX5M3m/psX7osnGl+J1lLQi2Wkt7zrwpVXYdpIWBY8gCRYTSNc86iD94F6G8J
         n6U7/KrJ6EIFWFQNrt+16h6NR5kAjjN1SX/TZFGGMTqZc5NnPqq/+UB+eyETUoPHhdCh
         1Tpg==
X-Gm-Message-State: AOAM533qMW7vLm8o53P6I0Zhr5KeEvrtR6iDG117goeIQrPUFE/4WYbN
        LsKYhCFuU1K7uM/MGzNHxkk=
X-Google-Smtp-Source: ABdhPJwJ3KllByNHOzNQfQeXSPKuKbmKZEO6YEk/D2I6ouGdP01uD322ewDAmJ7Yi3z550NeQ4LhjQ==
X-Received: by 2002:a05:651c:160b:b0:247:f955:1b18 with SMTP id f11-20020a05651c160b00b00247f9551b18mr53514803ljq.427.1654548623775;
        Mon, 06 Jun 2022 13:50:23 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id bp17-20020a056512159100b0047255d21186sm2990692lfb.181.2022.06.06.13.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:50:23 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 6 Jun 2022 22:50:21 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, urezki@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm/vmalloc: Add code comment for
 find_vmap_area_exceed_addr()
Message-ID: <Yp5ojeAk+2tf2Rr2@pc638.lan>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606083909.363350-5-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:39:08PM +0800, Baoquan He wrote:
> Its behaviour is like find_vma() which finds an area above the specified
> address, add comment to make it easier to understand.
> 
> And also fix two places of grammer mistake/typo.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 11dfc897de40..860ed9986775 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -790,6 +790,7 @@ unsigned long vmalloc_nr_pages(void)
>  	return atomic_long_read(&nr_vmalloc_pages);
>  }
>  
> +/* Look up the first VA which satisfies  addr < va_end,  NULL if none. */
>  static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
>  {
>  	struct vmap_area *va = NULL;
> @@ -929,7 +930,7 @@ link_va(struct vmap_area *va, struct rb_root *root,
>  		 * Some explanation here. Just perform simple insertion
>  		 * to the tree. We do not set va->subtree_max_size to
>  		 * its current size before calling rb_insert_augmented().
> -		 * It is because of we populate the tree from the bottom
> +		 * It is because we populate the tree from the bottom
>  		 * to parent levels when the node _is_ in the tree.
>  		 *
>  		 * Therefore we set subtree_max_size to zero after insertion,
> @@ -1659,7 +1660,7 @@ static atomic_long_t vmap_lazy_nr = ATOMIC_LONG_INIT(0);
>  
>  /*
>   * Serialize vmap purging.  There is no actual critical section protected
> - * by this look, but we want to avoid concurrent calls for performance
> + * by this lock, but we want to avoid concurrent calls for performance
>   * reasons and to make the pcpu_get_vm_areas more deterministic.
>   */
>  static DEFINE_MUTEX(vmap_purge_lock);
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
