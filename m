Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3131D5A416B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiH2DTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiH2DTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:19:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D8402E3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:19:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso4102771pjd.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=r0M9FUvZOZnp7Vmf7xtDgyqRqSJWKApPfYbePi7+It4=;
        b=kj4Df5cr/HmTCxI1B6gqSsn1/BC0sLpiOf8WCdGFlPXFH78J82EY2tFm8ijY4U9FZ4
         Xo89kX5U1PUzs1quar0gcZr1yMoE3Zc+PdLwiSQZsvvwLI5eCr2v0XQcyvYhe9JTE/xf
         ZREy48456hgcCiX0ud6LQWDkmgLeG7RFEQ4pWKCPLrBImfnJ2/GtGNNw0q6OwxkOustD
         jYRkbe/HTVET5dI+G7gx4RtKA+GYIPI1W7NcCi0davX7g/YEfLd0WyJVG4sUfiIMQvLK
         veNsSRXi9/wJ1q9nFymsLUaGzFu72pzaYCeFWrrKXrAPC6G5omL5ux9r4AUsoOPfhrm+
         eZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=r0M9FUvZOZnp7Vmf7xtDgyqRqSJWKApPfYbePi7+It4=;
        b=c5uR6SBI91IN6YQSku8veZ1H4O9Yh36kBafSvXdl2KIiVoXe3vLf5ShqWMET5us+6K
         DSiA15iwEPH0kOmgkYeU5trIggetvoXDgA+wshtdlYTWWqKaZ3NS1kO5Oyc1Oe9wpCA8
         pPk93nXWZvHeJcY8dHOb5FGjXdev9jkaMSdkFEJ8caz5K83/0ORNfsL22MKhsh9Y+z5p
         JejY1mLDdJFzSCqFbC8iCoZKEr99VVQn3SOg14ZTiQpAe1wab16PMAhro2Xwr/qbLnGu
         tiN9S2qZlaRfv8JjoYzl0CmktPAsScVV04ybVhXPd0rRKN9VsVYKzfISoFPbt5Sxsosg
         2WyA==
X-Gm-Message-State: ACgBeo20FXJ7hcudW2itiLMfr5/7IeHsTvbwj31rMSUO/EqL5U+lPh4M
        9DBu6tqA3WIm3FdIY7g0cy8=
X-Google-Smtp-Source: AA6agR6kO9cTXhT0sZ7o01el9AKJmOZotzwdH+bfWTAL+FHq4TJ8fnP+GQcfig0K1OATUHPZW6RPtA==
X-Received: by 2002:a17:90a:cb94:b0:1fd:86fe:ba3e with SMTP id a20-20020a17090acb9400b001fd86feba3emr10219460pju.240.1661743143607;
        Sun, 28 Aug 2022 20:19:03 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id p124-20020a622982000000b0052e7f103138sm5977303pfp.38.2022.08.28.20.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 20:19:02 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:18:57 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Message-ID: <YwwwIcZ6FUy6J4xh@hyeyoo>
References: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 11:14:48PM +0800, Dawei Li wrote:
> Current size2index is implemented by one to one hardcode mapping,
> which can be improved by order_base_2().
> Must be careful to not violate compile-time optimization rule.

> Generated code for caller of kmalloc:
> 48 8b 3d 9f 0b 6b 01 mov    0x16b0b9f(%rip),%rdi
>                             # ffffffff826d1568 <kmalloc_caches+0x48>
> ba 08 01 00 00       mov    $0x108,%edx
> be c0 0d 00 00       mov    $0xdc0,%esi
> e8 98 d7 2e 00       callq  ffffffff8130e170 <kmem_cache_alloc_trace>
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  include/linux/slab.h | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0fefdf528e0d..66452a4357c6 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -17,7 +17,7 @@
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <linux/percpu-refcount.h>
> -
> +#include <linux/log2.h>
>  
>  /*
>   * Flags to pass to kmem_cache_create().
> @@ -394,31 +394,16 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>  
>  	if (KMALLOC_MIN_SIZE <= 32 && size > 64 && size <= 96)
>  		return 1;
> +
>  	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
>  		return 2;
> -	if (size <=          8) return 3;
> -	if (size <=         16) return 4;
> -	if (size <=         32) return 5;
> -	if (size <=         64) return 6;
> -	if (size <=        128) return 7;
> -	if (size <=        256) return 8;
> -	if (size <=        512) return 9;
> -	if (size <=       1024) return 10;
> -	if (size <=   2 * 1024) return 11;
> -	if (size <=   4 * 1024) return 12;
> -	if (size <=   8 * 1024) return 13;
> -	if (size <=  16 * 1024) return 14;
> -	if (size <=  32 * 1024) return 15;
> -	if (size <=  64 * 1024) return 16;
> -	if (size <= 128 * 1024) return 17;
> -	if (size <= 256 * 1024) return 18;
> -	if (size <= 512 * 1024) return 19;
> -	if (size <= 1024 * 1024) return 20;
> -	if (size <=  2 * 1024 * 1024) return 21;
> -	if (size <=  4 * 1024 * 1024) return 22;
> -	if (size <=  8 * 1024 * 1024) return 23;
> -	if (size <=  16 * 1024 * 1024) return 24;
> -	if (size <=  32 * 1024 * 1024) return 25;

It does not apply. better rebase it on Vlastimil's slab tree (for-next branch)
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/

> +
> +	if (size <= 8)
> +		return 3;
> +
> +	/* Following compile-time optimization rule is mandatory. */
> +	if (size <= 32 * 1024 * 1024)
> +		return order_base_2(size);

Oh, it seems order_base_2() does compile-time opitmization as well.

With order_base_2(), what about using KMALLOC_MAX_CACHE_SIZE instead of 32 * 1024 * 1024?
I think that would be more robust.

Hmm also better check if it works okay with kfence tests (it passes non-constant value)
let't check if it breaks after rebase.

Thanks!

>  
>  	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>  		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> @@ -700,7 +685,6 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
>  	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
>  }
>  
> -
>  #ifdef CONFIG_NUMA
>  extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
>  					 unsigned long caller) __alloc_size(1);
> -- 
> 2.25.1
> 

-- 
Thanks,
Hyeonggon
