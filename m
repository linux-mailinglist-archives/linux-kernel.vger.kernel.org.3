Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F71F5501BB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 03:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380637AbiFRBpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 21:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiFRBpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 21:45:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD82666A1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:45:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id h1so5197000plf.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MVVfG1ukpcWxNx9o6iSFBfRaMO1Vdtzlg+i0swD+fb4=;
        b=q3BsEgoVvOfEqW1uqQ/h2RJoRA2KAVkCNjtFaZH6ciU4+b1sNXN3iCRnu2XCYBNH9q
         H853Swy9HwpS7fGroR74zzwzeCMiADQiOL904RmSeAWkEHmOGYj6KAELIK9/2Wpk2ODb
         HYuIf1TPlgIPga6t4XpZ7yWjNOYcBbyP6kGArJehExA0cPQecr8QJN0XoarWwQU7eE3o
         GJy3SaxfCY/UXVHJN8Lvq5FJTidG1DswoSRfxwcWhFuz1u1Nkt/3+eOOi/MQqh8LiXE8
         ayBueIF0F9dIb/6qCtV0l1HOo5loteHEVEbrUU5uFxokX3n86TI6zos1sknyef+TxN4f
         D98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MVVfG1ukpcWxNx9o6iSFBfRaMO1Vdtzlg+i0swD+fb4=;
        b=cu+ewGKWm+c8gJBrEx1OhRT5GEy8tSSCpo8U/lqJWVys8gg9dfIS17C6cjexVTVsFt
         kEqVUQqHp0/5UUoMz4whGZ2XVviU8C6HkmitF8hibzgBUYLqdAjj8XmtyMPYjmNH3Fvd
         u2Yv1BGNYfOiOd+cqIJjQUj7WOrpK6BUGuqW/somQHt595pEqCLTHQ86nV6yN5IZ+Osg
         FGuHBTnixO5iXdsaQvHKOyKNNlz5UaMM42ROgwgCiuTzQUTjLHP1Wm/RGNSVkkFehijY
         FABYpklWQUowkDtBE4DUezFJQg17euEuplH/H77wAF/Mq748lAxx2gwKrkxPZA/BX1X6
         ezhw==
X-Gm-Message-State: AJIora88C1vr8gAMwKVIIu4LsiBDmDGE+Y43ILqg1i3deqMcRu9drW+I
        jRT2auayo4rhlVKuysYTbEYXfg==
X-Google-Smtp-Source: AGRyM1sPqWjdN+XA9tmr0a8NAAwk+Ph/AdPkD7bdRPhjSkxbh27BWLRZd5LO4X5I+QCm+cbu4DJ4Ow==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id l15-20020a17090a408f00b001e3023a2370mr13610279pjg.84.1655516705705;
        Fri, 17 Jun 2022 18:45:05 -0700 (PDT)
Received: from [172.31.235.92] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id i186-20020a62c1c3000000b00524c5c236a6sm4039656pfg.33.2022.06.17.18.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 18:45:05 -0700 (PDT)
Message-ID: <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
Date:   Fri, 17 Jun 2022 18:45:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1655458375-30478-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 02:32, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the documentation for Richtek RTQ6056.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
> new file mode 100644
> index 00000000..6b4e0e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
> +  interface, and the device provides full information for system by reading
> +  out the loading current and power.
> +
> +  The device monitors both of the drops across sense resistor and the BUS
> +  voltage, converts into the current in amperes, and power in watts through
> +  internal analog-to-digital converter ADC. The programmable calibration,
> +  adjustable conversion time, and averaging function are also built in for
> +  more design flexibility.
> +
> +  Datasheet is available at
> +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
> +
> +properties:
> +  compatible:
> +    const: richtek,rtq6056
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  richtek,shunt-resistor-uohm:

Use standard properties, so "-micro-ohms". Drop the unit from
description and drop the ref.

> +    description: Shunt IN+/IN- sensing node resistor in microohm.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      rtq6056@40 {

Generic node name, so probably "adc" (or something else appropriate).

> +        compatible = "richtek,rtq6056";
> +        reg = <0x40>;
> +        #io-channel-cells = <1>;
> +      };
> +    };


Best regards,
Krzysztof
