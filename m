Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB3F514591
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356627AbiD2Jol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356676AbiD2Joa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:44:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF035AA9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:41:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8777F210DB;
        Fri, 29 Apr 2022 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651225271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLN93rTB7llJ/DviTuLPV8Vw8InbmxfO6KMnH2jX3Tg=;
        b=vNjNDSI2Wes8ONnaVEGXMqkr+7o8qgPdZ22+ueEmBrM1qo3apGIpHeHWQ0XaBqrb6krNld
        LpdM0USytIMix47Y9FPv2h6wkS09vRhtIFiKUDe7sRvZ9gIehJfIfTYNjK8gnwMT8yLT9q
        qlMKZ6OoCwXf5v8iRyJ6yCTtxtqzSQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651225271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLN93rTB7llJ/DviTuLPV8Vw8InbmxfO6KMnH2jX3Tg=;
        b=W/XlIb45DUWyXfJqS2V+DNIWA4NO+UI6p7qCWKXeqsPLz+BmjrTqOEEe4HcYZ/h8nvD6Y+
        CG1m+9HRo8Le/EAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5874113AE0;
        Fri, 29 Apr 2022 09:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PuvFFLeya2IHCgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Apr 2022 09:41:11 +0000
Message-ID: <6b31f436-5bfb-9d8f-9418-55036f342f2e@suse.cz>
Date:   Fri, 29 Apr 2022 11:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] mm: slab: fix comment for ARCH_KMALLOC_MINALIGN
Content-Language: en-US
To:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <fe1ca7a25a054b61d1038686d07569416e287e7b.1651161548.git.andreyknvl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 17:59, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> The comment next to the ARCH_KMALLOC_MINALIGN definition says that
> ARCH_KMALLOC_MINALIGN can be defined in arch headers. This is incorrect:
> it's actually ARCH_DMA_MINALIGN that can be defined there.
> 
> Fix the comment.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Thanks, added both patches to the slab tree.

> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 373b3ef99f4e..8cc1d54e56ad 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -190,7 +190,7 @@ void kmem_dump_obj(void *object);
>  /*
>   * Some archs want to perform DMA into kmalloc caches and need a guaranteed
>   * alignment larger than the alignment of a 64-bit integer.
> - * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
> + * Setting ARCH_DMA_MINALIGN in arch headers allows that.
>   */
>  #if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
>  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN

