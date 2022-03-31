Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7864EDFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiCaSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiCaSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:00:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABDB58395;
        Thu, 31 Mar 2022 10:58:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb19so174697pjb.1;
        Thu, 31 Mar 2022 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGkOVC70bzVuGq7W5va5FW2YqhPw4t1EaQSF8Oh5XFc=;
        b=A5n6vOXWM0DhT0+Ngm3q171Z8z9n2EvKxyNFWmEW/QjXgV3iQOMj9uzzIQWuuuI5N+
         Tclx8N4zuuFp5uY3IFLCezVBWNgQ5MZS6Qx+Mc/5Z48x7Od1o728XaztXg64VYZaB0O0
         k4N/lcc8+F+sHzgQSDIp8EPtIPq58kZ4uZbZgKVy2uAqKJo6NyxWHnlAqvuubhyT3+je
         BUpciCdjfg+OQlqA5LwhK071e+cs5MzKyizWY6y1jpVqH6YAEUUeAAWZArLGGn9qQA1M
         TWUMm3xydS9mWuXhCXSAy0vwd5tRG9Sv4p85knhqDh5Xu4eR0aSR4J6+SUWv3eLVoeyD
         GqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGkOVC70bzVuGq7W5va5FW2YqhPw4t1EaQSF8Oh5XFc=;
        b=3Mx0R/khYcwf9LYPzkZsaRypxuyuV6mVKBOStwuurXTwwc6zDTc6cuHYYNSHCLl4bP
         CLfs/lKXVzisNG9tyVyXL2QqNc38DH8ocHjwX/SG+xCLvJ8DeXZHqKffA1Gi6WK7mvXw
         pP9lhiYmf1iUyU61J0TAYM+V17dFaSzcrVxVqMEulaA7UtVKmFccHDYVhY2QnELLy3f1
         a9lk7Sc5r6VY3J8WeNb67stUlmqWYm32OcO3kCxafM5afsHfob7738QjL869SinZ6zjt
         uppC4Lo5kYokShR9aTRVcoH4Sv46O+jbO5SskZvFti2ptpuZ1pZBWRcJmHi8REBYn5gR
         wEQA==
X-Gm-Message-State: AOAM530JWNth+j1c4vDgMylbV4Se50upDO4tf13XV7snybybFi6Ex940
        niPklgu8j9O3kerCmbhkWv0=
X-Google-Smtp-Source: ABdhPJzUq/bCYFJfxLHEcil0Owpt5lmWROIU8bfkVBlOrIcuSkJUYs3LtQReAWDIuE6hBYlfkNzaYQ==
X-Received: by 2002:a17:90b:3a82:b0:1c7:bc91:a87e with SMTP id om2-20020a17090b3a8200b001c7bc91a87emr7390289pjb.7.1648749503248;
        Thu, 31 Mar 2022 10:58:23 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id v8-20020a056a00148800b004fa9bd7ddc9sm121741pfu.113.2022.03.31.10.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:58:23 -0700 (PDT)
Date:   Thu, 31 Mar 2022 23:28:17 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Message-ID: <20220331175817.GA91341@9a2d8922b8f1>
References: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 06:02:47PM +0200, Krzysztof Kozlowski wrote:
> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> Peripheral Interface (SPI) bindings to DT Schema.
> 
> The original bindings in TXT were not complete, so add during conversion
> properties already used in DTS and/or in the driver: reg-names, dmas,
> interconnects, operating points and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct $ref path and remove interconnect minItems (Kuldeep).
> 2. Remove child tpm device from example.
> 3. Pad reg hex addresses with 00.
> ---
>  .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 120 ++++++++++++++++++
>  2 files changed, 120 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> deleted file mode 100644
> index c8c1e913f4e7..000000000000
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
> -
> -The QUP v3 core is a GENI based AHB slave that provides a common data path
> -(an output FIFO and an input FIFO) for serial peripheral interface (SPI)
> -mini-core.
> -
> -SPI in master mode supports up to 50MHz, up to four chip selects, programmable
> -data path from 4 bits to 32 bits and numerous protocol variants.
> -
> -Required properties:
> -- compatible:		Must contain "qcom,geni-spi".
> -- reg:			Must contain SPI register location and length.
> -- interrupts:		Must contain SPI controller interrupts.
> -- clock-names:		Must contain "se".
> -- clocks:		Serial engine core clock needed by the device.
> -- #address-cells:	Must be <1> to define a chip select address on
> -			the SPI bus.
> -- #size-cells:		Must be <0>.
> -
> -SPI Controller nodes must be child of GENI based Qualcomm Universal
> -Peripharal. Please refer GENI based QUP wrapper controller node bindings
> -described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
> -
> -SPI slave nodes must be children of the SPI master node and conform to SPI bus
> -binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
> -
> -Example:
> -	spi0: spi@a84000 {
> -		compatible = "qcom,geni-spi";
> -		reg = <0xa84000 0x4000>;
> -		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-names = "se";
> -		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
> -		pinctrl-names = "default", "sleep";
> -		pinctrl-0 = <&qup_1_spi_2_active>;
> -		pinctrl-1 = <&qup_1_spi_2_sleep>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> new file mode 100644
> index 000000000000..62c4a9598e16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/qcom,spi-geni-qcom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  The QUP v3 core is a GENI based AHB slave that provides a common data path
> +  (an output FIFO and an input FIFO) for serial peripheral interface (SPI)
> +  mini-core.
> +
> +  SPI in master mode supports up to 50MHz, up to four chip selects,
> +  programmable data path from 4 bits to 32 bits and numerous protocol variants.
> +
> +  SPI Controller nodes must be child of GENI based Qualcomm Universal
> +  Peripharal. Please refer GENI based QUP wrapper controller node bindings
> +  described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,geni-spi
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: se
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: qup-core
> +      - const: qup-config
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    const: se

Why reg-names is required?
Reg contain max 1 value, we can skip reg-names like other users.

Also, "se" is used as clock name and using it again for reg-names?
I think this is wrong and reg-names shouldn't be documented.

-Kuldeep
