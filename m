Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317CF506FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346251AbiDSOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346063AbiDSOE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:04:29 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E083969B;
        Tue, 19 Apr 2022 07:01:46 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id r8so18201319oib.5;
        Tue, 19 Apr 2022 07:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mt7uVgc54YUjQtx9Wdev1B+Wcl8E6zcRnvUq+Ap7mpU=;
        b=SjlQ9VQb8gD6Cgv065x1WauoydmJUgJyfsbxAWrnzPwn+bb54wn6Pg8aNIBu+wuX2O
         keu6XEiPR4tDKLTzifNqAxfBfVAHzMGD6qk8OhcNnU++FLEaVbUb4AsIqJxMKTYq4DrJ
         1p++ptkstr49xLvioWfBaNJ0CXUzeExtAiKY/tOlwWsP57ibHFkHe85oHp1y9ICDb/YY
         fRTl+/XVO8AXij7izT5EVsW/KyXYfY5M/PaaNvQaA2Se7ZTvtR9k2aAevNJGpFelQWC0
         O/MnCX0giMAk4uiBldD5MyM5cn4E0d642+85Gt+puRUgiBSBc5a8Ea2Df/LyoUUr47jh
         GSKg==
X-Gm-Message-State: AOAM530CNk4PM8D19Y+W3QO9lBdz5dROJCg2sHzzoyc2meA9wakleVlj
        jnBIA4Vehd/Gi/Hh4fFSWQ==
X-Google-Smtp-Source: ABdhPJxpJIUSA95GyW1+vPT0tyqjivGQUiKsHq2oioysIJl2CsAbhyXZBLSNxZvsDwuh2ppF/zi1ig==
X-Received: by 2002:a05:6808:1911:b0:322:c4ec:85e5 with SMTP id bf17-20020a056808191100b00322c4ec85e5mr932540oib.12.1650376906225;
        Tue, 19 Apr 2022 07:01:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hc3-20020a056870788300b000e5dfc7d6b9sm2222231oab.14.2022.04.19.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:01:45 -0700 (PDT)
Received: (nullmailer pid 2460010 invoked by uid 1000);
        Tue, 19 Apr 2022 14:01:45 -0000
Date:   Tue, 19 Apr 2022 09:01:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus
 SM5703 MFD
Message-ID: <Yl7AyYAwkyO3oDrW@robh.at.kernel.org>
References: <20220415164356.25165-1-markuss.broks@gmail.com>
 <20220415164356.25165-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415164356.25165-3-markuss.broks@gmail.com>
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

On Fri, Apr 15, 2022 at 07:43:53PM +0300, Markuss Broks wrote:
> This patch adds device-tree bindings for the Silicon Mitus
> SM5703 MFD.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  .../bindings/mfd/siliconmitus,sm5703.yaml     | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> new file mode 100644
> index 000000000000..aa676967593d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/siliconmitus,sm5703.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Mitus SM5703 multi-function device bindings
> +
> +maintainers:
> +  - Markuss Broks <markuss.broks@gmail.com>
> +
> +description: |
> +  Silicon Mitus SM5703 is a multi-function device, that consists of several
> +  modules, designed for a mobile phone use. It consists of
> +  LDO, Buck, USBLDO and VBUS regulators, a flash LED driver, a MUIC unit,
> +  a fuel gauge and a battery charger circuit. The MUIC and Fuel-Gauge units
> +  are separate from the main MFD, having their own i2c lines, while the
> +  LED driver, regulators and charger are sharing the main i2c bus of the MFD.
> +
> +properties:
> +  compatible:
> +    const: siliconmitus,sm5703-mfd

'-mfd' is redundant. Drop.

> +
> +  reg:
> +    description:
> +      I2C slave address.
> +    maxItems: 1
> +
> +  regulators:
> +    $ref: ../regulator/siliconmitus,sm5703-regulator.yaml

/schemas/regulator/...

> +    description:
> +      List of child nodes that specify the regulators.
> +
> +  reset-gpio:

'-gpios' is the preferred form even with 1.

Are the MUIC and Fuel-Gauge units independent from this reset?

> +    description:
> +      GPIO which is connected to the MRSTB pin.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      mfd@49 {

'pmic' is the standard name.

> +        compatible = "siliconmitus,sm5703-mfd";
> +        reg = <0x49>;
> +
> +        reset-gpio = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
> +        pinctrl-0 = <&mrstb_default>;
> +
> +        regulator {
> +          compatible = "siliconmitus,sm5703-regulator";
> +
> +          regulators {
> +            sm5703_ldo1: ldo1 {
> +              regulator-min-microvolt = <2800000>;
> +              regulator-max-microvolt = <2800000>;
> +            };
> +
> +            sm5703_ldo2: ldo2 {
> +              regulator-min-microvolt = <1500000>;
> +              regulator-max-microvolt = <3300000>;
> +            };
> +
> +            sm5703_ldo3: ldo3 {
> +              regulator-min-microvolt = <3300000>;
> +              regulator-max-microvolt = <3300000>;
> +            };
> +
> +            sm5703_usbldo1: usbldo1 {
> +              regulator-min-microvolt = <4800000>;
> +              regulator-max-microvolt = <4800000>;
> +            };
> +
> +            sm5703_usbldo2: usbldo2 {
> +              regulator-min-microvolt = <4800000>;
> +              regulator-max-microvolt = <4800000>;
> +            };
> +
> +            sm5703_vbus: vbus {
> +              regulator-min-microvolt = <5000000>;
> +              regulator-max-microvolt = <5000000>;
> +            };
> +          };
> +        };
> +      };
> +    };
> +...
> -- 
> 2.35.1
> 
> 
