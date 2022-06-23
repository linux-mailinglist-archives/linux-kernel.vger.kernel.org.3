Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6339B557404
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiFWHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiFWHeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:34:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53546658
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:34:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso1754270pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p/+VGlu7EcyPo0XUSImIBdbWTMEq+6Oc052Qp24OKmY=;
        b=g87gZfYG/07FCtRHnX9zajUxqHETsSKV9iQC8Hu3BRmM5QH2sPaqsZtQWZyoQdy0Af
         7/5u8dUrmds+D2gmNVlLSTHao0aS9E6oGfMBm8NyCioPs2qeB9C8v5Dz/EJA291lW+0y
         J+a/FRmu5OIzvUL9mLUyELqNKdZcsSby8+KZW8/zr3yRmHNWfLMZ2ubjRhkW202cCKWZ
         AlRf+qYiL0WeiHHLj9GFWuM2fUnAX2R8G+vh+Oh8TK8sxZd8crx704NQ3M8MyOoyomZV
         h1cXsqaK/mhcm/h5cmB0uNPPS5IB9jmfvWQgvfbYdib3iaOOk0YgC+D1XWhy7QOYJFCi
         OYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p/+VGlu7EcyPo0XUSImIBdbWTMEq+6Oc052Qp24OKmY=;
        b=Z6l0LZN6Dxe6rW8eB0YHE5jd+DMaOayAEhjFDgWJRRrdGpHsheyuf8hzQ1NRrYBW51
         7rPoyiwx4/Rctr65rq172S0JhVZ61rgWMlkREHHKskzuaGbRUeZMkszO15g6rgqwm6s8
         i16L8D5RULaXj+dqGWSqi1jxPFCAdAaKBsaZldAbP6ySgES1/qHTBCioHp2eUX95nkQo
         lR7FNKAB9/DQ3FaKCrRg/Qebgkd5icuRHJFQ1W2hvNs4faORzc3P1XmgL6JKlF+YCu9X
         a14WBE93AncjhN3q9LEEwKONz3U67WqSxjskAB/u7juK/Fe+eO/bJ6uhIdSrC2p+CWuX
         EnXQ==
X-Gm-Message-State: AJIora8VKAo6uuhtLJXruugXnguOW8zmCWplKMHmafibuylj0cqqNd26
        ihHZGJ+KaZSAkQkRpZXjxgjOJ4gtdurNAVbAXQ0=
X-Google-Smtp-Source: AGRyM1tSACTTKI3laHGL+2owy3rlfPwq/RCCBXQ5Ok3ck5BShESEmK+hmWIHJAgEEJyCzFb92o2f7w==
X-Received: by 2002:a17:902:d5ce:b0:167:6c02:754c with SMTP id g14-20020a170902d5ce00b001676c02754cmr37379325plh.135.1655969655789;
        Thu, 23 Jun 2022 00:34:15 -0700 (PDT)
Received: from localhost ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090a564700b001ec2b1b7d8asm1100466pji.10.2022.06.23.00.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:34:15 -0700 (PDT)
Date:   Thu, 23 Jun 2022 15:34:11 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Lv qian <lvqian@nfschina.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com
Subject: Re: [PATCH] vmalloc:Merge multiple if conditional sentences
Message-ID: <YrQXc+KUhC1Z3nnT@FVFYT0MHHV2J.usts.net>
References: <20220623064527.4238-1-lvqian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623064527.4238-1-lvqian@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 02:45:27PM +0800, Lv qian wrote:
> Merge multiple if statements to improve code readability
>

Hi Lv qian,

Why do you think it is more readable? For me, the original one
is more readable than yours.

Thanks.
 
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
> 
