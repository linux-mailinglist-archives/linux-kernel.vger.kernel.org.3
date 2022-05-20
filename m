Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD27852EDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350090AbiETOFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiETOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:05:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B333FBE6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:05:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a23so9766685ljd.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZSoP2XlUk6Qy7Ea7GRzy0ZIIx3kZ4kuDve6bLr9v0FU=;
        b=yZ7J79WDUdV51e938vwl8Msup096rZpqY3nfbFVUSKIUsFNyR9/8ag2cYlrkTwwd4j
         dzZp5Q8ZAPU2TGmWct9hvwvGO5p7DJBUN4h0uyZVFdCET035Vo4nNx4MsSk1qAT47pQA
         drqkvYRuaUZW4zjj/+26jewpvDM/Q+/ePQamoMnK9aMKZMZwer8TTNLcYsOh43jg1Ea4
         silS4SJaRvPEmOyuqRjs8GNNPnybOonmk1N0ISaO1zK2aNYVxLwvoHTVJSP/9xk+zZDu
         SfxyAy7fRJd+Z5jhFzbXthmH25wM/9sAc0Q7xFwyMGnZGOY8nDRSPW6Kb8+8zShydSje
         9LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZSoP2XlUk6Qy7Ea7GRzy0ZIIx3kZ4kuDve6bLr9v0FU=;
        b=nIlA8CDS7nOKSoJIYUyckrGxGBFs8WGhW2WGkvUJ1HAtE0YD6SQmAVHgk/1PUD/VzH
         bjROWNusEfZusoP3pjZAmBhERC4TQYAQBiu5VKPln3zFcE0NmP1kLynhXVhAQk/kwrOp
         oPX5v9q7DFN2+nUg7aprS9JW71xLwiNdcAR/w4gFrgL1mr+hOQ/QTDdDkZJBv8E0hUQh
         nS6I9JVfRBRjxlYNlgo0Q42reH66ptzO3C/RdUMJOElpI6obHVOmtTfQS8kCC/ZxUpeP
         Qusx3w3YsK4nTe8RHHP5rSl6SAKGfzSSkChV9YmABEp2YmySG9xmg/1uDbHb4hW3ZdvM
         Xjbw==
X-Gm-Message-State: AOAM530Dg3vKxUK7IyTxJCRA0/rNJHdWPDNhhcH9EyUhAZGlQ3/TG4kt
        h1TpYqb2GpmKnEUvl+GlI6Uu0A==
X-Google-Smtp-Source: ABdhPJz18nK01Tozrb9341q0LvZVpstDY2wZjBWCLDMz2lSdMvfGQvcov2arOdxJJBKxZIyeoFm34g==
X-Received: by 2002:a2e:a54b:0:b0:250:5abe:4e97 with SMTP id e11-20020a2ea54b000000b002505abe4e97mr5392296ljn.458.1653055509621;
        Fri, 20 May 2022 07:05:09 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512024400b00477a6c86f17sm676907lfo.8.2022.05.20.07.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:05:09 -0700 (PDT)
Message-ID: <862862a6-afde-234a-ccb1-d3781d867775@linaro.org>
Date:   Fri, 20 May 2022 16:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] dt-bindings: usb: atmel: Add Microchip LAN966x
 compatible string
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
 <20220513105850.310375-3-herve.codina@bootlin.com>
 <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
 <20220520133426.3b4728ae@bootlin.com>
 <b087c34f-0e2f-edd0-a738-3ffc2853a41b@linaro.org>
 <20220520142109.57b84da2@bootlin.com>
 <01b31a02-523e-10bf-3b46-5b830e456522@linaro.org>
 <20220520150243.625723fa@bootlin.com>
 <d26c7ebd-fc1a-391e-39e4-5ec41bf4fbfa@linaro.org>
 <YoedFkAsTdoOn/3Y@mail.local>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YoedFkAsTdoOn/3Y@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 15:52, Alexandre Belloni wrote:
> Hello,
> 
> On 20/05/2022 15:38:36+0200, Krzysztof Kozlowski wrote:
>> On 20/05/2022 15:02, Herve Codina wrote:
>>> On Fri, 20 May 2022 14:50:24 +0200
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 20/05/2022 14:21, Herve Codina wrote:
>>>>>>> I think it makes sense to keep 'microchip,lan966x-udc' for the USB
>>>>>>> device controller (same controller on LAN9662 and LAN9668) and so
>>>>>>> keeping the same rules as for other common parts.    
>>>>>>
>>>>>> Having wildcard was rather a mistake and we already started correcting
>>>>>> it, so keeping the "mistake" neither gives you consistency, nor
>>>>>> correctness...
>>>>>>  
>>>>>
>>>>> I think that the "family" compatible should be present.
>>>>> This one allows to define the common parts in the common
>>>>> .dtsi file (lan966x.dtsi in our case).
>>>>>
>>>>> What do you think about:
>>>>> - microchip,lan9662-udc
>>>>> - microchip,lan9668-udc
>>>>> - microchip,lan966-udc  <-- Family
>>>>>
>>>>> lan966 is defined as the family compatible string since (1) in
>>>>> bindings/arm/atmel-at91.yaml and in Documentation/arm/microchip.rst
>>>>>   
>>>>
>>>> You can add some family compatible, if it makes sense. I don't get why
>>>> do you mention it - we did not discuss family names, but using
>>>> wildcards... Just please do not add wildcards.
>>>
>>> Well, I mentioned it as I will only use the family compatible string
>>> and not the SOC (lan9662 or lan9668) compatible string in lan966x.dtsi.
>>> In this case, the family compatible string can be seen as a kind of
>>> "wildcard".
>>
>> I understood as "the "family" compatible should be present" as you want
>> to add it as a fallback. It would be okay (assuming devices indeed share
>> family design). If you want to use it as the only one, then it is again
>> not a recommended approach. Please use specific compatibles.
>>
>> I mean, why do we have this discussion? What is the benefit for you to
>> implement something not-recommended by Devicetree spec and style?
>>
> 
> Honestly, I would just go for microchip,lan9662-udc. There is no
> difference between lan9662 and lan9668 apart from the number of switch
> ports.

Thank you, and maybe that was misunderstanding - I do not propose to add
additional lan9668 compatible, if it is not actually needed.


Best regards,
Krzysztof
