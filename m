Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1F522FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiEKJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiEKJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:53:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6AE64BEC;
        Wed, 11 May 2022 02:53:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so1424748plg.0;
        Wed, 11 May 2022 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d6SNw7JdSd6YtqFOPSVjKfAM018aUOIgVKdJnsWRVAg=;
        b=j/zPYQHw6XkZjVsgr8yLdt96ocmxBES/LAbGknCM9omFXYneOIkEJzeFlXsnUWxCLr
         iZ30x78kT6Boe7sJbe7xE+mLoL59YTxD/W1gNWKnGGKdvSmQnCLmnGp5gEaihZfSpEtF
         lB7aWWfVwf/SSz1MnGLsmbsED/+pp0pXFguz44G2ylLDhpejvDQ3AGMN9VL6qqOkSjWU
         4jGv9tDWR6Di360+9K0rgG9xBd99jrCu9qEKzUosYdTbrUyrSU2+PQ6Ga4YMZ1/rtZ1g
         jQ7oP9mKvoxiYiCpSl7MliYs4l5FVjNOSG6uG6jNkGKHUHiHNIZTElj8G7K5u9xP29ze
         GCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d6SNw7JdSd6YtqFOPSVjKfAM018aUOIgVKdJnsWRVAg=;
        b=W7R/d4izVCaK+Us13m0/g36xmjx+WBuRAyM7qUVTtmiWus7EnInaiBYVrVMNQSxrOC
         u/dl4eXhdFHtYi+5p1jd9B+f63rfcKkTye7ScLTGnmA0lDAadrtQtedN/9tJPEtAKUCl
         Ybj/1dyd0z/RHYTlc6Hchcj8KCklHFj35bdHkV/IZoNM5GFJmG4kFJqIi4WWwGf4Cvze
         8XgV38j1rec6kwKvOMXXVTzgz9sm3y5qK6CTVm4PPoVyNePv/94/rP87JF9AS96zQKbX
         5WTb9k0/r+WSfWL169t9/P59Mbt3AUe/67zB48e/dzpr4wiQJBrHbwgBMAfMAFsknbUj
         Z4zA==
X-Gm-Message-State: AOAM530LFDUD2n3qiz5LQkvVTp+ooWIN9URA9H4W+2Bozs0K/o4FUDos
        cjCKBPxheBTlkJH+NVTJQCU=
X-Google-Smtp-Source: ABdhPJwKMvveyhIS3/YJMLTEUy3+hqo9uHwfupeI0+Sztae7K++crQ68YYeZlhYT5ofoy1JlqhK+zg==
X-Received: by 2002:a17:90b:4d8b:b0:1dc:c94f:fc29 with SMTP id oj11-20020a17090b4d8b00b001dcc94ffc29mr4406702pjb.186.1652262779607;
        Wed, 11 May 2022 02:52:59 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015e8d4eb1d5sm1320481plk.31.2022.05.11.02.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:52:59 -0700 (PDT)
Message-ID: <19d97a67-6941-1e78-1670-94ec4b1ce96c@gmail.com>
Date:   Wed, 11 May 2022 17:52:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] MAINTAINERS: Become the docs/zh_CN maintainer
Content-Language: en-US
To:     Yanteng Si <siyanteng@loongson.cn>, corbet@lwn.net,
        alexs@kernel.org
Cc:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        siyanteng01@gmail.com
References: <20220511094633.2002194-1-siyanteng@loongson.cn>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <20220511094633.2002194-1-siyanteng@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/22 17:46, Yanteng Si wrote:
> It's time to become a maintainer of Chinese documentation, and Yanteng's plan
> is to help everyone with the utmost enthusiasm and patience.

Welcome to your great commitment! :)

> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Reviewed-by: Alex Shi <alexs@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e8c52d0192a6..74969c0a60ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4619,6 +4619,7 @@ F:	Documentation/dev-tools/checkpatch.rst
>  
>  CHINESE DOCUMENTATION
>  M:	Alex Shi <alexs@kernel.org>
> +M:	Yanteng Si <siyanteng@loongson.cn>
>  S:	Maintained
>  F:	Documentation/translations/zh_CN/
>  
