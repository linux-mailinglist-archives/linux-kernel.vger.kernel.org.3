Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2084EBB19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiC3Gum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243405AbiC3Gub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:50:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABF18CDB1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:48:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bi12so39572603ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3frxpVZce2nBNt3706nuqBBrB6UAiD1if/n7un9zI7M=;
        b=IOIoLxtEStyNGXLaiPfpEGSgWEir/G/yMzS+kf3oMtYR5oGZW5yVwfvF5XMcm1JKqT
         VJrCXVD/iAAL6ZhFZJAHX2nq3npHPXucf760QqLSc2kQenm8tlTXihEtrIGarg43AL/g
         0NEt/rdRPA5ywhHixqgEbmT4jokRdzjiR52LatBKrqQnptQekajqPIDv15Jj9zlO2MwG
         +Q0hNFP8na+2lKnctrMnfyKDy25DWKV8M/l6lJ7Vb1IPSNTyR9fY7TLcskxYG19xnRhv
         64Y2DiC6PpSoeXL/YYcmRxFec204JgOki162qzMJuHQzCxpqf9HS2tzOkXr59Nf2aM7l
         3+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3frxpVZce2nBNt3706nuqBBrB6UAiD1if/n7un9zI7M=;
        b=dN6KD5ijWr0sVZOT4xjBLjwl1no2bG5TjkZFTdgszpJRH0WdsONEUfhNS+n9uxPp2N
         aOZgdzpgoWoGLNWEHg9tuh8uC0+xOEunG2ZRxmmhyTNIOQeTQ/eWsqwfjd5x1c0qafUg
         ErUN3VhM5/Md7LaIYmKbiiS1mq+vvpblPqmsSr6XUwb3N2t/PNTwnbRRqn4roN78r7n+
         6rD4uNegyc5J4CxagF66Xb3/Md4H7Giz31xu83HaixrrbMjShydXZDXFQ9tAa7bk6yDZ
         64ut7DdXSXPjwr1TlGWgVxYUVTGOesalLlxFBQeICUzfYPT1C/bSec9DEkW3W+v/Ciq0
         o4tQ==
X-Gm-Message-State: AOAM530M9DSqgy29BvnrZfyGQj11WsF+rgoZbEG52CnP7cqmjiLMjJvs
        K8wVCIk1Z1n1nXl7Ac9CZMLoIw==
X-Google-Smtp-Source: ABdhPJye35/TV3C3GPqx2/usMTOpf2+2acjTfiN817foc/PVZIxXA5JCiKGDLF4JGGBqeDlJa/ZG/w==
X-Received: by 2002:a17:907:1b27:b0:6d9:ceb6:7967 with SMTP id mp39-20020a1709071b2700b006d9ceb67967mr40017117ejc.186.1648622919623;
        Tue, 29 Mar 2022 23:48:39 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7cf05000000b0041919e52a38sm9248731edy.46.2022.03.29.23.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:48:39 -0700 (PDT)
Message-ID: <ac686e08-008f-be08-db5e-b6d4d08df315@linaro.org>
Date:   Wed, 30 Mar 2022 08:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
 <20220330062313.GA51331@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220330062313.GA51331@9a2d8922b8f1>
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

On 30/03/2022 08:23, Kuldeep Singh wrote:
> On Tue, Mar 29, 2022 at 01:27:16PM +0200, Krzysztof Kozlowski wrote:
>> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
>> Peripheral Interface (SPI) bindings to DT Schema.
>>
>> The original bindings in TXT were not complete, so add during conversion
>> properties already used in DTS and/or in the driver: reg-names, dmas,
>> interconnects, operating points and power-domains.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
>>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 131 ++++++++++++++++++
>>  2 files changed, 131 insertions(+), 39 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
>>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
>> deleted file mode 100644
>> index c8c1e913f4e7..000000000000
>> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
>> +++ /dev/null
>> @@ -1,39 +0,0 @@
>> -GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
>> -
>> -The QUP v3 core is a GENI based AHB slave that provides a common data path
>> -(an output FIFO and an input FIFO) for serial peripheral interface (SPI)
>> -mini-core.
>> -
>> -SPI in master mode supports up to 50MHz, up to four chip selects, programmable
>> -data path from 4 bits to 32 bits and numerous protocol variants.
>> -
>> -Required properties:
>> -- compatible:		Must contain "qcom,geni-spi".
>> -- reg:			Must contain SPI register location and length.
>> -- interrupts:		Must contain SPI controller interrupts.
>> -- clock-names:		Must contain "se".
>> -- clocks:		Serial engine core clock needed by the device.
>> -- #address-cells:	Must be <1> to define a chip select address on
>> -			the SPI bus.
>> -- #size-cells:		Must be <0>.
>> -
>> -SPI Controller nodes must be child of GENI based Qualcomm Universal
>> -Peripharal. Please refer GENI based QUP wrapper controller node bindings
>> -described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
>> -
>> -SPI slave nodes must be children of the SPI master node and conform to SPI bus
>> -binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
>> -
>> -Example:
>> -	spi0: spi@a84000 {
>> -		compatible = "qcom,geni-spi";
>> -		reg = <0xa84000 0x4000>;
>> -		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>> -		clock-names = "se";
>> -		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
>> -		pinctrl-names = "default", "sleep";
>> -		pinctrl-0 = <&qup_1_spi_2_active>;
>> -		pinctrl-1 = <&qup_1_spi_2_sleep>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
>> new file mode 100644
>> index 000000000000..a85ff02ba1db
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
>> @@ -0,0 +1,131 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/qcom,spi-geni-qcom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
>> +
>> +maintainers:
>> +  - Andy Gross <agross@kernel.org>
>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +description:
>> +  The QUP v3 core is a GENI based AHB slave that provides a common data path
>> +  (an output FIFO and an input FIFO) for serial peripheral interface (SPI)
>> +  mini-core.
>> +
>> +  SPI in master mode supports up to 50MHz, up to four chip selects,
>> +  programmable data path from 4 bits to 32 bits and numerous protocol variants.
>> +
>> +  SPI Controller nodes must be child of GENI based Qualcomm Universal
>> +  Peripharal. Please refer GENI based QUP wrapper controller node bindings
>> +  described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
>> +
>> +allOf:
>> +  - $ref: /spi/spi-controller.yaml#
> 
> Rob sometime back sent an update on how to refer absolute paths.
> Please see below:
> https://lore.kernel.org/linux-spi/20220325215652.525383-1-robh@kernel.org/

Yes, this is wrong. I copied other existing schema without checking. :(

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,geni-spi
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: se
>> +
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  interconnects:
>> +    minItems: 2
> 
> We can skip minItems here.
> As minimim value defaults to maximum if not defined.

True.

> 
>> +    maxItems: 2
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: qup-core
>> +      - const: qup-config
> 
> Some properties like clocks, dmas, dma-names, interconnect etc. are
> defined as common child properties of geni based qup.
> Please see Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> 
> Shouldn't we skip these entities here? as spi reference will anyway be
> used in geni-se.yaml.

We could have them there, just like we could store all of this schema
there. Having something half-here-half-there will not work, because this
schema won't validate.

Therefore all of child properties from qcom,geni-se.yaml should be
rather moved to child schema (which is included directly in my patch #2).


Best regards,
Krzysztof
