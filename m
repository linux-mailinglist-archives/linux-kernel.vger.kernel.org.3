Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46A5A91B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiIAIK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiIAIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:09:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79781299C1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:09:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p7so12140779lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jdaImCAMzvEFX9TwXI3b3A22fnyD7RAu4eGJcB2v2L4=;
        b=T5we5fmyC8p8+kk27wkfq0GL1b/ybd4BIXqIjTjUIFJ6yL1szPCGv1FMsWQfITTimy
         b9wW54HB7bBhJ3R6Yi8GoSKrHTlmfit/WD2xt20MeDIlO65jXQWDrt3iiFe7TTZNvN5d
         Ra4ZbPxt5dA3R6uyWNA3VfypbwwSIxU1E3a3sxZU148FCpnGDTjRyDPQuPgFrQegaIwE
         kefgZy2n3Bau7KRgMimrpkuOOuXEJc8jyRjnrIY5ci5LX1di17H9e5FB3cBbKUwc2Wrx
         UYx5KlrOd0A+s0177ERo9VBKNxJpgDJVpCQQHgKEsjB4e3J75d8ylBzrNt352aJyaouR
         wHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jdaImCAMzvEFX9TwXI3b3A22fnyD7RAu4eGJcB2v2L4=;
        b=3UQb1Lw8AM9yXKAwF7tqiobV7EZJ8LWWzi9oSz1MXFwocJn/ciytVEkxOTi0hTidQw
         0mJyEhi2jgDCveDn9lGuP1Daiyl48jmkiGs9ddtjKDrMnPo+doDDnFlbnVv5+0eyh1NK
         LtnaALel1D9eRX9xgv6NoYab000DjYv+XvNsLWch1pyWp5TgMNjYrJFOk2cAnqOZ0Xhh
         o6tIYXoso7w+n/e8fyjg/K3hwIsX0au8iPoFWgQHZ+f3/urDhbkkxaNFP0olfh0vNXPI
         Btxf6EasQ1LADTTqcDfEyGpTSKQY5SHfULmWGJMtGYPjvsakQM0tCFa9/lz7RZo2eilQ
         jAng==
X-Gm-Message-State: ACgBeo0XDCyNX9ZnzzJJGNT4mtL8zAaN0ViGAJvNQCQ+/NBDmhKDPvz/
        VRIdprTqltQW9fCE6ibfhyQ0qy38WzGZlg4p
X-Google-Smtp-Source: AA6agR6ozcS7BNEED6T7ONfuYK1PEO81TnBZdK0SOVWrXBnqMgkXc+sQbCOLwiQhHF/PUp4UDU719w==
X-Received: by 2002:a05:6512:32c6:b0:494:99fe:49b9 with SMTP id f6-20020a05651232c600b0049499fe49b9mr751880lfg.410.1662019762610;
        Thu, 01 Sep 2022 01:09:22 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id bj38-20020a2eaaa6000000b002682754293fsm726958ljb.1.2022.09.01.01.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:09:21 -0700 (PDT)
Message-ID: <bee118ef-0e38-2049-ffe3-a9893a49b8c3@linaro.org>
Date:   Thu, 1 Sep 2022 11:09:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 08/13] dt-bindings: mfd: add rk806 binding
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220831215437.117880-1-sebastian.reichel@collabora.com>
 <20220831215437.117880-9-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831215437.117880-9-sebastian.reichel@collabora.com>
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

On 01/09/2022 00:54, Sebastian Reichel wrote:
> Add DT binding document for Rockchip's RK806 PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/mfd/rockchip,rk806.yaml          | 388 ++++++++++++++++++
>  1 file changed, 388 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> new file mode 100644
> index 000000000000..c775ef60db8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
> @@ -0,0 +1,388 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RK806 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Sebastian Reichel <sebastian.reichel@collabora.com>
> +
> +description: |
> +  Rockchip RK806 series PMIC. This device consists of an spi or
> +  i2c controlled MFD that includes multiple switchable regulators.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk806
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  vcc1-supply:
> +    description:
> +      The input supply for DCDC_REG1.
> +
> +  vcc2-supply:
> +    description:
> +      The input supply for DCDC_REG2.
> +
> +  vcc3-supply:
> +    description:
> +      The input supply for DCDC_REG3.
> +
> +  vcc4-supply:
> +    description:
> +      The input supply for DCDC_REG4.
> +
> +  vcc5-supply:
> +    description:
> +      The input supply for DCDC_REG5.
> +
> +  vcc6-supply:
> +    description:
> +      The input supply for DCDC_REG6.
> +
> +  vcc7-supply:
> +    description:
> +      The input supply for DCDC_REG7.
> +
> +  vcc8-supply:
> +    description:
> +      The input supply for DCDC_REG8.
> +
> +  vcc9-supply:
> +    description:
> +      The input supply for DCDC_REG9.
> +
> +  vcc10-supply:
> +    description:
> +      The input supply for DCDC_REG10.
> +
> +  vcc11-supply:
> +    description:
> +      The input supply for PLDO_REG1, PLDO_REG2 and PLDO_REG3.
> +
> +  vcc12-supply:
> +    description:
> +      The input supply for PLDO_REG4 and PLDO_REG5.
> +
> +  vcc13-supply:
> +    description:
> +      The input supply for NLDO_REG1, NLDO_REG2 and NLDO_REG3.
> +
> +  vcc14-supply:
> +    description:
> +      The input supply for NLDO_REG4 and NLDO_REG5.
> +
> +  vcca-supply:
> +    description:
> +      The input supply for PLDO_REG6.
> +
> +  regulators:
> +    type: object
> +    patternProperties:
> +      "^(DCDC_REG[1-9]0?|[PN]LDO_REG[1-6])$":

1. Your pattern is a bit wide. Seems to accept DCDC_REG90. That piece
should be ([1-9]|10)

2. Only lowercase and no underscores in node names.


> +        type: object
> +        $ref: ../regulator/regulator.yaml#

Full path, so /schemas/regulator/......

> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/pinctrl/rockchip.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@0 {
> +            compatible = "rockchip,rk806";
> +            reg = <0x0>;
> +
> +            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +
> +            vcc1-supply = <&vcc5v0_sys>;
> +            vcc2-supply = <&vcc5v0_sys>;
> +            vcc3-supply = <&vcc5v0_sys>;
> +            vcc4-supply = <&vcc5v0_sys>;
> +            vcc5-supply = <&vcc5v0_sys>;
> +            vcc6-supply = <&vcc5v0_sys>;
> +            vcc7-supply = <&vcc5v0_sys>;
> +            vcc8-supply = <&vcc5v0_sys>;
> +            vcc9-supply = <&vcc5v0_sys>;
> +            vcc10-supply = <&vcc5v0_sys>;
> +            vcc11-supply = <&vcc_2v0_pldo_s3>;
> +            vcc12-supply = <&vcc5v0_sys>;
> +            vcc13-supply = <&vcc5v0_sys>;
> +            vcc14-supply = <&vcc_1v1_nldo_s3>;
> +            vcca-supply = <&vcc5v0_sys>;
> +
> +            regulators {
> +                vdd_gpu_s0: DCDC_REG1 {

Only lowercase and no underscores in node names.

> +                        regulator-always-on;

Messed up indentation. 4 spaces for DTS.

Best regards,
Krzysztof
