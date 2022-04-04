Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FABB4F1D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383128AbiDDVcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379355AbiDDRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:02:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AD340A1E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:00:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dr20so21173256ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=At6V+p98WWM5cl2f18ea78oUqq1fd0MCKDFUe0vUx34=;
        b=Aq5amcLXoa1xta3fhiqw88Vg7dVh9Q0gabJOkj7Dzik/gqQihPTvqDaJaj2dIj/aOH
         2w3Ue6XFp8r+zwOGaUZ1kNNE85hQG9dHzxKJQfLgo5nuK4F6mkJZUgVhWHKnpwxjJBBQ
         r3cxY7UOQbNy8GR7XHuvBQbW2Nj0V4PBpaZxeToaVjWoxblvkouLlzF9N1Ipz3cq+Vmc
         L9Cc8AS4JXnsqmls3YhbmOtjq5v/NvlDJ3L1Es49PDmHhyX+Zf5d4fzIHkFgX/wmAYSx
         VX7210Z46K4VC84HTRPoVzz+ACPq0jKrVSB8ncv9XYeetGtn69usXjUvIqang62tpuXk
         fqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=At6V+p98WWM5cl2f18ea78oUqq1fd0MCKDFUe0vUx34=;
        b=XlHjqDD3mO7aIh0OAf2OZJKFEf7Dp+mXX9Pw5pPK9CUH5A6KWtIvl4pq0Ipo37OvQq
         LCcJ2t85IcohKlGiLMPpPmNxqER7WmQhgkGJezqOFwYoSKkNbrKAySs9d/oaVOlCT7aQ
         PqbOfm+87AC14RdNR+hBQWJD7Mfa3UbFfznbW4yrpzBQN0DqZQ5bMpmyTCXRdizd2wje
         wShWbOkG3wR7+135o6f+wqlRUAR066csXsab5pfudcPFovWdjdUfOpAGpxqM2utWhoWP
         UTRslWoT/NCE468QGIxRcXpnZZ6Y9ARbO3o2hJgQG4zYW0gUVAENqnqUUdS/qEF+kHYW
         tIsw==
X-Gm-Message-State: AOAM533lMKyY1gG5+0Z25G9ChySVy3h/xz/4W+SqiFfEVumopKH6/xem
        4u26dpLbWYEoAB3pGL77oHE=
X-Google-Smtp-Source: ABdhPJwf3gGp2dlb23aM6MTrLaWCvwj85fBB2Fe5rbvzOf3UUHr2eXmjzifKz94TBBUkDjDECxscUw==
X-Received: by 2002:a17:907:3f0a:b0:6e0:7189:cd6 with SMTP id hq10-20020a1709073f0a00b006e071890cd6mr1009892ejc.740.1649091651809;
        Mon, 04 Apr 2022 10:00:51 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm4559495ejl.185.2022.04.04.10.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 10:00:51 -0700 (PDT)
Message-ID: <297f97b5-e7ad-b225-cf58-b901a30ad6de@gmail.com>
Date:   Mon, 4 Apr 2022 19:00:50 +0200
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

Hi Dan,

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

It has the same issue. I'll leave these two as is in v2.

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

It turned out that these are all unused and can be removed.
I should really have looked deeper into this, sorry.

I'll remove them in a separate patch in v2.

thanks,
Michael
