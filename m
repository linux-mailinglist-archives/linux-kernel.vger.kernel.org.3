Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B575B1595
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIHH0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIHH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:26:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC285A97
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:26:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u18so13979156lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 00:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zV14ZrPb0sLe3LlJJhGfIpC1GJYkmJpmWMU/WGtehbI=;
        b=gfOOKl14bPeQJmyQHPROYW1RZ6gTeG51WxCl8wVG5NKJ9qO4xuN/gfd0gCd4kxvBqU
         DMWe+mlHCMvBDwxho76t33439XmBey5up5wN01r1TrCXG164S92RApQW/hXZ3NmmWjPo
         uUgll2Q7BTWa3vnxZIQCOti65s+zn0sggUR8BChQF16uIDdjvysr3q2+LvQWIiIAqJwO
         Gr8c/A5KQASdWuYHcUUrdeWZ4gZslrggA7I/uaENKqn6XQ4FcuAYoIChNLCaG8vMey/V
         nb8SvxQn1hd4owrRQdZqwzQHKrAUGQ47veTnzEuliXrZ8Wbmo7W5bsErADh0XrWdawRv
         Ohig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zV14ZrPb0sLe3LlJJhGfIpC1GJYkmJpmWMU/WGtehbI=;
        b=J4uydUaCpj45NuGxSNngEMW0Kevajpdw8ercvO3f5q2TRc7MaP+lzVSWbMfvqFnO1Y
         772W6b8IW/UVly3AyadFekZfcuYUIQxCbshGyQbpq6HRUOGoPrjdCI2o2CgjadFdCo5F
         UJIwEF+Q0T5KrCtoWahVhYwby9QTTgQGVtxMYMoWDY9KrkrTehQUrESc54/MBZB9Eojf
         1/JXn7O41d/LBvOx3fvl/DxRmmxcO3mhsBze2SkazdU5WrTCw3nAFXTiMsrpjQRzkgUX
         vavmIq1Leb6knCjONJCARceMCXsbIwCbm0H/7xA0Dknzg1aI59I25mqVrfV2Cb787Upa
         AauA==
X-Gm-Message-State: ACgBeo3ZUmDitIomKc/7SjPUteeVr6PShTP85zhaZ1iL7L8uGJPZkIVF
        HzeylgXpEtz74EaO3Wwd4UFcaw==
X-Google-Smtp-Source: AA6agR6hfBQxU5tREXAYW7heBGTbG9JR2EcyRgYr5+8t111tVvCNN1TGQEysisztgbCCE4VCgUeb8Q==
X-Received: by 2002:a05:6512:e99:b0:492:cf19:875 with SMTP id bi25-20020a0565120e9900b00492cf190875mr2349119lfb.690.1662621987999;
        Thu, 08 Sep 2022 00:26:27 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 18-20020a2eb952000000b00268335eaa8asm3072406ljs.51.2022.09.08.00.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 00:26:27 -0700 (PDT)
Message-ID: <5bf2258e-9d98-8427-07eb-f2577e6f3b54@linaro.org>
Date:   Thu, 8 Sep 2022 09:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: Add PM6125 PMIC
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220805135729.1037079-1-marijn.suijten@somainline.org>
 <20220805135729.1037079-4-marijn.suijten@somainline.org>
 <4cef00b4-c184-ae78-3709-5ed520ca3375@linaro.org>
 <20220907212747.i2y6qi75avhavyr4@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907212747.i2y6qi75avhavyr4@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 23:27, Marijn Suijten wrote:
> On 2022-08-08 12:17:06, Krzysztof Kozlowski wrote:
>> On 05/08/2022 16:57, Marijn Suijten wrote:
>>> This PMIC is commonly used on boards with an SM6125 SoC and looks very
>>> similar in layout to the PM6150.
>>>
>>> Downstream declares more nodes to be available, but these have been
>>> omitted from this patch: the pwm/lpg block is unused on my reference
>>> device making it impossible to test/validate, and the spmi-clkdiv does
>>> not have a single device-tree binding using this driver yet, hence
>>> inclusion is better postponed until ie. audio which uses these clocks is
>>> brought up.
>>>
>>
>> Thank you for your patch. There is something to discuss/improve.
> 
> I can respin the series with the suggested changes (and the iio patch
> removed as that has now been applied), but note that all other PMIC dtsi
> files as of -next today still carry the "wrong" adc-tm or gpios node
> names.  Are there plans to patch those up too (if not already in a
> series that I missed)?

See below

> 
> - Marijn
> 
>>> +
>>> +			xo-therm@4c {
>>> +				reg = <ADC5_XO_THERM_100K_PU>;
>>> +				qcom,pre-scaling = <1 1>;
>>> +				qcom,hw-settle-time = <200>;
>>> +				qcom,ratiometric;
>>> +			};
>>> +		};
>>> +
>>> +		pm6125_adc_tm: adc-tm@3500 {
>>
>> Generic node names, so either this is adc or thermal-sensor. Looks like
>> thermal-sensor.

My comment was here not correct. The schema indeed expects this to be
adc-tm. I did not plan to change it, so let's keep adc-tm also here.

>>
>>> +			compatible = "qcom,spmi-adc-tm5";
>>> +			reg = <0x3500>;
>>> +			interrupts = <0x0 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			#thermal-sensor-cells = <1>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pm6125_rtc: rtc@6000 {
>>> +			compatible = "qcom,pm8941-rtc";
>>> +			reg = <0x6000>, <0x6100>;
>>> +			reg-names = "rtc", "alarm";
>>> +			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>>> +			status = "disabled";
>>> +		};
>>> +
>>> +		pm6125_gpio: gpios@c000 {
>>
>> s/gpios/gpio/

Both are allowed by schema, but convention in all other cases is "gpio",
so let's change it. I'll send a patch for other files.

Best regards,
Krzysztof
