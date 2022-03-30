Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107DF4EBFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbiC3Lol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiC3Lok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:44:40 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58125CBBE;
        Wed, 30 Mar 2022 04:42:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b130so15981077pga.13;
        Wed, 30 Mar 2022 04:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QBJSUD8GqAvRvcwNkbx5+/oJaLZv56nrRkRtYdsXQJA=;
        b=Q6eDP6sF55ijEVUzRKOoLdvNfr49+8AnK6I+UZEuoPzNEfqUYouALd99NdraOLIVeI
         Vk/wA66w0TDebiNJ+elh4UHVRvOeTC+XxNmeq4kHRaua0mVsDpZozOzrHXoR/xeJvmXo
         eyatq2Do5uUL5xXze6vIkKaAXF6uWsWlM6PR7hvU3Ws+G8YCjBXjlG1EI/DCSwoC2IGJ
         NyuBRwhp1SFJzsV/nhNudd40i5RYEjzZmyO3wxa7nf4h8hIXDDsJ18jDglQUKlgXPXJ8
         /nmuWj0zWNVGxdgcgvBQOMic2/H5qAqJa1PlnEl1OoR5r+64M5YUOLisdii+3+7cvvum
         lImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBJSUD8GqAvRvcwNkbx5+/oJaLZv56nrRkRtYdsXQJA=;
        b=EX/CXh1nsfH2PFtlhyq/LqoGM790NKiwDrTIGsaynZq9Cj7/AK/IgNZA9oK5S2Qo0o
         38YV6863P9E+tw2BY5yVMZT4YqIKMev1jw6gJHehBoz2+e2HL9TlXJfRqEI+SlYXsNKH
         nE5UNtjY3sPgf4inpcaH2+Na4cJu+UDL31WRFutLKhqRnZ2+kDRS3tbmaAHvB23+DYui
         YN7Du6f74Vw8xzkD34wUKMaT4WI/coeeyB+ZFJHt9WfeTdAz8HENKSgzQFscO4D7MRrb
         3qxv/+s9fqOqOfvPae0Sl01eh3naMIsZ522wAr5eR9rvLpVUNSPE5shcGcRJ2WNYpXR6
         luAw==
X-Gm-Message-State: AOAM531AfD7TE/pry+aip+DD+najAe8DBlZ3A2Cg5vpqLqLlMtYDCsYo
        YbehYg0HjXUZt/cX3n1oFX0=
X-Google-Smtp-Source: ABdhPJxAAhY612bveOREqICLxVDezvI6njy4NTy7Q4zaKSI5Zh7LiSFrfLNW7LFcEy/0nF2zvtG5dg==
X-Received: by 2002:a63:742:0:b0:382:2684:dd41 with SMTP id 63-20020a630742000000b003822684dd41mr5962733pgh.38.1648640574826;
        Wed, 30 Mar 2022 04:42:54 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a0022cf00b004fb32b9e000sm15988949pfj.1.2022.03.30.04.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:42:54 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:12:47 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] spi: dt-bindings: qcom,spi-qup: convert to dtschema
Message-ID: <20220330114247.GA51417@9a2d8922b8f1>
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
 <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 01:29:02PM +0200, Krzysztof Kozlowski wrote:
> Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
> Interface (SPI) bindings to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
>  .../devicetree/bindings/spi/qcom,spi-qup.yaml |  82 ++++++++++++++
>  2 files changed, 82 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> deleted file mode 100644
> index 5c090771c016..000000000000
> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
> -
> -The QUP core is an AHB slave that provides a common data path (an output FIFO
> -and an input FIFO) for serial peripheral interface (SPI) mini-core.
> -
> -SPI in master mode supports up to 50MHz, up to four chip selects, programmable
> -data path from 4 bits to 32 bits and numerous protocol variants.
> -
> -Required properties:
> -- compatible:     Should contain:
> -		  "qcom,spi-qup-v1.1.1" for 8660, 8960 and 8064.
> -		  "qcom,spi-qup-v2.1.1" for 8974 and later
> -		  "qcom,spi-qup-v2.2.1" for 8974 v2 and later.
> -
> -- reg:            Should contain base register location and length
> -- interrupts:     Interrupt number used by this controller
> -
> -- clocks:         Should contain the core clock and the AHB clock.
> -- clock-names:    Should be "core" for the core clock and "iface" for the
> -                  AHB clock.
> -
> -- #address-cells: Number of cells required to define a chip select
> -                  address on the SPI bus. Should be set to 1.
> -- #size-cells:    Should be zero.
> -
> -Optional properties:
> -- spi-max-frequency: Specifies maximum SPI clock frequency,
> -                     Units - Hz. Definition as per
> -                     Documentation/devicetree/bindings/spi/spi-bus.txt
> -- num-cs:	total number of chipselects
> -- cs-gpios:	should specify GPIOs used for chipselects.
> -		The gpios will be referred to as reg = <index> in the SPI child
> -		nodes.  If unspecified, a single SPI device without a chip
> -		select can be used.
> -
> -- dmas:         Two DMA channel specifiers following the convention outlined
> -                in bindings/dma/dma.txt
> -- dma-names:    Names for the dma channels, if present. There must be at
> -                least one channel named "tx" for transmit and named "rx" for
> -                receive.
> -
> -SPI slave nodes must be children of the SPI master node and can contain
> -properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> -
> -Example:
> -
> -	spi_8: spi@f9964000 { /* BLSP2 QUP2 */
> -
> -		compatible = "qcom,spi-qup-v2";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		reg = <0xf9964000 0x1000>;
> -		interrupts = <0 102 0>;
> -		spi-max-frequency = <19200000>;
> -
> -		clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
> -		clock-names = "core", "iface";
> -
> -		dmas = <&blsp1_bam 13>, <&blsp1_bam 12>;
> -		dma-names = "rx", "tx";
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&spi8_default>;
> -
> -		device@0 {
> -			compatible = "arm,pl022-dummy";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0>; /* Chip select 0 */
> -			spi-max-frequency = <19200000>;
> -			spi-cpol;
> -		};
> -
> -		device@1 {
> -			compatible = "arm,pl022-dummy";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <1>; /* Chip select 1 */
> -			spi-max-frequency = <9600000>;
> -			spi-cpha;
> -		};
> -
> -		device@2 {
> -			compatible = "arm,pl022-dummy";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <2>; /* Chip select 2 */
> -			spi-max-frequency = <19200000>;
> -			spi-cpol;
> -			spi-cpha;
> -		};
> -
> -		device@3 {
> -			compatible = "arm,pl022-dummy";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <3>; /* Chip select 3 */
> -			spi-max-frequency = <19200000>;
> -			spi-cpol;
> -			spi-cpha;
> -			spi-cs-high;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
> new file mode 100644
> index 000000000000..aa5756f7ba85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/qcom,spi-qup.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
> +
> +maintainers:
> +  - Andy Gross <agross@kernel.org>
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  The QUP core is an AHB slave that provides a common data path (an output FIFO
> +  and an input FIFO) for serial peripheral interface (SPI) mini-core.
> +
> +  SPI in master mode supports up to 50MHz, up to four chip selects,
> +  programmable data path from 4 bits to 32 bits and numerous protocol variants.
> +
> +allOf:
> +  - $ref: /spi/spi-controller.yaml#

Same thing for reference here as we discussed on other thread.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
> +      - qcom,spi-qup-v2.1.1 # for 8974 and later
> +      - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx

Just wanted to confirm one thing, did you try with rx-tx?
As once I noticed for some other spec, that warnings were reduced when
order was reversed as most of the DTs follow rx-tx order.

We can keep order which disturb less DTs.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
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
> +    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi@7575000 {
> +        compatible = "qcom,spi-qup-v2.2.1";
> +        reg = <0x07575000 0x600>;
> +        interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
> +                 <&gcc GCC_BLSP1_AHB_CLK>;
> +        clock-names = "core",
> +                      "iface";

clock-names can be written in one line.

> +        pinctrl-names = "default", "sleep";
> +        pinctrl-0 = <&blsp1_spi1_default>;
> +        pinctrl-1 = <&blsp1_spi1_sleep>;
> +        dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
> +        dma-names = "tx", "rx";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> -- 
> 2.32.0
> 
