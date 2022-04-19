Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40D750728B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354281AbiDSQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354242AbiDSQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:07:04 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B82E9F5;
        Tue, 19 Apr 2022 09:04:21 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h11so21118901ljb.2;
        Tue, 19 Apr 2022 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lcB3xg3aCe3l1gTiXN3XpYTB4RffO49bkw83Esq1A5w=;
        b=gYEfwwJ8DOY74cYxXoJFWXNFcA/hGjBl1+wc9vyPlHUYbtMioc+2NkhS7vmZFUdfOO
         U4j5WuPJK0pfRRyQfv7fQ1adAx9HlQXnbxrc9MQ8SorTKCLE5+5gZBhcNxNsxE9dId67
         bLGkBZ2EgpLS5pFyRliGSE4RGcmdZIDAGdG6TCsMXQ9+dp0c/zM5pSPQbZg7C7H/icGO
         HxFG2kzt1HYgaMvYQJmccEV0R5k2Q98E5nRu/2q9UsEfnlu3N7/qcNgw/Clf82DojdZJ
         +fuaUrx9y0tNRUSQmgENvc527sDOKqPT1MgxtW86U7cH/0Sm2Q+FrrRXyY+CkmIuwpog
         NI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lcB3xg3aCe3l1gTiXN3XpYTB4RffO49bkw83Esq1A5w=;
        b=Hn7wwbltQe6WxDLaDQEvBxdKoNKKhrYZ4k8+YIR0ZNORWxT+iz4MYA2WcUUDKqsF10
         8zfq07kJMVrnQFuAWC3f6M9QBnRSkuGgGvTQ/4LXYi4hM7RnabWZSxUVVRfF1zYF2L7P
         8Vr0QJhePZRmCXttAxWDm0Ddk0Xw2H4MWLHY66K/APYTPGkNx0Cqj2rvRIu19wo3G247
         FyK1rU1RhAaX6ogT7PxN79oHN6CxEqa7uH/E2iFmWSJWwIngntj/2uaqqOH0DCMPnhKl
         r229J26lJAVKq4719CdVzs+JCWCOSQCFqAB/+USKi0DoGsghM4Ji824Tjf2mHPezMKoD
         HMJQ==
X-Gm-Message-State: AOAM531qdfEGwFbYZ8Zmrb4SsPeDLMOHa3PLzCq2DU1tuDQ3IAT3I1Zz
        +iAEj2/T8ROqcKCYDNMj9NI=
X-Google-Smtp-Source: ABdhPJylD3rj6khsSbNbJh855VFdHgI5doGMocjwhZdoPzXz7QMzACyo+imdgp5TBWrkrtbhKWsHvw==
X-Received: by 2002:a2e:9d06:0:b0:24c:7dee:4d58 with SMTP id t6-20020a2e9d06000000b0024c7dee4d58mr10555814lji.177.1650384259290;
        Tue, 19 Apr 2022 09:04:19 -0700 (PDT)
Received: from [192.168.86.247] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x21-20020a056512047500b0046f960e1988sm1300491lfd.153.2022.04.19.09.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 09:04:18 -0700 (PDT)
Message-ID: <5508c508-5009-361c-bd95-d31d139c6f13@gmail.com>
Date:   Tue, 19 Apr 2022 19:04:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus
 SM5703 MFD
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
References: <20220415164356.25165-1-markuss.broks@gmail.com>
 <20220415164356.25165-3-markuss.broks@gmail.com>
 <Yl7AyYAwkyO3oDrW@robh.at.kernel.org>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <Yl7AyYAwkyO3oDrW@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 4/19/22 17:01, Rob Herring wrote:
> On Fri, Apr 15, 2022 at 07:43:53PM +0300, Markuss Broks wrote:
>> This patch adds device-tree bindings for the Silicon Mitus
>> SM5703 MFD.
>>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> ---
>>   .../bindings/mfd/siliconmitus,sm5703.yaml     | 95 +++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> new file mode 100644
>> index 000000000000..aa676967593d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> @@ -0,0 +1,95 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/siliconmitus,sm5703.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Silicon Mitus SM5703 multi-function device bindings
>> +
>> +maintainers:
>> +  - Markuss Broks <markuss.broks@gmail.com>
>> +
>> +description: |
>> +  Silicon Mitus SM5703 is a multi-function device, that consists of several
>> +  modules, designed for a mobile phone use. It consists of
>> +  LDO, Buck, USBLDO and VBUS regulators, a flash LED driver, a MUIC unit,
>> +  a fuel gauge and a battery charger circuit. The MUIC and Fuel-Gauge units
>> +  are separate from the main MFD, having their own i2c lines, while the
>> +  LED driver, regulators and charger are sharing the main i2c bus of the MFD.
>> +
>> +properties:
>> +  compatible:
>> +    const: siliconmitus,sm5703-mfd
> '-mfd' is redundant. Drop.
>
>> +
>> +  reg:
>> +    description:
>> +      I2C slave address.
>> +    maxItems: 1
>> +
>> +  regulators:
>> +    $ref: ../regulator/siliconmitus,sm5703-regulator.yaml
> /schemas/regulator/...
>
>> +    description:
>> +      List of child nodes that specify the regulators.
>> +
>> +  reset-gpio:
> '-gpios' is the preferred form even with 1.
>
> Are the MUIC and Fuel-Gauge units independent from this reset?
 From my understanding, they're completely separate from the main unit. 
The tests also confirm that they both work normally no matter the reset 
GPIO state.
>
>> +    description:
>> +      GPIO which is connected to the MRSTB pin.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - regulators
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      mfd@49 {
> 'pmic' is the standard name.
>
>> +        compatible = "siliconmitus,sm5703-mfd";
>> +        reg = <0x49>;
>> +
>> +        reset-gpio = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
>> +        pinctrl-0 = <&mrstb_default>;
>> +
>> +        regulator {
>> +          compatible = "siliconmitus,sm5703-regulator";
>> +
>> +          regulators {
>> +            sm5703_ldo1: ldo1 {
>> +              regulator-min-microvolt = <2800000>;
>> +              regulator-max-microvolt = <2800000>;
>> +            };
>> +
>> +            sm5703_ldo2: ldo2 {
>> +              regulator-min-microvolt = <1500000>;
>> +              regulator-max-microvolt = <3300000>;
>> +            };
>> +
>> +            sm5703_ldo3: ldo3 {
>> +              regulator-min-microvolt = <3300000>;
>> +              regulator-max-microvolt = <3300000>;
>> +            };
>> +
>> +            sm5703_usbldo1: usbldo1 {
>> +              regulator-min-microvolt = <4800000>;
>> +              regulator-max-microvolt = <4800000>;
>> +            };
>> +
>> +            sm5703_usbldo2: usbldo2 {
>> +              regulator-min-microvolt = <4800000>;
>> +              regulator-max-microvolt = <4800000>;
>> +            };
>> +
>> +            sm5703_vbus: vbus {
>> +              regulator-min-microvolt = <5000000>;
>> +              regulator-max-microvolt = <5000000>;
>> +            };
>> +          };
>> +        };
>> +      };
>> +    };
>> +...
>> -- 
>> 2.35.1
>>
>>
- Markuss
