Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C65835D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiG1AAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiG1AAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:00:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1ABCBD;
        Wed, 27 Jul 2022 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WTkGwzy7iFB5CID6XuwVfQXOKDRWcxWpB3w1MB3wbdc=; b=rMmanMomRUROJ4Z73WFcyYvy9S
        iYJU9TXa4jwnNZrijkl2WsLwgPRBJ9DbZ74am8ccJijDET+oJYwujiT9W9W2Lz0jz4KvkTqzpQKsg
        nSA9B4Tq9g+eGFnI9dPimfqpKZdAzIJ7wJHzw7CSkVrvVM10Ki9AVqVGg0wt2atEN8a443Z7/mVp9
        rJR1tSIoDdNr6iWaGlVBDkMihOrawFcpYAypDH2lbBMHNLb9A4Ek5VRqOC/wkvVlmscqEMKFwuS3i
        dY6Ss0xoXJeHyHTmlftZ4CzolwHqa4oIw3xt+sZbBCx8amznu4YlD2I57VEJE1sAW9bmZIa+ZLf5T
        pSPNQqag==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGqwo-001hzo-1q; Thu, 28 Jul 2022 00:00:14 +0000
Message-ID: <08da326f-3fe4-3342-bce8-bbd94bf8be97@infradead.org>
Date:   Wed, 27 Jul 2022 17:00:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] mm/kfence: Introduce kernel parameter for selective
 usage of kfence.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, glider@google.com,
        elver@google.com, dvyukov@google.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20220727234241.1423357-1-imran.f.khan@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220727234241.1423357-1-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/27/22 16:42, Imran Khan wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 98e5cb91faab..d66f555df7ba 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5553,6 +5553,11 @@
>  			last alloc / free. For more information see
>  			Documentation/mm/slub.rst.
>  
> +	slub_kfence[=slabs][,slabs]]...]	[MM, SLUB]

I suppose that 'slabs' are by name?
How can the names be found?  via 'slabinfo -l' or 'ls /sys/kernel/slab/' ?


It seems to me that the boot option should be listed as s/slabs/slab/.
I.e., one uses 'comma' to list multiple slabs.
Or is there a way for multiple slabs to be entered without commas?

> +			Specifies the slabs for which kfence debug mechanism
> +			can be used. For more information about kfence see
> +			Documentation/dev-tools/kfence.rst.
> +

thanks.
-- 
~Randy
