Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E3550A13
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiFSLMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiFSLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:12:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A1BBB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:12:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd6so8753493edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0bO4N/uSieqHtAnXgf/1baS2dwMBhkMs6Pm0kaBNkWE=;
        b=E4/RD8c9rgPv1AHiFlOx3T32aiVVENFAPBzZ9eV0RNHaZapFln+0wSq/1SvWdjT7/w
         tY0sACxJsQ+bpZtP51DRVW/qXg/pG5lSvr939MlZdLH3ym40kjJdxzBLp1VGbXUYM4K3
         +qH1aUL9URwDODcWkf+uniMnQzkcUoDPXaVuQirmuPerVEIeFM4796MtJD3w1kElqwEj
         MKcrnBGR4Sanhvm8dGCsbRVNZX5w9TQDsh8wTbaaOrhL+m0JfZqLITvwbPTn4MXVdtm0
         54rg7Nun0IsRPjJwYggAKcsRYquLxH0KpHwH0rS4qCdZwe/qRWEmb+bncbHYUGbi9hSE
         0fPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0bO4N/uSieqHtAnXgf/1baS2dwMBhkMs6Pm0kaBNkWE=;
        b=TEPOG1aj4OFIiw0o2JHbk8pPBd/WiikGhYFovQvV4Go1IugNbAjm1ItmYyAOV8x83K
         fZiT1CyoQSMxa7FJWlNJDJtp56y580TnGrxwYdPSkWbej/mBv2kxJf+GqVHoqyrPYcGA
         eQ1idBDG5UpSoGNaWfXa1VCrsStw8UyOnZklKHQ7MdzX8Va0DpQPfnJOwOFmaNTdZeV2
         0ldW4lOWLWUq7Xv/QkkWHFVoLPlLJfBs49H1cFkexGRJirfUrlUfMCoTVrxsrek9QSrZ
         8QYkEm9TfrKOXBwHONCh9KVAaSdPtsYT6Elg0Jj0DuZw+JlPUievatwSPAUUI9YgVPoP
         DClg==
X-Gm-Message-State: AJIora+FDSyUHm1H41s87uVMszFyQwm91EkCqLtZ8St15lmyyrq6nK8r
        kp4GdDo6mK02AbIhSwjnSgAZlQ==
X-Google-Smtp-Source: AGRyM1sz0sgafrtoHUw3Rga320+sJuYPhf/shTkqFB8UnCO7EmRgYnNSdcZbJGtmYHwsovZ6x1Cdhw==
X-Received: by 2002:a05:6402:35d0:b0:42e:1a76:67ae with SMTP id z16-20020a05640235d000b0042e1a7667aemr23346476edc.311.1655637165805;
        Sun, 19 Jun 2022 04:12:45 -0700 (PDT)
Received: from [192.168.0.206] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906318200b006fe98fb9523sm4489330ejy.129.2022.06.19.04.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 04:12:45 -0700 (PDT)
Message-ID: <8faae2a3-6758-979c-e7b0-1d4b18ae1a5b@linaro.org>
Date:   Sun, 19 Jun 2022 13:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 06/16] dt-bindings: gpio: Add AXP192 GPIO bindings
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-7-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220618214009.2178567-7-aidanmacdonald.0x0@gmail.com>
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

On 18/06/2022 23:39, Aidan MacDonald wrote:
> The AXP192 PMIC is different enough from the PMICs supported by
> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> driver also supports interrupts and pinconf settings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> new file mode 100644
> index 000000000000..1e368cac9d3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/gpio/x-powers,axp192-gpio.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: X-Powers AXP192 GPIO Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +
> +properties:
> +  compatible:
> +    const: x-powers,axp192-gpio
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: >
> +      The first cell is the pin number and the second is the GPIO flags.
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +patternProperties:
> +  "-pins$":
> +    $ref: /schemas/pinctrl/pinmux-node.yaml#
> +
> +    properties:
> +      pins:
> +        items:
> +          enum:
> +            - GPIO0
> +            - GPIO1
> +            - GPIO2
> +            - GPIO3
> +            - GPIO4
> +            - N_RSTO
> +
> +      function:
> +        enum:
> +          - output
> +          - input
> +          - ldo
> +          - pwm
> +          - adc
> +          - low_output
> +          - floating
> +          - ext_chg_ctl
> +          - ldo_status
> +
> +required:
> +  - compatible
> +  - "#gpio-cells"
> +  - gpio-controller
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pinctrl0: gpio@0 {

Unit address without reg, that's not a valid DTS.

> +        compatible = "x-powers,axp192-gpio";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&pinctrl0 0 0 6>;
> +    };


Best regards,
Krzysztof
