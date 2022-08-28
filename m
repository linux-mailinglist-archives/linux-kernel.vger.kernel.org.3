Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4035A3ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiH1RW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiH1RWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:22:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69AB2FFCE;
        Sun, 28 Aug 2022 10:22:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FC14B80B08;
        Sun, 28 Aug 2022 17:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55473C433D6;
        Sun, 28 Aug 2022 17:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661707370;
        bh=X/bJ8/YnfvOS3pILlnvcfejXdvbO54HabKlizeNiJn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZaJ0C0XqgcCZS4e2cl0mEGa3Zek2R2V4LDwh/hZ5qciexVXV0/Vhr6wns4SmZlxI4
         zvflcSL6W9SpNwDNi2L/WTNk/PGRKnqrSCQ2BmrhyGDaNu1mejwKUGR7Yu1WUXt+GB
         FFB2JBDafWTGLaZqclwORULDcQ1vQuMP4l4JcLNAd8tk4d3qLHpuRJbFLf26Gfg77Y
         oZPSzlVOjV8yHdmFZ9MGyEeGObvGId65185Kh7zOUA05lOWMFAeVaP/8117kUiPcH6
         z90Ut/JPdjLZ7GhIA6BQola+0lg4Q4dXUBEjdW9JTa5geeCJ80dJ139poiz2ffqQD/
         4IME/8eYlnktA==
Date:   Sun, 28 Aug 2022 17:48:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] bindings: iio: adc: Add max11205 documentation file
Message-ID: <20220828174829.68f37d25@jic23-huawei>
In-Reply-To: <20220824125203.685287-2-ramona.bolboaca@analog.com>
References: <20220824125203.685287-1-ramona.bolboaca@analog.com>
        <20220824125203.685287-2-ramona.bolboaca@analog.com>
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

On Wed, 24 Aug 2022 15:52:02 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add bindings documentation file and MAINTAINERS entry for MAX11205.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
Hi Ramona,

Welcome to IIO. 

A few comments inline to add to what Krzysztof sent.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/maxim,max11205.yaml      | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  8 +++
>  2 files changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> new file mode 100644
> index 000000000000..bddd18a44969
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
> @@ -0,0 +1,65 @@
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
> +  The MAX11205 is an ultra-low-power (< 300FA max
> +  active current), high-resolution, serial-output ADC.

Wrap lines nearer to 75-80 chars.

> +
> +  https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
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
> +      The regulator supply for the ADC reference voltage.

Might be worth mentioning it's a differential reference. I'm not 100% sure
how we handle those...  I guess as a regulator, but it's a little unusual.

Jonathan

> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency
> +  - spi-cpha
> +  - interrupts
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        max11205@0 {
> +                      compatible = "maxim,max11205a";
> +                      reg = <0>;
> +                      spi-max-frequency = <5000000>;
> +                      spi-cpha;
> +                      interrupt-parent = <&gpio>;
> +                      interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
> +                      vref-supply = <&max11205_vref>;
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

