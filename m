Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E8D468BB1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhLEPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhLEPSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:18:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A34C061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:14:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so16882703wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2/0APoaO2+RxAk+XbsfV9HVu43G2c1MKgB8KCbqjUUw=;
        b=Z0xbodD7b6pytjY+yYuxl4raiGU18/rJdLc5zdNGz4OqRK/KFjxgn3CFdTqpUFYu2i
         yO5/zpUd8AyGLtzGaxqiTlJopcu0HiURCef9ri4y5UjSUe2XpHbfvSvn0oN9qgqMi5K3
         EpFYE+LqGemf4Lmmga6sXqRNownqyegUEaiZ4WKHGIMG+wzI6chFV6kwuQ3a+G3ZSfNR
         jnKvwMXo3m54CXhjNCGrf2/3wtZaTvF0ELgJhu/HK5dIP2iXeFnxlggf5uYxvA6bWo5A
         k1gShPojNPMwoVTROZD2QNtH5+x5qgUJXr9SaDdgvTr8sOCGD/AD/H7PrHouW5suTmct
         +fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2/0APoaO2+RxAk+XbsfV9HVu43G2c1MKgB8KCbqjUUw=;
        b=vP6FWps8sOh38lT+7yMn/vx1tJdsU6GHlyBF8ecP5tI+UnzlGtqK2B64m5lfKufvb0
         YMECnWY4xZlVuxsabGXmnwB6wfW/KUAgX+lyT/pp4EmSKTMSMNg8aFAh0iFEjrR8JOTS
         afmuyl23LIx81JUdBkJiUvOhyMftqcX5kifes4AzPbesLt7VWOtS8QSJ6riEUwr5xSSz
         ScpIMOTAQQIXOPwnb7zt9HXDAXyXd9Nh4sgDTQ6CecM601/x0vSkbV/+6Nalrgrvr4sQ
         ezF9DFJwvy60M0MPBPzfSKWiPjDswHgQgqF2CHItWViomLQYIgVImOqa+VoSAgu4YVKe
         W61g==
X-Gm-Message-State: AOAM533APHgoHrF1Wcc4jiVf4d4lDzilVSbUt91CRS4wTsIhY2OPx0LO
        kwWkHm2xjOguMzAEfd8CYnA=
X-Google-Smtp-Source: ABdhPJw4y4Yj3l5J6oeNCBkQ5NolC2g/qkyvZGUvgQTKsQszDjGCLzy66Yo0KBNHrRoKp8BKhLAD8Q==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr5508754wrr.561.1638717280178;
        Sun, 05 Dec 2021 07:14:40 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::b792? ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id d15sm11551294wri.50.2021.12.05.07.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 07:14:39 -0800 (PST)
Message-ID: <663b392b-67a0-9ce1-6f32-158a72f3262a@gmail.com>
Date:   Sun, 5 Dec 2021 16:14:38 +0100
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

I agree.

> 
> adapt->HalData is used in GET_HAL_DATA() macro all across the driver 
> code and nobody checks if it valid or not. If allocation fails here, 
> than we will likely hit GPF while accessing hal_data fields.
> 
> Maybe we can embed struct hal_data_8188e instead of storing a pointer to 
> it?
> 
> 
> 

We could remove rtl8188eu_alloc_haldata() completely and replace its
usage in the function rtw_usb_if1_init().

--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -362,7 +362,9 @@ static struct adapter *rtw_usb_if1_init(struct 
dvobj_priv *dvobj,
         padapter = rtw_netdev_priv(pnetdev);

         /* step 2. allocate HalData */
-       rtl8188eu_alloc_haldata(padapter);
+       padapter->HalData = kzalloc(sizeof(*padapter->HalData), GFP_KERNEL);
+       if (!padapter->HalData)
+               goto handle_dualmac;

This way rtw_drv_init() would return -ENODEV if the allocation fails.
What do you think?

Regards,
Michael
