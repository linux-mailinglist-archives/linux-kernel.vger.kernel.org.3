Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9904C5D23
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiB0QbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiB0Qaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:30:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA86D4FE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=OYI0DMvnPqa+60GAv7cFVpt7mnjohAntl6p3vksWtnQ=; b=DjcB7DVFVspRVXyu9GOKwXTCvJ
        PygxXcz+mHkNERbXGaHuaEQSQNGE07Sn6k1QKYNpfSGYgU/KVQ2DuhcSTSu9rx7whuoBbX5evQxrf
        jR+N49UQxf/Zc57YH1h3u4JyXE1En/66s32b2KQtbKaEfGrXqSlDQCaJtLcNrVoDOOsvhGFSFkli6
        7iQ4ANmjmBVIi4BlaUOWE28JQf7KdPkcJrWAzY82WMUplla8k/Hm/G9Js0oALjht1Aa6TCjMgCkRp
        V5LYwfTiElkwJK0DxmSvatO1l25IZyC0F+mRyJrGXyY+CG4ZKk0zE7SvQTHVHA20o98KTKL8CEOuf
        0k0RiJqQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOMQZ-00Db39-I2; Sun, 27 Feb 2022 16:29:43 +0000
Message-ID: <572369c5-85e4-75af-85f4-d150c25e75fd@infradead.org>
Date:   Sun, 27 Feb 2022 08:29:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/vmalloc.c: fix a comment
Content-Language: en-US
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220227084544.4681-1-caoyixuan2019@email.szu.edu.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220227084544.4681-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/22 00:45, Yixuan Cao wrote:
> Dear Sir/Madam,
> 
> The sentence
> "but the mempolcy want to alloc memory by interleaving"
> should be rephrased with
> "but the mempolicy wants to alloc memory by interleaving"
> where "mempolicy" is a struct name.
> 
> Thanks and best regards,
> Yixuan Cao
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>  mm/vmalloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b454cf1a261f..89d48d8eb20c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2905,7 +2905,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			/* memory allocation should consider mempolicy, we can't
>  			 * wrongly use nearest node when nid == NUMA_NO_NODE,
>  			 * otherwise memory may be allocated in only one node,
> -			 * but mempolcy want to alloc memory by interleaving.
> +			 * but mempolicy want to alloc memory by interleaving.

s/want/wants/
as in your commentary above.

>  			 */
>  			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
>  				nr = alloc_pages_bulk_array_mempolicy(bulk_gfp,

thanks.
-- 
~Randy
