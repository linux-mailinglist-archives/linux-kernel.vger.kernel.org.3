Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1A582180
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiG0Htl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG0Hth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:49:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D02E422CB;
        Wed, 27 Jul 2022 00:49:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z18so8021703edb.10;
        Wed, 27 Jul 2022 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7qrKymhpLOAPYDYIFsDNUzeQR021XnkNkwlPESUcTX8=;
        b=FY9ZK6DN7/WlouONO+X7GQTuYKV2MQxX+NxsAxG9h3cBD5XAQJUqonvfI5qp4qOB5Q
         ym19B8AQOzTbLQmo2n2Gmx0t4SpoqBf50VL5TRiTAyTxa+i4Yj2d2+Dd2a6oqLySyJJe
         MFvtgnnuQdxYYqDUf90lSOotu51KM13cmu9MDpbImfwBVrYDvC0X4kaO45i2IPiJgp/M
         cvvHCP3n+c25o6DnZEyE+O3l0/lKE6l/+wtE6pAiJMSl+YHcjuNvAdwsYCRHQh5+cYOH
         sKf7q0xFFxSLN8MHdvsFSIwT8AK/auwulCLQB/zGBG6yIAM8odehRGMp6xtMXIMaog5m
         OOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7qrKymhpLOAPYDYIFsDNUzeQR021XnkNkwlPESUcTX8=;
        b=Ag3D5HZIYniQISiOlna4J7vkAAF+vI4xdKfBMI8MJNuKf9d9w58GjGvXbN4nLGpJuw
         mR2RlsmJfZy0sxu7A8PAnR2KddKdxyA9EiWp+KGqh+3q/EcDIUkTJqOdyofkWJRSNAz0
         ireQXL8QUjppDlI6Bj25cCFvAdZyVU5Lws9l7sbTIzygvt0ZPW7DMbf0XWIiCf0a6xbG
         m8ehH5LG5iMEUZ/7+z2aGeW/Qo7Rp0dW/GWlnbO8p/wqtugMRZdTPlY2CeXHRcJ/qA/1
         AB9q51mOVEsgO55wudMJPVy6Lh0vpvC+hPZpFg0of46yxZAR0W/3KTFxw2bdXsyZPxvb
         GGMw==
X-Gm-Message-State: AJIora9q5Z8KammNEnru6qIOauVE1ZiGeQdoUG5By6qP4qJ2niIAb9c8
        op8Ul5aKOz3pls+8bPO2fH2fHAZfn6NYKTGu
X-Google-Smtp-Source: AGRyM1tXpncuFPJXAmibcjFfJyU4q/R3OQaxywdRzAQa2B0nQnvOw7ZLhPVOhUShHwVnwox3XPIyqw==
X-Received: by 2002:a05:6402:1f01:b0:43a:239e:e65a with SMTP id b1-20020a0564021f0100b0043a239ee65amr21521389edb.428.1658908174880;
        Wed, 27 Jul 2022 00:49:34 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id bt8-20020a0564020a4800b0043bba5ed21csm9698792edb.15.2022.07.27.00.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 00:49:34 -0700 (PDT)
Message-ID: <79fce900-2825-45ca-44f2-9fb94b5eeed3@gmail.com>
Date:   Wed, 27 Jul 2022 10:49:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] dt-bindings: regulator: Document the PM6125 SPMI
 PMIC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-2-iskren.chernev@gmail.com>
 <CAA8EJpoLMioMy61np6Y8Gn+Uhb8EvgU6bwuUyouuNcDz0XwByg@mail.gmail.com>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <CAA8EJpoLMioMy61np6Y8Gn+Uhb8EvgU6bwuUyouuNcDz0XwByg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/22 23:36, Dmitry Baryshkov wrote:
> On Tue, 26 Jul 2022 at 21:11, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>>
>> Add support for pm6125 compatible string and add relevant supplies in QCom SPMI
>> regulator documentation.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> 
> The order of sign-offs seems incorrect. The sender's signature should
> be the last one.

Sure, will do!

>> ---
>>  .../regulator/qcom,spmi-regulator.yaml        | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
>> index 8b7c4af4b551..d8f18b441484 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
>> @@ -12,6 +12,7 @@ maintainers:
>>  properties:
>>    compatible:
>>      enum:
>> +      - qcom,pm6125-regulators
>>        - qcom,pm660-regulators
>>        - qcom,pm660l-regulators
>>        - qcom,pm8004-regulators
>> @@ -106,6 +107,24 @@ required:
>>    - compatible
>>
>>  allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pm6125-regulators
>> +    then:
>> +      properties:
>> +        vdd_l1_l7_l17_l18-supply: true
>> +        vdd_l2_l3_l4-supply: true
>> +        vdd_l5_l15_l19_l20_l21_l22-supply: true
>> +        vdd_l6_l8-supply: true
>> +        vdd_l9_l11-supply: true
>> +        vdd_l10_l13_l14-supply: true
>> +        vdd_l12_l16-supply: true
>> +        vdd_l23_l24-supply: true
>> +      patternProperties:
>> +        "^vdd_s[1-8]-supply$": true
> 
> Add an empty line please.

All other if-then blocks don't have newlines, shall I add one between each as
well?

>>    - if:
>>        properties:
>>          compatible:
>> --
>> 2.37.1
>>
> 
> 
