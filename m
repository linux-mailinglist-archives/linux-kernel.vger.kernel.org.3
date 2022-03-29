Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948984EA985
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiC2IqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiC2IqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:46:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686D1158D82
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:44:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so23684995wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Htf510lK0K0COaDanUWn9grVtQC7hoD/BNW+qqmuIzY=;
        b=ydBG1SsWkporM4icCaqCFjTWkROmyeZ3Ob2QMeUEysrgdC5VYUgoGRvr4YNO9iM4IE
         Q35Kd0kUOiX8ntz3z8DvfqgdwqJvlTg3LEfM5rxB2jEj9t4Xnmj8mLV+cObDjIbfc6XV
         D8iskwAMbGIHPwVuHwzVfISuyCPF70kHf6V4h/PAjqrILHZk34gFraz9T+xsFxuQMXgP
         Xts8GamC1I0k0AI6yB1cft2NSAVgv/UQ6Tiacv+tP6HGXlw/jxZ3vWp8jtnkYB/OZerU
         v72nRUIU8p6F/mTy/4p7xT7/geVhhU1OetUz2uL3JDjNUdIQFzwgVSQ+TLVgCQHi1sZI
         OZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Htf510lK0K0COaDanUWn9grVtQC7hoD/BNW+qqmuIzY=;
        b=6c2Ol9JidEp9UF3Grd1h6RhdCbopscIbylREIm3gPKWlyHlXavqc5PC8NU134iDSxo
         G3oX0eMKSd7juyZxi5RY0YvK8VdwQIz6VbgskLLbY0Ag1esCkL5W23P+IGsDeFh43HfD
         aDImE8GXL50yDebiSXNgREeRrYriuBGdmCnZlgb9pKmJFCDAHv+TWp05R88b8hplr1BC
         1GZFVy3nXDmpSMLLSKw+jpeSCm+DG3hwn/w84YmXM803SW8fG3RfU7YQDFCWHgT7tuHJ
         atx1Wxkeo/QqvTxYMP9tQt0ZjC0fclKkTFAzuLR4Vl2CfcqKFULk4ffxH1x6+YsXJJw5
         c2Qw==
X-Gm-Message-State: AOAM531UgenhEDqiOIm51CTpIE/MIUbGplHyI4bGLNITVvPSgJe6uSI6
        rhyA0HUGPbrkNRPLSmNxs7tmjg==
X-Google-Smtp-Source: ABdhPJxOxk74gcWW7ZlOUIH21Esvp3h7kP/TrINagIG08xeGiSbVPKvEo/5GjZ/XH8OljMI9dvwPqw==
X-Received: by 2002:adf:df8c:0:b0:203:e4f3:920 with SMTP id z12-20020adfdf8c000000b00203e4f30920mr29736954wrl.461.1648543470930;
        Tue, 29 Mar 2022 01:44:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z18-20020a5d6412000000b0020400dde72esm14180734wru.37.2022.03.29.01.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 01:44:30 -0700 (PDT)
Message-ID: <ae78d199-a782-75ed-5178-c9757be79f5d@linaro.org>
Date:   Tue, 29 Mar 2022 09:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250: move wcd938x node out of
 soc node
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220328143035.519909-1-vkoul@kernel.org>
 <20220328143035.519909-6-vkoul@kernel.org>
 <0b43c297-d0d6-f38f-9609-47fca856aa6d@linaro.org> <YkHssmiGup+LdIBC@matsya>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YkHssmiGup+LdIBC@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2022 18:13, Vinod Koul wrote:
