Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4BB55AC9A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiFYUf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiFYUfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:35:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E5E1057E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:35:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lw20so11343913ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5ibzd/HltQFWXUhqB2ZPgR5KDRUPRWUvyYsOfNwKbfY=;
        b=QRg8Wn9tuMwaH5zMhzagX7y+7r8khYhZVFXd66vWy12ReAr8MIM0zFmwG2HeHJ9Juw
         57V6vul5SHR7XnYmojf58+iTEt9YiJIWrm7Ni1/qejh95Kq/nAFGflZmlNSlhCtOeX2S
         fnB3TvLv10nrGc7uA4rKDbnpid/7PDbyWlAE7aHmf39Gh/xdhsXPuFLWUTZej7KU5MJX
         yf0tPIub7tujKPlJUNyaPzjmWsx/fIr52DrJi+eNgXJZSHqNrciq9GzU0hasy9XemPyr
         PuE0XokkeqmTNE+zagJT0HxEH84TGjMgcW90n2ppIRMVBBabyvLgMu+2Emd9JjY8+AxY
         uiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ibzd/HltQFWXUhqB2ZPgR5KDRUPRWUvyYsOfNwKbfY=;
        b=tO00q9GSDOvmuE+aT0Mvn1ntkteYF9qAS4WYBtfEsjKWT1mXnKQnI+3lz/4AJg6qFi
         38fc78agA9tykjDR0CccjyrYddJ7hdSrKI4le1qgA8voJRA27zxfQORQnDSU5fsM2b8w
         f3qdk7U8Skzt9Y04SnMwoqA/ysixKoXkK0fn9Gwba7Bi+cv1ffKPK0JFClixWK7i7bss
         O7/Dhds1o16um6ogwWKxBMr6XuHrNfkpT44SoCHQiFBYZgUNI8RLLYCyQnIxwpTVWS5/
         QRWvxbRFRKifIYzq0exDsZhyawkjXLXF41AYGrA5Q16I8A8UuubEizapxxi61AWn6I4h
         ks/g==
X-Gm-Message-State: AJIora+Yd2TtuL5ZxD/PAI+wnKuSAnuhvLvGZQuNpYl9g3KvnZVH3ifj
        6beXw2da0MOO1JdFp33pq4ugOw==
X-Google-Smtp-Source: AGRyM1v81F3RG7MfyQz8Riw19Mirn3N6XSSPEn5oFuEJlC3FzZe7mHAPwIF1XCX9vhMSIremg7Y1bw==
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id bi5-20020a170906a24500b00708ce69e38bmr5385559ejb.100.1656189352173;
        Sat, 25 Jun 2022 13:35:52 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709060f1000b007238429996bsm2953529eji.91.2022.06.25.13.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:35:51 -0700 (PDT)
Message-ID: <7b138ea1-735f-03b1-720b-d3934ad83060@linaro.org>
Date:   Sat, 25 Jun 2022 22:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] media: dt-bindings: ov5693: document YAML binding
Content-Language: en-US
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624230307.3066530-1-tommaso.merciai@amarulasolutions.com>
 <20220624230307.3066530-8-tommaso.merciai@amarulasolutions.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624230307.3066530-8-tommaso.merciai@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
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

On 25/06/2022 01:03, Tommaso Merciai wrote:
> This patch adds documentation of device tree in YAML schema for the
> OV5693 CMOS image sensor from Omnivision
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> ---
>  .../bindings/media/i2c/ovti,ov5693.yaml       | 123 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> new file mode 100644
> index 000000000000..1ee70af40000
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 Amarulasolutions
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5693.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Omnivision OV5693 CMOS Sensor
> +
> +maintainers:
> +  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#

This goes after description.

> +
> +description: |
> +  The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
> +  image sensor that delivers 2592x1944 at 30fps. It provides full-frame,
> +  sub-sampled, and windowed 10-bit MIPI images in various formats via the
> +  Serial Camera Control Bus (SCCB) interface.
> +
> +  Supports images sizes: 5 Mpixel, EIS1080p, 1080p, 720p, VGA, QVGA
> +
> +  OV5693 is programmable through I2C and two-wire Serial Camera Control Bus (SCCB).
> +  The sensor output is available via CSI-2 serial data output (up to 2-lane).
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5693
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      System input clock (aka XVCLK). From 6 to 27 MHz.
> +    maxItems: 1
> +
> +  dovdd-supply:
> +    description:
> +      Digital I/O voltage supply, 1.8V.
> +
> +  avdd-supply:
> +    description:
> +      Analog voltage supply, 2.8V.
> +
> +  dvdd-supply:
> +    description:
> +      Digital core voltage supply, 1.2V.
> +
> +  reset-gpios:
> +    description:
> +      The phandle and specifier for the GPIO that controls sensor reset.
> +      This corresponds to the hardware pin XSHUTDN which is physically
> +      active low.
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +
> +          # Supports max data transfer of 900 Mbps per lane
> +          link-frequencies: true

This is not needed. Provided by video-interfaces.yaml.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - dovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ov5693: camera@36 {
> +            compatible = "ovti,ov5693";
> +            reg = <0x36>;
> +
> +            reset-gpios = <&gpio2 RK_PB1 GPIO_ACTIVE_LOW>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&cif_clkout_m0>;
> +
> +            clocks = <&cru SCLK_CIF_OUT>;
> +            assigned-clocks = <&cru SCLK_CIF_OUT>;
> +            assigned-clock-rates = <19200000>;
> +
> +            avdd-supply = <&vcc_1v8>;
> +            dvdd-supply = <&vcc_1v2>;
> +            dovdd-supply = <&vcc_2v8>;
> +
> +            rotation = <90>;
> +            orientation = <0>;
> +
> +            port {
> +                ucam_out: endpoint {
> +                    remote-endpoint = <&mipi_in_ucam>;
> +                    data-lanes = <1 2>;
> +                    link-frequencies = /bits/ 64 <450000000>;
> +                };
> +            };
> +        };
> +    };
> \ No newline at end of file

^^^ This has to be fixed.

> diff --git a/MAINTAINERS b/MAINTAINERS
Best regards,
Krzysztof
