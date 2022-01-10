Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F292489B53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiAJOe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235567AbiAJOe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641825265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pdJvkaxaICLWqFTDyGX/FRGk93JW9C93pZSDi04sCM=;
        b=cHL6R8IppPCV1gelJOXYm/yQs1vAf0PbWA0Rbv/BkfdaajDpCi08vISYTvpCbVSGCwTiwJ
        yz8G2XW5RC6Y+IunVIp8oDqfze1YctuVXDuF5RHPArg8xu0L0TDjyus062khct7LF4oa4J
        PGTgWKAWy3xqv93WIxoyxDnHWLZrOMo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-K-_o-cEpNHuGuTZ-GMP48A-1; Mon, 10 Jan 2022 09:34:24 -0500
X-MC-Unique: K-_o-cEpNHuGuTZ-GMP48A-1
Received: by mail-ed1-f70.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so10297063edz.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 06:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=0pdJvkaxaICLWqFTDyGX/FRGk93JW9C93pZSDi04sCM=;
        b=jEAnzoIGj86uyx3ofXAjtgafjoJDGHpGW+qrcTJJbn8LKzptN1ZvoznXuQ7tR+zFRz
         4uW4eDU6j8Yj7fSDPSi7bIIbti7bPEC8ZIj0EzGtp2pYuBhQh7Qjz/umzruWpaNoI53h
         NKec/q/RVrqwZcIQ7H4oT0ap7AN596Xss2rYtHW9ceGrr/7tceFsu34gk3PHCF7AVQPZ
         fBzwAD/QrwoNmRp4cvsksrk8eXX/8hgnGsy2Zhfe1wZwqQ8BGLhONmJn/mOxCi+26fNJ
         WR4ac6n7wlJ9ANkgS4VChw34rOakUpv4Uf+ZOOCBYYoJX6/uo4Go/AW1SVucPGB3hCCr
         C/rw==
X-Gm-Message-State: AOAM532iWigscIuNwVCZCQdw0IODTYFLlIS1XhZJUiIJSUO1N+Zx1iof
        gHn/33RTe+ezm8tyrhycydn94hclMQ0ncDn4ZRrmbKQysP4ZWnFgd8WPo8S71zExzm9X2+UoeC/
        65VDng+Ry8XbeJSvtA2O+b65r
X-Received: by 2002:a17:907:3e1b:: with SMTP id hp27mr29496ejc.686.1641825262860;
        Mon, 10 Jan 2022 06:34:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ2+s8QwI/3ARaTXW/ZkaHnJbTUJ8rqKsbIr6UBeAbkwrR/OK7SfljCqSgZ1QwRnS97L2OLA==
X-Received: by 2002:a17:907:3e1b:: with SMTP id hp27mr29483ejc.686.1641825262606;
        Mon, 10 Jan 2022 06:34:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:cf00:ac25:f2e3:db05:65c3? (p200300cbc701cf00ac25f2e3db0565c3.dip0.t-ipconnect.de. [2003:cb:c701:cf00:ac25:f2e3:db05:65c3])
        by smtp.gmail.com with ESMTPSA id 2sm2496382ejt.224.2022.01.10.06.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 06:34:22 -0800 (PST)
Message-ID: <da578a75-5cee-5c16-b63c-be6ba2b9ba5d@redhat.com>
Date:   Mon, 10 Jan 2022 15:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     sxwjean@me.com, akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20220110141957.259022-1-sxwjean@me.com>
 <20220110141957.259022-3-sxwjean@me.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] proc: Add getting pages info of ZONE_DEVICE
 support
In-Reply-To: <20220110141957.259022-3-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.22 15:19, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> When requesting pages info by /proc/kpage*, the pages in ZONE_DEVICE were
> missed.
>

The "missed" part makes it sound like this was done by accident. On the
contrary, for now we decided to not expose these pages that way, for
example, because determining if the memmap was already properly
initialized isn't quite easy.


> The pfn_to_devmap_page() function can help to get page that belongs to
> ZONE_DEVICE.

What's the main motivation for this?

> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  fs/proc/page.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 9f1077d94cde..2cdc2b315ff8 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -15,6 +15,7 @@
>  #include <linux/page_idle.h>
>  #include <linux/kernel-page-flags.h>
>  #include <linux/uaccess.h>
> +#include <linux/memremap.h>
>  #include "internal.h"
>  
>  #define KPMSIZE sizeof(u64)
> @@ -46,6 +47,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>  {
>  	const unsigned long max_dump_pfn = get_max_dump_pfn();
>  	u64 __user *out = (u64 __user *)buf;
> +	struct dev_pagemap *pgmap = NULL;
>  	struct page *ppage;
>  	unsigned long src = *ppos;
>  	unsigned long pfn;
> @@ -60,17 +62,18 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
>  	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>  
>  	while (count > 0) {
> -		/*
> -		 * TODO: ZONE_DEVICE support requires to identify
> -		 * memmaps that were actually initialized.
> -		 */
>  		ppage = pfn_to_online_page(pfn);
> +		if (!ppage)
> +			ppage = pfn_to_devmap_page(pfn, &pgmap);
>  
>  		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
>  			pcount = 0;
>  		else
>  			pcount = page_mapcount(ppage);
>  
> +		if (pgmap)
> +			put_dev_pagemap(pgmap);

Ehm, don't you have to reset pgmap back to NULL? Otherwise during the
next iteration, you'll see pgmap != NULL again.

> +
>  		if (put_user(pcount, out)) {
>  			ret = -EFAULT;
>  			break;
> @@ -229,10 +232,12 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
>  {
>  	const unsigned long max_dump_pfn = get_max_dump_pfn();
>  	u64 __user *out = (u64 __user *)buf;
> +	struct dev_pagemap *pgmap = NULL;
>  	struct page *ppage;
>  	unsigned long src = *ppos;
>  	unsigned long pfn;
>  	ssize_t ret = 0;
> +	u64 flags;
>  
>  	pfn = src / KPMSIZE;
>  	if (src & KPMMASK || count & KPMMASK)
> @@ -242,13 +247,15 @@ static ssize_t kpageflags_read(struct file *file, char __user *buf,
>  	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>  
>  	while (count > 0) {
> -		/*
> -		 * TODO: ZONE_DEVICE support requires to identify
> -		 * memmaps that were actually initialized.
> -		 */
>  		ppage = pfn_to_online_page(pfn);
> +		if (!ppage)
> +			ppage = pfn_to_devmap_page(pfn, &pgmap);
> +
> +		flags = stable_page_flags(ppage);
> +		if (pgmap)
> +			put_dev_pagemap(pgmap);

Similar comment.

>  
> -		if (put_user(stable_page_flags(ppage), out)) {
> +		if (put_user(flags, out)) {
>  			ret = -EFAULT;
>  			break;
>  		}
> @@ -277,6 +284,7 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
>  {
>  	const unsigned long max_dump_pfn = get_max_dump_pfn();
>  	u64 __user *out = (u64 __user *)buf;
> +	struct dev_pagemap *pgmap = NULL;
>  	struct page *ppage;
>  	unsigned long src = *ppos;
>  	unsigned long pfn;
> @@ -291,17 +299,18 @@ static ssize_t kpagecgroup_read(struct file *file, char __user *buf,
>  	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
>  
>  	while (count > 0) {
> -		/*
> -		 * TODO: ZONE_DEVICE support requires to identify
> -		 * memmaps that were actually initialized.
> -		 */
>  		ppage = pfn_to_online_page(pfn);
> +		if (!ppage)
> +			ppage = pfn_to_devmap_page(pfn, &pgmap);
>  
>  		if (ppage)
>  			ino = page_cgroup_ino(ppage);
>  		else
>  			ino = 0;
>  
> +		if (pgmap)
> +			put_dev_pagemap(pgmap);

Similar comment.


IIRC, we might still stumble over uninitialized devmap memmaps that
essentially contain garbage -- I recall it might be the device metadata.
I wonder if we at least have to check pgmap_pfn_valid().

-- 
Thanks,

David / dhildenb

