Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A4D4755AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhLOKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236587AbhLOKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639562560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyR/pWafnbNjoPSmt1z9ikLmnUdYGSINL8i08WMaNZA=;
        b=RwVR8bX/L1DXjuCA6d5guAdKGgVw0DW+NSei15oXzTPJ52iihQhrOGem5cEQJzH7po4XI3
        u1KamN+upO/llBRD++GeMbcbYMs7psBoSbemdGFh3xyx4e2dG9dmRfGEfEb3diaqq8M4d7
        SyxWYOPGh6+HzA+OGTDqt2GZfbuKjsE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-1zj5FdItOwWJ9yVcg7YqQw-1; Wed, 15 Dec 2021 05:02:28 -0500
X-MC-Unique: 1zj5FdItOwWJ9yVcg7YqQw-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so14431898wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=XyR/pWafnbNjoPSmt1z9ikLmnUdYGSINL8i08WMaNZA=;
        b=iJEki/OuTXKoPp2vYKYOorR4HUXHeFgk/KMI+lDdKAV8PQ7RT1qREP3DydQDL4gdPH
         +v5xYb6okFM0ty1ukYMYS7uNh/0dfxVf6nWP5FUWwz4x3bfcZz7hMpwXgwHUF2DO07qm
         rz+B6HYTpumDONHiiI7pB+//lSEEXN6dkDgGr1moGFIHJHUiGTgs1fPmOkPAjgg245Jm
         32Xz29s65//xRw32AxyY5ts1hmTY0HdMlxdulU7Z2PCzdp5Y6muNDjVZeuN3f4hY8VK3
         j/9pRbXpUW3AAQPCnYWpsF9/p8LQqnRpRmSAYCG8u/hC4gRbnmPv32Y//symZ9PUDdZ7
         Lzzg==
X-Gm-Message-State: AOAM531R+lUYlWaSlF9s4ag9BfqoudzR4JZXPgAqJbYzxyg4RXb64gDh
        p4qA6l2QYERQdB53jcrAhtMOjSWNglQtxX9MYLBOS9zQl3M1C8w/4pJEg68H97eat3ecz1kiWkE
        dHsWVo5wWVAdL2aFVLrvhnUM6
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr3691953wrs.695.1639562547817;
        Wed, 15 Dec 2021 02:02:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdubGtC8gDGXF6elvkw+36Dl7Xj4AMF/njhaoKIkj3646k6GttbI6BvS31c205muApfZvYIA==
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr3691936wrs.695.1639562547589;
        Wed, 15 Dec 2021 02:02:27 -0800 (PST)
Received: from [192.168.3.132] (p5b0c609b.dip0.t-ipconnect.de. [91.12.96.155])
        by smtp.gmail.com with ESMTPSA id i15sm5680610wmq.18.2021.12.15.02.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:02:27 -0800 (PST)
Message-ID: <bbdc65e7-2028-4314-3174-c25a9e2d7c62@redhat.com>
Date:   Wed, 15 Dec 2021 11:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] arm64: mm: apply __ro_after_init to memory_limit
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, rppt@kernel.org
Cc:     akpm@linux-foundation.org, anshuman.khandual@arm.com,
        geert+renesas@glider.be, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.21 07:45, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> This variable is only set during initialization, so mark with
> __ro_after_init.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index a8834434af99..db63cc885771 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -172,7 +172,7 @@ int pfn_is_map_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_is_map_memory);
>  
> -static phys_addr_t memory_limit = PHYS_ADDR_MAX;
> +static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
>  
>  /*
>   * Limit the memory size that was specified via FDT.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

