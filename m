Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1317469190
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbhLFIgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231612AbhLFIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638779571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wecGDveWUle3J4VBkSXQko4iWiORAAUofSRD9jsgjls=;
        b=OSIkiMSk4H6F5Vb1k9go0sy3b0LrtoSL5C6sLdZWK850fjyaJNBwRg2NF8NqMbvIrg2b8I
        LCj44IZRYObDp6C8FsX4PPdXkMK9Qpsxw1p8EcRHCvUT8MTx/dMaByDLQxtYZ79wJVdeOO
        /xhtamV20zBFjx8Mb34lx6AkNAYDCkI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-wc2nEX8bOpm2eM7HoVXmRw-1; Mon, 06 Dec 2021 03:32:50 -0500
X-MC-Unique: wc2nEX8bOpm2eM7HoVXmRw-1
Received: by mail-wm1-f72.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso7511965wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=wecGDveWUle3J4VBkSXQko4iWiORAAUofSRD9jsgjls=;
        b=cYXPeKsrMa5DF4C5/yj+6MbMm2uVQrnz0iJ0vCLJl1aOv2YdP5Uc8KvanjI3tkI6s7
         435pul+eONd7iwhNdz+uiovM8wZrVCfLmJFL39DXgmIOLcl8zjVCv8//hcIDmw1N3KKX
         5BcUdeKEKlLMWOGK49/8waFShrz0kcnHFDaaLr3iGuTbeE6/G5GJAI/NObeV6ChNdjL5
         HEasZvr0Od8Rht8v8jWArfdWsJI5XE6S39rioYpx3c5G8boL9RXAvaR4BMiOygwlNyLZ
         EF3c2eAFehZGiBmUqU/kuwaofGbJ2k4D+dRLQRkFzohW8HgZCs90q5Si7ySOYNQ1TpDe
         SkLA==
X-Gm-Message-State: AOAM533gfnVIpliqr7enM+c8mYF9/nbkHxOK85ub8oaMnow1xGSITpD6
        0Hl6cwGMS86jgyYVwhiOdDnnVWo4OU3KS3XV2+58RLq26TNFVX/JPLsAKgrVsZ2PLu0gIeIJDI6
        0z9rKpX+PJNVUDnU2FLkC7MuE
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr38253947wme.188.1638779569070;
        Mon, 06 Dec 2021 00:32:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxM9FIdviVdATWYqVBaHI+Z8825CuCfHKVgMwDbUZiKBURdSBOcquh52XYbI1LjhjINOuHScA==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr38253920wme.188.1638779568904;
        Mon, 06 Dec 2021 00:32:48 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62c6.dip0.t-ipconnect.de. [91.12.98.198])
        by smtp.gmail.com with ESMTPSA id f15sm12329778wmg.30.2021.12.06.00.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:32:48 -0800 (PST)
Message-ID: <71499507-78dd-63fa-2104-350660f31c08@redhat.com>
Date:   Mon, 6 Dec 2021 09:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     shakeelb@google.com, ktkhai@virtuozzo.com, shy828301@gmail.com,
        guro@fb.com, vbabka@suse.cz, vdavydov.dev@gmail.com,
        raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211206033338.743270-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.21 04:33, Nico Pache wrote:
> We have run into a panic caused by a shrinker allocation being attempted
> on an offlined node.
> 
> Our crash analysis has determined that the issue originates from trying
> to allocate pages on an offlined node in expand_one_shrinker_info. This
> function makes the incorrect assumption that we can allocate on any node.
> To correct this we make sure we only itterate over online nodes.
> 
> This assumption can lead to an incorrect address being assigned to ac->zonelist
> in the following callchain:
> 	__alloc_pages
> 	-> prepare_alloc_pages
> 	 -> node_zonelist
> 
> static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
> {
>         return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
> }
> if the node is not online the return of node_zonelist will evaluate to a
> invalid pointer of 0x00000 + offset_of(node_zonelists) + (1|0)
> 
> This address is then dereferenced further down the callchain in:
> 	prepare_alloc_pages
> 	-> first_zones_zonelist
>   	 -> next_zones_zonelist
> 	  -> zonelist_zone_idx
> 
> static inline int zonelist_zone_idx(struct zoneref *zoneref)
> {
>         return zoneref->zone_idx;
> }
> 
> Leading the system to panic.
> 
> We also correct this behavior in alloc_shrinker_info, free_shrinker_info,
> and reparent_shrinker_deferred.
> 
> Fixes: 2bfd36374edd ("mm: vmscan: consolidate shrinker_maps handling code")
> Fixes: 0a4465d34028 ("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/vmscan.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fb9584641ac7..731564b61e3f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -221,7 +221,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  	int nid;
>  	int size = map_size + defer_size;
>  
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		pn = memcg->nodeinfo[nid];
>  		old = shrinker_info_protected(memcg, nid);
>  		/* Not yet online memcg */
> @@ -256,7 +256,7 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>  	struct shrinker_info *info;
>  	int nid;
>  
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		pn = memcg->nodeinfo[nid];
>  		info = rcu_dereference_protected(pn->shrinker_info, true);
>  		kvfree(info);
> @@ -274,7 +274,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  	map_size = shrinker_map_size(shrinker_nr_max);
>  	defer_size = shrinker_defer_size(shrinker_nr_max);
>  	size = map_size + defer_size;
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
>  		if (!info) {
>  			free_shrinker_info(memcg);
> @@ -417,7 +417,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  
>  	/* Prevent from concurrent shrinker_info expand */
>  	down_read(&shrinker_rwsem);
> -	for_each_node(nid) {
> +	for_each_online_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
>  		for (i = 0; i < shrinker_nr_max; i++) {
> 

What happens on memory/cpu hotplug, resulting in a new node getting
onlined? Will the data structures get allocated and the data get
properly set up?

-- 
Thanks,

David / dhildenb

