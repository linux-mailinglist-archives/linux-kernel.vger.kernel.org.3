Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3C4B5840
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356968AbiBNRPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:15:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356955AbiBNRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:15:02 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A86517B;
        Mon, 14 Feb 2022 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hP69zmrWln9sFp7Qn5hjhCDPMAmpxl21/+2CAr0FVmk=; b=XKfMu41RkWGyY5mb/9G3tmIk47
        8JTbiKP7RW4K4/rpJp1J/ILdUowIsBPs8Ik+styTlQXecQm9GnwayqvI0BOYZhE9MeOtVORpxgkHc
        DIjgvxrqLvH48oGEIvZq/V8tjlFN99N2FL3riVobl4QtdRn+5t02PtaMGuoZAP6SEq5RvuzMAH8Bj
        xSev9fNxt81gmt+bwMV46+PjodHxLUQyEbY6YBXI1wfmptWbGWAyzitndflH+G2I75A8joVrrQWe8
        BL7wfrAHbmR9Yt+3Orvt9YNke7lJpZH3xweA4d13MPTmQT9Mh39fwbu2IKfUR9WOpe0Dct7ZjMPDC
        15CAaiOQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJew0-009xHr-2G; Mon, 14 Feb 2022 17:14:44 +0000
Message-ID: <918fe170-51ef-e214-4620-3a82b425965c@infradead.org>
Date:   Mon, 14 Feb 2022 09:14:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] block: Fix non-kernel-doc comment
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, rafael@kernel.org
Cc:     pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220214091522.100669-1-jiapeng.chong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220214091522.100669-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/14/22 01:15, Jiapeng Chong wrote:
> Fixes the following W=1 kernel build warning:
> 
> kernel/power/swap.c:120: warning: This comment starts with '/**', but
> isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The diff looks OK to me, but the Subject is quite misleading.
There are no "block:" patch contents here, just "PM:" or
"PM: hibernate:" according to
$ git log --oneline kernel/power/swap.c

> ---
>  kernel/power/swap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 6c4f983cbacc..91fffdd2c7fb 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -88,7 +88,7 @@ struct swap_map_page_list {
>  	struct swap_map_page_list *next;
>  };
>  
> -/**
> +/*
>   *	The swap_map_handle structure is used for handling swap in
>   *	a file-alike way
>   */
> @@ -116,7 +116,7 @@ struct swsusp_header {
>  
>  static struct swsusp_header *swsusp_header;
>  
> -/**
> +/*
>   *	The following functions are used for tracing the allocated
>   *	swap pages, so that they can be freed in case of an error.
>   */
> @@ -170,7 +170,7 @@ static int swsusp_extents_insert(unsigned long swap_offset)
>  	return 0;
>  }
>  
> -/**
> +/*
>   *	alloc_swapdev_block - allocate a swap page and register that it has
>   *	been allocated, so that it can be freed in case of an error.
>   */
> @@ -189,7 +189,7 @@ sector_t alloc_swapdev_block(int swap)
>  	return 0;
>  }
>  
> -/**
> +/*
>   *	free_all_swap_pages - free swap pages allocated for saving image data.
>   *	It also frees the extents used to register which swap entries had been
>   *	allocated.

thanks.
-- 
~Randy
