Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5625986AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343949AbiHRO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbiHRO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:59:01 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A9137190;
        Thu, 18 Aug 2022 07:58:45 -0700 (PDT)
Date:   Thu, 18 Aug 2022 22:58:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660834723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUxQG9E/JOlLTHeBkFAkSNSYI+XFzfu1BhI66/Ss6h8=;
        b=unUva2CYC3tZebs7tkMt9Ffula7ZWOGCQLK37/XZ5AZnb61zjY/+vOWxI3M8w8JjezSyFi
        FhsLycP3A8/YMYaBPV9OqqDJ+9f++Iw3adlE83tlIhPFDZ6C4udmZ7nNM693FSWS+FYgyH
        oEdVjpXuSnJgbwx2Nf9b09LRonJaOGQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 02/13] docs: update vmemmap_dedup.rst reference
Message-ID: <Yv5TimOuTK45ZHyH@bobwxc.mipc>
References: <cover.1660829433.git.mchehab@kernel.org>
 <2c81bc7ef207f0a84387a5d714601513f4bf1960.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c81bc7ef207f0a84387a5d714601513f4bf1960.1660829433.git.mchehab@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

话说 Mauro Carvalho Chehab 于 2022-08-18 (四) 15:38:48 +0200 曰过：
> Changeset ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> renamed: Documentation/vm/vmemmap_dedup.rst
> to: Documentation/mm/vmemmap_dedup.rst.
> 
> Update its cross-reference accordingly.
> 
> Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Wu XiangCheng <bobwxc@email.cn>

Thanks,

> ---
> 
> See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/
> 
>  mm/hugetlb_vmemmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 25bd0e002431..b8fc23c8763f 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -16,7 +16,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>  
>  /*
>   * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
> - * Documentation/vm/vmemmap_dedup.rst.
> + * Documentation/mm/vmemmap_dedup.rst.
>   */
>  #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
>  
> -- 
> 2.37.1
> 

-- 
Wu XiangCheng	0x32684A40BCA7AEA7

