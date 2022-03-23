Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDFD4E54DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbiCWPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiCWPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:07:38 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13CF13F6C;
        Wed, 23 Mar 2022 08:06:07 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id bi12so3455727ejb.3;
        Wed, 23 Mar 2022 08:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=cNxSQx97vgtvb107U/L1ql0G+sBh/iewmtdw4bJS2bw=;
        b=iaIMmy59Tutmd3P8Ji7Zmyw/LVBL71gQAkdI+U8FNN6tJbPLWS6q2cBlmSFrWcWSj8
         15kK8HEgWMNmzUaqqDkIdacm8Fqr5R8EToYP6l+3NP9+R7X6IM7mFVkN8/SejSDONvfm
         ZUIoymQHMjJ54m1Jlj0TF8ab43x/yDFrcJq/XZB3+PQDt65EjtXCXKwtSJUUr5s9E3wr
         tJEHrdpg+H3vfI7enIYbDdjFacCXKGkwkTpAKkvxaJQYOb/se450qIWCmvgWemyaYYr3
         od0vyrVl0FW5F0lRUdxVDJ6cVh+MEpyz1WR2lhFLAwCCGCOJpRQUYRFnJiEJrVUzsaVC
         cQIg==
X-Gm-Message-State: AOAM533YusMqlabcOdKqvhCsDsIGsQBF/zfDmr8JufLo+bK3ve98bHB7
        Nq+vRcOrNJg4r4yHmr6JmpA8YQiIJticpw==
X-Google-Smtp-Source: ABdhPJxB195zpfiu3gCQWy7ZE1/RrY52u6+CtkeCsd4ZpF2kkg4TPNd/m84pPRlB+Kt55l2EHvzFCg==
X-Received: by 2002:a17:906:7751:b0:6ce:e3c:81a6 with SMTP id o17-20020a170906775100b006ce0e3c81a6mr435071ejn.278.1648047966103;
        Wed, 23 Mar 2022 08:06:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id v4-20020a170906338400b006d5aca9fc80sm50074eja.106.2022.03.23.08.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:06:05 -0700 (PDT)
Message-ID: <f716c6fd-66c6-4dd9-cedb-6024f415ddc7@kernel.org>
Date:   Wed, 23 Mar 2022 16:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
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
In-Reply-To: <CY4PR04MB0567A424CBEFF7F3338EF320CB189@CY4PR04MB0567.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 15:59, Jonathan Bakker wrote:
> Hi Krzysztof,
> 
> On 2022-03-23 3:54 a.m., Krzysztof Kozlowski wrote:
>> On 22/03/2022 21:11, Jonathan Bakker wrote:
>>> Memory nodes should only have a singular reg property in them, so
>>> split the memory nodes such that there is only per node.
>>>
>>> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>>> ---
>>>  arch/arm/boot/dts/s5pv210-aquila.dts |  8 ++++++--
>>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 14 +++++++++++---
>>>  arch/arm/boot/dts/s5pv210-goni.dts   | 14 +++++++++++---
>>>  3 files changed, 28 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
>>> index 6423348034b6..6984479ddba3 100644
>>> --- a/arch/arm/boot/dts/s5pv210-aquila.dts
>>> +++ b/arch/arm/boot/dts/s5pv210-aquila.dts
>>> @@ -29,8 +29,12 @@
>>>  
>>>  	memory@30000000 {
>>>  		device_type = "memory";
>>> -		reg = <0x30000000 0x05000000
>>> -			0x40000000 0x18000000>;
>>> +		reg = <0x30000000 0x05000000>;
>>> +	};
>>> +
>>> +	memory@40000000 {
>>> +		device_type = "memory";
>>> +		reg = <0x40000000 0x18000000>;
>>>  	};
>>>  
>>>  	pmic_ap_clk: clock-0 {
>>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>> index 160f8cd9a68d..70ff56daf4cb 100644
>>> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
>>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>>> @@ -24,9 +24,17 @@
>>>  
>>>  	memory@30000000 {
>>>  		device_type = "memory";
>>> -		reg = <0x30000000 0x05000000
>>> -			0x40000000 0x10000000
>>> -			0x50000000 0x08000000>;
>>
>> 0x40000000 to 0x58000000 is continues, so I wonder why it is split? Look
>> at Aquila DTS.
>>
>>
> 
> Yes, it was split in the vendor kernel as well [1], and that's been continued along
> here.  I personally don't see a reason to keep it split, but there might be something
> I'm not aware of.
> 

I guess they wanted maybe to express the physical banks. Fine with me.
Just your explanation is not entirely correct:
> Memory nodes should only have a singular reg property in them,
one reg but it can have multiple items. Why do think multiple reg items
is not allowed?


Best regards,
Krzysztof
