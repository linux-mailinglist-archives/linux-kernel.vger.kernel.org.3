Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F296B4CA0F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbiCBJie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbiCBJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:38:25 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AA524BE2;
        Wed,  2 Mar 2022 01:37:41 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id d10so2383455eje.10;
        Wed, 02 Mar 2022 01:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HzvRX5aXV39P54ewUBoE5fNDbFJ/AGNr/7ZVd7EAqhU=;
        b=xB8K0eAABiL5mdf2Ac4lhdzyh1TFFcInpgbqL/nrLFht9Wd3+5nPuX3XxGAK9op+qG
         z5mozocLWXjamVJ5cmVJcBRjIfpH0R7eir5r0+XgQqdLZ0Uxt9tHrUVbCwLpOvSNvFgk
         KIYDFD4G0OP25Q5UJNE5xj/jg6o5pjvZJ1NVe+CphevVVZ34Favc0TbLLlsPPF6QIWjj
         smB/QjKeYXlsD3sM1ofrPFkwHmXKfQnMcO6tXMdnfkUlwrJsLnxx3RXdS1sdiJX2e6qT
         xNdUrrP6x8fmjCPd+nSYRDonvFKg2wLmHsId6/Z5YWFMpdKxagWjcGmBFcE4kFcosARq
         s45A==
X-Gm-Message-State: AOAM5319fPH9w+Cz/ZkfklEwXlrzl10VtufXPxJTVfxmU//8/McA9gQU
        rU2u1cZOMfKHZM7V62yenjc=
X-Google-Smtp-Source: ABdhPJzhWPmaQ9FhPqIrZ6ZcBkbvC7QdZNYl0E13QfkwC+CTiw5paUnnb74ikJhTVqnbfURy/R+hkA==
X-Received: by 2002:a17:906:7f09:b0:6d6:daee:566f with SMTP id d9-20020a1709067f0900b006d6daee566fmr8052781ejr.294.1646213860190;
        Wed, 02 Mar 2022 01:37:40 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id m22-20020a056402051600b00415a0cbd561sm1179366edv.74.2022.03.02.01.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:37:39 -0800 (PST)
Message-ID: <d714ec21-b6e8-1753-1d1f-3b51bae68f35@kernel.org>
Date:   Wed, 2 Mar 2022 10:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220302070831.23822-1-potin.lai@quantatw.com>
 <20220302070831.23822-3-potin.lai@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220302070831.23822-3-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 08:08, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index 223393d7cafd..b191abddf20b 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -37,6 +37,72 @@ properties:
>      description:
>        Shunt resistor value in micro-Ohm.
>  
> +  adi,volt-curr-sample-average:
> +    description: |
> +      Number of samples to be used to report voltage and current values.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +
> +  adi,power-sample-average:
> +    description: |
> +      Number of samples to be used to report power values.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adm1075
> +              - adi,adm1276
> +    then:
> +      properties:
> +        adi,volt-curr-sample-average:
> +          default: 128
> +        adi,power-sample-average-enable: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adm1275
> +    then:
> +      properties:
> +        adi,volt-curr-sample-average:
> +          default: 16
> +        adi,power-sample-average-enable: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adm1272
> +    then:
> +      properties:
> +        adi,volt-curr-sample-average:
> +          default: 128
> +        adi,power-sample-average-enable:
> +          default: 128
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adm1278
> +              - adi,adm1293
> +              - adi,adm1294
> +    then:
> +      properties:
> +        adi,volt-curr-sample-average:
> +          default: 128
> +        adi,power-sample-average-enable:

This should be adi,power-sample-average?

> +          default: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -53,5 +119,8 @@ examples:
>              compatible = "adi,adm1272";
>              reg = <0x10>;
>              shunt-resistor-micro-ohms = <500>;
> +            adi,volt-curr-sample-average = <128>;
> +            adi,power-sample-average = <128>;
> +            adi,power-sample-average-enable;

This property does not exist. Did you run dt_binding_check?

>          };
>      };


Best regards,
Krzysztof
