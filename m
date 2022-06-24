Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C91559B96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiFXOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiFXOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:34:24 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5338C4E3BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:34:23 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id t26-20020a9d775a000000b006168f7563daso2012545otl.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CjIdCdZWGFwSuc3oixIghf0c9pmC77enrG3S29aQdzk=;
        b=RisIJZG9CAXzvhjel+xoPaFykN4jy2Qs7nCO4uKlGR98zc6xtBpiv9OlIj4MJDJKYc
         SYE/WmMJwyiyfk0NMdna8DTHYuHzlhHPwTf/dcAFVE1sjpGD7v89NWIKSJ5t92uzQBEZ
         eBZvVlP8/VSvTFRik84w8DAChz/B5jHVOP9jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjIdCdZWGFwSuc3oixIghf0c9pmC77enrG3S29aQdzk=;
        b=LTa2JQie9PWLq+LT8hurfIrA+jNG/xh40pWItg1ByGY8LSrnQ+v+m36Z9jZ3SBVDeq
         NFRV45kiVpAbTbwYYSXd9wN5l5M4jh2AaMxQYphllB2fyZpSOncB9ZwIpqaFBf9bh6ZB
         LsZEnVOje4PdO1xlIsHEtAZ1t4EpxWHqIbTw/I5/KCW0mU40HueG/kR9hpwvctI97tvq
         L305Q2VvA0AiWXGyAxF0gU3ptVdNp1KxNd5sVdIP81QrB0RrFdeqe2GZ0cycBnqPD1yx
         ob6vaDkhGEohih7oAJoawMXidJx871xYJdc0ZaZq/FZyWZctbLGlRT6pIaqtImjLgcIn
         gBUA==
X-Gm-Message-State: AJIora8oS3p7nb+n+i/KZJ1E3j0L4XWxBHNVzBW7dRuK5y9AlNxvGkq5
        OW6z2pMO1p5wokk1o2wz+Foa9Q==
X-Google-Smtp-Source: AGRyM1sr1U0Q+MAMmwHVe4fuH4P4dltMP1c4GZfhQTtdyFkgESMympT4FHxQZkIXS4a9OageKAm5eQ==
X-Received: by 2002:a05:6830:246e:b0:616:ab52:7bce with SMTP id x46-20020a056830246e00b00616ab527bcemr1284775otr.143.1656081262597;
        Fri, 24 Jun 2022 07:34:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm1664963ote.9.2022.06.24.07.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:34:22 -0700 (PDT)
Subject: Re: [PATCH] cpupower: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>, trenn@suse.com
Cc:     shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220624065555.33345-1-wangxiang@cdjrlc.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5e787efe-6e78-59a4-61b9-7ece2ea1fde1@linuxfoundation.org>
Date:   Fri, 24 Jun 2022 08:34:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220624065555.33345-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/22 12:55 AM, Xiang wangx wrote:
> Delete the redundant word 'cpu'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>   tools/power/cpupower/bench/system.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
> index 40f3679e70b5..eb79dd9ac670 100644
> --- a/tools/power/cpupower/bench/system.c
> +++ b/tools/power/cpupower/bench/system.c
> @@ -37,7 +37,7 @@ long long int get_time()
>    * sets the cpufreq governor
>    *
>    * @param governor cpufreq governor name
> - * @param cpu cpu for which the governor should be set
> + * @param cpu for which the governor should be set

This is correct the way it is. It specifies the name of the parameter
and describes what it is.

>    *
>    * @retval 0 on success
>    * @retval -1 when failed
> 

There is nothing to fix here.

thanks,
-- Shuah
