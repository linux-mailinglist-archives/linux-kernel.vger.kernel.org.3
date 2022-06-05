Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C973453DED1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351763AbiFEWzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiFEWzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:55:12 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A52F4EDD9;
        Sun,  5 Jun 2022 15:55:08 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id br33so8097392qkb.0;
        Sun, 05 Jun 2022 15:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDlnU81AiM8Gn0ExLEpLMPSw6ZZMLCrZp3X9UqZjqro=;
        b=hYQkiSQEkQvDNyN7l2GczVC2nNjKF9wca34kLTdExr4w3IMAOYi7BzqrHdXSJpGwWU
         vCmp7VvJKBJnq+syWWO1jbxTobp/64+mnIteclU05tAICL+Dx7iJ+PfytNFuMKZSL96g
         ThCWquMK4jMQTcTnkWEdFJUdxn8Ey/aIhkf2Z8NBKp/c6072dZPBkLmM2yTAdXkktffq
         4hptSX+AyPoucmsva9PXFIfGdxx5+VHwJUQn9BlaMk3+0l5o4rIYs5bJ3AKoKmZhWjMG
         9s7BXpYrm8eFFFeSQhh7+UCcm2M+uHzr+qs8GcvCZg1wRH1A953rbP/RH/RDngAoO1+/
         eJoA==
X-Gm-Message-State: AOAM532mb0HGuFEa43yHK+eOMDouWN2BdsOSOWeMVXQ6DcdvEJYjAri0
        P69GvY4gCYCOPfMlPJDTKQ==
X-Google-Smtp-Source: ABdhPJxhOTbHhJKechkHtyNPX6o7qRMCIqbh9d8lKz+uJmQcV5Y4H4GAHqF0tyDtjHw7nRY8SPNZIw==
X-Received: by 2002:a05:620a:29c1:b0:6a5:aa9b:d13e with SMTP id s1-20020a05620a29c100b006a5aa9bd13emr13581579qkp.629.1654469707606;
        Sun, 05 Jun 2022 15:55:07 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:1bdb:2e61:f12:452:5315:9c7e])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a1a8d00b002f39b99f6a4sm9591309qtc.62.2022.06.05.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 15:55:07 -0700 (PDT)
Received: (nullmailer pid 3681998 invoked by uid 1000);
        Sun, 05 Jun 2022 22:55:04 -0000
Date:   Sun, 5 Jun 2022 17:55:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: gpio: Add AXP192 GPIO bindings
Message-ID: <20220605225504.GA3678983-robh@kernel.org>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-6-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-6-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:57:09PM +0100, Aidan MacDonald wrote:
> The AXP192 PMIC is different enough from the PMICs supported by
> the AXP20x GPIO driver to warrant a separate driver. The AXP192
> driver also supports interrupts and pinconf settings.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  .../bindings/gpio/x-powers,axp192-gpio.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> new file mode 100644
> index 000000000000..7a985640ade8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp192-gpio.yaml
> @@ -0,0 +1,59 @@
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
> +  "#gpio-cells":
> +    const: 2
> +    description: >
> +      The first cell is the pin number and the second is the GPIO flags.
> +
> +  compatible:
> +    oneOf:
> +      - enum:

No need for 'oneOf' with only 1 entry.

> +          - x-powers,axp192-gpio
> +
> +  gpio-controller: true
> +
> +patternProperties:
> +  "^.*-pins?$":

You can omit '^.*'

Why does 's' need to be optional?

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
> +
> +additionalProperties: false
> +
> +...
> -- 
> 2.35.1
> 
> 
