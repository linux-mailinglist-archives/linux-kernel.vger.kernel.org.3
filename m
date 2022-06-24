Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D555A119
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiFXSro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:47:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24F81705
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:47:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d5so2805509plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EJ/rs91GRos3tFmq5ZNamdqFk2L/UuGhKzbbDsYJNtw=;
        b=qWB89vfGH1eZ6L6P3c9n1ivpU+TWzcjZSdX16pMXH01txP3FPQi+War7M31w2TLl34
         whyL8MHkzoAU0mmpCh3PFDdDQsnc+wBI+sjdGrzYTFJO8O+ngSkuPWOZGG4k2qF5Ws8I
         JasJZAIdLjBWosATm3BqRJGTtWLCFv4HPGGEBa81Z8s01sfdW6ydIDagXAZH6y4mn+yP
         9F/3KHbLswUuBDD5axQy7qtWFUlf9aXZKWRUhWkz71mfuOUphFJ5z0FeduDV4EfmkdJq
         jjHAGy9ENfKC6bOLcUv/tgitiur9wpENU0XPx/tYJDFgWoARzw6zRgiH27ZywOTfBusZ
         SRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJ/rs91GRos3tFmq5ZNamdqFk2L/UuGhKzbbDsYJNtw=;
        b=dcNEqBOJIx+/ceJkln+KxkA0NPpRqnYqtPM4Jj8eeltAXK0rtqIdsNMXaLWwos7vO3
         wWXUPR4f1JQR+OKYeQPQxnxE1Mb6P0O1Z66m1nD9vufTECwJ0OeFigc+w4NM6562hv7B
         kSwi53q5l18poEGj2coHqDR48I6O9UE2WDsGK8xqGvO1Xeg/KegQECT7l5exEzJ3YMpH
         ViXntSxzMCZ+GKm1CWfp+49ZCl4KdT1nV4qMtTWSRCOBcHHNWHDre0m9yujXXEo0xdcu
         s/FNTSafo0Di1lBcgRScVjCzXn1qy+o6LuQzbZkAh78+L22XyZ/qvWELq+3NFT0fZlwp
         72fw==
X-Gm-Message-State: AJIora82WIPU4HMyxiHf17tmTpooeyrLHKBOfhPP/3f4cFLU55G53bUu
        7qqSz8GVJyRggCVHCXlOune21LQWGBR5mg==
X-Google-Smtp-Source: AGRyM1t+kwMdSiXf0Ks06lYZdaX+jlwhDvq3Ij1wXRalOpgZ6rqgALtYqLbFm7JPfgOMfj26ASZ2mQ==
X-Received: by 2002:a17:903:245:b0:168:efbc:c10 with SMTP id j5-20020a170903024500b00168efbc0c10mr443245plh.71.1656096459617;
        Fri, 24 Jun 2022 11:47:39 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id 142-20020a621494000000b0052285857864sm2121661pfu.97.2022.06.24.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:47:38 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:47:34 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] mm/huge_memory: fix comment of
 __pud_trans_huge_lock
Message-ID: <YrYGxgXocKIx190t@google.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 01:06, Miaohe Lin wrote:
> __pud_trans_huge_lock returns page table lock pointer if a given pud maps
> a thp instead of 'true' since introduced. Fix corresponding comments.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 83fb6c3442ff..a26580da8011 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1903,10 +1903,10 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
>  }
>  
>  /*
> - * Returns true if a given pud maps a thp, false otherwise.
> + * Returns page table lock pointer if a given pud maps a thp, NULL otherwise.
>   *
> - * Note that if it returns true, this routine returns without unlocking page
> - * table lock. So callers must unlock it.
> + * Note that if it returns page table lock pointe, this routine returns without

s/pointe/pointer

> + * unlocking page table lock. So callers must unlock it.
>   */
>  spinlock_t *__pud_trans_huge_lock(pud_t *pud, struct vm_area_struct *vma)
>  {
> -- 
> 2.23.0
> 
