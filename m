Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6243C55E72C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345526AbiF1Nzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiF1Nze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:55:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC5230542;
        Tue, 28 Jun 2022 06:55:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so12687045pjj.5;
        Tue, 28 Jun 2022 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=BDUJ/ka+kgkQoriSSldrNOaZy2Lthlgzh4tWOgyV1eg=;
        b=TTcVoKDwF/QDCDhip9ZNimV8pF3crRWHTJ3htHT9TRpOVaa0OEhUJsLWLYvjeHvfpg
         lW9Z3yjh68KgFUkH0zRbYLGF7frgorqrDpa1HhEfqJ1nobJRdob+22uuUqIQ3ep4PVIo
         jhUpbWBMfdxuSQNtUaAQVOeXBwitrScreoawp8isdXe9FKRtIJJSNvttP7nJDt7sDPuf
         WhuK5Du25kXZTZKE2PJmbepcoa+2woOeKOshq/vwP1QtGK3lziv+XJyuMgw5AnXIiTFp
         jlMvO2X/3hx/eAlZXAgXjZcM9637e9k5Fesr1sI38+PcTum0aI4YlXq4wl219KI9BCaF
         1DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=BDUJ/ka+kgkQoriSSldrNOaZy2Lthlgzh4tWOgyV1eg=;
        b=xYPzPBw9gQa79/+D0oplG6e4osCyT8bVrF6iUqX1V3+4VGYqQZMPOs3/9HIxgMbrQo
         n7yzZrhfSQ76vs103IptgXmfQnULBeh1+VIMZw8Dxmt6M/2wQw2xAN6qwdvBbyvfoZLY
         D/AXeTCZt4RUgu2npWO9xJfGiWQb5cF4777VjSgN2sQGOxmBVWa7yOPueloLekdqn1Xc
         kMqBLvf8u4j7gGPh90Su/CY6RLZKDw/ZqI9p6D9QUPk4u3YUULZZ9R8PYAJuMjbrqfga
         ruGxSYj589kSodL2D+mEvHDnAHOEs8C9WEGOiPBQBGWmNxFbteHmip1gr7o2DsKwx4/o
         yl+g==
X-Gm-Message-State: AJIora8L0nt5XcwX3u8BcBBDYbnihtgghhI8SXM7NnQ5FhIDdiZ/bggZ
        vO6ASKuNLM8GZF20+xT9uuo=
X-Google-Smtp-Source: AGRyM1tPf23++oTwJhdLzgnRQtVlTLSLIDsf8xfKQ5RuIU55wlphxpz/Eafpsh3K64XDOfBxVSFiXQ==
X-Received: by 2002:a17:90b:d86:b0:1ec:caca:170a with SMTP id bg6-20020a17090b0d8600b001eccaca170amr27829769pjb.94.1656424532909;
        Tue, 28 Jun 2022 06:55:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a09c600b001ec9ae91e30sm11594026pjo.12.2022.06.28.06.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:55:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c230ccdc-b20d-32a6-c3cb-715698d06945@roeck-us.net>
Date:   Tue, 28 Jun 2022 06:55:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Schspa Shi <schspa@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai
References: <20220628054539.33187-1-schspa@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: dw_wdt: Fix buffer overflow when get timeout
In-Reply-To: <20220628054539.33187-1-schspa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 22:45, Schspa Shi wrote:
> The top_val can be obtained from device-tree, if it is not configured
> correctly, there will be buffer overflow.
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>   drivers/watchdog/dw_wdt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index cd578843277e..1f8605c0d712 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -155,6 +155,9 @@ static unsigned int dw_wdt_get_min_timeout(struct dw_wdt *dw_wdt)
>   			break;
>   	}
>   
> +	if (WARN_ON_ONCE(idx == DW_WDT_NUM_TOPS))
> +		idx = DW_WDT_NUM_TOPS - 1;
> +
dw_wdt_get_min_timeout() returns the lowest non-0 configurable timeout.
The  last entry in the timeout array must not be 0, meaning there must
be at least one entry in the array where the timeout is not 0. Therefore
this situation can not happen.

>   	return dw_wdt->timeouts[idx].sec;
>   }
>   
> @@ -178,6 +181,9 @@ static unsigned int dw_wdt_get_timeout(struct dw_wdt *dw_wdt)
>   			break;
>   	}
>   
> +	if (WARN_ON_ONCE(idx == DW_WDT_NUM_TOPS))
> +		idx = DW_WDT_NUM_TOPS - 1;
> +

idx is derived from a top_val value written into WDOG_TIMEOUT_RANGE_REG_OFFSET,
and the value written is derived from an entry in the timeouts array.
This array contains an entry for each possible top_val. While the array is not
sorted by top_val, dw_wdt_handle_tops() still guarantees that an entry exists.

I do not see how bad devicetree data can circumvent that. If it does, please
provide an example and explain.

Thanks,
Guenter
