Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8104EBFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiC3Lre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbiC3Lrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:47:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8481D914D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:45:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j15so40913689eje.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0GsLMAkDyt+1jx3DTeQT6eRUT/0nrtKR8ZoOzMTE7Lg=;
        b=i0jN+H0RY59ZkOgp5tgYjUEXQhX8Yr5MqZGzrutYxn+qRhZtMLCQVBDc+lKW5SJ0jP
         mW3dB7UcFks/f/v+V2bWb3l+1nwRhQX0J9qY00OX/ygdu4BWldQNgEDjLmAtHkYn615q
         URoFXNjer8IFxjgx3tB6D2DEci4IpZb3PDAeD/8Wz7KjbYSM23lCuLZDNmcPIXZYKtFu
         pfIaQ8i7HAaA78g6laRzYl6BUHfDmXYaSH+xhtP8TJTevdAsMdF60M2tp5tMqGoK+X9p
         iR3oIMrkSLCsGX4A/Cirqm+a1Oydh+2jQ7HR/WzE/az4dD5G1G3Q0fR1uXFn7vRPgS9i
         iz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0GsLMAkDyt+1jx3DTeQT6eRUT/0nrtKR8ZoOzMTE7Lg=;
        b=01DGVolgYmGZ7QdTqO6rca2nSqZx5MjxUr+7Aj4UnOLQBVuPt+NrXbKFxfz2aYMpXZ
         7MPrzK2oJcLg7XepjNgVRn6hiYxsuxouF+g8x3XdmatdsGZgEKUYvJjMs8xRF9XDzsLR
         dq/GsfD9f6pHXb6eIuDhYiW4vtrSdaw5dzBjU7Aa4qHL6aIKmgaAF4qWMiqJiHeaUwtL
         6ETCi3ERL3NaI6+k3yumlxp7J5GeAbgETueOUTMk+/USdJKWD+Bp+KNPB7oK70+YAQ74
         GEQ6Tlvs9upWOSg1sS1Ec6Lcd8Hw+8z+uIvbbUkUTk88p4OQJTinYdKELIWV7n3WJ1rK
         BOug==
X-Gm-Message-State: AOAM533HaZzgPGIWMtngO+BpwEEdmPr+e9kqT6tOaHEh84w3gdiRka7r
        LJolrQ2/DxhDqkfsc0wUjAqynQ==
X-Google-Smtp-Source: ABdhPJzqMwkVBfZmjptcZU4txEkzsjTR+KKIcwdkHBemub6ugGroebYrOPwu8qUCwsM5ElcHwe6d7Q==
X-Received: by 2002:a17:907:3e99:b0:6db:6c1c:d9d9 with SMTP id hs25-20020a1709073e9900b006db6c1cd9d9mr39049124ejc.688.1648640743717;
        Wed, 30 Mar 2022 04:45:43 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090635cc00b006e055c9c91esm8028494ejb.101.2022.03.30.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 04:45:43 -0700 (PDT)
Message-ID: <4d3c1f8a-122a-eb3a-b3d3-94e89d1ba6e8@linaro.org>
Date:   Wed, 30 Mar 2022 13:45:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] spi: dt-bindings: qcom,spi-qup: convert to dtschema
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
 <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
 <20220330114247.GA51417@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330114247.GA51417@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2022 13:42, Kuldeep Singh wrote:
