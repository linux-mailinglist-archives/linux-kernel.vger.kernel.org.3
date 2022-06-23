Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616BE5588B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiFWTZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiFWTZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:25:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD98532DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:39:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j22so224911ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e8SDsEUV/+l+yjQBEqPltwU6ofWW2E8uywELya/jeJA=;
        b=mfFyIlUhcwhxs8N5/fmvOcYpn87xprnkeltTD7hiOU1orbGR9IiHL48IUX6y4Z0h50
         OdrDMFRcgkcUf+pb3Hi//elwNZBQU965d0PJtw7vdbzduTOIn7P/iqGJMLh468RO9xs6
         P7AcJCe5Xw7aVnDYSNcSTzGNt59fEiLLhiYeXvmnRlNjCnd2JiORTAV0wg2OOvWfKsua
         PhoSQTZlUmlxvpvqrigaaHpj0Uvsg5+LRFZN+k3jJoWXesno1FSfF1rA2UtiGP0loRkw
         gS2WbgcMutZjzU9hhtvNljKUKFk1Bf2BMB9pcTd+1pc2BDJ7h7WD+ZFBhkUU+OUCZecN
         ilVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8SDsEUV/+l+yjQBEqPltwU6ofWW2E8uywELya/jeJA=;
        b=dmSwq36+/yY3BH0ezh+dtjh9tPh48w8bNPVt69Giw5XNXLQKJAueCvakBgwnVvD/cD
         CAzth43j/ve7+gBmkrOS+vGb9vb+4N1eEggbgiiTKia72s3yXwJpBRy4sQ+m2TiJm/vH
         NTnpq8+ZHwXR8YG1FieVkDDUeui1Jqxsc+vDSGRzmycvWNT0abOB1u4AEZJjqKwsUmX4
         I84AdyO42MyFo2jJ7lq78XYIt2osN+7WiGvycb5MxdSLVLz9zb+xVfYcSaxtAP+Hyo/k
         rz9B8sT4frwGPWWPZFCcTWCDudQswzLy0AP8zNS/5EoId1/vsTxJ4bPe2WXcZU472Mhb
         WyFA==
X-Gm-Message-State: AJIora/cztl3yb9qCJWE7Zr454gy6TY7o8Llm4dW9D3v4LsBnY2vb47m
        tX8jrLMZKR+T9hZfdDhc9dpfgOAYSlmDK6sG
X-Google-Smtp-Source: AGRyM1vXx9rmutRDA5SS9P9St/JLzRoyqqPUaFvCUXMjek6GzImjeJv6aLvsx6wLhxfVBEp3SVP4Pw==
X-Received: by 2002:a2e:98d5:0:b0:25a:7b9a:6a3 with SMTP id s21-20020a2e98d5000000b0025a7b9a06a3mr5305105ljj.399.1656009549815;
        Thu, 23 Jun 2022 11:39:09 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id a15-20020a056512200f00b0047f8ec3ca4esm964436lfb.87.2022.06.23.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:39:08 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 23 Jun 2022 20:39:06 +0200
To:     Lv qian <lvqian@nfschina.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] vmalloc:Merge multiple if conditional sentences
Message-ID: <YrSzSglchu/aErqQ@pc638.lan>
References: <20220623064527.4238-1-lvqian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623064527.4238-1-lvqian@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Merge multiple if statements to improve code readability
> 
> Signed-off-by: Lv qian <lvqian@nfschina.com>
> ---
>  mm/vmalloc.c | 66 ++++++++++++++--------------------------------------
>  1 file changed, 18 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index effd1ff6a4b4..6902a180f8f7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -135,22 +135,12 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
>  			unsigned int max_page_shift)
>  {
> -	if (max_page_shift < PMD_SHIFT)
> -		return 0;
> -
> -	if (!arch_vmap_pmd_supported(prot))
> -		return 0;
> -
> -	if ((end - addr) != PMD_SIZE)
> -		return 0;
> -
> -	if (!IS_ALIGNED(addr, PMD_SIZE))
> -		return 0;
> -
> -	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
> -		return 0;
> -
> -	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> +	if (max_page_shift < PMD_SHIFT ||
> +			!arch_vmap_pmd_supported(prot) ||
> +			(end - addr) != PMD_SIZE ||
> +			!IS_ALIGNED(addr, PMD_SIZE) ||
> +			!IS_ALIGNED(phys_addr, PMD_SIZE) ||
> +			(pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr)))
>  		return 0;
>  
>  	return pmd_set_huge(pmd, phys_addr, prot);
> @@ -185,22 +175,12 @@ static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
>  			unsigned int max_page_shift)
>  {
> -	if (max_page_shift < PUD_SHIFT)
> -		return 0;
> -
> -	if (!arch_vmap_pud_supported(prot))
> -		return 0;
> -
> -	if ((end - addr) != PUD_SIZE)
> -		return 0;
> -
> -	if (!IS_ALIGNED(addr, PUD_SIZE))
> -		return 0;
> -
> -	if (!IS_ALIGNED(phys_addr, PUD_SIZE))
> -		return 0;
> -
> -	if (pud_present(*pud) && !pud_free_pmd_page(pud, addr))
> +	if (max_page_shift < PUD_SHIFT ||
> +			!arch_vmap_pud_supported(prot) ||
> +			(end - addr) != PUD_SIZE ||
> +			!IS_ALIGNED(addr, PUD_SIZE) ||
> +			!IS_ALIGNED(phys_addr, PUD_SIZE) ||
> +			(pud_present(*pud) && !pud_free_pmd_page(pud, addr)))
>  		return 0;
>  
>  	return pud_set_huge(pud, phys_addr, prot);
> @@ -236,22 +216,12 @@ static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
>  			phys_addr_t phys_addr, pgprot_t prot,
>  			unsigned int max_page_shift)
>  {
> -	if (max_page_shift < P4D_SHIFT)
> -		return 0;
> -
> -	if (!arch_vmap_p4d_supported(prot))
> -		return 0;
> -
> -	if ((end - addr) != P4D_SIZE)
> -		return 0;
> -
> -	if (!IS_ALIGNED(addr, P4D_SIZE))
> -		return 0;
> -
> -	if (!IS_ALIGNED(phys_addr, P4D_SIZE))
> -		return 0;
> -
> -	if (p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr))
> +	if (max_page_shift < P4D_SHIFT ||
> +			!arch_vmap_p4d_supported(prot) ||
> +			(end - addr) != P4D_SIZE ||
> +			!IS_ALIGNED(addr, P4D_SIZE) ||
> +			!IS_ALIGNED(phys_addr, P4D_SIZE) ||
> +			(p4d_present(*p4d) && !p4d_free_pud_page(p4d, addr)))
>  		return 0;
>  
>  	return p4d_set_huge(p4d, phys_addr, prot);
> -- 
> 2.18.2
> 
IMO, it is more complicated to understand.

--
Uladzsislau Rezki
