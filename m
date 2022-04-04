Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B204F16CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359781AbiDDORQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDDORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:17:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF741CFCD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:15:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bg10so20280398ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=enyn11va52J9YxQxLmqhfvPGfWKhAIsk5cKTiEymAy8=;
        b=DYgwwlBRxHL11XWuLBjeldXaJ17wCvLDMeD+znq7eRfTRHLj1uU+klXgm4fbtlPIp9
         aynoOVc2w0F/r0ZVkpjk5GVq1uOhIMyoLUSl576QC+GOz4CIssm2ehzVx2fIioxLoU16
         UEMww73nSnux78NcL5HqujFuN9hbW25wwxVPN+CKctdQ0udFOiFDEqqychsRMl7uGstM
         Y05oO0hiHok3yp8v/gVaNWzrBoVcKiyemVg2fUspexCn6C1cTCbQQB4+ZwoJGngYbbCq
         L0baz3djCGDN/VIHHCJh5x3kmz+6qn1sUsV6OJhphL9nAwBYjQFNqRZwXYPIIQ0Z6k5L
         uwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=enyn11va52J9YxQxLmqhfvPGfWKhAIsk5cKTiEymAy8=;
        b=6WZB7qRw9NTiMV1+DancAbadfV5DnF+03UUJFqn3FomKF9HwhBTweY5X9z0HQ+htcF
         m1bla8nRT7QDrOopbao4zmXP1Gb/R2IfHJHjr+bQUcDSE64YfoV8ne/ZW2kPRicZlNgK
         iGtoOmTVQHv4OGdklCOjwav8Vayy5JYXOTojsHDJGZCjI/Z6I05lKuLnWcyKFezuPU4k
         cbZJzWyYlPDi6sawFebVsuY/KONRAu/4tCNppiK9XA2BfX/kjsmDjuPCVwpInO6tg6Yb
         QlDoc/736xHxDlxyOwoyTCW0DNO6ROZRQrzg1arkoCDSbzkiANBib4BE07AVkQR1nohv
         ES9Q==
X-Gm-Message-State: AOAM532qcoouuQeajrfovm0OKYngtr7ZgDA6J8VML7tO4rJJ+9ipVGRf
        4h9m/yxpdHh9QQrJuGZLHDw=
X-Google-Smtp-Source: ABdhPJyqXfzSLxl8wjDqi4xLBZx1uRh2S2sl5ltqUKrbYSm4o59TfjmyHaflD9f40+BsygBGXNdU/g==
X-Received: by 2002:a17:907:3e03:b0:6da:8c5a:6d4a with SMTP id hp3-20020a1709073e0300b006da8c5a6d4amr200538ejc.585.1649081712524;
        Mon, 04 Apr 2022 07:15:12 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm5441200edb.47.2022.04.04.07.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 07:15:11 -0700 (PDT)
Message-ID: <00574358-05fd-d80f-e052-ba9549a120ed@gmail.com>
Date:   Mon, 4 Apr 2022 16:15:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging: r8188eu: remove unncessary ternary operator
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220402173835.7560-1-straube.linux@gmail.com>
 <20220404130854.GB3293@kadam>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20220404130854.GB3293@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/22 15:08, Dan Carpenter wrote:
> On Sat, Apr 02, 2022 at 07:38:35PM +0200, Michael Straube wrote:
>> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
>> index 45b788212628..18650cd96f09 100644
>> --- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
>> +++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
>> @@ -137,7 +137,7 @@ void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi
>>   
>>   	bitmap |= ((raid << 28) & 0xf0000000);
>>   
>> -	short_gi_rate = (arg & BIT(5)) ? true : false;
>> +	short_gi_rate = arg & BIT(5);
>>   
> 
> This is a bug.  Valid values of short_gi_rate are 0 and 1 but this sets
> it to BIT(5) so it will break odm_RateUp_8188E() which tests for:
> 
> 	else if ((pRaInfo->SGIEnable) != 1)
> 

Oh I see, I should have been more careful with this type of removals.

>>   	raid = (bitmap >> 28) & 0x0f;
>>   
>> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
>> index 6811be95da9a..ffc82d17ddbe 100644
>> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
>> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
>> @@ -747,7 +747,7 @@ void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
>>   
>>   		/*  decide hw if support remote wakeup function */
>>   		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
>> -		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1)) ? true : false;
>> +		padapter->pwrctrlpriv.bSupportRemoteWakeup = hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT(1);
> 
> I have not looked at this one to see if has a similar issue...  I don't
> necessarily want to audit all of these.  I guess I will, but could you
> do it first and then I will check?
> 

Sure I'll do.

Thanks,
Michael

>> diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
>> index 8c20363cdd31..03d63257797a 100644
>> --- a/drivers/staging/r8188eu/include/ieee80211.h
>> +++ b/drivers/staging/r8188eu/include/ieee80211.h
>> @@ -127,7 +127,7 @@ enum NETWORK_TYPE {
>>   	 (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
>>   
>>   #define IsSupported24G(NetType)					\
>> -	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
>> +	((NetType) & SUPPORTED_24G_NETTYPE_MSK)
> 
> This too.
> 
>>   
>>   #define IsEnableHWCCK(NetType)					\
>>   	IsSupported24G(NetType)
>> @@ -135,11 +135,11 @@ enum NETWORK_TYPE {
>>   #define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
>>   
>>   #define IsSupportedTxCCK(NetType)				\
>> -	((NetType) & (WIRELESS_11B) ? true : false)
>> +	((NetType) & WIRELESS_11B)
>>   #define IsSupportedTxOFDM(NetType)				\
>> -	((NetType) & (WIRELESS_11G) ? true : false)
>> +	((NetType) & WIRELESS_11G)
>>   #define IsSupportedTxMCS(NetType)				\
>> -	((NetType) & (WIRELESS_11_24N) ? true : false)
>> +	((NetType) & WIRELESS_11_24N)
>>   
> 
> And this.
> 
> regards,
> dan carpenter
> 
