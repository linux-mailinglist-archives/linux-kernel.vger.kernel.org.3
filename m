Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E6596BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiHQI5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiHQI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:57:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160588035F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:57:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z16so15396256wrh.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=b0Hbu1BABi8Xh8b3bvkqzLWTDHQ7JLqil1MsktXkomc=;
        b=H1rBkQzh9tCamdDvX5WJuSKYyliKjdA7gLziAw+J6QBIcwTgLqgRoWkR22Jd2qb7T5
         UmPOZrVilaLP73T/OJRsQMK5piwYfLIHdiIT/Z4acOw794l4EVKoLhuHjLlvDkKPSxNI
         /eo3MCpYoLdgjAT4VQncss0H1K50GzmPHPkeDMTCO2ZC62193OU0RlSIW2eAtzxE+H9P
         XthKg3tC0PAZrTpbnlz3cOIA9DVy8ieiUV+ookr1xvDxqHjP43XJFTulS6ilZMobitqb
         rePaXGJDyohQXWnqr+ta4OVLRzOCIdUt39XdQnkbxUqus2xS3uuugT6PKF11afCK0Y3d
         NFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=b0Hbu1BABi8Xh8b3bvkqzLWTDHQ7JLqil1MsktXkomc=;
        b=R3mp9l/dSPBAeRXNpXm514xJkPXAreoXVDLV/A+5zaPdZchaYyayzqZPsHdOryYO7w
         0B9Lm8eyTVU9hyHPlGU7QLaTc/CzxvFikfVpHssINJvhKFmXuVH0ur0+D9Ds1MkiVrtB
         xapURyj8jwUJ872F6kkes0C8teRssL8Iy1Opr4cQvobQYtSQuAEcuCAWSJCY9QM80fvh
         cixKkSCe+PbZ/bEJhRXXVt67pzythVxEtqExGVjvSVM1yGl58ChJU6OCt9wr49lQx3a5
         Vp5grOIXwUeQj/5ukAlAT5b/wsvRHvHPHQR1r4OJN8LGze4ZWQL5N8EaVr5MljlcCwC3
         X2xw==
X-Gm-Message-State: ACgBeo272pp/gdtgtibrebwOcPb0Upz5tqreW/BMmYBEVEzZpCuGVVjF
        q/kxoa9+p8Jo9SQ46K+//PuXFw==
X-Google-Smtp-Source: AA6agR6zSKE5SCy82IA9kzf8IZHR+bNgzhRgAvsv0F/4nTwzno5ASm/Orou2N5D+SI2pwvFqbD/7EA==
X-Received: by 2002:a05:6000:82:b0:225:21ff:a389 with SMTP id m2-20020a056000008200b0022521ffa389mr1652992wrx.22.1660726664564;
        Wed, 17 Aug 2022 01:57:44 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g9-20020a5d64e9000000b0021badf3cb26sm16861988wri.63.2022.08.17.01.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 01:57:44 -0700 (PDT)
Message-ID: <44887e94-d3a6-12cb-01c5-d61e067ab791@linaro.org>
Date:   Wed, 17 Aug 2022 09:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi
 pinctrl bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220816180538.9039-1-srinivas.kandagatla@linaro.org>
 <20220816180538.9039-2-srinivas.kandagatla@linaro.org>
 <6c283634-70b3-200f-a346-28eb4c428d39@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <6c283634-70b3-200f-a346-28eb4c428d39@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Thanks Krzysztof,

On 17/08/2022 07:05, Krzysztof Kozlowski wrote:
> On 16/08/2022 21:05, Srinivas Kandagatla wrote:
>> Add device tree binding Documentation details for Qualcomm SC8280XP
>> LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +  gpio-ranges:
>> +    maxItems: 1
>> +
>> +#PIN CONFIGURATION NODES
>> +patternProperties:
>> +  '-pins$':
>> +    type: object
>> +    description:
>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>> +      Client device subnodes use below standard properties.
>> +    $ref: "/schemas/pinctrl/pincfg-node.yaml"
> 
> Drop the quotes
Will do that.
.
> 
>> +
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in this
>> +          subnode.
>> +        items:
>> +          pattern: "^gpio([0-1]|[0-8]])$"
> 
> error in pattern - double ]. If you have 19 GPIOs, this should be
> probably: ^gpio([0-9]|1[0-8])$
> 
that is true..I did overlook  '|'

>> +
>> +      function:
>> +        enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
>> +                dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic4_clk,
>> +                dmic4_data, i2s2_clk, i2s2_ws, dmic3_clk, dmic3_data,
>> +                qua_mi2s_sclk, qua_mi2s_ws, qua_mi2s_data, i2s1_clk, i2s1_ws,
>> +                i2s1_data, wsa_swr_clk, wsa_swr_data, wsa2_swr_clk,
>> +                wsa2_swr_data, i2s2_data, i2s3_clk, i2s3_ws, i2s3_data,
>> +                ext_mclk1_c, ext_mclk1_b, ext_mclk1_a ]
>> +
> 
> Skip blank line (confuses with a new property).
> 
okay

>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +
>> +      drive-strength:
>> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
>> +        default: 2
>> +        description:
>> +          Selects the drive strength for the specified pins, in mA.
>> +
>> +      slew-rate:
>> +        enum: [0, 1, 2, 3]
>> +        default: 0
>> +        description: |
>> +          0: No adjustments
>> +          1: Higher Slew rate (faster edges)
>> +          2: Lower Slew rate (slower edges)
>> +          3: Reserved (No adjustments)
>> +
>> +      bias-pull-down: true
>> +
>> +      bias-pull-up: true
>> +
>> +      bias-disable: true
>> +
>> +      output-high: true
>> +
>> +      output-low: true
>> +
>> +    required:
>> +      - pins
>> +      - function
>> +
>> +    additionalProperties: false
>> +
>> +allOf:
>> +  - $ref: "pinctrl.yaml#"
> 
> Drop the quotes.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - gpio-controller
>> +  - '#gpio-cells'
>> +  - gpio-ranges
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/sound/qcom,q6afe.h>
>> +    lpi_tlmm: pinctrl@33c0000 {
> 
> Drop the label, not used anywhere here.
> 
makes sense, I will address all the comments and post next version.
thanks,
srini
>> +        compatible = "qcom,sc8280xp-lpass-lpi-pinctrl";
>> +        reg = <0x33c0000 0x20000>,
>> +              <0x3550000 0x10000>;
>> +        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +        clock-names = "core", "audio";
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        gpio-ranges = <&lpi_tlmm 0 0 18>;
>> +    };
> 
> 
> Best regards,
> Krzysztof
