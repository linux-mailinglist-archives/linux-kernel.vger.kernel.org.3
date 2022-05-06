Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA4051D0AD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350145AbiEFFcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389164AbiEFFc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:32:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994C21A6
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:28:45 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q130so8009197ljb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=scIm3CmTcO2KWT8ZS2Lbs/SBUHl3LpCFTjgnQ50RNcM=;
        b=iReOINUwgI5fjw9uLnS9nrkugE8XgtvpsqZHUH8etxUkC/+1lEb2/3OQHo9HYyAPY6
         5wrKVVNLGX8zJtaAJ4ahMBKt1zldC0LS7iklMTBIvnQpXgQeWmafWys47Dk8iUFQ0b70
         q+m3qy1CPLd8Q0MILOIDVnuwYOnQ5uswRBHEF3MQfOecmY1lizBbpjNWWPTB/IfJTJQ3
         CaaMeAVnyhz7Wuy9oK3KeQAJ9UqptkGMHBXZSyGKvzapNFKnC06jZwAen4cJKQDx8tJ0
         qPABidbtv0UpQPk4UXkpKDnYb/jyqVc9v0zhHnlofBqP1C3bqLOutv3Vsa7Apy4KJ+AP
         zqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=scIm3CmTcO2KWT8ZS2Lbs/SBUHl3LpCFTjgnQ50RNcM=;
        b=jKk2uRzJWpMUU36PHDFCsx5FT57NEB0OADkVe92anGxIaZ2t14tuo0UpyJbTqFMpJ2
         czGybvPbaiKGYv6MfW7voQa7RyHGG6oDBdrA8+X3yCY3/33nO2rDX17U5nu341TbPzwA
         yzN43emyL5T7zGl1ezx/58XEonqgtqVoNb1Ixixr/H9QEtaaNbmxzfYpFpNIsXW4Ujlu
         g+tD0ToRawmo/KuAS2ouwxTFqFHUyGE/zOOBoMrevfruQPDKapz4fyQCyMVriya4CrQM
         DHgWJg3MnFFEqamJw2epPY0ECj91B6ZlxFIFCpq/eTSBBTS456sfifQSoHbG80d3f7Vh
         4BOA==
X-Gm-Message-State: AOAM530OgZzJLRNbIR2rjf60zHC/tsunK0yN6kr4onSjBToOZ4aNWUDQ
        LduWLwWjIPZpNPyRXotZRMKTTPABrnBgOg==
X-Google-Smtp-Source: ABdhPJwGSEAQ6xvanTtv71aNh7zGc7VXptad97QwybH6OpORRLZgIhBvpZ1pXnYdxx91OGqVdLRlfQ==
X-Received: by 2002:a2e:9d46:0:b0:24c:7f32:869e with SMTP id y6-20020a2e9d46000000b0024c7f32869emr972794ljj.348.1651814923274;
        Thu, 05 May 2022 22:28:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:9cae:8c00:9682:e720:334f:2fac? (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id c2-20020a05651200c200b0047255d211ebsm517606lfp.282.2022.05.05.22.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 22:28:42 -0700 (PDT)
Message-ID: <e3861491-74f0-1d83-fef7-9086a9ae0fdc@gmail.com>
Date:   Fri, 6 May 2022 08:28:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4] kernel/crash_core.c : remove redundant check of
 ck_cmdline
Content-Language: en-US
To:     lizhe <sensor1010@163.com>, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@redhat.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220506043226.125611-1-sensor1010@163.com>
From:   Kari Argillander <kari.argillander@gmail.com>
In-Reply-To: <20220506043226.125611-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.5.2022 7.32, lizhe wrote:
> At the end of get_last_crashkernel(), the judgement of ck_cmdline is
> obviously unnecessary and causes redundance, let's clean it up.
> 
> Signed-off-by: lizhe <sensor1010@163.com>

Signed off by should be real name. Greg ask this already, but you did
not ever answer [1].

[1]: https://lore.kernel.org/lkml/Yi2nfjH7aph6CuiX@kroah.com/

> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Philipp Rudo <prudo@redhat.com>
> ---
>   kernel/crash_core.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6db573c..c232f01a2c54 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -222,9 +222,6 @@ static __init char *get_last_crashkernel(char *cmdline,
>   		p = strstr(p+1, name);
>   	}
>   
> -	if (!ck_cmdline)
> -		return NULL;
> -
>   	return ck_cmdline;
>   }
>   
