Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C283468BC0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhLEP0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhLEP0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:26:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552CC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:22:51 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so8579083wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9rEahx2eGYTHy18kCwRl+ypwISPthXIudXILPZK+gmk=;
        b=XJo+1n6Y5eyLhaiDowlIN6GpjUZ4ep9GPiFvVkxauguigOzsSZW/eNxLzhMwKzmHCO
         BjxKBU8d6efJ2wGgpfELa/tEq80ZmOtLEb+dxoqOgxx30Et7PsQTSYm8x4OCOuI8QQtK
         3biPGl5mBx5WJkho6DUc1XUtUZAiGUN4JaEMOeOH+nOQJLCUb3Dqnrm5Vh5BD31aprj1
         0b1bITU+l9tJ3/iCwEgds5DchcP8DwBf69fXLjkt3QoQiqPtfFCZTFbU6b6TlOvCHrQD
         k3E22A4O+Lwrk9sliD27UFxq9BuqyDoUcgonWuqFvCl/E9qMbTeZMb5DRNYLmJejxwYJ
         UF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9rEahx2eGYTHy18kCwRl+ypwISPthXIudXILPZK+gmk=;
        b=ochPBxdBpeVXYkT/WgE/8CnpyCQ1haaGv2LFt34pueuBowQl7C11l6Xt/Lw5RH+oqT
         ZBEW2vdSiWKEvmSkThk3ARYdkMKfKd8H/d16SQzQLgrE3pjjnaGmBiYcNbpOmQncDYmc
         OOIIA3oI0ClZC2vtMyqMnOXifh8JeTEHaNmC+nKOpC5IhnNrsPu4b5dI/hHz9xjx+iPO
         rJFeUZt6RG/Regb2ypkZspYmHQtBZ2eeufFPHad6xzQ2qzYAArd4utd7jti7o7d6eqyu
         +v1VjTvMq55mKMp2YUYZZ6aH9yHuux4tqCYhOHih8SkUmYfWkhdIOMNwcxCMYBoGD83O
         v3uQ==
X-Gm-Message-State: AOAM5325WVwQAolrPCkwVMhIu2UVp/I+7crBi6btWwJjuh1sJ2jUA9Ey
        UVFit4kAEL95kIZZF9KbnW0=
X-Google-Smtp-Source: ABdhPJwjOMhpYjmJk8Dv4UtZ//nhj/kZ6EGmnIErXNUIEnYo1CTtI2GNTbX1qlWD3BBz+tTzL7BbYg==
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr30729607wmq.16.1638717769991;
        Sun, 05 Dec 2021 07:22:49 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::b792? ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id g13sm8136450wmk.37.2021.12.05.07.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 07:22:49 -0800 (PST)
Message-ID: <b3886219-9a24-c119-fe10-12e5e7c6b139@gmail.com>
Date:   Sun, 5 Dec 2021 16:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 12/12] staging: r8188eu: hal_data_sz is set but never used
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211205135919.30460-1-straube.linux@gmail.com>
 <20211205135919.30460-13-straube.linux@gmail.com>
 <197e167b-2225-3593-dab3-4f1f61331de9@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <197e167b-2225-3593-dab3-4f1f61331de9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/21 15:42, Pavel Skripkin wrote:
> On 12/5/21 16:59, Michael Straube wrote:
>> hal_data_sz in struct adapter is set but never used. Remove it.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/r8188eu/hal/usb_halinit.c   | 1 -
>>   drivers/staging/r8188eu/include/drv_types.h | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c 
>> b/drivers/staging/r8188eu/hal/usb_halinit.c
>> index 641aaf299109..da966538596f 100644
>> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
>> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
>> @@ -1969,5 +1969,4 @@ void rtl8188eu_alloc_haldata(struct adapter *adapt)
>>       adapt->HalData = kzalloc(sizeof(struct hal_data_8188e), 
>> GFP_KERNEL);
>>       if (!adapt->HalData)
>>           DBG_88E("cant not alloc memory for HAL DATA\n");
>> -    adapt->hal_data_sz = sizeof(struct hal_data_8188e);
>>   }
> 
> Not related to your patch, but not returning an error from this function 
>   looks very dangerous to me.
> 
> adapt->HalData is used in GET_HAL_DATA() macro all across the driver 
> code and nobody checks if it valid or not. If allocation fails here, 
> than we will likely hit GPF while accessing hal_data fields.
> 
> Maybe we can embed struct hal_data_8188e instead of storing a pointer to 
> it?

Rethinking my prevoius answer, embedding struct hal_data_8188e is the
better solution I think.

Regards,
Michael
