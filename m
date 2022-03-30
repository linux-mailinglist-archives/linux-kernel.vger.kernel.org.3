Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C824ECAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349404AbiC3Rkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349338AbiC3Rki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:40:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4390DE929
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:38:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso448978wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s/RKowGNcyAz+6eEh3xMpapodgsQb/fvti1gfWp+kgI=;
        b=bfekdHmoCCQXGlBqaIiNShhbEFM4MG7+AL1kJo/g/hTQVQ+tbiHFYQBiPnESIw7d31
         G+vB65B3LLh8kZvYqpVYn/OilmBjH9ty7SN+u8oPviwrEwNPwY1HBQS8nmvafzVesjeJ
         1YqQIm9fw9PxTEFsHmoU7bJnlKGZUrYkQVxkc8SGnycoHruyEpxRSfZcjSi6ffVrgvNp
         kQ2vuRWxPwKriVp2OtkIA1DV0S1L3si3zSYOPwgM64U4wQzlRNFVNmNf99pIgNra89ON
         mt3BTi4j+44h5wThdRKqLiaCANq6h69VV4Fgo/y/HbjEIiel4Eca/wY3QoWD3rqL4d3y
         O7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s/RKowGNcyAz+6eEh3xMpapodgsQb/fvti1gfWp+kgI=;
        b=S3fnic8ejDQ36sZFYTlN5g13R9wPqKvArM6m7uCerSgEizRRVfi8z6t/svmiHSuavQ
         0CTsPPPdCSDXhDxdhkae73JZIXuvgEZ4Q3jdYgj1ymrvCwymiv8zD78A9/aCnDQME7lg
         Tq8E1qc8sH4kyTxMmmKtU6ovodmhKuhhmODsZKfUitplN4VIMyVtt7I2y7F6+6fxwU4m
         mwPkmXCxNnGyDnc/kKqyO+DE7amGJgp/cD0hoLdXuoZGnMsrpK004MiDWwJ1UywcOMEy
         3fqzcsrWXbXCnxYSQVXoNIx8Mw9BniwZqVIEvhaJC4e++RDG9XA5BiNZjFuEHen1lptd
         Biuw==
X-Gm-Message-State: AOAM533iBtic4GTVoU1gvrK08ofq6lA4CopSVwZJlXTin0ef8af29l3u
        eCY/rBuwhPFRYOXbyFpeGR4=
X-Google-Smtp-Source: ABdhPJwDLV/c3Iis8GSNyw5iaY23HbEdflpzpvf8zyL4cC+QnDBB/JQGzc1AmObtxhsUHzPS30yyPQ==
X-Received: by 2002:a1c:f30b:0:b0:380:e444:86b9 with SMTP id q11-20020a1cf30b000000b00380e44486b9mr513171wmq.81.1648661930105;
        Wed, 30 Mar 2022 10:38:50 -0700 (PDT)
Received: from [192.168.1.14] ([41.37.132.115])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm28183523wrr.54.2022.03.30.10.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 10:38:49 -0700 (PDT)
Message-ID: <9e6abf4a-cf5c-05c9-b179-b863ef53f35f@gmail.com>
Date:   Wed, 30 Mar 2022 19:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] staging:rtl8723bs:rtw_cmd.c remove suspect indent
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220330153100.5813-1-eng.alaamohamedsoliman.am@gmail.com>
 <20220330170936.GA1176693@alison-desk>
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <20220330170936.GA1176693@alison-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٣٠‏/٣‏/٢٠٢٢ ١٩:٠٩, Alison Schofield wrote:
> On Wed, Mar 30, 2022 at 05:31:00PM +0200, Alaa Mohamed wrote:
>> Fix "WARNING: suspect code indent for conditional
>> statements (16, 32)" for line 1240
>> founded by checkpatch.pl
>>
>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> Hi Alaa,
>
> https://kernelnewbies.org/PatchPhilosophy
> Please take a look at the section on "Patch subject formatting"
> and the follow on sections about checkpatch descriptions.

I will check , Thank you

>
> Thanks,
> Alison
>
>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
>> index 14d37b369273..46e18a90529f 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
>> @@ -1238,7 +1238,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
>>   		/*&& !MgntInitAdapterInProgress(pMgntInfo)*/) {
>>   		/*  if we raise bBusyTraffic in last watchdog, using lower threshold. */
>>   		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
>> -				BusyThreshold = BusyThresholdLow;
>> +			BusyThreshold = BusyThresholdLow;
>>   
>>   		if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > BusyThreshold ||
>>   			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
>> -- 
>> 2.35.1
>>
>>
