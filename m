Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560B148270C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiAAIVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiAAIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:21:51 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A0C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:21:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso15664571wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DdSGUrU0vDXWE8xHPpRJcvlPrMSiSNmqC4Sg59d2jto=;
        b=HzRL4mXV15RjNFLwwU5utndwUtSzdeE8JtqCOHWm7oPE3QkAFbHziOf0ruUC6iAzNm
         zwJOf1OvLvcA50qkVyLWJbydx5f494L7wx0Z6uWxdqu2AobHa5Y3mgCr4Xb87FG63oCb
         ii1VidHK/IHmcrVsCZfV1pXK9l0XFHCem24JuZbZ12tsJKfEcaa3/Cra43vUA+n9Qiiu
         1fIsSPojN6NDdW9zfUOrfjQjJ5Fc1jTNyfFalqYCEH60EGBL3rWmSEKVOYm2M4szoD0r
         ICtUrryD6Z5hJlH2b2ZL3X+T3GDtMccCC27QaAs1HdbCYcQUraifgux2qgFj/3U9rgKL
         BiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DdSGUrU0vDXWE8xHPpRJcvlPrMSiSNmqC4Sg59d2jto=;
        b=BFuq0ER3jBwjAIuxQliRVDSS18wiSwcfzYmAp6LeRgMqnxmWKlhZDL3sZsdYXE63Uh
         SVUMjzl3xDMa9P1R+Iqsac9MIAEq58v+Yj+sgnAYl282fvmBir+LR2/0ZjP3OyorEVMV
         YLPoQGYWi03mRSCFFpFltFzrQwOJu9ImwiEGzA5WZO4hRNwErQIvQTD0NYSTLiknHCUR
         kXiQ1A/qb+c2hr9u8DvnU2A6tYH5ifiXZINFh+OO0YCOw9jwTU3BBGbidI+oNSffTvEv
         gr2tOxBYElMlk3SxlGPIwTP4sMEQNB2/BUp4U9q4+4IsbxfA3AMnAN8zeaYBDKPGjdbl
         I7Rg==
X-Gm-Message-State: AOAM533L23bVZ1UBtnwJZaQH+Ga9UKHWpZQJYpVfgANs2GMBBjo3bmzU
        8OPSVmbbE6Fv3vxwOuQVPoFqCpPqdIc=
X-Google-Smtp-Source: ABdhPJy98yJF5blj6Krt1g+lK7xbBM62PiHo8alC1AQD1WyiLchU3qYlvw9Jkxf43lb9aIP2/uSC+g==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr32280911wmg.185.1641025309059;
        Sat, 01 Jan 2022 00:21:49 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::6619? ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id f6sm29800411wri.115.2022.01.01.00.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jan 2022 00:21:48 -0800 (PST)
Message-ID: <444324cb-5313-d9a5-7c9d-320072bfe6cf@gmail.com>
Date:   Sat, 1 Jan 2022 09:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 6/7] staging: r8188eu: IntArray and C2hArray are set but
 never used
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211230200059.13406-1-straube.linux@gmail.com>
 <20211230200059.13406-7-straube.linux@gmail.com>
 <2838d56e-9618-1582-4127-9dc3d56ff311@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <2838d56e-9618-1582-4127-9dc3d56ff311@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/21 21:11, Pavel Skripkin wrote:
> On 12/30/21 23:00, Michael Straube wrote:
>> The fields IntArray and C2hArray of struct hal_data_8188e are set but
>> never used. Remove them.
>>
>> While at it, remove the unsed defines USB_INTR_CONTENT_CPWM1_OFFSET
>> and USB_INTR_CONTENT_CPWM2_OFFSET as well.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
> 
> Hi Michael,
> 
> thanks for your clean ups!
> 
>>   drivers/staging/r8188eu/hal/usb_ops_linux.c     | 10 ----------
>>   drivers/staging/r8188eu/include/rtl8188e_hal.h  |  3 ---
>>   drivers/staging/r8188eu/include/rtl8188e_spec.h |  7 -------
>>   3 files changed, 20 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c 
>> b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> index 9ec55a77dccd..85bcde5ee79a 100644
>> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
>> @@ -185,20 +185,10 @@ int rtw_writeN(struct adapter *adapter, u32 
>> addr, u32 length, u8 *data)
>>   static void interrupt_handler_8188eu(struct adapter *adapt, u16 
>> pkt_len, u8 *pbuf)
>>   {
>> -    struct hal_data_8188e *haldata = &adapt->haldata;
>> -
>>       if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
>>           DBG_88E("%s Invalid interrupt content length (%d)!\n", 
>> __func__, pkt_len);
>>           return;
>>       }
>> -
>> -    /*  HISR */
>> -    memcpy(&haldata->IntArray[0], 
>> &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
>> -    memcpy(&haldata->IntArray[1], 
>> &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
>> -
>> -    /*  C2H Event */
>> -    if (pbuf[0] != 0)
>> -        memcpy(&haldata->C2hArray[0], 
>> &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
>>   }
> 
> This function can be removed totally then, since it does nothing. Not 
> sure if function removal fits this patch, but why not :)
> 

Hi Pavel,

I've sent v2 that removes the function.

Happy new year! :)
Michael

