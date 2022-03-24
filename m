Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEADF4E626B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbiCXLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiCXLYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:24:46 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AB646B;
        Thu, 24 Mar 2022 04:23:14 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id pv16so8561140ejb.0;
        Thu, 24 Mar 2022 04:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dlOlXPMPAGBLtab/eN9h0+VSJ5BfGK0qXZEyv3ue3cI=;
        b=DT9P+bvrSekj0ia3VIUkDEhkSd9lm1ATnuYTLEeuuA5Q2hpRKsLKYQMFn/9c4yAA8s
         G//WnzU0YGZ1Z7pmftCvFUfxzYFk+I5AHHYWJKF8ZmtRoCSfXwkS/AD4WapH7NQ5moCF
         3IMpfrlzzBY8sbklVDm7qNJ1TetYz+MqpjuXhKiW2TcRAYcGA3DSvb20hlq4ZMw2T+Hm
         lw/ldF48TqB5xZZO/aKPkcZKBtw8hzR7Hfyi51smUuDT9+0P3h+QpDizU2wPNb2w6teF
         dSMsZHT99D/vJLHKSf4OfSHhmrc0oyqeIybJDJ4520r4Dl6fJfhUyC2vIghHqhNqnJSf
         TZ6w==
X-Gm-Message-State: AOAM530TSMMX4Y10ydB6ulh8sCYupgWqBYGI/WqjCpNEDMZKfzQpFW9N
        Hcyntwihhn80EQOs4cnIcfE=
X-Google-Smtp-Source: ABdhPJzf906OKCiFQZCKLtfoiz1tqDlEhYuYUaG0vtkJRHvVym5g1zhC+z6+nftcldpHaKSlGdYirQ==
X-Received: by 2002:a17:906:99c2:b0:6df:8834:4f4c with SMTP id s2-20020a17090699c200b006df88344f4cmr5194204ejn.496.1648120993119;
        Thu, 24 Mar 2022 04:23:13 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm996565ejz.57.2022.03.24.04.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:23:12 -0700 (PDT)
Message-ID: <377e97c2-03e4-bc74-595d-2f4dba7e142f@kernel.org>
Date:   Thu, 24 Mar 2022 12:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/7] ARM: dts: s5pv210: Split memory nodes to match spec
Content-Language: en-US
To:     Jonathan Bakker <xc-racer2@live.ca>, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220322201144.20320-1-xc-racer2@live.ca>
 <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
 <51007577-52a2-60a5-0720-7b2c7f78ae3e@kernel.org>
 <CY4PR04MB0567A424CBEFF7F3338EF320CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
 <f716c6fd-66c6-4dd9-cedb-6024f415ddc7@kernel.org>
 <CY4PR04MB05671F31023376B0B7050C68CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CY4PR04MB05671F31023376B0B7050C68CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 18:05, Jonathan Bakker wrote:
> 
> 
> On 2022-03-23 8:06 a.m., Krzysztof Kozlowski wrote:
>> On 23/03/2022 15:59, Jonathan Bakker wrote:
>>> Hi Krzysztof,
>>>
>>> On 2022-03-23 3:54 a.m., Krzysztof Kozlowski wrote:
>>>> On 22/03/2022 21:11, Jonathan Bakker wrote:
>>>>> Memory nodes should only have a singular reg property in them, so
>>>>> split the memory nodes such that there is only per node.
>>>>>
>>>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>>>> ---
>>>>>  arch/arm/boot/dts/s5pv210-aquila.dts |  8 ++++++--
>>>>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 14 +++++++++++---
>>>>>  arch/arm/boot/dts/s5pv210-goni.dts   | 14 +++++++++++---
>>>>>  3 files changed, 28 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
>>>>> index 6423348034b6..6984479ddba3 100644
>>>>> --- a/arch/arm/boot/dts/s5pv210-aquila.dts
>>>>> +++ b/arch/arm/boot/dts/s5pv210-aquila.dts
>>>>> @@ -29,8 +29,12 @@
>>>>>  
>>>>>  	memory@30000000 {
>>>>>  		device_type = "memory";
>>>>> -		reg = <0x30000000 0x05000000
>>>>> -			0x40000000 0x18000000>;
>>>>> +		reg = <0x30000000 0x05000000>;
>>>>> +	};
>>>>> +
>>>>> +	memory@40000000 {
>>>>> +		device_type = "memory";
>>>>> +		reg = <0x40000000 0x18000000>;
>>>>>  	};
>>>>>  
>>>>>  	pmic_ap_clk: clock-0 {
>>>>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>> index 160f8cd9a68d..70ff56daf4cb 100644
>>>>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>>>> @@ -24,9 +24,17 @@
>>>>>  
>>>>>  	memory@30000000 {
>>>>>  		device_type = "memory";
>>>>> -		reg = <0x30000000 0x05000000
>>>>> -			0x40000000 0x10000000
>>>>> -			0x50000000 0x08000000>;
>>>>
>>>> 0x40000000 to 0x58000000 is continues, so I wonder why it is split? Look
>>>> at Aquila DTS.
>>>>
>>>>
>>>
>>> Yes, it was split in the vendor kernel as well [1], and that's been continued along
>>> here.  I personally don't see a reason to keep it split, but there might be something
>>> I'm not aware of.
>>>
>>
>> I guess they wanted maybe to express the physical banks. Fine with me.
>> Just your explanation is not entirely correct:
>>> Memory nodes should only have a singular reg property in them,
>> one reg but it can have multiple items. Why do think multiple reg items
>> is not allowed?
>>
> 
> I was basing it off of this warning when running make dtbs_check
> 
> rch/arm/boot/dts/s5pv210-aquila.dt.yaml: /: memory@30000000:reg:0: [805306368, 83886080, 1073741824, 402653184] is too long
> 	From schema: /home/jon/.local/lib/python3.7/site-packages/dtschema/schemas/reg.yaml
> 
> and this solved the warning, booted, and I still had the correct
> amount of memory.
> 
> Would
> 
> 	memory@30000000 {
> 		device_type = "memory";
> 		reg = <0x30000000 0x05000000>,
> 			<0x40000000 0x18000000>;
> 	};
> 
> be equally correct?  (untested).

Yes, this one should be correct.


Best regards,
Krzysztof
