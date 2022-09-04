Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD045AC559
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiIDQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIDQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0A33419;
        Sun,  4 Sep 2022 09:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F03B60FBD;
        Sun,  4 Sep 2022 16:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0181C433D6;
        Sun,  4 Sep 2022 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308246;
        bh=qNaHz5JBYke/CVfWVhBgjj6fWzJwmnx0pYh93wiiZ/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V+Whq1+ARgA/tq/LnDfiiKpU1VmZDHX/+7OX8jt2QGS7i9/QXaFuNjD5pCfbvwCIu
         7yrjLgQhShOtNhiSQsLX9qwho6tSb1zJZFbd+EynPcEEtcEjAoJR4UiExla1RGTxGr
         0ddGKVaPrkL+HXf2lCx6U6IpI6/Kjq2A5LWGx6pM5890myj1Y6vkVLvU4oP/G9ei51
         5DFJe+ZZpbafzasH6magsev3KgEFTYWlKzWCGw79T6GJg9Eo+Z+qZy8X3HE965ZuRJ
         oQ9+2MxEb3bZNv+d61HZZENOo1XBgA+xlZuec47t6bMq++w09l6Yp5skT9N6jv7F1u
         Frl12bZ30sgTA==
Date:   Sun, 4 Sep 2022 16:43:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] bindings: iio: adc: Add max11205 documentation
 file
Message-ID: <20220904164318.50280599@jic23-huawei>
In-Reply-To: <20220831133021.215625-1-ramona.bolboaca@analog.com>
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 16:30:20 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add bindings documentation file and MAINTAINERS entry for MAX11205.

Binding patch titles tend to be
dt-bindings: iio:

etc.
I'll fix whilst applying.

> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
> changes in v2:
>  - reference /schemas/spi/spi-peripheral-props.yaml in allOf 
>  - use unevaluatedProperties:false and remove additionalProperties:false
>  - use generic node name and fix indentation in device-tree example
>  - wrap lines nearer to 75-80 chars in documentation
>  - add extra information to the description of the regulator
>  .../bindings/iio/adc/maxim,max11205.yaml      | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> new file mode 100644
> index 000000000000..7902f82da927
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max11205.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX11205 ADC
> +
> +maintainers:
> +  - Ramona Bolboaca <ramona.bolboaca@analog.com>
> +
> +description: |
> +  The MAX11205 is an ultra-low-power (< 300FA max active current),
> +  high-resolution, serial-output ADC.
> +
> +  https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max11205a
> +      - maxim,max11205b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 5000000
> +
> +  spi-cpha: true
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for the ADC reference voltage. This is a differential
> +      reference. It is equal to the V_REFP - V_REFN. The maximum value is 3.6V.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpha
> +  - interrupts
> +  - vref-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@0 {
> +            compatible = "maxim,max11205a";
> +            reg = <0>;
> +            spi-max-frequency = <5000000>;
> +            spi-cpha;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
> +            vref-supply = <&max11205_vref>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96f47a7865d6..db1b5dc03988 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12341,6 +12341,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
>  F:	drivers/iio/proximity/mb1232.c
>  
> +MAXIM MAX11205 DRIVER
> +M:	Ramona Bolboaca <ramona.bolboaca@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> +F:	drivers/iio/adc/max11205.c
> +
>  MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
>  R:	Iskren Chernev <iskren.chernev@gmail.com>
>  R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

