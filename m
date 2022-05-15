Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C425279EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiEOUfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEOUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:35:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA0FD35
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:35:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so9839935wms.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l7yzdPWP9oJM8k+dt6SbrPRUqaxJOT+vLQ0kaYXYGIc=;
        b=CfeyHbLqe3DOG6Rp9HJfMomA38jRORPLC1I7vYd2YICmjRiR4K4Wh+5Hn+IWHTylv2
         nwjhKxkrn+SJ3+y5yjcwIcHkB1nKiaEjWYChGRHGP8g+n0ocpj/K05BaCcuZetf0kZF7
         mM7klvbV4zhq71O7qbFNCR9Jct8L5M1XRBeGfotY9FfSsoTJXc4YtsetZ4H/sL2L1IUf
         uXlsGoCgwvBzs6Y8ETA6jpfU9fRV/UDVK4Pr1ShUi991IwsHmIAcJFFEi9+0YvaCzLJ3
         jYQmup4YQ3COrHsDE4iGOCo8v5N8jD8O//cUfBgr929Sg79o28/S21mE1khmDPFYc8Ys
         aYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l7yzdPWP9oJM8k+dt6SbrPRUqaxJOT+vLQ0kaYXYGIc=;
        b=zCh/YjpK+KW25vBMkHlJOYkkLlWYSqKR/JI7WbBlKJLCtb/bjW8MNyzAZ4VgmoIhC2
         xNUCABdMME9DxU4FrgDh1UUV9YxtsCik2fSZ2XLvA9Ils5oGM7kQ1DxZ6PGPsB17AOxJ
         Mrmx+f1h7WHI+KaIfYKIqLqzbf3lPivWg5NAZOwXGcdrALbzxPcz2imq1gRnEPSc1a/T
         C0102A7GMUWh1xuZ4kBCCaGDUNXTCcprq2bEz18YMEFeyMNGPGZUgwnl00UEz13beNPK
         4kkgnj6rVSyqqtpBQYgbrKHI/7KsMKixP2vPDn+7HVJbO+GVNI6iloR5mSyCVZxA3SDu
         I/oA==
X-Gm-Message-State: AOAM532p3qKPRztrRc+UZPz8wdxmMi9D8ZMe5vlzTrzx955bfYc4cTKI
        r24wDs/DPrVsVWruDbEmRfp28s3m9yg=
X-Google-Smtp-Source: ABdhPJx7i5LUMAYFSRbrqwFRUOMEWyj8ZLAYg9JWtTsxoL1UBEnyY3RCo03bQJ0r7Z1CvxJCK00+7w==
X-Received: by 2002:a7b:c001:0:b0:394:87bc:ad70 with SMTP id c1-20020a7bc001000000b0039487bcad70mr24710869wmb.147.1652646949662;
        Sun, 15 May 2022 13:35:49 -0700 (PDT)
Received: from [192.168.1.20] ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id m18-20020adfa3d2000000b0020c5253d8ffsm7736509wrb.75.2022.05.15.13.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 13:35:49 -0700 (PDT)
Message-ID: <6e0029f6-f499-c688-9174-61409180eae5@gmail.com>
Date:   Sun, 15 May 2022 22:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ep93xx: clock: Do not return the address of the freed
 memory
Content-Language: en-US
To:     Genjian Zhang <zhanggenjian123@gmail.com>,
        hsweeten@visionengravers.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>
References: <20220512075943.2397833-1-zhanggenjian@kylinos.cn>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20220512075943.2397833-1-zhanggenjian@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Genjian!

Thank you for the patch!

On 12/05/2022 09:59, Genjian Zhang wrote:
> Although there will be basic judgments of IS_ERR() on this return value
> elsewhere,but I think it can be replaced by the actual error return
> value of clk_register.

Actually this fixes very similar use-after-free which I missed in
commit 9645ccc7bd7a1.

I propose to add
Fixes: 9645ccc7bd7a1 ("ep93xx: clock: convert in-place to COMMON_CLK")

> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>  arch/arm/mach-ep93xx/clock.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 4fa6ea5461b7..762328de4bce 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -345,9 +345,10 @@ static struct clk_hw *clk_hw_register_ddiv(const char *name,
>  	psc->hw.init = &init;
>  
>  	clk = clk_register(NULL, &psc->hw);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
>  		kfree(psc);
> -
> +		return (struct clk_hw *)clk;

Could you please use ERR_CAST()?

> +	}
>  	return &psc->hw;
>  }
>  
> @@ -452,9 +453,10 @@ static struct clk_hw *clk_hw_register_div(const char *name,
>  	psc->hw.init = &init;
>  
>  	clk = clk_register(NULL, &psc->hw);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
>  		kfree(psc);
> -
> +		return (struct clk_hw *)clk;

same as above

> +	}
>  	return &psc->hw;
>  }
>  
