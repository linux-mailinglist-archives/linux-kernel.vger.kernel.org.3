Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93D5712A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiGLHCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiGLHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:02:05 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4FE8CC8D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:02:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t1so8856296lft.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rR4EvPz2QTL/uIlV/7u9u2k3BsIB6Cd/Y2fmLLbm+6Q=;
        b=uv2LG7gzP10xj/mheaKVtOSrTN+X0UgE93fZG1uQNEpadxp50LH8Wy6Nb+ABdxSpFm
         B4ik9P6lWDr3pkePBdZ5WVfIHNQJB1iZdsDBFbuKkGmwpvwVYB1mQ7TlzJreqpP/7y6q
         Hpa3hqo05U29UPqt2oLIG4BsnlwCiJiPZtr/u1WI29lQpVbeGTgyyM5hVCiVpjX1yiZs
         Q4NIrluD9usVxYsfHc9sGHN0SS1C7ElIyyy8ySmBekz5t4ckAnHO5F/8Nn3J06LO3FYz
         ugCpqa4Ff8QbFTsnd1J0VBqMGRmvUbnYwJfz4hjJIstdQHANHF9OQPUcaRxCV7AWMPTc
         eaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rR4EvPz2QTL/uIlV/7u9u2k3BsIB6Cd/Y2fmLLbm+6Q=;
        b=M5wTcCK3km9cBJputMkCqN9V3YxShHKw3D7iePTZcnqRf4ETEjfF0QOkgTjMC2ZkyB
         aSiYpT+TFIMrJecPp02a1co1IRBzxXC3JjDVykmcR5hpMoNG354NxmwmOa0nMlQTgLaC
         81PJH1SV70MgF5K1mWE9XCSqNqi96Nb5Vl6kBBWPgTEClIVeG8iAZ4EnMov40z2Thd7w
         203n2WluOCZ6ZzUdlaKaYaAnZxaO07h3iahFke/+Gk58qMRV7EA6rS7gabd+Bn/7AR0T
         HhFNCcoc/OuSMMAfA6m1/p6p+IWTZcqhsnM51XKUcLA97eSrTHOW+tL9TSNzF4IYCDSO
         V5Lw==
X-Gm-Message-State: AJIora+/JllCfzzc1rjR3nDyFCL4O0W/9BiL/bmAka8QqPUeFjjy9fa5
        PlYR8KgQoBcS00Y6XOZC5ONLDw==
X-Google-Smtp-Source: AGRyM1v8I7FEdMPilvPTeX/T5acQuHUvYJJlCGQqXlGNHZ8ieSAEOmPjfUgENxvwkU4d+kyg3znBVA==
X-Received: by 2002:a19:520f:0:b0:489:dc56:df68 with SMTP id m15-20020a19520f000000b00489dc56df68mr6534018lfb.295.1657609322071;
        Tue, 12 Jul 2022 00:02:02 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b00489da32ec80sm1387629lfr.238.2022.07.12.00.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:02:01 -0700 (PDT)
Message-ID: <69e8195e-8d2b-3df0-0783-269f9aef1a83@linaro.org>
Date:   Tue, 12 Jul 2022 09:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/3] dt-binding: power: power-domain: add
 power-supply-needs-irq
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, robh@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220711094549.3445566-1-martin.kepplinger@puri.sm>
 <20220711094549.3445566-2-martin.kepplinger@puri.sm>
 <c68e4ae9-c435-c74e-91cd-b153be6de92f@linaro.org>
 <f2142a9816095eca504c464a6221a96a0cbd6b54.camel@puri.sm>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f2142a9816095eca504c464a6221a96a0cbd6b54.camel@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 15:17, Martin Kepplinger wrote:
> Am Montag, dem 11.07.2022 um 12:38 +0200 schrieb Krzysztof Kozlowski:
>> On 11/07/2022 11:45, Martin Kepplinger wrote:
>>> Add the power-supply-needs-irq board description property for power
>>> domains.
>>
>> Where is a board description here? I think you just meant
>> "power-supply-needs-irq property"?
>>>
>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>>> ---
>>>  .../devicetree/bindings/power/power-domain.yaml        | 10
>>> ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/power-
>>> domain.yaml b/Documentation/devicetree/bindings/power/power-
>>> domain.yaml
>>> index 889091b9814f..e82c2f7ccb97 100644
>>> --- a/Documentation/devicetree/bindings/power/power-domain.yaml
>>> +++ b/Documentation/devicetree/bindings/power/power-domain.yaml
>>> @@ -70,6 +70,16 @@ properties:
>>>        by the given provider should be subdomains of the domain
>>> specified
>>>        by this binding.
>>>  
>>> +  power-supply: true
>>
>> This is a new property not described in the commit msg.
> 
> true, I think it's missing and could be added as a separate patch.
> 
>>
>>> +
>>> +  power-supply-needs-irq:
>>> +    type: boolean
>>> +    description:
>>> +      A power-supply can link for example to a regulator
>>> controlled via
>>> +      i2c or otherwise needing interrupts enabled to be able to
>>> enable and
>>> +      disable. 
>>
>> Not really a property of power domain. How the regulator supply works
>> is
>> entirely up to regulator. Otherwise such property should appear for
>> every device.
> 
> you're right. The power-domain driver could read the power-supply
> regulator node directly. Still, I think then a new regulator property
> is needed instead, or is it?

In case of regulator, I am not so sure it needs a dedicated property of
DT. If it is I2C regulator - the parent node is I2C bus and regulator
device is some child of I2C controller (could be via a MFD device), so
no need for dedicated property.

If it uses interrupts, then:
1. The presence of interrupts is already known - "interrupts" property.
2. The actual use of interrupts is DT independent and only driver knows it.

Best regards,
Krzysztof
