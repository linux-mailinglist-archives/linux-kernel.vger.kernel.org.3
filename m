Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4987B597EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiHRHEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbiHRHEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:04:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2285F84
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:04:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so1004031lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=JIhqnGFxqlWQT6HH4YHYR+CEvA6ZgGkLEwhbs6gjVNs=;
        b=UUBPeBvh9P4fC4LIsBACFCj8EcocoO1lfi9Myu5LoHIUmC3lNTgkVaDbp3fIl2j+uB
         F8VhDacewf2PyFD5FWP51bIjbd3i10tzjSYmH68d3o9Jhr8VLJps+uidbXPD25i9lVtI
         csVu6kYWk6/yyIln8g2TJFgDfnW8KJ9/QJRh+dMzp96izrrrDa2CDMKXhy9sVaiaPM5A
         fKo3456HiZgXTH2rUU1rKOP14HkZ8vzcSqqEBsKSNKoA2K4NwnpViC7nKqltBrYoAhI8
         qi3lIER0jOHP3Pr1a512FiZhB6makQvYx5WBMU18wNNl9U+jiFgZueE+fwm3XTftum1/
         vcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JIhqnGFxqlWQT6HH4YHYR+CEvA6ZgGkLEwhbs6gjVNs=;
        b=RYrkaJYBC55sOU7oFfxg1BsNpB/kz51nNpFvDs8v8TaeGj1aTBoNh2TMXVJJxLdo66
         vkLA146To4T3aWUGMTbZOJrFCFBstmf/cTSxZO+APxiJTS255ALPGFTYhJfX4QeOjuml
         g0258nVZIfxqLZhgzub2uxSHvAwNbZILI3VAh/x4Z/7sUyTW067fb7gUgLeJ+Y2LpY+C
         iYT3/iukWc/RQ8lssoO03PIl953rIhxfxHljd39KO6GwtDUd0cYP5aDnniTMNPffaGox
         bzSaEGDy/frsDeBnF8uCqE7NyFzmdE4cMMMWBTqkrK5SKRw5m7aGVpBXyEWxzoWmqRvV
         aT1A==
X-Gm-Message-State: ACgBeo1tfSULSNjFIYq5uEOMLJGVUU9Sx2MAmelp5Fx7L7l/6hgHxOhf
        /cUNjO/2UOqJkYzjOwQ2HfAEIg==
X-Google-Smtp-Source: AA6agR4Oc8syUDVbDFu8aECZoYEKFU7OJbEOvOx68plORXAqXVUa1yzPSH8X875MRPp/TKNNYJlHWg==
X-Received: by 2002:a05:6512:c25:b0:48b:1241:fb9f with SMTP id z37-20020a0565120c2500b0048b1241fb9fmr561581lfu.74.1660806258450;
        Thu, 18 Aug 2022 00:04:18 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512371400b0048b3768d2ecsm107282lfr.174.2022.08.18.00.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 00:04:17 -0700 (PDT)
Message-ID: <4aea569f-38c1-953c-8293-25d6fb5e4477@linaro.org>
Date:   Thu, 18 Aug 2022 10:04:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH v2 14/14] arm64: dts: qcom: sm8150: switch TCSR mutex
 to MMIO
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817130342.568396-1-krzysztof.kozlowski@linaro.org>
 <20220817130342.568396-15-krzysztof.kozlowski@linaro.org>
 <15fb94b1-e901-c139-3f83-21922ae28c35@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <15fb94b1-e901-c139-3f83-21922ae28c35@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 00:07, Konrad Dybcio wrote:
> 
> 
> On 17.08.2022 15:03, Krzysztof Kozlowski wrote:
>> The TCSR mutex bindings allow device to be described only with address
>> space (so it uses MMIO, not syscon regmap).  This seems reasonable as
>> TCSR mutex is actually a dedicated IO address space and it also fixes DT
>> schema checks:
>>
>>   qcom/sm8150-mtp.dtb: hwlock: 'reg' is a required property
>>   qcom/sm8150-mtp.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> index 7d509ecd44da..dc6770391813 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
>> @@ -585,12 +585,6 @@ scm: scm {
>>  		};
>>  	};
>>  
>> -	tcsr_mutex: hwlock {
>> -		compatible = "qcom,tcsr-mutex";
>> -		syscon = <&tcsr_mutex_regs 0 0x1000>;
>> -		#hwlock-cells = <1>;
>> -	};
>> -
>>  	memory@80000000 {
>>  		device_type = "memory";
>>  		/* We expect the bootloader to fill in the size */
>> @@ -2054,9 +2048,10 @@ ipa_virt: interconnect@1e00000 {
>>  			qcom,bcm-voters = <&apps_bcm_voter>;
>>  		};
>>  
>> -		tcsr_mutex_regs: syscon@1f40000 {
>> -			compatible = "syscon";
>> -			reg = <0x0 0x01f40000 0x0 0x40000>;
>> +		tcsr_mutex: hwlock@1f40000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0 0x01f40000 0 0x20000>;
>> +			#hwlock-cells = <1>;
>>  		};
> No replacement for the trailing 0x20000?
> 

There is no user of it, so I did not add. I could add remaining block
just for completeness.


Best regards,
Krzysztof
