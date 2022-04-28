Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15039513193
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiD1Ksj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiD1Ksf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:48:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E713890BE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:45:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g6so8744772ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cYKCRoREjH87n5LGj1ImFAnKPWrOHAXKmxpNcNNNnIw=;
        b=l17YCFMxKiwjEr5HZ0HPvJ9Lp/No3mKPtEwmSTNmRmgT2RGTJcYSTwyW3ZAGFxNhhG
         hemeitu4DciYBdWDTVfpRkaS4x14zdyI4L6NtXH1TBAWKHDN9AyxE/u3/GlKo2LuRr8S
         R5kWe+WsFQl6l1GEXZamWspcggud4YW1AHazmNflTGkpcSZN2UwIGJ457pndK0rlZbk5
         bDtLeUKFu+7YurGBdZ2t+SrjRzkoneO4541QY4RHWSC+7E2Bm+EVDy+YyF8Y40k0FiJZ
         UT+6IDNuGkq8AQRkGQh4GZGA6YYifsOo8ZX1qcpZWS09L30vH/rRXx09o4OVFllVV0xL
         t3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cYKCRoREjH87n5LGj1ImFAnKPWrOHAXKmxpNcNNNnIw=;
        b=1BLW+9Im3DwupLS7mkQcGV/C7zZZlbZJEF5aURLrN6LqWrWqSjvHeDuL0F5bDK4+qH
         I33/D77vKO+zANBhXGCsGGBisoUnpIHE6WEBL9uICIjKQw64FGAPANDh75ITwS6LNoGw
         Xllufbf60v1sAgziGvq0N4eaU/IrMu54M5iMuiCM8LA4TN5p7RlR+GsNRohK0E7xlHt0
         04dTZ5WCZAH30e1b8WoedaLFNxnX2vddVPuzDjPt6NPAevsYTWyv2yyHGIakKD4tu63r
         m8pR70rlnTObC0J7+uOZeDtCEn7xWSaV907iJ/cOdtgLiKWts9fkeptUUEL1EHBJgqVe
         yzVQ==
X-Gm-Message-State: AOAM5325yi7rZa+3ctLY2oyqTIb+ME+1JFEz4WDKMXJutyd1+NaTwe/6
        yDydKtNELNIr090rmjdK7Bgyjw==
X-Google-Smtp-Source: ABdhPJyp6f5iGveZCxbZ+tLf8F4Iv7cCwecumgh+r4Mv003t4J9QnoHQJbOmBYZwweCyrVxme8/N/g==
X-Received: by 2002:a17:907:7ba3:b0:6ef:f9ca:f2da with SMTP id ne35-20020a1709077ba300b006eff9caf2damr20181561ejc.634.1651142719668;
        Thu, 28 Apr 2022 03:45:19 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709060f4700b006e8d0746969sm8053221ejj.222.2022.04.28.03.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:45:19 -0700 (PDT)
Message-ID: <d8448fa4-3cec-db1c-c132-d875cab61572@linaro.org>
Date:   Thu, 28 Apr 2022 12:45:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 04/10] arm64: dts: juno: use proper
 'dma-channels/requests' properties
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <20220427155840.596535-5-krzysztof.kozlowski@linaro.org>
 <1d1aae6e-50db-d6db-9727-62f9c2d1ca6b@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1d1aae6e-50db-d6db-9727-62f9c2d1ca6b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 12:43, Robin Murphy wrote:
> On 2022-04-27 16:58, Krzysztof Kozlowski wrote:
>> pl330 DMA controller bindings documented 'dma-channels' and
>> 'dma-requests' properties (without leading hash sign), so fix the DTS to
>> match the bindings.
>>
>> Reported-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> index 4f40a5c8f565..96ef0ddc0b2d 100644
>> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
>> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
>> @@ -829,8 +829,8 @@ dma-controller@7ff00000 {
>>   		compatible = "arm,pl330", "arm,primecell";
>>   		reg = <0x0 0x7ff00000 0 0x1000>;
>>   		#dma-cells = <1>;
>> -		#dma-channels = <8>;
>> -		#dma-requests = <32>;
>> +		dma-channels = <8>;
>> +		dma-requests = <32>;
> 
> BTW, this has always been wrong - Juno is configured with only 8 request 
> interfaces. But then it's moot anyway since PL330 has an ID register for 
> this stuff[1], so the DT properties aren't used by Linux, and shouldn't 
> be needed in general.

Marek also raised the point [1] that these properties are useless for
PL330 because the actual data is read from the device registers.

I understand you are also supporting the idea of removing them from
pl330 device nodes?

[1]
https://lore.kernel.org/linux-devicetree/20220427155840.596535-1-krzysztof.kozlowski@linaro.org/T/#mf108b8c9f0d513ebc6e381775e3c6887b5c2fe31

Best regards,
Krzysztof
