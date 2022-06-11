Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDE4547135
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbiFKCCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKCCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:02:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350921F99A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:02:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKgzK18VGzjXV2;
        Sat, 11 Jun 2022 10:01:01 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 10:02:01 +0800
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220610101258.75738-1-david@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c68a6c6c-2e3d-73e3-8aec-725477617925@huawei.com>
Date:   Sat, 11 Jun 2022 10:02:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220610101258.75738-1-david@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/10 18:12, David Hildenbrand wrote:
> There are certainly a lot more files that partially fall into the memory
> hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
> and mm/page_alloc.c. Let's only add what's almost completely memory
> hot(un)plug related.
> 
> Add myself as reviewer so it's easier for contributors to figure out
> whom to CC.

This really helps. Thanks! :)

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..77aebce76288 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
>  F:	mm/
>  F:	tools/testing/selftests/vm/
>  
> +MEMORY HOT(UN)PLUG
> +M:	Andrew Morton <akpm@linux-foundation.org>
> +R:	David Hildenbrand <david@redhat.com>
> +L:	linux-mm@kvack.org
> +S:	Maintained
> +F:	Documentation/admin-guide/mm/memory-hotplug.rst
> +F:	Documentation/core-api/memory-hotplug.rst
> +F:	drivers/base/memory.c
> +F:	include/linux/memory_hotplug.h
> +F:	mm/memory_hotplug.c
> +F:	tools/testing/selftests/memory-hotplug/
> +
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> 

