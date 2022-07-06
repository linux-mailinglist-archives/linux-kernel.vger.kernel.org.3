Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8E56918C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGFSQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiGFSQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:16:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21CB5FF0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:16:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bu42so7425027lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OD75XxCwnED+FS5wDk/RwNU3mc/oEXTZU6iEW1jy/AA=;
        b=enNCpRpLSPco3263TwwGPuW4YQAoukdfvw/6dI4TtK37J4vjsMgQ6a+FaWF+Mhkx7b
         MHGt7Vtsu584ZOHcOR6sFOlvSm1O1ITZdbBV6KB+L5wUy/eSiYMVHdHz+o6gOI6io9NZ
         fYWPuTdmOpRUbFI0Y8y2clDj9A96EKH0v0BEf5khCNOd+pLvDxOybz8VSMY/3obRIMvQ
         B+BxoFvQINouX+nOwZ+SayABbwAONw9RmhLlZLbWDfFnyxP8lbKxinwgHIIl8YUSPA05
         5DAZCqje0eNjwIK0ZdAJKHlBu++M7G+AIKo/n4d6ewKfygCI0p/Y4JtdNV1kqrHeGQId
         /7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OD75XxCwnED+FS5wDk/RwNU3mc/oEXTZU6iEW1jy/AA=;
        b=0pSzMQgTCT4jRqorLUVBEBieuupRyWOP6auDDELjbdCJpX1uOC77gGpGnax9KRKxqn
         7ecKPEPh4/IeD0+pPzmiDPslAZiueCzABDACr2cQiwUsbLIAwKisw8fmPuzDNPEDFv3E
         0dnPp5PMi9/e9t/ANuO6xnRHkQ2/wP+s16GK3yIlIHoCzZt77S0mJE7DpedAr+/npX8n
         zfw/uI95y+wk8KcbEF+BRxFSy9XiKiFRccVgFjfLBD4sbMtNUy3StnHly/TiWbPGRqFn
         wy1UjecgqcIE6rYtYenIm6Bxq7bujROWNQ9sFVD9ym/67maGHXTLEXPxm0RaNRzRC370
         kwIQ==
X-Gm-Message-State: AJIora/8LvgcZMuRTbmN5rib+XZuWPD9KHt+rKHSSFC5JMlMrEnMKXeE
        mho6Abnu5kSkhEjX9MB8Tij8xA==
X-Google-Smtp-Source: AGRyM1vlTSDepPmb4CPBwh36YAfQLpzXxUXnSgiBNoiUoqkpIvuHzue1UGpTOo0IR7n2mqEABuaTsA==
X-Received: by 2002:a05:6512:118b:b0:46b:a9ae:3a3b with SMTP id g11-20020a056512118b00b0046ba9ae3a3bmr3697317lfr.188.1657131413946;
        Wed, 06 Jul 2022 11:16:53 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id i17-20020a2ea231000000b002555d6ca497sm6343498ljm.115.2022.07.06.11.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 11:16:53 -0700 (PDT)
Message-ID: <c285332f-dde9-2e71-8637-0526c4baeb1e@linaro.org>
Date:   Wed, 6 Jul 2022 20:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Content-Language: en-US
To:     =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org> <20220706131507.353f0bed@thinkpad>
 <20220706111912.hz2mx4dc35lgq6l5@pali> <20220706172732.6228d180@thinkpad>
 <25b43586-eeb3-4b7b-7362-2d599aa89cf0@linaro.org>
 <20220706184301.3f42a692@thinkpad>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220706184301.3f42a692@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2022 18:43, Marek Behún wrote:
> On Wed, 6 Jul 2022 17:36:43 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 06/07/2022 17:27, Marek Behún wrote:
>>> On Wed, 6 Jul 2022 13:19:12 +0200
>>> Pali Rohár <pali@kernel.org> wrote:
>>>   
>>>> On Wednesday 06 July 2022 13:15:07 Marek Behún wrote:  
>>>>> On Tue,  5 Jul 2022 17:59:28 +0200
>>>>> Pali Rohár <pali@kernel.org> wrote:
>>>>>     
>>>>>> +examples:
>>>>>> +  - |
>>>>>> +    #include <dt-bindings/leds/common.h>
>>>>>> +
>>>>>> +    cpld@3,0 {    
>>>>>
>>>>> The generic node name should be just "bus". That it is a CPLD
>>>>> implementation should come from compatible string.    
>>>>
>>>> Sorry, I do not understand why "bus". Why other memory chips are named
>>>> e.g. "nand" or "nor" and not "bus" too?  
>>>
>>> As far as I understand this is because that is the preferred name for
>>> busses and this is a bus, since there is also the simple-bus compatible.
>>>   
>>>> By this logic should not be _every_ node called just "bus"? Hm... and 
>>>> are names needed at all then?  
>>>
>>> :-)
>>>
>>> The schema
>>>   https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/simple-bus.yaml
>>> allows for different names (soc|axi|ahb|*-bus) to avoid warnings on
>>> existing old dts files.
>>>
>>> The preferred way is to not have the implementation in nodename,
>>> similar to how we use 'switch' instead of 'mv88e6xxx', or
>>> 'ethernet-phy' instead of 'mv88e151x', or 'led-controller', ...  
>>
>> Thanks Marek for detailed explanation.
>> The cases above rather trigger my comments and this one here, after
>> Pali's explanation, do not fit them. pld is a generic class of a device,
>> so it is okay here. cpld probably as well (although one could argue that
>> it is a subset of pld, so the generic name is pld, but then one would
>> say fpga also should be called pld). For me it does not have to be bus,
>> just don't want mv88e6xxx or any other vendor/model names. Therefore
>> cpld is fine.
> 
> What about cpld-bus? It is used as a bus (simple-bus compatible) and
> would work with the *-bus pattern in dt-schema.

If we talk about the example - it does not use any compatible, so we are
focusing on unimportant piece. Anyway using a simple-bus compatible does
not necessarily mean it is a bus. "soc" nodes also use it, but these are
not buses.


Best regards,
Krzysztof
