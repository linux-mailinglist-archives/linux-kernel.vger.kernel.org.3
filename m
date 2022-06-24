Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7888555989A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiFXLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFXLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:39:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB36802C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:39:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id g26so4130211ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wj6+le4xQYgRWhbJ4o+JcrPIptpoGXL5M4xVrdtZbXI=;
        b=O26iv82q0trCWgDQwRmW6rUiSusM7pWvnNkO+V25QbNy7sOhu5esaQuJS7PwEwU3me
         Y5h7BfA9Gsbe2XrGvelcv6XAS5b+QDIjWuyq9j37ZvWmhRmJ48gmjKfPI+n6s0JkG0Im
         CDVkH9TIGF7b8/w7lXV62OP94WgbzGfx7wpTJbGIrqDtM3uOjQnbLKSKlKwAtePFBT0V
         p0UC7KC2dcsZiVk+jsW+BB+3hwR39LVFSI68D3J4t1grJmX1kHAWk4K42QCX24AX1oi0
         SbMSM89C1Pj1C7dtRAeCcSnHR7lTOSfcpvpwV+KgsO9loIxaBH/9by5n0QkWSZvgYpVw
         4zZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wj6+le4xQYgRWhbJ4o+JcrPIptpoGXL5M4xVrdtZbXI=;
        b=WHQmK1oUXYoZg3gr3gnis/G+cupxHRXEVkA0HFjszi3Rh932mttFOCwpoWxD8jXE/C
         zcDCGbHFbRDeKA4zsCooC+BswUDEgftyZBW26/T2T5iQ80LkzACbwFIZlz6rnHXWPJU7
         8q65+AQeivN0zzhJ/01MEN1Iz+aDcpyWN8AcYRmbhWKk4t4IoLuOcmCiJJHfdNWscxrY
         6B7L1Os6T0CoVlTGCumFf982VHyhAYbU5LOgaPNRpFxDZ2eimNpe4zTgdMlua6yyn/df
         3dqRz+24Y+lZHx8gCU1jPc9H9fpfYC1n8o2CSWsOmCY6ws0WJtzrSV7mpxUXPA4qHLYF
         KGFA==
X-Gm-Message-State: AJIora9dC/115FEbq1umKJ+jPfDY3xAWLN0bcvp+frerXj3+W6Wceqto
        Io9YhtXafRkRP8UmTBRxw5a1ug==
X-Google-Smtp-Source: AGRyM1tMl63rWpj4b70pBJHZZBdq7tLURrxHPvEhTWmOq2GveNEsVZf4u0behvJ6CGqQ22A5aqS+/g==
X-Received: by 2002:a17:907:7e81:b0:726:2912:7467 with SMTP id qb1-20020a1709077e8100b0072629127467mr7207432ejc.373.1656070778635;
        Fri, 24 Jun 2022 04:39:38 -0700 (PDT)
Received: from [192.168.0.235] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm962517ejd.196.2022.06.24.04.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 04:39:38 -0700 (PDT)
Message-ID: <8956c98e-657c-0263-c8d9-d6beb54410f9@linaro.org>
Date:   Fri, 24 Jun 2022 13:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 06/14] dt-bindings: mfd: Add Mediatek MT6370
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-7-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623115631.22209-7-peterwu.pub@gmail.com>
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

On 23/06/2022 13:56, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek MT6370 binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> 
> v3
> - Use " in entire patchset
> - Refine ADC description
> - Rename "enable-gpio" to "enable-gpios" in "regualtor"
> - Change "/schemas/" to "../" in every reference of all MT6370 modules
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6370.yaml   | 280 +++++++++++++++++++++
>  include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |  18 ++
>  2 files changed, 298 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> new file mode 100644
> index 0000000..fa9da13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> @@ -0,0 +1,280 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,mt6370.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT6370 SubPMIC
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  MT6370 is a highly-integrated smart power management IC, which includes a
> +  single cell Li-Ion/Li-Polymer switching battery charger, a USB Type-C &
> +  Power Delivery (PD) controller, dual flash LED current sources, a RGB LED
> +  driver, a backlight WLED driver, a display bias driver and a general LDO for
> +  portable devices.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370
> +
> +  reg:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  adc:
> +    type: object
> +    description: |
> +      Provides 9 channels for system monitoring, including VBUSDIV5 (lower
> +      accuracy, higher measure range), VBUSDIV2 (higher accuracy, lower
> +      measure range), VBAT, VSYS, CHG_VDDP, TS_BAT, IBUS, IBAT, and TEMP_JC.
> +
> +    properties:
> +      compatible:
> +        const: mediatek,mt6370-adc
> +
> +      "#io-channel-cells":
> +        const: 1
> +
> +    required:
> +      - compatible
> +      - "#io-channel-cells"
> +
> +  backlight:
> +    type: object
> +    $ref: ../leds/backlight/mediatek,mt6370-backlight.yaml#

This was correct before: /schemas/leds/ ....

Same in other places.


Best regards,
Krzysztof
