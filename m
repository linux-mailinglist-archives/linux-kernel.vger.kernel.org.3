Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8C4FF6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiDMM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiDMM31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:29:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB45DA4E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:27:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so2148324edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UWf3WD8etSo1FUiV/Va7759QYZ2hF4d/jpBeQeYNuh0=;
        b=V1YebfM3uL4q1jK8/PspIru7Nkbh7M2BcwDi8WKctQcIrkCwf4tddAevvUJ7NJX9th
         NhUhIzyxqZ4HdW6OlwRxDPZFiTYztI9/qL97vT/L5AQmRyuUyUt27IAH/kBY0L7AcrGv
         5oJNVQdIPIZtkLwHWZMG2ZVRqAI7o+ffiPYPNFL7GKqPdroRvFIdsyPXuRi0f4eTjC9S
         ojoCIuHQnE20+96uU/aud0d6tlxB7+rbNJjg5yK46MAIcJRTXG1KZSSvmiMm6BG6KL5+
         jE7T+kRwq+ZjSc23P1MhTe4AMzDn2Bw0EXwbiCs5C3vhtcXmdKfYO5I3mlRQNHq/Mc0f
         ZiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UWf3WD8etSo1FUiV/Va7759QYZ2hF4d/jpBeQeYNuh0=;
        b=T7no2yAOFezQPRF7K5Ef17CLBvnypssMTJ2TUEWcmjktz5jtl5BrxBTeXyuaI+dWJ7
         E+ucGOx22vZ9anLre8cbcJ3MKPzpRTqX/y25kliQawwbQfExYJux2zUQ7YKQTIP4cjVH
         yGW5a6vsKCCioV8f8PmwjOATOez3r1iIKmc5q0kGJOjhps3VRjXlielU8yo5Sf8eNpnn
         S1cNAQVAkrptg8ZDWXSvaMgvF6BFBLhYxeVb8hdhQ4/X2MFE4f61daUyycJ3Q1sriepy
         hEFcqjMaqIK1WvP1MFbHLHW6RvjKU/2euH/uWSWLT4Guohle09slTXJK3aLwO9QoayZX
         Zmew==
X-Gm-Message-State: AOAM533AvhGWeuOpsl80fgLlK197JOwbR/GfYepLBDwq8gA6fptOoiZa
        OsGU7GG1lDBeZ0feMsxJRzC02A==
X-Google-Smtp-Source: ABdhPJxFkgSsSbyre3Mhq9/5vpL/TcAtBritChJHV6hHs0Thrw4NNs9uIjp2WHOlI6cLIlMu4LSdIg==
X-Received: by 2002:a05:6402:1941:b0:413:2b5f:9074 with SMTP id f1-20020a056402194100b004132b5f9074mr42989674edz.414.1649852821599;
        Wed, 13 Apr 2022 05:27:01 -0700 (PDT)
Received: from [192.168.0.204] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm14177221ejy.87.2022.04.13.05.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 05:27:01 -0700 (PDT)
Message-ID: <a4b6c158-da56-7879-04a4-558f751cb372@linaro.org>
Date:   Wed, 13 Apr 2022 14:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: imx8mm-evk: add pwm1/backlight support
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220413102052.20207-1-tommaso.merciai@amarulasolutions.com>
 <c6fe3895-29b2-a371-ccae-c5a12c45d4f1@linaro.org>
 <20220413115810.GA4713@tom-ThinkPad-T14s-Gen-2i>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220413115810.GA4713@tom-ThinkPad-T14s-Gen-2i>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 13:58, Tommaso Merciai wrote:
>>> +	backlight: backlight {
>>> +		status = "disabled";
>>
>> Why disabled?
>>
>>> +		compatible = "pwm-backlight";
>>> +		pwms = <&pwm1 0 5000000>;
>>> +		brightness-levels = <0 255>;
>>> +		num-interpolated-steps = <255>;
>>> +		default-brightness-level = <250>;
>>> +	};
>>> +
>>>  	ir-receiver {
>>>  		compatible = "gpio-ir-receiver";
>>>  		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
>>> @@ -395,6 +404,12 @@ &wdog1 {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&pwm1 {
>>> +	pinctrl-names = "default";
>>> +	pinctrl-0 = <&pinctrl_backlight>;
>>> +	status = "disabled";
>>
>> Same here.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> I think is better to keep disable into .dtsi and enable it at .dts
> level.
> What do you think about?

Why better? This is already board DTSI, not a SoC DTSI. All boards using
it are supposed to have it available, aren't they?

Usually nodes should be disabled in a DTSI if they need some resources
not available in that DTSI. For example if they need some supply. It's
not the case here, right?


Best regards,
Krzysztof
