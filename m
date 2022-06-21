Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7065533F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiFUNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiFUNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:47:35 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3288B25292
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:47:34 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id l24so1744313ion.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xdWJmoRejUz+usfSLKb7xTPUz6NOCPSTvqf5z1FVOJ8=;
        b=u/kTnsf1La7YBmG43UjGEHCgCToSRc/Lc1X2KD921nzg+i32xzUUy9PIcl1Y7iUBog
         oD6QFdzlAtyHWEY9JEbgvORE02AsCEoGVypTvlcbjc16TKFM9XzkP8pPe7/P9YEXV5GE
         edAVDWB76/YYfOImIhTw1LgxKN8EFoWDv5xRJyjw4ioO7z5A4DRn5OP7cMnIUQKKtzf9
         ic/8qhjBloQphV1as0srTWKAGEZLX61tvhiBHLlHszr+Z6SJ1MMvn89uTZN+8w2jLSJb
         OhOBC96GVHxXxXheJUU1V1Q5f/IGGp6yFTSHhA18p4t2hMwyKZ6KyJmUWgK6jr2h9qvs
         YwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xdWJmoRejUz+usfSLKb7xTPUz6NOCPSTvqf5z1FVOJ8=;
        b=Ti0BuPsJ4t+LYv1W7aK1Zsqzh59uLtXxXU+iTm2qC7DWKBfmDCVQMq36rXUoTVMz1Q
         /N5nNC9mU7IcND9DRBos4M9DfWuj4xcqhcfEgqK+bn7w2yuILlNw2CiWQOJPTAiWpwsP
         9bz5OEjy2RSdeBgeg15oP3LBkPn36WH6+i2ccBpviltpFYxfM82DSTrhf0ktmrnF71lM
         nixHk3geEVy2EAyKbP3tbCqZATBZwdfut6OFiDDQc1CAfpbsG5lmhGs98RTfVZTs2iEk
         1AJpS1ttRnoiJ/uoQ9dlvNca7n/UUnyM9GKcVJ6tZHqOjvM3Qn7TqyTVA2b/H0D54nFH
         oYFg==
X-Gm-Message-State: AJIora8VjJqcE//sD3vJNHRq2lJxEzFSeB3EP6feLrmhiNogaC76OAYg
        ZiTRHrwucH6WLJRCQaxI2po+Gg==
X-Google-Smtp-Source: AGRyM1sbd72qqTReT8J49xfpU6Ltqk6Tv0BNo5NwR7vplQG1VOCUAf/C0JMNLiCLfB3X8nJ/RGtohA==
X-Received: by 2002:a05:6602:1696:b0:66a:d4d:e8c3 with SMTP id s22-20020a056602169600b0066a0d4de8c3mr14501356iow.48.1655819253333;
        Tue, 21 Jun 2022 06:47:33 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q1-20020a027b01000000b00334748f85easm7183302jac.106.2022.06.21.06.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:47:33 -0700 (PDT)
Message-ID: <1a81c73e-234d-0c7d-618a-a3bcf773f1b0@linaro.org>
Date:   Tue, 21 Jun 2022 08:47:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] net: ipa: remove unexpected word "the"
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220621085001.61320-1-jiangjian@cdjrlc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220621085001.61320-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 3:50 AM, Jiang Jian wrote:
> there is an unexpected word "the" in the comments that need to be removed

In the future, maybe something more like "Remove duplicate 'the'
in two places."

But regardless, this looks fine to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>   drivers/net/ipa/gsi_trans.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
> index cf646dc8e36a..29496ca15825 100644
> --- a/drivers/net/ipa/gsi_trans.c
> +++ b/drivers/net/ipa/gsi_trans.c
> @@ -339,7 +339,7 @@ struct gsi_trans *gsi_channel_trans_alloc(struct gsi *gsi, u32 channel_id,
>   	if (!gsi_trans_tre_reserve(trans_info, tre_count))
>   		return NULL;
>   
> -	/* Allocate and initialize non-zero fields in the the transaction */
> +	/* Allocate and initialize non-zero fields in the transaction */
>   	trans = gsi_trans_pool_alloc(&trans_info->pool, 1);
>   	trans->gsi = gsi;
>   	trans->channel_id = channel_id;
> @@ -669,7 +669,7 @@ int gsi_trans_read_byte(struct gsi *gsi, u32 channel_id, dma_addr_t addr)
>   	if (!gsi_trans_tre_reserve(trans_info, 1))
>   		return -EBUSY;
>   
> -	/* Now fill the the reserved TRE and tell the hardware */
> +	/* Now fill the reserved TRE and tell the hardware */
>   
>   	dest_tre = gsi_ring_virt(tre_ring, tre_ring->index);
>   	gsi_trans_tre_fill(dest_tre, addr, 1, true, false, IPA_CMD_NONE);

