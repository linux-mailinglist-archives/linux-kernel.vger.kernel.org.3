Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC39D4775B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbhLPPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:19:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232620AbhLPPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639667974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+sQyopi0uIME//r8qldSsjFvpGoZ+LazJwGfIuhnnM=;
        b=Szq9nVh1AUGpQ+IgmTXL77NRWClXrOUJVSPPszYhEMLVivyhqJeKYDlSywbG3XS2SVUnU7
        F7YCRrw8eloyp+x1vbOyB07GGWnw2aCCylKXbLkqOUUXObZz/psFIw4Pmk7h74uDFzRVNI
        54hfy0tNcPKLSWLkTBnL26vIbXCe8Ww=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-nhrbBq_TMYWDv95zOWtnQA-1; Thu, 16 Dec 2021 10:19:33 -0500
X-MC-Unique: nhrbBq_TMYWDv95zOWtnQA-1
Received: by mail-wm1-f69.google.com with SMTP id 69-20020a1c0148000000b0033214e5b021so13914807wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=b+sQyopi0uIME//r8qldSsjFvpGoZ+LazJwGfIuhnnM=;
        b=AWvVKUAGlJ7neefj+Y/KJLQaBPWiGyROazal8N5SUos/MoAFXVLiK6H2HJjvsQCoQY
         awgGpYzzZhEgo3ihbYaoadyn6uR6KTEns+6uI15D8nml4F2tFA7MZC4L8M3Fg5eFm+oi
         yiLTIyAExJ0eGP3UAYDcsaFarRoNGDUnmiM0+pf6wkwdqxjsocdKMbS0jb7VcTxa9QIE
         wtNifk1s52yU8hhVVcp9FQ2WUJAap0PvZlvsQ2D2KP4LR3GHgBP5xJQbhZ+I3SeZ2iAK
         wWiHYyYN8XqSVY2BaLwMqlond6XUXe3sm71my62Cemb/6+xFgG4Lo2rGddXEW49xuh5E
         pfbw==
X-Gm-Message-State: AOAM532J3vPWP3npSOdFodF+5Qk1IAynHSbkWv/I2OQ9+R4gDg5mCZ68
        fWI91gyAIOqtvtitsseObd0P7GVbFiqbnZP3ZdzNag/3k76xw0CImz2UtqvYxLvtiESs2NlOvKc
        5Ki3hDhwKs1HvadoY6RtyCHIp
X-Received: by 2002:a05:600c:4f86:: with SMTP id n6mr5283251wmq.129.1639667972132;
        Thu, 16 Dec 2021 07:19:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyi2biwblkcE3Sdx6LdWlmPVQL9ind80eFCHvbthDOUMB7XZKIOVpbSm2flDQPaoEIPReIZhA==
X-Received: by 2002:a05:600c:4f86:: with SMTP id n6mr5283219wmq.129.1639667971930;
        Thu, 16 Dec 2021 07:19:31 -0800 (PST)
Received: from [192.168.3.132] (p4ff23dcd.dip0.t-ipconnect.de. [79.242.61.205])
        by smtp.gmail.com with ESMTPSA id z6sm6479489wmp.9.2021.12.16.07.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 07:19:31 -0800 (PST)
Message-ID: <995f4a1c-35e2-03ef-d09d-14e822e186fe@redhat.com>
Date:   Thu, 16 Dec 2021 16:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Content-Language: en-US
To:     Jianyong Wu <jianyong.wu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org
Cc:     quic_qiancai@quicinc.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gshan@redhat.com, justin.he@arm.com, nd@arm.com
References: <20211216082812.165387-1-jianyong.wu@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211216082812.165387-1-jianyong.wu@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.21 09:28, Jianyong Wu wrote:
> The 'fixmap' is a global resource and is used recursively by
> create pud mapping(), leading to a potential race condition in the
> presence of a concurrent call to alloc_init_pud():
> 
> kernel_init thread                          virtio-mem workqueue thread
> ==================                          ===========================
> 
>   alloc_init_pud(...)                       alloc_init_pud(...)
>   pudp = pud_set_fixmap_offset(...)         pudp = pud_set_fixmap_offset(...)
>   READ_ONCE(*pudp)
>   pud_clear_fixmap(...)
>                                             READ_ONCE(*pudp) // CRASH!
> 
> As kernel may sleep during creating pud mapping, introduce a mutex lock to
> serialise use of the fixmap entries by alloc_init_pud().
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
> 
> Change log:
> 
> from v2 to v3:
>      change spin lock to mutex lock as kernel may sleep when create pud
> map.
> 
>  arch/arm64/mm/mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index acfae9b41cc8..e680a6a8ca40 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
> +static DEFINE_MUTEX(fixmap_lock);
>  
>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> @@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	}
>  	BUG_ON(p4d_bad(p4d));
>  
> +	/*
> +	 * We only have one fixmap entry per page-table level, so take
> +	 * the fixmap lock until we're done.
> +	 */
> +	mutex_lock(&fixmap_lock);
>  	pudp = pud_set_fixmap_offset(p4dp, addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
> @@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  	} while (pudp++, addr = next, addr != end);
>  
>  	pud_clear_fixmap();
> +	mutex_unlock(&fixmap_lock);
>  }
>  
>  static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> 

Hopefully now we get it right and there are not any "special" callpaths :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

