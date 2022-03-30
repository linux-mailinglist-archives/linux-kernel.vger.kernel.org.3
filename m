Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC74EBAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243279AbiC3GZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiC3GZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:25:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC63B11C10;
        Tue, 29 Mar 2022 23:23:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l129so8263652pga.3;
        Tue, 29 Mar 2022 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BiHWJwiIydA5jhTGeSH+INFFNAJdf8Sa+rmfJIIh3qg=;
        b=Xb67sKNFaSviOnP61J/wq3rfpID0GMXkkRwb1V3x+UWVOMLQI0bmbS/ofyVxr7lgdr
         9BfhMFynRvHeH+uQA5KNLuulxmDlTY0C6zd81N+Ughzy4Pqx6JvwpN6SNakHMxvvbpNV
         lwWma4ZY9MFRGf5qS49m5x49OXUmUTd02XPf/BOpOqmU5h75vEXhERugScY3RC9ZqZxS
         9dfIL4X2m1IGEQFHn/dZFT+5QKb3joIN4klOx++tPCYxQ1McOhPi7SyMxN8gYx1zzm/w
         fOMqzn2fXz5T6erRBXK2JypdiRiV07DuQnQ8zkN9GC45rpPyAMFGaGKRIWtTfO6xudyG
         6qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BiHWJwiIydA5jhTGeSH+INFFNAJdf8Sa+rmfJIIh3qg=;
        b=SyAH5A2aY8X34yqUc64WWQFd+1mP2TzJH3EymyuPkp3Ya1q83AsxFN3mIXAhuWixFh
         HIbFO6vjySwfuKRJk4G2zoR9v8b2RuzrCG1B94qxlGNyLI9E2aJnag/lSWQdfC/PGn8X
         BEgVhMsj3AhygKMgiKoROkxC7Tp2VgQkXnt/AJ5RZhBPmLQUqpZa1uKkSRTrGDs5LWBm
         lro9unt4M/P6L1RHs4FEneSaODuOeeskHwCbUu6wQBwaWlHRJHOLHmXZxxOvmkCDB1+g
         6nAFTLz/qK+jwloOinPkyHXsBsO6UcMplf/qXcTkw9JbOK/mxII/L+Qr6vDHJMfv35Wm
         4uYg==
X-Gm-Message-State: AOAM531eLpbIIlFTwKgLXhRORcRsq64JjWRzXKz5N//+AnFXH4TNDsQ+
        updlo7qhJeh1EwGf8TXlcNw=
X-Google-Smtp-Source: ABdhPJzj2x2+2tRZY3QnYY8m1kwSwdQIzntX9mPa0upuAejXgLrIt8aaQNtW6QGr5FC8C2ocR+Gs3w==
X-Received: by 2002:a65:56cb:0:b0:378:82ed:d74 with SMTP id w11-20020a6556cb000000b0037882ed0d74mr4985440pgs.491.1648621399319;
        Tue, 29 Mar 2022 23:23:19 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id e6-20020a636906000000b00398a43e17e8sm1280498pgc.75.2022.03.29.23.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 23:23:19 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:53:13 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Message-ID: <20220330062313.GA51331@9a2d8922b8f1>
References: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:27:16PM +0200, Krzysztof Kozlowski wrote:
> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> Peripheral Interface (SPI) bindings to DT Schema.
> 
> The original bindings in TXT were not complete, so add during conversion
> properties already used in DTS and/or in the driver: reg-names, dmas,
> interconnects, operating points and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 39 deletions(-)
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
> index 000000000000..a85ff02ba1db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> @@ -0,0 +1,131 @@
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
> +  - $ref: /spi/spi-controller.yaml#

Rob sometime back sent an update on how to refer absolute paths.
Please see below:
https://lore.kernel.org/linux-spi/20220325215652.525383-1-robh@kernel.org/

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
> +    minItems: 2

We can skip minItems here.
As minimim value defaults to maximum if not defined.

> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: qup-core
> +      - const: qup-config

Some properties like clocks, dmas, dma-names, interconnect etc. are
defined as common child properties of geni based qup.
Please see Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml

Shouldn't we skip these entities here? as spi reference will anyway be
used in geni-se.yaml.

-Kuldeep

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
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +    #include <dt-bindings/interconnect/qcom,sc7180.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    spi@880000 {
> +        compatible = "qcom,geni-spi";
> +        reg = <0x880000 0x4000>;
> +        clock-names = "se";
> +        clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&qup_spi0_default>;
> +        interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        power-domains = <&rpmhpd SC7180_CX>;
> +        operating-points-v2 = <&qup_opp_table>;
> +        interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
> +                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
> +        interconnect-names = "qup-core", "qup-config";
> +
> +        tpm@0 {
> +            compatible = "google,cr50";
> +            reg = <0>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&h1_ap_int_odl>;
> +            spi-max-frequency = <800000>;
> +            interrupt-parent = <&tlmm>;
> +            interrupts = <42 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/dma/qcom-gpi.h>
> +
> +    spi@884000 {
> +        compatible = "qcom,geni-spi";
> +        reg = <0x884000 0x4000>;
> +        reg-names = "se";
> +        clock-names = "se";
> +        clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +        dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
> +               <&gpi_dma0 1 1 QCOM_GPI_SPI>;
> +        dma-names = "tx", "rx";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&qup_spi1_default>;
> +        interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +        spi-max-frequency = <50000000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> -- 
> 2.32.0
> 
