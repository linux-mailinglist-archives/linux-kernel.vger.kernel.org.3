Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D154F7A72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243288AbiDGIzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDGIzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:55:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB71174EA6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:53:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so1095951pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8mmueqbLnm3tk7tVIxrPw233tyq03LboORzG5ca8hgQ=;
        b=isj2jzKX5U7EBQ02gJe8d/pvWluEXF8nTkNftYQmporcsD388FAfJlvlYX3tYcCtc4
         qBp5/z4g+8o2i0+5Y6HEYjDLAR0/0qEcfriQvVv99iwnckZ/jJDIY5Zj2cxp9ftLwly4
         9nQNRYkHc2G7eRfJYD+i79S+WQFgcDKOC76KUnq3aFxZn2DxLNI5LbwfZL9HEDEJNdGf
         00CWlGXTWmbDZM6o45ZbWwbcAr3MH1kT+D6yYnrWjnXIBAQM5Hhh0FIiGZfcNgguKm1g
         AqdAjyA+1U2H/lGHESLx2XRIY15f9zr29ejfpt/+UdaCMJTN+JorwqPvSPQzpMQfwP1+
         Jn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8mmueqbLnm3tk7tVIxrPw233tyq03LboORzG5ca8hgQ=;
        b=GiEoUZPZEkeHu1802LjmLvcjgfQ1F4a+L8MKJo0xHRWQHz/BgOktGJhI/I+arNs9Kf
         48CxDkSSDx1x+rJmPpC/8Q9DAeDgaZcA+raY4nYOlorzArqEcxDb2ncpeGdFQwbo07qw
         loOQ9zDzD6bF3niqThR5LPsfMwHbbXG/0+l00WrciMP3lZj+16stDOW9ifnkPZrjE+UK
         h9ps1KC9O7Y4geEg7WPfpS49G5ZyKVnxLdgL1KjffCGjYs73bjcHfXf35ftKFL4NkJcq
         HOzATL28+n3vLWGA3JIXqLZSdDvKNBxUDWFZLhBIbKJzSZhvFSGUp9wFnSwZMxv/hGcw
         bEJQ==
X-Gm-Message-State: AOAM533XeoN+QTzhnL2Npa5vKE3zA2AEhGrJ2BxR8/R7AKMEA9fs2/zF
        HTAET3dQKH2DKSBZYT6l01+U1Zw/EdrMJWUz
X-Google-Smtp-Source: ABdhPJxF0JgZGdq0qnZLc3MZOz6/F3m9oT65Ox4sm1zdr45nDtltCTbFUB/akj11Tu0h0Y8jm+itgw==
X-Received: by 2002:a17:902:aa88:b0:156:914b:dc79 with SMTP id d8-20020a170902aa8800b00156914bdc79mr12732694plr.138.1649321613071;
        Thu, 07 Apr 2022 01:53:33 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090a890a00b001cb14240c4csm1235786pjn.1.2022.04.07.01.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:53:31 -0700 (PDT)
Date:   Thu, 7 Apr 2022 17:53:24 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c: fix comments
Message-ID: <Yk6mhDuKwhviUxXi@hyeyoo>
References: <20220407080958.3667-1-caoyixuan2019@email.szu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407080958.3667-1-caoyixuan2019@email.szu.edu.cn>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:09:58PM +0800, Yixuan Cao wrote:
> While reading the source code,
> I noticed some language errors in the comments, so I fixed them.
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  mm/slab.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 90b16c7ae01a..e882657c1494 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -781,7 +781,7 @@ static inline int cache_free_alien(struct kmem_cache *cachep, void *objp)
>  	int slab_node = slab_nid(virt_to_slab(objp));
>  	int node = numa_mem_id();
>  	/*
> -	 * Make sure we are not freeing a object from another node to the array
> +	 * Make sure we are not freeing an object from another node to the array
>  	 * cache on this cpu.
>  	 */
>  	if (likely(node == slab_node))
> @@ -832,7 +832,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
>  
>  	/*
>  	 * The kmem_cache_nodes don't come and go as CPUs
> -	 * come and go.  slab_mutex is sufficient
> +	 * come and go.  slab_mutex provides sufficient
>  	 * protection here.
>  	 */
>  	cachep->node[node] = n;
> @@ -845,7 +845,7 @@ static int init_cache_node(struct kmem_cache *cachep, int node, gfp_t gfp)
>   * Allocates and initializes node for a node on each slab cache, used for
>   * either memory or cpu hotplug.  If memory is being hot-added, the kmem_cache_node
>   * will be allocated off-node since memory is not yet online for the new node.
> - * When hotplugging memory or a cpu, existing node are not replaced if
> + * When hotplugging memory or a cpu, existing nodes are not replaced if
>   * already in use.
>   *
>   * Must hold slab_mutex.
> @@ -1046,7 +1046,7 @@ int slab_prepare_cpu(unsigned int cpu)
>   * offline.
>   *
>   * Even if all the cpus of a node are down, we don't free the
> - * kmem_cache_node of any cache. This to avoid a race between cpu_down, and
> + * kmem_cache_node of any cache. This is to avoid a race between cpu_down, and
>   * a kmalloc allocation from another cpu for memory from the node of
>   * the cpu going down.  The kmem_cache_node structure is usually allocated from
>   * kmem_cache_create() and gets destroyed at kmem_cache_destroy().
> @@ -1890,7 +1890,7 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
>   * @flags: SLAB flags
>   *
>   * Returns a ptr to the cache on success, NULL on failure.
> - * Cannot be called within a int, but can be interrupted.
> + * Cannot be called within an int, but can be interrupted.
>   * The @ctor is run when new pages are allocated by the cache.
>   *
>   * The flags are
> @@ -3138,7 +3138,7 @@ static void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
>  }
>  
>  /*
> - * A interface to enable slab creation on nodeid
> + * An interface to enable slab creation on nodeid
>   */
>  static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
>  				int nodeid)
> -- 
> 2.17.1
> 
> 
> 
>

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
