Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC84EB1C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiC2Q1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbiC2Q1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:27:24 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5BC2296C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:25:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so36216068ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Jg/lgUXJ8tlbH0TThjgXJTU0nO4xWzd7wXj/Y11atM=;
        b=Krt37wklsbXb5xXyChlds582mL4VFW5icapNaELKjNu/70ES8p6bWgd0245neemOpS
         XCJuNQ9YXeePUP85EZ7JohKauY332BGbyb0R7gE3a7xTAROKF3MjTopC+/uxcIiuuICe
         4FofNnpNPyR3Iz3kGZA55fPsGIwgk9AQiKXJwbsBeaR8HDH8JwFdIyQUURJMVC9/9ltb
         eRGMUMM23fRa1KNnPKJ31p+kBQqYgwevz730F1j8kp4IfU2+w81pVMDkOHfmU3EBOFH1
         Dt8xX+0vbImVTZN9T83vIYLiSGBpva+dMQG57zMGkSGTKhCDSeDpjrht2HN6N7igANeF
         Me+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Jg/lgUXJ8tlbH0TThjgXJTU0nO4xWzd7wXj/Y11atM=;
        b=C7EiUWQQxfSbQ3qb5YsGATU4OCBS5CC0MPcvD5Yjptx7Leeg3TnWMpqdePGVe9hxVX
         6fcd8XHuC3m7DS5KBhmwcsSB9KWB2E5DY6nAtQS61Cz3OCeZXaA0YhTR5ZXsB5EgFHkc
         h+SPG6N+Aqq0cxg/6lZXAJtSABNjzEQQaX4JEABVJjMOQWnsqnTEjzgtElWGUev5zqzp
         MRKz/sBg3qo3ISdUonAz/vrbJ7yNW/Un/M2CTib1jRql6POkJxITvc3pZWLRbToEGbUg
         mB0N2Qb6N/0EnyLPRVtUF2WAdNvnw9dAHT56kFfMjN7nbQhNMnBVb9z+pBm5cCq/pxLi
         EBHg==
X-Gm-Message-State: AOAM530hEKAw5dC4Z/TsTRgqlV8rUBoxb2LVm33rjaJCTGMHbRTP05uz
        j6BPDxGQNdr8NDYu45PRkP5w1tQDNJ0=
X-Google-Smtp-Source: ABdhPJzYorWbZr5xoJzG1ZpCofK5AbbMnXygNv72OX4gBIzREHz+Jnw/9YhXtO5XYzOK7KmLyuTREA==
X-Received: by 2002:a17:906:2ac9:b0:6ce:dc0f:9139 with SMTP id m9-20020a1709062ac900b006cedc0f9139mr35652179eje.206.1648571136860;
        Tue, 29 Mar 2022 09:25:36 -0700 (PDT)
Received: from [192.168.0.253] (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ga42-20020a1709070c2a00b006df76956b53sm7114319ejc.212.2022.03.29.09.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 09:25:36 -0700 (PDT)
Message-ID: <b06f943e-a9e3-0bb2-7384-6f0d23bd2e96@gmail.com>
Date:   Tue, 29 Mar 2022 18:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/9] staging: r8188eu: remove HW_VAR_ACM_CTRL from
 SetHwReg8188EU()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220328113940.6396-1-straube.linux@gmail.com>
 <20220328113940.6396-5-straube.linux@gmail.com> <YkMtsKlCsMOnV1Q0@kroah.com>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YkMtsKlCsMOnV1Q0@kroah.com>
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

On 3/29/22 18:02, Greg KH wrote:
> On Mon, Mar 28, 2022 at 01:39:35PM +0200, Michael Straube wrote:
>> SetHwReg8188EU() is called with HW_VAR_ACM_CTRL only in one place.
>> Remove the HW_VAR_RESP_SIFS case from SetHwReg8188EU() and replace its
>> call with the code from that case. This is part of the ongoing effort
>> to get rid of the unwanted hal layer.
>>
>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   drivers/staging/r8188eu/core/rtw_wlan_util.c | 27 +++++++++++++++++---
>>   drivers/staging/r8188eu/hal/usb_halinit.c    | 26 -------------------
>>   drivers/staging/r8188eu/include/hal_intf.h   |  1 -
>>   3 files changed, 24 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
>> index eda4e5f9a6af..cde3779ff21d 100644
>> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
>> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
>> @@ -571,10 +571,31 @@ void WMMOnAssocRsp(struct adapter *padapter)
>>   		}
>>   	}
>>   
>> -	if (padapter->registrypriv.acm_method == 1)
>> -		SetHwReg8188EU(padapter, HW_VAR_ACM_CTRL, (u8 *)(&acm_mask));
>> -	else
>> +	if (padapter->registrypriv.acm_method == 1) {
>> +		u8 acmctrl = rtw_read8(padapter, REG_ACMHWCTRL);
>> +
>> +		if (acm_mask > 1)
>> +			acmctrl = acmctrl | 0x1;
>> +
>> +		if (acm_mask & BIT(3))
>> +			acmctrl |= ACMHW_VOQEN;
>> +		else
>> +			acmctrl &= (~ACMHW_VOQEN);
>> +
>> +		if (acm_mask & BIT(2))
>> +			acmctrl |= ACMHW_VIQEN;
>> +		else
>> +			acmctrl &= (~ACMHW_VIQEN);
>> +
>> +		if (acm_mask & BIT(1))
>> +			acmctrl |= ACMHW_BEQEN;
>> +		else
>> +			acmctrl &= (~ACMHW_BEQEN);
>> +
>> +		rtw_write8(padapter, REG_ACMHWCTRL, acmctrl);
> 
> Shouldn't be a function that explains what you are doing here?  Like you
> did with previous changes in this patch series?
> 

Sound like a good idea.
I'll send v2 and address your other comments to this series too.

Thanks,
Michael
