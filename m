Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6234E4C3EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 08:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiBYHGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 02:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237991AbiBYHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 02:06:46 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9581E14BF;
        Thu, 24 Feb 2022 23:06:15 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a8so8983599ejc.8;
        Thu, 24 Feb 2022 23:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JDaN7T5a5SMQ/lOcHwZ3iJ4ce75iqqbIoOIHiwveTKo=;
        b=c96gCPG5Y/tQfdRBC9u0UrvqKXz5O8eh9Twj7TgGZpiciHYLP8BSWOBQkGQBgSt2Uy
         hXHDjUMzqm8AS4dNjMJqYjVfpFFZzelMMw3GPuh4Bb2zqXwqAHBIt1yWpoMJkdy5kYAF
         opjbD3pSFDICcUYexXj6a5fMBbnNtxvMSfyfx/jNWnqzkKIsieS0egjKkfyeKSY/IXyS
         26VzBbhbpP4VQHVUdYAqn8bkg//B5TkEiDiZ/eZDrqIgdJkeyJ4kOAbrJ3Iex/p6WVS8
         M7Xl7lSs8LeEktJ7HgAA44J822/uxk5O7Xh8hSCV7OQAcprlo06ehm01/uJ8zbHG/lgj
         JQSA==
X-Gm-Message-State: AOAM532PhANhrK8uRK5uoZWb2KXCALMbv9zKv5jKo2YRnw8wY+h59eUM
        zWjqACJGECz8CfTj8MlRMZhvwOvqnZI=
X-Google-Smtp-Source: ABdhPJxxrOBNQcNwFo2aVjJ+AbwXnC5WVqb7SCBZSef51+r9okC3As9UhHyBUCIpUkgb0puyfUK3tg==
X-Received: by 2002:a17:907:78cc:b0:6b4:ecc1:42fb with SMTP id kv12-20020a17090778cc00b006b4ecc142fbmr4808647ejc.248.1645772773371;
        Thu, 24 Feb 2022 23:06:13 -0800 (PST)
Received: from [192.168.0.128] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id h12-20020a1709060f4c00b006b4ec988cc3sm664190ejj.4.2022.02.24.23.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 23:06:12 -0800 (PST)
Message-ID: <c6607953-927e-4d85-21cb-72e01a121453@kernel.org>
Date:   Fri, 25 Feb 2022 08:06:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: Add sample averaging property
 for ADM1275
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220224154329.9755-1-potin.lai@quantatw.com>
 <20220224154329.9755-3-potin.lai@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220224154329.9755-3-potin.lai@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2022 16:43, Potin Lai wrote:
> Add new properties for binding sample averaging in PMON_CONFIG register
> 
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index 223393d7cafd..325f6827648f 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -37,6 +37,48 @@ properties:
>      description:
>        Shunt resistor value in micro-Ohm.
>  
> +  adi,volt-curr-sample-average:
> +    description: |
> +      A value to configure VI_AVG in PMON_CONFIG register to indicate a
> +      number of samples to be used to report voltage and currentvalues.

missing space after current.

> +      If set to 7, the 128 samples averaging would be used.
> +
> +    $ref: /schemas/types.yaml#/definitions/uint8

Make it a uint32.

The previous usage of this field was more appropriate. Instead of
keeping register values in DT, it's better to keep logical value. What
if in next cheap the register values have calculation method?

This should be like in v1 - enum for number of samples to take in averaging.

> +    enum:
> +      - 0 # 1 sample averaging
> +      - 1 # 2 sample averaging
> +      - 2 # 4 sample averaging
> +      - 3 # 8 sample averaging
> +      - 4 # 16 sample averaging
> +      - 5 # 32 sample averaging
> +      - 6 # 64 sample averaging
> +      - 7 # 128 sample averaging
> +    default: 0
> +
> +  adi,power-sample-average:
> +    description: |
> +      A value to configure PWR_AVG in PMON_CONFIG register to indicate a
> +      number of samples to be used to report power values.
> +      If set to 7, the 128 samples averaging would be used.

The same.

> +
> +      The chip supports power sample averaging:
> +        "adi,adm1272"
> +        "adi,adm1278"
> +        "adi,adm1293"
> +        "adi,adm1294"

This should be in if-block like here:
https://lore.kernel.org/linux-devicetree/YheqjZQHq0T%2FRSIz@robh.at.kernel.org/T/#m0672807a08c95aba2bccb927d37ff24fde471b8b


Best regards,
Krzysztof
