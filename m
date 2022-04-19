Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9857F5064CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349007AbiDSGrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349028AbiDSGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:47:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46625BC0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:44:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g18so30835637ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WDQdMsSQtFeONfrPWRQrEMWsmK9TYCXo9oQyKgCX1d4=;
        b=W+DEw3OjhbAorYeQvkZAGbdpHDkjISIw2sWe7zSQRBSDh3kasiZwD3BvHX9g6DsaeF
         Z1zeOIp/nCjpP4LNqhDwh2Bl39liGxKTC2D2N1TbhkAOpaEsRLf6zRK+OAfWbHawGpVb
         dDc1ONAw+G1uVAm4MZnn/jw7CWyH7TD/VjyM9sfIHDdI+ENh9f2zRasrOFLafKxDS1h5
         47lMDtfkJGU/nuspJfIvREbR+WZYQM6sy8m0HMbdeOjVLvGYLAcFsTJpMqz4qaYpbj6C
         dwjMD3EC04lWTJeBRG1AqBD4X/cUvQ6+LjCk4SyMnRfaXQ0CEKvVtcRE2Ns0E+U1I3+k
         ZeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WDQdMsSQtFeONfrPWRQrEMWsmK9TYCXo9oQyKgCX1d4=;
        b=HgCTBJrWpuW9bXOJIvwRZfBYBqEgEetPGWBKshxIKqpApwcSiphaeCH3PdXwS6v73F
         5O9ID7s3CG+os4GJGMOdMoJQ0y5Tk4mLELifZL9QMb5i30gtDa+ot25tcFLUQcBhLrCw
         BQqgMA6+B/TmoQ1YKxmfoZL9gSxgeFdaLxUlnzIdNdxG4Bn8r/XxMWGNokYlNEedgwNR
         Z3OI1gLYWLyt0wSBqndKUvscdJ+Dj7Tm/vmqMeDyJnAigQSWW9K6IYNwxer9xuEZz3wa
         EhCJXstwX8mWaLQU66OtTUy7888wB54FajLPq34/y0/fStAvY+O7i8tQI55jmEDgBTtj
         U2qQ==
X-Gm-Message-State: AOAM5306bVi4pbgBaNcL1S5Q+jB3RtTw8/Wbdu1M/697OzNu9SKm86ph
        7EufEr5kf4DyIJezUoaikUDKKg==
X-Google-Smtp-Source: ABdhPJxZvaWhIZoWqA8l9E3QzXXqm8pjAwVmspK/s+lgWoyTFUJy55XOrlYTGTP6SvstEVOAaHiuEQ==
X-Received: by 2002:a17:907:6095:b0:6e7:cc3f:c33d with SMTP id ht21-20020a170907609500b006e7cc3fc33dmr12375812ejc.570.1650350689890;
        Mon, 18 Apr 2022 23:44:49 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm7693260edb.39.2022.04.18.23.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 23:44:49 -0700 (PDT)
Message-ID: <39b68e91-93cc-ad74-d064-a29ff01d60a6@linaro.org>
Date:   Tue, 19 Apr 2022 08:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: qcom,rpmh: document
 supplies per variant
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
 <20220412073123.27229-2-krzysztof.kozlowski@linaro.org>
 <YlhC5B+ZaNn9wUuB@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YlhC5B+ZaNn9wUuB@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2022 17:51, Rob Herring wrote:
> On Tue, Apr 12, 2022 at 09:31:22AM +0200, Krzysztof Kozlowski wrote:
>> The RPMH regulator binding covers several devices with different
>> regulator supplies, so it uses patterns matching broad range of these
>> supplies.  This works fine but is not specific and might miss actual
>> mistakes when a wrong supply property is used for given variant.
>>
>> Describe the supplies depending on the compatible, using a defs-allOf
>> method.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../regulator/qcom,rpmh-regulator.yaml        | 290 +++++++++++++++++-
>>  1 file changed, 276 insertions(+), 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> index 842ccef691b8..773536fe37c7 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>> @@ -95,35 +95,297 @@ properties:
>>    vdd-rgb-supply:
>>      description: Input supply phandle of rgb.
>>  
>> -  vin-lvs-1-2-supply:
>> -    description: Input supply phandle of one or more regulators.
>> -
>> -  vdd-bob-supply:
>> -    description: BOB regulator parent supply phandle.
>> -
>>    bob:
>>      type: object
>>      $ref: "regulator.yaml#"
>>      description: BOB regulator node.
>>  
>>  patternProperties:
>> -  "^vdd-s([0-9]+)-supply$":
>> -    description: Input supply phandle(s) of one or more regulators.
>> -
>> -  "^vdd-(l[0-9]+[-]){1,5}supply$":
>> -    description: Input supply phandle(s) of one or more regulators.
>> -
>>    "^(smps|ldo|lvs)[0-9]+$":
>>      type: object
>>      $ref: "regulator.yaml#"
>>      description: smps/ldo regulator nodes(s).
>>  
>> -additionalProperties: false
>> -
>>  required:
>>    - compatible
>>    - qcom,pmic-id
>>  
>> +allOf:
>> +  - $ref: "#/$defs/pm6150"
>> +  - $ref: "#/$defs/pm6150l"
>> +  - $ref: "#/$defs/pm7325"
>> +  - $ref: "#/$defs/pm8005"
>> +  - $ref: "#/$defs/pm8009"
>> +  - $ref: "#/$defs/pm8150"
>> +  - $ref: "#/$defs/pm8150l"
>> +  - $ref: "#/$defs/pm8350"
>> +  - $ref: "#/$defs/pm8350c"
>> +  - $ref: "#/$defs/pm8450"
>> +  - $ref: "#/$defs/pm8998"
>> +  - $ref: "#/$defs/pmg1110"
>> +  - $ref: "#/$defs/pmi8998"
>> +  - $ref: "#/$defs/pmr735a"
>> +  - $ref: "#/$defs/pmx55"
>> +  - $ref: "#/$defs/pmx65"
>> +
>> +unevaluatedProperties: false
>> +
>> +$defs:
> 
> I'm not following on why you need $defs here rather than putting the 
> if/then schemas under the 'allOf'. $defs should primarily only be used 
> where it saves duplicating a schema 2 or more times. That could be the 
> case here if there's a case that's a subset of another case.

The allOf+defs is a workaround for schema behavior. The entire approach
if defining properties in "if:then:" works only with
unevaluatedProperties, not with additionalProperties. However
unevaluatedProperties require to reference other schema, which I do not
do here. I don't have other schema.

allOf+def has references tricking schema to accept unevaluatedProperties.


Best regards,
Krzysztof
