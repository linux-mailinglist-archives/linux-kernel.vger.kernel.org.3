Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4241515ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241418AbiD3GoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiD3GoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:44:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48315729;
        Fri, 29 Apr 2022 23:40:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso3612293pjb.5;
        Fri, 29 Apr 2022 23:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YUPwNyLPHZa5hixR22g0azdeZ0E7hPm3LgYZIKLMpT8=;
        b=bkPrR2BfpZPU4Yu0AR4GZ+CO51ixoWTwtHQXvYiGDUWhQTs7gvg3cmFJFlfhzhA+CM
         twJEMlI15VquADfqF+puE7B5xiS2eCIYdyhjU2z61J9+7fkOP/sr9oob+rV+Z/krmcSw
         ROlEkTITVuKWQKFjGgz6K7be42DKVBhTlNx69obnZ1cUcK8QLxVwb82NouQ/Xzokr5WH
         HiBgerP+FFeHZjPqMhq323P5cxdQ1S+gNiJQosuzh++Rb7eryiRh+eboxSyCpUH5Bvkt
         kbD2xlFIOSKOizGEol/hr5wJ0KLRU4NDy+SBGuEoJBbfkp5L0UrYKC3oGNxNKjYsSw1/
         AkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YUPwNyLPHZa5hixR22g0azdeZ0E7hPm3LgYZIKLMpT8=;
        b=3IH8BooiztmOMZaafefv1AMErOEtU10fFLFmUlKYkSLPlmrPae5L5DHxHN7dgkCxUg
         RXfvy6GXLTSJPlN2LEDCtxz5ycU7wKuIyCiethmje9fv/3i5MefafHxTCQI5lzmKL9mw
         7bRfhTflkYiadbtXszeBgzsuFyRsVTVQeokrj+2K5tonpVByQutNgEbQqCCStdyiKCzk
         nZWWwj97jrR0X8sXyXXr1FppZ5qT6fCf5GT3Irl3ln/w0a3E8CITrsw6ar9NMHO7eyJB
         ni50W4TYPafX9QJ7XtPT29Y0AzQoSVAfBJzKErU55wm+XYfJx4mlXvXVCW4T2oKvSvv8
         O9sA==
X-Gm-Message-State: AOAM530FF1ShwMyRrVjAqzAYNOmRPO08080+k0Y7y9v+4PX3a+eKvWVE
        5eAyvzTa8r4NJ352rmIgbhU=
X-Google-Smtp-Source: ABdhPJyIhwHiAu4ro7z/6oK62fjkTk/fsSZ9nE+GX3E78EqQ7XBTHXDjQ0Yx8w3WXCWECK6oGJxcbQ==
X-Received: by 2002:a17:90a:bb8f:b0:1d9:650e:10f5 with SMTP id v15-20020a17090abb8f00b001d9650e10f5mr7716611pjr.148.1651300847853;
        Fri, 29 Apr 2022 23:40:47 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b0050dc76281c6sm747905pfo.160.2022.04.29.23.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 23:40:47 -0700 (PDT)
Message-ID: <ea37d4f9-26e2-272a-01d6-fa7e8c62687e@gmail.com>
Date:   Sat, 30 Apr 2022 15:40:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and
 Describe details using table
Content-Language: en-US
To:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, baihaowen@meizu.com, seakeel@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        caoyixuan2019@email.szu.edu.cn, yejiajian2018@email.szu.edu.cn,
        yuhongf@szu.edu.cn
References: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/04/30 3:19,
Shenghong Han wrote:
> Some syntax errors exist in "page_owner.rst". Thanks to Akira Yokosawa and
> Haowen Bai for tips to help improve the documentation.
> 
> We try to fix them. Hope that the Documentation is showed as we expect.
> 
> Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
> Fixes: edc93abbcc6d ("tools/vm/page_owner_sort.c: support sorting blocks by multiple keys")
> 
> ---
> Thanks Jonathan's suggestion.
> 
> This fix is a simpler than before.
> And yes, It has built in my machine.
> 
> Best,
> 
> 	Shenghong Han
> ---
> ---
>  Documentation/vm/page_owner.rst | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 25622c715..0ecb4a739 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -171,11 +171,12 @@ Usage
>  
>  STANDARD FORMAT SPECIFIERS
>  ==========================
> -::
>  
> -For --sort option:
> +1) For --sort option.
>  
> +	====		==========	===========
>  	KEY		LONG		DESCRIPTION
> +	====		==========	===========
>  	p		pid		process ID
>  	tg		tgid		thread group ID
>  	n		name		task command name
> @@ -183,14 +184,18 @@ For --sort option:
>  	T		txt		full text of block
>  	ft		free_ts		timestamp of the page when it was released
>  	at		alloc_ts	timestamp of the page when it was allocated
> -        ator            allocator       memory allocator for pages
> +	ator		allocator	memory allocator for pages
> +	====		==========	===========
>  
> -For --curl option:
> +2) For --curl option.
>  
> +	====		==========	===========
>  	KEY		LONG		DESCRIPTION
> +	====		==========	===========
>  	p		pid		process ID
>  	tg		tgid		thread group ID
>  	n		name		task command name
>  	f		free		whether the page has been released or not
>  	st		stacktrace	stack trace of the page allocation
> -        ator            allocator       memory allocator for pages
> +	ator		allocator	memory allocator for pages
> +	====		==========	===========

So, I have actually tested this.

Are you OK with the look of

  1) For --sort option.

and

  2) For --curl option.

in generated HTML or PDF docs?

In literal blocks, you would see double dashes of "--".
Now they are converted to so-called endash, which is a single dash
slightly longer than a normal hyphen.  It looks confusing to me.

To remedy this, you need inline literal markers of

  1) For ``--sort`` option.

and

  2) For ``--curl`` option.


By the way, this patch changes ":" to "." at the end of them.
Are they intentional changes?  If so, why?

        Thanks, Akira
