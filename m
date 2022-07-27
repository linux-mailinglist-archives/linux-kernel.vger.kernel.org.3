Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD7581F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiG0FWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0FWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:22:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D483ED4C;
        Tue, 26 Jul 2022 22:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53DF9B81F27;
        Wed, 27 Jul 2022 05:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7CCC433D7;
        Wed, 27 Jul 2022 05:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658899357;
        bh=OZIRhN7VrvtIIX7C5jGw3KpdUFPLglKm2y+Z9engUX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o4h43SfALHCO4IWCDLSQ3e43OmHAxZz3LDz9q/wTF4EH1eFciCHXtKRogB65bYafG
         rToIz4PzSTF8TXIWn6vlOrDyRmdTOWp3KNq889jPLcTl9AkaSnircHErJ0SmztFl1L
         8/Ah5X2DlEWuUT5fquO7JURchr8UcTjrDAAaV5PrFn05XRGuCC/JogDOp64nTJN3bg
         wXgyEa5+Zlxe1A4TenKvOW80qvRyG5Iu7UL6d3j/ImfxvrLQNZYiSM9Eoj4dVnt3e9
         vlw9LUzo8FHIvUG+PYQM+9yq7/jwSQsAYzCYtV3Wda6wIKZbIeyP2lJx9/Gnla40q/
         Cf29kGu1HApkA==
Date:   Wed, 27 Jul 2022 10:52:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: qcom,pm8916-wdt: convert to
 dtschema
Message-ID: <YuDLmbEQKfuGzkUC@matsya>
References: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
 <20220726120215.101868-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726120215.101868-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-22, 14:02, Krzysztof Kozlowski wrote:
> Convert the Qualcomm PM8916 watchdog timer controller bindings to DT
> schema and include them in parent device schema.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/power/reset/qcom,pon.yaml        |  4 ++
>  .../bindings/watchdog/qcom,pm8916-wdt.txt     | 28 ----------
>  .../bindings/watchdog/qcom,pm8916-wdt.yaml    | 51 +++++++++++++++++++
>  3 files changed, 55 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> index e8ecb75155db..e7b436d2e757 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> @@ -36,6 +36,10 @@ properties:
>      type: object
>      $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
>  
> +  watchdog:
> +    type: object
> +    $ref: /schemas/watchdog/qcom,pm8916-wdt.yaml
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> deleted file mode 100644
> index 6fb984f31982..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -QCOM PM8916 watchdog timer controller
> -
> -This pm8916 watchdog timer controller must be under pm8916-pon node.
> -
> -Required properties:
> -- compatible: should be "qcom,pm8916-wdt"
> -
> -Optional properties :
> -- interrupts : Watchdog pre-timeout (bark) interrupt.
> -- timeout-sec : Watchdog timeout value in seconds.
> -
> -Example:
> -
> -	pm8916_0: pm8916@0 {
> -		compatible = "qcom,pm8916", "qcom,spmi-pmic";
> -		reg = <0x0 SPMI_USID>;
> -
> -		pon@800 {
> -			compatible = "qcom,pm8916-pon";
> -			reg = <0x800>;
> -
> -			watchdog {
> -				compatible = "qcom,pm8916-wdt";
> -				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
> -				timeout-sec = <10>;
> -			};
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
> new file mode 100644
> index 000000000000..568eb8480fc3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/qcom,pm8916-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PM8916 watchdog timer controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,pm8916-wdt
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/spmi/spmi.h>
> +
> +    pmic@0 {
> +        compatible = "qcom,pm8916", "qcom,spmi-pmic";
> +        reg = <0x0 SPMI_USID>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pon@800 {
> +            compatible = "qcom,pm8916-pon";
> +            reg = <0x800>;
> +            mode-bootloader = <0x2>;
> +            mode-recovery = <0x1>;
> +
> +            watchdog {
> +                compatible = "qcom,pm8916-wdt";
> +                interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
> +                timeout-sec = <60>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1

-- 
~Vinod
