Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED62516B48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348591AbiEBHcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383578AbiEBHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:32:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313A186D2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:28:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y3so26111952ejo.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 00:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/NousMCOU2e8E7hccDsKNh4JGgzjX6q7ryA6BmSRng=;
        b=gBUPE1p+7lsQ4itS6GewgP6XozdgUjNm2CHpGIWblg5O286TIpp8Y8VU8HVPlL7xKI
         Z97lK1hGjOgDECZVjh2eU1xfKTa8dmuLv+zk5tFVsp5N4WXdzqR3PtDoDb3cbfqaJ5Hg
         Jy4uDHaUg8UBLLgRfXapyRCsMSpjo7VgqolOGpKv2nU/WIsvswLPV4nZFqnj/njrh7k9
         Ln02Zt8ib/p56Hbu4zHY2t5d16gkxXlO1mT9YDTBHUPx49miHu+1tEM9fF8RVDUl+UXo
         55lvAmxRno4i6RGOB6jrABkGgbvBvD+3tGenFZj/eOF7zJ4m11usrJErh4PmlV/dQmq0
         BY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/NousMCOU2e8E7hccDsKNh4JGgzjX6q7ryA6BmSRng=;
        b=14ojr2n45ERndG477lqzUkfE1V0ebrQRiw5dnZgr87y/YIeoSGe2SfnErdQqA5vIFi
         p2hOnHxsFmYr7z2rNVgKFtW17UqaqXbaOvUlQW7qmbNcPXreQR7Uw+dO7EkbCnXndKgs
         P+X7sNZ+EvQMoB7FRumVefO4EqncxOQ4eyBcN1WY+5kMiHUompmvgbh3S1PaRwhRztK3
         sELzP/8iA9oD8l01kFhNmMmU1LVqJkESzWOYQ2dAAm8FjnX12X5dHPRc4KLdJc6x4lKW
         54hEISdPJRyV9Y1dFw09YrugycTc/5bPf9NWpxREvYZVuguIAwcxGY0yHyxRBlZOUFLb
         0lDA==
X-Gm-Message-State: AOAM530qn1lQ5cD/xiYGs8iyEaxhONxb3bZnw+vJhKA5l5h+CEqJm0U7
        7rLosRTO/Mao6NzNyLowlaZVqQ==
X-Google-Smtp-Source: ABdhPJy1WAFLZ6+3JWSAnuTXC9t3CGDp5zLxhd0V+yCegQ2Y56/R48BrbmskPXklEKAAbTvczq4ekw==
X-Received: by 2002:a17:907:3f96:b0:6f3:cd20:b00c with SMTP id hr22-20020a1709073f9600b006f3cd20b00cmr10092926ejc.185.1651476534983;
        Mon, 02 May 2022 00:28:54 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jx28-20020a170907761c00b006f3ef214e29sm3361223ejc.143.2022.05.02.00.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 00:28:54 -0700 (PDT)
Message-ID: <dab1dd94-71af-e17c-cf90-662615c4a9f3@linaro.org>
Date:   Mon, 2 May 2022 09:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/9] ARM: dts: zynq-7000: drop useless
 'dma-channels/requests' properties
Content-Language: en-US
To:     Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220430121902.59895-1-krzysztof.kozlowski@linaro.org>
 <20220430121902.59895-2-krzysztof.kozlowski@linaro.org>
 <a838f962-354c-9dcf-c0dc-80d1a6cd4fc3@xilinx.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a838f962-354c-9dcf-c0dc-80d1a6cd4fc3@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 09:27, Michal Simek wrote:
> 
> 
> On 4/30/22 14:18, Krzysztof Kozlowski wrote:
>> The pl330 DMA controller provides number of DMA channels and requests
>> through its registers, so duplicating this information (with a chance of
>> mistakes) in DTS is pointless.  Additionally the DTS used always wrong
>> property names which causes DT schema check failures - the bindings
>> documented 'dma-channels' and 'dma-requests' properties without leading
>> hash sign.
>>
>> Reported-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Not adding acquired review tag because of significant change.
>> ---
>>   arch/arm/boot/dts/zynq-7000.dtsi | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index 47c2a4b14c06..c193264a86ff 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -343,8 +343,6 @@ dmac_s: dmac@f8003000 {
>>   			             <0 40 4>, <0 41 4>,
>>   			             <0 42 4>, <0 43 4>;
>>   			#dma-cells = <1>;
>> -			#dma-channels = <8>;
>> -			#dma-requests = <4>;
>>   			clocks = <&clkc 27>;
>>   			clock-names = "apb_pclk";
>>   		};
> 
> Acked-by: Michal Simek <michal.simek@amd.com>
> 
> If you can take it via your tree that would be great (easier for me than sending 
> pull request with just one patch) but I can also take it.

Thanks, I will take it.


Best regards,
Krzysztof
