Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA14C8A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiCALQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiCALQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:16:55 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED64790FF5;
        Tue,  1 Mar 2022 03:16:14 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id p15so30780395ejc.7;
        Tue, 01 Mar 2022 03:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h2jNuuQ3X244COKFVoV1RG62sUTFE6CqbPsrzI1NU2U=;
        b=ZsfY03216WYDqB0aSFWWdDBgNJAvZRUnBZbXgx+v+XESMX9fkFUPnBu2ylYNyheonS
         Xbr99cPdmOT3t4TdvaiubqDcW3hqFykmKRktaJ9nkiainVqA1+nokMVLEuwo65MY4ihB
         kQTvjpzIo5omjV3JZ1VE/ATvaMizcFWgf16PpyQHjTKD1uL0cCyWTiDbxdAbbklF3wGn
         y73N5SPeQeBytJZCwXCYA3BxALSD560ZnKeIEqRjUfKinHF4PZcD61XtVJf8b4a4rSNL
         uKjoMlNcAmUD4ICpMhcTD+LumHsm9+LTIE2ZtflLysfRHNBLnv/m9CT1SWDkl/mcdujy
         Nk1w==
X-Gm-Message-State: AOAM531JQHip9BEonRi5Ef56JaDUFDNQBa8GkhV6Mq+aXCk3ki4oKvDX
        MTbrYnm29x4fNK3ZXllV7gX9gM1A0dw=
X-Google-Smtp-Source: ABdhPJzSg88kcttrGM/CoKgQp82btzjsFWI1wpILXaVOA33pdNKTlsuVV+3V4s9sDD7Rxp+Up76gAw==
X-Received: by 2002:a17:906:7185:b0:6cd:e09c:e5f5 with SMTP id h5-20020a170906718500b006cde09ce5f5mr18262782ejk.287.1646133373092;
        Tue, 01 Mar 2022 03:16:13 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id 5-20020a508e45000000b003fe03798eafsm7242832edx.32.2022.03.01.03.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:16:12 -0800 (PST)
Message-ID: <da4ac970-9e7d-c9cb-eea3-e5ec8a1eef00@kernel.org>
Date:   Tue, 1 Mar 2022 12:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] dt-bindings: hwmon: Add sample averaging
 properties for ADM1275
Content-Language: en-US
To:     Potin Lai <potin.lai@quantatw.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Patrick Williams <patrick@stwcx.xyz>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220301103900.12637-1-potin.lai@quantatw.com>
 <20220301103900.12637-3-potin.lai@quantatw.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220301103900.12637-3-potin.lai@quantatw.com>
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

On 01/03/2022 11:39, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> - adi,power-sample-average-enable
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> index 223393d7cafd..1b612dc06992 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml
> @@ -37,6 +37,47 @@ properties:
>      description:
>        Shunt resistor value in micro-Ohm.
>  
> +  adi,volt-curr-sample-average:
> +    description: |
> +      Number of samples to be used to report voltage and current values.
> +      If the configured value is not a power of 2, sample averaging number
> +      will be configured with smaller and closest power of 2.
> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +    default: 1
> +
> +  adi,power-sample-average:
> +    description: |
> +      Number of samples to be used to report power values.
> +      If the configured value is not a power of 2, sample averaging number
> +      will be configured with smaller and closest power of 2.
> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> +    default: 1
> +
> +  adi,power-sample-average-enable:
> +    description: Enable sample averaging for power reading.
> +    type: boolean

Why do you need this property? Voltage/current sampling is enabled in
your driver with presence of adi,volt-curr-sample-average. Why power
sampling is different?


Best regards,
Krzysztof
