Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0517E4AFE85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiBIUd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:33:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiBIUdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:33:23 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4EC001F56
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:33:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 13so6446490lfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NF9zbk0D0Y3erel7tZF3i+ekloEMwIpuyMDBcQMQrrs=;
        b=VAJ1k7CK2/skYA9GXLBz/RAqXiI5gxRFVBlhzPK69YUu61yQixrpiX5/26987vS+36
         mjDMxhSVZbB796MA5caEVhDsz54JuTPC2Ywo0/5RAECuZmb6tBiEEf0mWYRsm8pPnv7F
         wLLgZ9e+YdDWiPzxK3tVORwM0tmanF3vBZS/1c37aeN/fADzQl3P0//yCmuTUrsDiQVu
         mnb2WsXlK0K/97JKKVeSHNROG3eIrJDJt0z/KcWss1AMHAshC5mZuprcF/Mj8Sqfu52X
         l+eKprVTBVJIM/+v5+G7EX2RluLMVDHeKWhWw4KOH9SinKxUzZnqYNW4oOeJ4rdv0Z/D
         Hw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NF9zbk0D0Y3erel7tZF3i+ekloEMwIpuyMDBcQMQrrs=;
        b=00roQIWZwglLBAMhKjwlWXrjJyOJ+0CUM6jaeirNxDG93gV1djvC7Wq8I5vOwwmyRC
         4FOxyBLv6lrlTPcuPsTIExdlhZpgL5swJrxGb9+336veTD+eUaUu2mGFX8vf/496EBbK
         OdIwpc9LBpFNywraQgDBxmd/nuM+U6noJHoCcAPPOXdXrdksT07EvPjzYwso4ii8M805
         2MJq57skR7ICbeUm2ZfhlOOA1m2cXZhVsaTjYm+/cAF8ZJfKqVQXAskNCTbspcaysukE
         daG2C5ePkzOA4MfKdH1Vk+Q7glqi6qepF/8dR0umR1xLWfYvIKTnr75AokP6sP8tBhQj
         1k3g==
X-Gm-Message-State: AOAM533D9PavGyIGSaa4OliY4yUIxM9cuS3/1aj5k5zboMN4SD28FOhr
        ZyLO9BZksfYmM+TLmYjpnbq1e3/6m1j5/Q==
X-Google-Smtp-Source: ABdhPJzi07lxSmAR55Homq9Mwd/SChq7a+ulh7a93B2AmGz1YTCq7kuawz0B+qaL7x64Xo3/oW41Bw==
X-Received: by 2002:a05:6512:3a88:: with SMTP id q8mr2858003lfu.349.1644438803823;
        Wed, 09 Feb 2022 12:33:23 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.154])
        by smtp.gmail.com with ESMTPSA id q28sm2508062lfp.272.2022.02.09.12.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 12:33:23 -0800 (PST)
Message-ID: <3448c8bf-a72b-803b-bb50-f5d74340d6db@gmail.com>
Date:   Wed, 9 Feb 2022 23:33:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Staging: r8188eu: core: Comparisons should place the
 constant on the right side of the test
Content-Language: en-US
To:     Leonardo Araujo <leonardo.aa88@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20220209202758.2940-1-leonardo.aa88@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220209202758.2940-1-leonardo.aa88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

On 2/9/22 23:27, Leonardo Araujo wrote:
> This patch fixes the following checkpatch.pl warning:
> 
> WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Leonardo Araujo <leonardo.aa88@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index a9a5453aa1cc..e236316188c1 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -618,7 +618,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
>   		res = rtw_enqueue_cmd(cmdpriv, cmdobj);
>   	} else {
>   		/* no need to enqueue, do the cmd hdl directly and free cmd parameter */
> -		if (H2C_SUCCESS != disconnect_hdl(padapter, (u8 *)param))
> +		if (disconnect_hdl(padapter, (u8 *)param) != H2C_SUCCESS)

Actually disconnect_hdl() always return H2C_SUCCESS. Looks like this 
check can be dropped completely

Unfortunately, we can't make it return void, since it's used as part of 
wlancmds array :(



With regards,
Pavel Skripkin
