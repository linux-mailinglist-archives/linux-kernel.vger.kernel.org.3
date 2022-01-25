Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DAC49BCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiAYUEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbiAYUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643141034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+izeh7Z97NDvTmlpI6JSKmVzqvy/iR5BgtVtzG1h4kk=;
        b=jN5UCRHo7rACCy/YFf2cWwF+hF2yznKl+9n9sri5TMRDewvehjtvDiV4UjWiwHvlZlAvkH
        QfY45nHG6Qfe2dKKRD3O4cg8EI++a5s7gUOHkaKSCvqe17RFNMGgnvaGUAHINdI8oBDBvZ
        xzlun7llEGFNlUz2KCzWX9+nwwaSKgk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-EQuInvgGPWaXi7b5KVYKNA-1; Tue, 25 Jan 2022 15:03:53 -0500
X-MC-Unique: EQuInvgGPWaXi7b5KVYKNA-1
Received: by mail-oi1-f200.google.com with SMTP id o11-20020a0568080f8b00b002cd0d1c3638so4792270oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+izeh7Z97NDvTmlpI6JSKmVzqvy/iR5BgtVtzG1h4kk=;
        b=QCvyH0kj/DIkha6s7xOe4fSg6pzVgNsATLTC2b/JnstAstNOVl/btnOVvYaHWaKicB
         ThSjuwQpDlJxtmNyqaKMvJk82jg2ajS6BXIuZ1g2aSja073Jo8zEsWIWTN+USG0JL8ql
         ydnfmCmiobV4VOf1p1lEyj7Hce09BTIW76CftdmWtiL8lbzMYQCydNDecYQHil4QRqjl
         q7f9wzKsyWFnWgRaVCcYLhPcUX6LM38H7mThnCfiFNt5OyZni4nfcU1Z4I5ozUiSuuyS
         Ljmjr8AYhVQdr2y/4bEMRSCBR49cjLIcu8GTlcIHGwOvV01PNraowRXJFpgc+Tra3XN/
         3oOA==
X-Gm-Message-State: AOAM533oe3EKR/eg0tRU0KPkAdvdvL+WcM75A1Ee3Q1T9yWFgjJMIH4v
        pNNrLENhkFOCcokYGSKpQsaS+t+Q2QjwCbFjWTN1OYoGbNZLG1V2VDmbJ/voq8xDK2LidVw9HWT
        UzcnoLfJndRMknjYxCh/L/mBMsihd3e70QQHNJOeCLX+fkvopVcMVahvReZU0ct2dA6GNltE=
X-Received: by 2002:a9d:6057:: with SMTP id v23mr1347582otj.44.1643141032175;
        Tue, 25 Jan 2022 12:03:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX4L4LMSmynaVIV+STdJn0kXU/a2f220vOcOGFKcJgrkytqf0BHbTnAtDsE0dECG6Fxolkyg==
X-Received: by 2002:a9d:6057:: with SMTP id v23mr1347568otj.44.1643141031919;
        Tue, 25 Jan 2022 12:03:51 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id b8sm5091714otk.36.2022.01.25.12.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:03:51 -0800 (PST)
Subject: Re: [PATCH] ieee80211: cleanup double word in comment
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220125180735.1123792-1-trix@redhat.com>
 <10efb4246ce9c76403ac54fa06e8ea3d0d87785e.camel@sipsolutions.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <65cbae9c-20dc-6fab-a462-b74468b9303e@redhat.com>
Date:   Tue, 25 Jan 2022 12:03:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <10efb4246ce9c76403ac54fa06e8ea3d0d87785e.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/22 10:19 AM, Johannes Berg wrote:
> On Tue, 2022-01-25 at 10:07 -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Remove the second 'that'.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   include/linux/ieee80211.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
>> index 559b6c6449384..5475383936f8b 100644
>> --- a/include/linux/ieee80211.h
>> +++ b/include/linux/ieee80211.h
>> @@ -467,7 +467,7 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
>>   static inline bool ieee80211_is_data_present(__le16 fc)
>>   {
>>   	/*
>> -	 * mask with 0x40 and test that that bit is clear to only return true
>> +	 * mask with 0x40 and test that bit is clear to only return true
>>   	 * for the data-containing substypes.
>>
> I don't think it's just a duplicate?
>
> ... and (test that) (that bit is clear to ...)
>
> no?

ok, reads ok.

Sorry for the noise.

T

>
> johannes
>