> On Tue, Mar 29, 2022 at 01:29:02PM +0200, Krzysztof Kozlowski wrote:
>> Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
>> Interface (SPI) bindings to DT Schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
>>  .../devicetree/bindings/spi/qcom,spi-qup.yaml |  82 ++++++++++++++
>>  2 files changed, 82 insertions(+), 103 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
>>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
>> deleted file mode 100644
>> index 5c090771c016..000000000000
>> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
>> +++ /dev/null
>> @@ -1,103 +0,0 @@
>> -Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
>> -
>> -The QUP core is an AHB slave that provides a common data path (an output FIFO
>> -and an input FIFO) for serial peripheral interface (SPI) mini-core.
>> -
>> -SPI in master mode supports up to 50MHz, up to four chip selects, programmable
>> -data path from 4 bits to 32 bits and numerous protocol variants.
>> -
>> -Required properties:
>> -- compatible:     Should contain:
>> -		  "qcom,spi-qup-v1.1.1" for 8660, 8960 and 8064.
>> -		  "qcom,spi-qup-v2.1.1" for 8974 and later
>> -		  "qcom,spi-qup-v2.2.1" for 8974 v2 and later.
>> -
>> -- reg:            Should contain base register location and length
>> -- interrupts:     Interrupt number used by this controller
>> -
>> -- clocks:         Should contain the core clock and the AHB clock.
>> -- clock-names:    Should be "core" for the core clock and "iface" for the
>> -                  AHB clock.
>> -
>> -- #address-cells: Number of cells required to define a chip select
>> -                  address on the SPI bus. Should be set to 1.
>> -- #size-cells:    Should be zero.
>> -
>> -Optional properties:
>> -- spi-max-frequency: Specifies maximum SPI clock frequency,
>> -                     Units - Hz. Definition as per
>> -                     Documentation/devicetree/bindings/spi/spi-bus.txt
>> -- num-cs:	total number of chipselects
>> -- cs-gpios:	should specify GPIOs used for chipselects.
>> -		The gpios will be referred to as reg = <index> in the SPI child
>> -		nodes.  If unspecified, a single SPI device without a chip
>> -		select can be used.
>> -
>> -- dmas:         Two DMA channel specifiers following the convention outlined
>> -                in bindings/dma/dma.txt
>> -- dma-names:    Names for the dma channels, if present. There must be at
>> -                least one channel named "tx" for transmit and named "rx" for
>> -                receive.
>> -
>> -SPI slave nodes must be children of the SPI master node and can contain
>> -properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
>> -
>> -Example:
>> -
>> -	spi_8: spi@f9964000 { /* BLSP2 QUP2 */
>> -
>> -		compatible = "qcom,spi-qup-v2";
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -		reg = <0xf9964000 0x1000>;
>> -		interrupts = <0 102 0>;
>> -		spi-max-frequency = <19200000>;
>> -
>> -		clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
>> -		clock-names = "core", "iface";
>> -
>> -		dmas = <&blsp1_bam 13>, <&blsp1_bam 12>;
>> -		dma-names = "rx", "tx";
>> -
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&spi8_default>;
>> -
>> -		device@0 {
>> -			compatible = "arm,pl022-dummy";
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -			reg = <0>; /* Chip select 0 */
>> -			spi-max-frequency = <19200000>;
>> -			spi-cpol;
>> -		};
>> -
>> -		device@1 {
>> -			compatible = "arm,pl022-dummy";
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -			reg = <1>; /* Chip select 1 */
>> -			spi-max-frequency = <9600000>;
>> -			spi-cpha;
>> -		};
>> -
>> -		device@2 {
>> -			compatible = "arm,pl022-dummy";
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -			reg = <2>; /* Chip select 2 */
>> -			spi-max-frequency = <19200000>;
>> -			spi-cpol;
>> -			spi-cpha;
>> -		};
>> -
>> -		device@3 {
>> -			compatible = "arm,pl022-dummy";
>> -			#address-cells = <1>;
>> -			#size-cells = <1>;
>> -			reg = <3>; /* Chip select 3 */
>> -			spi-max-frequency = <19200000>;
>> -			spi-cpol;
>> -			spi-cpha;
>> -			spi-cs-high;
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
>> new file mode 100644
>> index 000000000000..aa5756f7ba85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/qcom,spi-qup.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
>> +
>> +maintainers:
>> +  - Andy Gross <agross@kernel.org>
>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +description:
>> +  The QUP core is an AHB slave that provides a common data path (an output FIFO
>> +  and an input FIFO) for serial peripheral interface (SPI) mini-core.
>> +
>> +  SPI in master mode supports up to 50MHz, up to four chip selects,
>> +  programmable data path from 4 bits to 32 bits and numerous protocol variants.
>> +
>> +allOf:
>> +  - $ref: /spi/spi-controller.yaml#
> 
> Same thing for reference here as we discussed on other thread.

Yes.

> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>> +      - qcom,spi-qup-v2.1.1 # for 8974 and later
>> +      - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>> +
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: iface
>> +
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
> 
> Just wanted to confirm one thing, did you try with rx-tx?
> As once I noticed for some other spec, that warnings were reduced when
> order was reversed as most of the DTs follow rx-tx order.
> 
> We can keep order which disturb less DTs.

Yeah, I tried. The amount is more or less the same, so I went with tx-rx
as mentioned in original bindings.

> 
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    spi@7575000 {
>> +        compatible = "qcom,spi-qup-v2.2.1";
>> +        reg = <0x07575000 0x600>;
>> +        interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
>> +                 <&gcc GCC_BLSP1_AHB_CLK>;
>> +        clock-names = "core",
>> +                      "iface";
> 
> clock-names can be written in one line.

I made it on purpose to align the format with clocks.

Best regards,
Krzysztof
