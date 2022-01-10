Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE04F489322
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiAJIQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32438 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbiAJIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641802584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DXb2Qdot0WJqkZ8hEt07gD3PLBZLtkyHeR+k71iLxo=;
        b=JBKBwkoivI7qvfC2+NxfIbhkwNKsmOSitJRcMzBR5ubY+MyDYpxHRwhujvTGEyAY3iAMMe
        un0+AT4H2eqBkeIHZkIcus2DybrAM31cBDrrU4sR1JtNx/x+i/jwE4wx0rm1ErY2yIqbfb
        HsijQ3I09BM+XDA8d3tVuL5tIqKT/fY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-rSbnhDuFPQmGsC2qfxcG2Q-1; Mon, 10 Jan 2022 03:16:22 -0500
X-MC-Unique: rSbnhDuFPQmGsC2qfxcG2Q-1
Received: by mail-ed1-f69.google.com with SMTP id s7-20020a056402520700b003f841380832so9483486edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=6DXb2Qdot0WJqkZ8hEt07gD3PLBZLtkyHeR+k71iLxo=;
        b=WZW1yp78zcfGqRVwmDzyExZfvSSUW/jguqP8I8JSeYenoe5asFctXIdBewyZ2Z2KRf
         0DMA3Cei0fY4LBv1aIe/h/Fs1PWkAWCNLd95Ko1+Qth5haZ6zJz5brnHanXsr2zHQICY
         DqiIgxPfK2K3zPaw4+fYNFq1XVBHrXpSciyJynUZoljoqEBr3o/73uaOakNFBFGQl5qY
         LEF/I8ogvOQbwnCvDZUE8ke6oYfl7o4ijNcUtwcnMhkHesPrZrYVZQNrEtT96FoIEPlN
         Yvn+4iytMH8UPUuxuIJ2DXeg3LqiZX5L6ikLmc5M6U3X2R/I2TNSzKoY2L0KjDjqVHp/
         j17A==
X-Gm-Message-State: AOAM531EQoUgphjCxvEnlM9oB27GQlqUtPGP8drylT2Qjq8InZ5kaKAy
        yl6Rela2XykTNNwnfDwQhxtPbEGn7S/Zij5p7dL735GnqJPsEIMPlhGfAvip3KhjRToeBxf0Alh
        ndpdDEofZfMANYibmVFPFqvtr
X-Received: by 2002:a17:907:6da0:: with SMTP id sb32mr4805833ejc.455.1641802581517;
        Mon, 10 Jan 2022 00:16:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxng77QYf5XAHe4Ds2nAHQWNTds07aUYSF1+NQLW6VnRIrXWSP6tbZZhTPAWIzZvUhxiRRfgQ==
X-Received: by 2002:a17:907:6da0:: with SMTP id sb32mr4805813ejc.455.1641802581236;
        Mon, 10 Jan 2022 00:16:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:cf00:ac25:f2e3:db05:65c3? (p200300cbc701cf00ac25f2e3db0565c3.dip0.t-ipconnect.de. [2003:cb:c701:cf00:ac25:f2e3:db05:65c3])
        by smtp.gmail.com with ESMTPSA id f15sm3191568edq.33.2022.01.10.00.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:16:20 -0800 (PST)
Message-ID: <93865d07-1cc6-8cad-c14a-7fcded63e954@redhat.com>
Date:   Mon, 10 Jan 2022 09:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] mm/memremap.c: Add pfn_to_devmap_page() to get page
 in ZONE_DEVICE
Content-Language: en-US
To:     sxwjean@me.com, akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, osalvador@suse.de,
        naoya.horiguchi@nec.com, thunder.leizhen@huawei.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20220109130515.140092-1-sxwjean@me.com>
 <20220109130515.140092-2-sxwjean@me.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220109130515.140092-2-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.22 14:05, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> when requesting page information by /proc/kpage*, the pages in ZONE_DEVICE
> were missed. We need a function to help on this.
> 
> The pfn_to_devmap_page() function like pfn_to_online_page(), but only
> concerns the pages in ZONE_DEVICE.
> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  include/linux/memremap.h |  8 ++++++++
>  mm/memremap.c            | 42 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index c0e9d35889e8..621723e9c4a5 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -137,6 +137,8 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
>  struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  		struct dev_pagemap *pgmap);
> +struct page *pfn_to_devmap_page(unsigned long pfn,
> +		struct dev_pagemap **pgmap);
>  bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>  
>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
> @@ -166,6 +168,12 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  	return NULL;
>  }
>  
> +static inline struct page *pfn_to_devmap_page(unsigned long pfn,
> +		struct dev_pagemap **pgmap)
> +{
> +	return NULL;
> +}
> +
>  static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
>  {
>  	return false;
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 5a66a71ab591..072dbe6ab81c 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -494,6 +494,48 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>  }
>  EXPORT_SYMBOL_GPL(get_dev_pagemap);
>  
> +/**
> + * pfn_to_devmap_page - get page pointer which belongs to dev_pagemap by @pfn
> + * @pfn: page frame number to lookup page_map
> + * @pgmap: to save pgmap address which is for putting reference
> + *
> + * If @pgmap is non-NULL, then pfn is on ZONE_DEVICE and return page pointer.
> + */
> +struct page *pfn_to_devmap_page(unsigned long pfn, struct dev_pagemap **pgmap)
> +{
> +	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct mem_section *ms;
> +	struct page *page = NULL;
> +
> +	if (nr >= NR_MEM_SECTIONS)
> +		return NULL;
> +
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_PFN_VALID) && !pfn_valid(pfn))
> +		return NULL;
> +
> +	ms = __nr_to_section(nr);
> +	if (!valid_section(ms))
> +		return NULL;
> +	if (!pfn_section_valid(ms, pfn))
> +		return NULL;
> +
> +	/*
> +	 * Two types of sections may include valid pfns:
> +	 * - The pfns of section belong to ZONE_DEVICE and ZONE_{NORMAL,MOVABLE}
> +	 *   at the same time.
> +	 * - All pfns in one section are offline but valid.
> +	 */
> +	if (!online_device_section(ms) && online_section(ms))
> +		return NULL;
> +
> +	*pgmap = get_dev_pagemap(pfn, NULL);
> +	if (*pgmap)
> +		page = pfn_to_page(pfn);
> +
> +	return page;
> +}
> +EXPORT_SYMBOL_GPL(pfn_to_devmap_page);

Is this complexity really required?

Take a look at mm/memory-failure.c

p = pfn_to_online_page(pfn);
if (!p) {
	if (pfn_valid(pfn)) {
		pgmap = get_dev_pagemap(pfn, NULL);
		if (pgmap)
			// success
		// error
	}
	// error
}


Also, why do we need the export?

-- 
Thanks,

David / dhildenb

