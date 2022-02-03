Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8D4A8169
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbiBCJZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbiBCJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643880355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGSSgLbVI6aAIEB9+yonqjHxMTOVKzKIbf4r9so+9F0=;
        b=Hfrce/d97s8jd41JKdtKnRplrZaqr9WUD/a698RMim6EXehTvOrQUneEmVPOmm299q75Am
        /xWTR98nw/Hf4kpC9Ex7nfA2DmRsQAxFsj5emz6uFtG0sAE9RrpKN3ofdQS4Wo4v9dpE5C
        o4+ovSGrAkTTjiU0Ew3eDZ1jnJ8AlkU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-yJZ3GJlnM5a8lBQv7M0b4w-1; Thu, 03 Feb 2022 04:25:54 -0500
X-MC-Unique: yJZ3GJlnM5a8lBQv7M0b4w-1
Received: by mail-wm1-f70.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so1103216wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 01:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=HGSSgLbVI6aAIEB9+yonqjHxMTOVKzKIbf4r9so+9F0=;
        b=zj8WQQfw50gdA12QgSnPZ4Qt199RYhK5KRsJaZccvqVULI0kR+0Z0ETrJ1TMG5sXMQ
         EWDhlwv+zo7HtyOeI+/6Mzy5SFiJeIVcQD7hicpzb8f8JnL3ux+PjnXWE4W4M8Ozb7Nm
         2JPlumQUkfAG7u0UGihzTasPhhfybkV6Xrbydkiek5rJeLMj3dBFSQW75K0F0xTuOdsp
         iO22hfbyZI7H/KzHyvsXEyPEraQtHfqQgKZj5F9vLOrGLavVjzcaRrOftk55zKnYVJo/
         xdZNgmIEPIpL/RKHSDTF2uVJBseW2twX7zeUh5f4vFMwxGERvkAZQmcZDbUQ52HNueMj
         bJhw==
X-Gm-Message-State: AOAM531593cMDMhqOLv9Rwk4Vuu7HMJ0VJD1ODsT9F9hLErY9n9DeA8O
        Lv2Jgi2LXnzBXvGGx0uX2aVEEQihGJkHLdDe722n04jb2yKnxxUZ1TFP6n8l/7Y5cySBzAStd3T
        4zrNo2CiIXaIAfliZvZJaSbo1
X-Received: by 2002:a5d:544c:: with SMTP id w12mr27664830wrv.357.1643880353014;
        Thu, 03 Feb 2022 01:25:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3d2LnuGTJxZPrIEIW6ESYD9bj3fX2gcGpKKuKvYuOgKefaDHuBKXCUZcq9WOaBptIp61dUw==
X-Received: by 2002:a5d:544c:: with SMTP id w12mr27664817wrv.357.1643880352801;
        Thu, 03 Feb 2022 01:25:52 -0800 (PST)
Received: from ?IPV6:2003:d8:2f11:9700:838c:3860:6500:5284? (p200300d82f119700838c386065005284.dip0.t-ipconnect.de. [2003:d8:2f11:9700:838c:3860:6500:5284])
        by smtp.gmail.com with ESMTPSA id g20sm9382448wmq.9.2022.02.03.01.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 01:25:52 -0800 (PST)
Message-ID: <530d1ca4-6e05-b237-e0a9-c43d61767c4d@redhat.com>
Date:   Thu, 3 Feb 2022 10:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        mhocko@suse.com, mgorman@techsingularity.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220203020022.3044-1-richard.weiyang@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/page_alloc: add zone to zonelist if populated
In-Reply-To: <20220203020022.3044-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.02.22 03:00, Wei Yang wrote:
> During memory hotplug, when online/offline a zone, we need to rebuild
> the zonelist for all nodes. Current behavior would lose a valid zone in
> zonelist since only pick up managed_zone.
> 
> There are two cases for a zone with memory but still !managed.
> 
>   * all pages were allocated via memblock
>   * all pages were taken by ballooning / virtio-mem
> 
> This state maybe temporary, since both of them may release some memory.
> Then it end up with a managed zone not in zonelist.
> 
> This is introduced in 'commit 6aa303defb74 ("mm, vmscan: only allocate
> and reclaim from zones with pages managed by the buddy allocator")'.
> This patch restore the behavior.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Mel Gorman <mgorman@techsingularity.net>
> CC: David Hildenbrand <david@redhat.com>
> Fixes: 6aa303defb74 ("mm, vmscan: only allocate and reclaim from zones with pages managed by the buddy allocator")

That commit mentions that there used to be some ppc64 cases with fadump
where it might have been a real problem. Unfortunately, that commit
doesn't really tell what the performance implications are.

We'd have to know how many "permanent memblock" allocations we have,
that can never get freed.

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index de15021a2887..b433a57ee76f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6092,7 +6092,7 @@ static int build_zonerefs_node(pg_data_t *pgdat, struct zoneref *zonerefs)
>  	do {
>  		zone_type--;
>  		zone = pgdat->node_zones + zone_type;
> -		if (managed_zone(zone)) {
> +		if (populated_zone(zone)) {
>  			zoneref_set_zone(zone, &zonerefs[nr_zones++]);
>  			check_highest_zone(zone_type);
>  		}

The comment above the function also expresses that "Add all populated
zones of a node to the zonelist.", so one way or the other, that should
be made consistent.

-- 
Thanks,

David / dhildenb

