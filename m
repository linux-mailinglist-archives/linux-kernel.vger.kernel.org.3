Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CDF55FED1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiF2LjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiF2LjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:39:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEE423EF34;
        Wed, 29 Jun 2022 04:39:01 -0700 (PDT)
Received: from [192.168.87.140] (unknown [50.47.106.71])
        by linux.microsoft.com (Postfix) with ESMTPSA id 740FA20CDF40;
        Wed, 29 Jun 2022 04:39:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 740FA20CDF40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1656502741;
        bh=nMMncbj7PcZxuOTOGA9EBSFftECnVGmkQTDJvUjK8Ao=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CnfkjBSoe3VldwsxCa2rq1Jsqah/UaFoJnxR/eoaDuoljMrz6XIsBxzffBHx2LRBt
         XbrRVRxkOlcRfKCLcL2Ngr1c0z9lARuha1sRI0C/ZOJ7SeCOdjDvRHqYaSPkISxdGG
         c0XNzOpralATM0laJNwInmCQPg89bNR4IXsEXTxQ=
Message-ID: <74981148-70ab-059b-6e77-b88ea908e703@linux.microsoft.com>
Date:   Wed, 29 Jun 2022 04:39:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220629032008.1579899-1-neal_liu@aspeedtech.com>
 <20220629032008.1579899-3-neal_liu@aspeedtech.com>
 <b70e06e7-81fc-dfc1-f9c5-f83cb4a18293@linaro.org>
 <HK0PR06MB32025ACEE605D1016DD3B99D80BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <409af908-5e03-8df7-fcd5-7fab75cdfb34@linaro.org>
 <HK0PR06MB32021F63833C4C482CC616D580BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <HK0PR06MB32021F63833C4C482CC616D580BB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2022 1:49 AM, Neal Liu wrote:
[...]
>>>>> diff --git a/include/dt-bindings/clock/aspeed-clock.h
>>>>> b/include/dt-bindings/clock/aspeed-clock.h
>>>>> index 9ff4f6e4558c..6e040f7c3426 100644
>>>>> --- a/include/dt-bindings/clock/aspeed-clock.h
>>>>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>>>>> @@ -46,11 +46,12 @@
>>>>>   #define ASPEED_RESET_MCTP		1
>>>>>   #define ASPEED_RESET_ADC		2
>>>>>   #define ASPEED_RESET_JTAG_MASTER	3
>>>>> -#define ASPEED_RESET_MIC		4
>>>>> +#define ASPEED_RESET_HACE		4
>>>>
>>>> I did not ack such change. This is a significant change from previous
>>>> version, invalidating my previous ack.
>>>>
>>>> This breaks the ABI, so NAK without proper explanation why ABI break
>>>> is accepted.
>>>
>>> I changed the original define (MIC) into different value (see below diff), and
>> add a new define for HACE.
>>> How does that break the ABI? I'll be appreciated if you can explain it more
>> details.
>>> And sorry for not remove ack with new change.
>>
>> Yes, this breaks ABI. Previously the ASPEED_RESET_MIC define had value of 4,
>> now it has value of something else.
> 
> Got your point. I'll re-define HACE without modifying ABI.
> Thanks for your suggestion.
> 

As per HW manuals, new def is correct for AST2500, but not for AST2400.

AST2500:
SCU04[4] = HACE
SCU04[18] = MIC

AST2400:
SCU04[4] = MIC
SCU04[18] = HACE

The header file is shared between AST2400 and AST2500 (aspeed-g4.dtsi
and aspeed-g5.dtsi), which needs to be split into separate header files
given the collision.

Also, It will be better to split AST2500 and AST2600 changes in separate
patches.

Regards,
Dhananjay

