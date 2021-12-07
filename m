Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B60946B8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhLGKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:22:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229758AbhLGKWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638872328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCZbDnbEh9UK6bU7RJluwKcGq9uZewyX/bt5UOEgz80=;
        b=GrLhP/VoXEP0dFgWSs1vDF4+RrtRweLnTq2XWmL5lOnIOwLQBB2TSZQYoyrUg6A3W0LP7H
        pl/Qgi1MAJ0jLA7T2Rpd4e6gv70aNmeoJhOvE0x/PoIG5kNto7ZlfurQPDJoLb8oH0jHm3
        V2ZCD85Rzwmdp01UCjeRn1++oChIk10=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-kGx-y3GsNxml8Nwb0_JCww-1; Tue, 07 Dec 2021 05:18:47 -0500
X-MC-Unique: kGx-y3GsNxml8Nwb0_JCww-1
Received: by mail-wm1-f69.google.com with SMTP id ay17-20020a05600c1e1100b0033f27b76819so7485197wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 02:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=RCZbDnbEh9UK6bU7RJluwKcGq9uZewyX/bt5UOEgz80=;
        b=vGk9PMvCE069pr//57tVYgEolyjSGBTCgQFIHU/lGaGuQ/Y2uAiz00nUctiVojkcTd
         mLh4Psi1mWQOW4szJb3Ye+cTXdRiSGVdtu1IE27mbY6LGFL6wEMDDaBRISVValUuiQuQ
         QiC9Tnwa4GhaYVRitWXStUMTt8IJcKjXlxKpgD7FeNc6jGviatHL+vFItPuJzyBjVzoH
         FERp62cmnpioZsCERlOxDTyNiwSBYfHiw88o/+7C/ae6/w+ayQnUxbG50PNXYmDIBb4L
         vrmhKSF+QqCjGgkOOhWFhtSYEZd0Vkl6G3m4Jp+xt3PyEJjmMo+p9hC9BiDTgKCpzsry
         UDpg==
X-Gm-Message-State: AOAM531JqcDQMJ//LJUGrwF8Bzx3YP/hRppczcd5iXqzQf6JNEGOsb7G
        pY3JIVclYIN6lsxYKyRRM78xoTvdr4k3er9bWMPexYcyx9W6Ti4cglXRX5WNULbbVM+kpYdHIWK
        YF28bmhIrgyIP66L534mZRn2A
X-Received: by 2002:adf:8b1e:: with SMTP id n30mr49452836wra.75.1638872326203;
        Tue, 07 Dec 2021 02:18:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyA2Tl2YN9Wye0XvROD5EVAcbTqHiHWYbDy6hHq2NvqLuJKzyLtdSeyX+0nZwRHbRXD6Ex3lg==
X-Received: by 2002:adf:8b1e:: with SMTP id n30mr49452821wra.75.1638872326049;
        Tue, 07 Dec 2021 02:18:46 -0800 (PST)
Received: from [192.168.3.132] (p4ff23e57.dip0.t-ipconnect.de. [79.242.62.87])
        by smtp.gmail.com with ESMTPSA id w17sm14565391wrp.79.2021.12.07.02.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:18:45 -0800 (PST)
Message-ID: <72c5006e-fc04-8546-7754-3b03ae0a968e@redhat.com>
Date:   Tue, 7 Dec 2021 11:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm:remove unneeded variable
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cm>
References: <20211207083222.401594-1-chi.minghao@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211207083222.401594-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.21 09:32, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
> 
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
> -	int ret;
>  
>  	if (page->mapping != mapping)
>  		return 0;
> @@ -213,9 +212,7 @@ invalidate_complete_page(struct address_space *mapping, struct page *page)
>  	if (page_has_private(page) && !try_to_release_page(page, 0))
>  		return 0;
>  
> -	ret = remove_mapping(mapping, page);
> -
> -	return ret;
> +	return remove_mapping(mapping, page);
>  }
>  
>  int truncate_inode_page(struct address_space *mapping, struct page *page)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