> On 28-03-22, 17:21, Krzysztof Kozlowski wrote:
>> On 28/03/2022 16:30, Vinod Koul wrote:
>>> The soc node expects all the nodes to have unit addresses. The wcd codec
>>> node does not have that which causes warnings:
>>>
>>> arch/arm64/boot/dts/qcom/sm8250-mtp.dts:631.17-648.4:
>>> Warning (simple_bus_reg): /soc@0/codec: missing or empty reg/ranges property
>>>
>>> Move wcd node out of soc to fix this
>>>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
>>>   1 file changed, 19 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
>>> index fb99cc2827c7..3876a94b49a9 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
>>> @@ -156,6 +156,25 @@ vreg_s6c_0p88: smpc6-regulator {
>>>   		regulator-always-on;
>>>   		vin-supply = <&vph_pwr>;
>>>   	};
>>> +
>>> +	wcd938x: codec {
>>
>> This probably should be under "sound" node. Anyway having it under soc
>> seemed incorrect.
> 
> yeah it might make sense to be under sound. I think this is a slimbus
> codec (right Srini..?) and this should be under slim node..

wcd938x can be moved out of soc node but not under sound as it is.

If we plan to move external codecs under sound node then sound node has 
to be converted in to a simple-bus I guess. If we do that we have to 
make sure that we are consistent across all the qcom dts. This does 
sound correct either.

Currently sound node is only used for sound-card, sound card uses LPASS 
IP which is part of SoC along with external or internal codecs.

I am not 100% sure moving aggregate devices like sound card which uses 
SoC components along with external components out of soc node is the 
right choice.

Moving sound out of soc node might also add some regressions as sound 
device is sometimes used to allocate dma memory, so we have to be 
careful with this move.

The reason why sound node is empty in SoC is because the wiring of dais 
are board specific. We could add compatible string to soc sound node if 
that helps clear some confusion.
> 
>>
>> I actually wonder where this wcd9380 sits? What type of bus?

WCD938x codec has two parts wcd938x-tx and wcd938x-rx which are under 
there respective SoundWire bus.

We can not move wcd938x-tx and wcd938x-rx out of there bus nodes which 
result with no device enumeration.

--srini



>>
>>
>>> +		compatible = "qcom,wcd9380-codec";
>>> +		#sound-dai-cells = <1>;
>>> +		reset-gpios = <&tlmm 32 0>;
>>> +		vdd-buck-supply = <&vreg_s4a_1p8>;
>>> +		vdd-rxtx-supply = <&vreg_s4a_1p8>;
>>> +		vdd-io-supply = <&vreg_s4a_1p8>;
>>> +		vdd-mic-bias-supply = <&vreg_bob>;
>>> +		qcom,micbias1-microvolt = <1800000>;
>>> +		qcom,micbias2-microvolt = <1800000>;
>>> +		qcom,micbias3-microvolt = <1800000>;
>>> +		qcom,micbias4-microvolt = <1800000>;
>>> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
>>> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>>> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>>> +		qcom,rx-device = <&wcd_rx>;
>>> +		qcom,tx-device = <&wcd_tx>;
>>> +	};
>>>   };
>>>   
>>>   &adsp {
>>> @@ -627,27 +646,6 @@ &slpi {
>>>   	firmware-name = "qcom/sm8250/slpi.mbn";
>>>   };
>>>   
>>> -&soc {
>>> -	wcd938x: codec {
>>> -		compatible = "qcom,wcd9380-codec";
>>> -		#sound-dai-cells = <1>;
>>> -		reset-gpios = <&tlmm 32 0>;
>>> -		vdd-buck-supply = <&vreg_s4a_1p8>;
>>> -		vdd-rxtx-supply = <&vreg_s4a_1p8>;
>>> -		vdd-io-supply = <&vreg_s4a_1p8>;
>>> -		vdd-mic-bias-supply = <&vreg_bob>;
>>> -		qcom,micbias1-microvolt = <1800000>;
>>> -		qcom,micbias2-microvolt = <1800000>;
>>> -		qcom,micbias3-microvolt = <1800000>;
>>> -		qcom,micbias4-microvolt = <1800000>;
>>> -		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
>>> -		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>>> -		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>>> -		qcom,rx-device = <&wcd_rx>;
>>> -		qcom,tx-device = <&wcd_tx>;
>>> -	};
>>> -};
>>> -
>>>   &sound {
>>>   	compatible = "qcom,sm8250-sndcard";
>>>   	model = "SM8250-MTP-WCD9380-WSA8810-VA-DMIC";
>>
>>
>> Best regards,
>> Krzysztof
> 
