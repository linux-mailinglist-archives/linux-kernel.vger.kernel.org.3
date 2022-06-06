Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D790053EE41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiFFTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiFFTBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:01:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A11658F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:01:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a15so24760023lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HsF6PFNjQdhI9fkMmd1jzJRlQO2RX9NPxQwW7vOOtf8=;
        b=Sg3b8LiXhFBmypAGCEZfcuogUken/zA0HLogif/U2MAEvxh0B9zlPTD4Up8IMLnbTW
         TNlcxZXJpZI526Qx0At0s6m4kJ7wuSO/pIeC5VB9IzGP/u59Q0shLPzQEggb6iD9YMkD
         gmJRb/aV6HKsRED0qmERbpIKux9tgvD8Pktl2OExMHX2NH+TjFzb5Zj5al96PMxFhHBm
         xrsylH8TuDbfzYsjySWHy5eQ9/qYsHpjrQTVWgU41VXCc+4QGOORStu5qEkrNYwieg5z
         kNC46PE403d4EOvyhhFsKu8Q9lS6QCuNValXUtMngO4WRyvjU0JWf2uWg+kuz26HOMzN
         ygDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HsF6PFNjQdhI9fkMmd1jzJRlQO2RX9NPxQwW7vOOtf8=;
        b=CRZYDjDz8qdeWg4HGhVv8Eot0ObkHBtwJdYIG44688Z9em+LtZUArs5BvD6GK008bN
         tQ0Os/NZbv57mnSGF3Va+uDdfLlwysk1yxHJb6bLQP0peaLtFCC2PTQTZFD2v4mLy30t
         8Na1Z98H6NmY9RWcYlnPIKazA+xDNi7bZ6fZ26X5E4u3SBgThuX7wTJMMrpV8cpLm0g6
         H2rZh9SwtzSfCFmoguqHeE9qdpt6XsZMl+qpXEzopXN3BIwH5RIfljkbp+5FAI0AGeGU
         +v2mrSBmynsUz2TmNSutn9pjkwVwW3o7vHOziJiHNRo6LxRfkgSqJddRFE6xlTvT7FFf
         qJBw==
X-Gm-Message-State: AOAM533CexCkOTuqKDC8cL3pacKyoLzqShktX5gEYQXecqtZpGnan9LD
        mClDbJR9nzUwegLHBV7r2AQ=
X-Google-Smtp-Source: ABdhPJyuzwqiwPI3WZiPgTWZqjXJg4VSREuSpZTNo6Em9hBq8mQr6C68Yd5ODYKNHfij3P27ZL1plw==
X-Received: by 2002:a05:6512:1293:b0:479:4bbb:f785 with SMTP id u19-20020a056512129300b004794bbbf785mr3950971lfs.170.1654542060100;
        Mon, 06 Jun 2022 12:01:00 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.27])
        by smtp.gmail.com with ESMTPSA id g28-20020a2eb5dc000000b00253dfbe2522sm2485503ljn.100.2022.06.06.12.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 12:00:59 -0700 (PDT)
Message-ID: <774c3d04-4c02-ed52-f545-73acbffde561@gmail.com>
Date:   Mon, 6 Jun 2022 22:00:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/4] staging: r8188eu: add error handling of rtw_read16
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <cover.1652994483.git.paskripkin@gmail.com>
 <fd10125ab8f4a64572742ec01d3202af2a79b1d0.1652994483.git.paskripkin@gmail.com>
 <Yp2VQU9G1xVw9lHE@kroah.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Yp2VQU9G1xVw9lHE@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/6/22 08:48, Greg KH wrote:
>> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
>> index e67ecbd1ba79..6662ebc30f7b 100644
>> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
>> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
>> @@ -249,11 +249,14 @@ static void efuse_read_phymap_from_txpktbuf(
>>  		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
>>  
>>  		if (i == 0) {
>> +			u16 reg;
>> +
>>  			/* Although lenc is only used in a debug statement,
>>  			 * do not remove it as the rtw_read16() call consumes
>>  			 * 2 bytes from the EEPROM source.
>>  			 */
>> -			rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
>> +			res = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &reg);
>> +			(void)res;
> 
> Same here, that line isn't ok.
> 
hm, that place is not obvious.

I guess, on-chip EEPROM acts like a FIFO, so this read must be completed 
w/o any errors, so I will simply propagate an error to callers

And will place another "FIXME" for further work :)

thanks,


With regards,
Pavel Skripkin
