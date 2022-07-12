Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AAF5720DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiGLQc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiGLQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:32:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7CCB47C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:32:25 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a9so14828000lfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bGU0yXesemRThSvHGP4URgc+lQcVUG1tVloK/aCPF+s=;
        b=LdcYHBSVEo9pFeFsLsb9svxhl3ksXrKn+bSRtdCJl93S3DP0k0R8a0GFyUqvmz5AGT
         uqG+zDUzzlNas8knMHcjbFRnOaV6boVSZlpgcaJln37yQDV6KM8iDejLaQ4OaiTRCy+g
         mz3Ck76y1aNFzPlFFAqNQNP+RdudRMK5noFDSC93yPsckPhCD/+PEJvwahdxSOn9N6pn
         CtKYt3u6x7gbkw6+mwHGkUrqPOQNRD/N+FwL62oMLQ3sAuh1JkGudJWWY11wzyvntHSP
         F18sz9j3dRL0rY90cfHXt5n0wqQE2qxKi8MbEdsY2lyglIObO1B65sn0f1OlOxVqDa5K
         UC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bGU0yXesemRThSvHGP4URgc+lQcVUG1tVloK/aCPF+s=;
        b=cngfxBOOGhAgWRbI6pEYw3mSS+n+75twB7IqiGISaWBLyYEHrrIeZILNGmkj/NC/y6
         wTz7W9lhmx2I6omrUcM84UcZGfQfPZkrPUpHzbWhkiRoWaEjBDOSz2Uh3lS8SpOQIkFF
         2gPK8SgXhSFuxEKbkyK28LcHQhcrq9uLCRzv8TKcwTFAUhQ6XkkEf7lLJ627X29Z4Qxv
         9DkL6jexB4luO/9ADkIV0LWweIBI7Cwi18T02Z9er7/RofgxKt2aLYzXFzqE0VO6aj+P
         kRr4udyFEJ/LDd8oDpUyBoIN5Nu+I2sPS9T1Kw8Gf54xXSBfvKGUJpjeydpndzICROMO
         9+Yg==
X-Gm-Message-State: AJIora+ZZ3EXxxz+mYwfm/LzBD47DRFc53wY9fOj8F4yMtv2V5eZiYfT
        lzSBDEB9924uVFcl6qf8j5Pzzg==
X-Google-Smtp-Source: AGRyM1tRmrglXSwIf2mjhymrTfdr0BxGH2TkYY7cXGNmj1tK75CzEIgDKoisOCiHoVLqaoQr58IZdg==
X-Received: by 2002:a05:6512:2254:b0:489:d168:20cf with SMTP id i20-20020a056512225400b00489d16820cfmr9867374lfu.97.1657643543577;
        Tue, 12 Jul 2022 09:32:23 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id p21-20020a056512235500b0047255d210easm2273054lfu.25.2022.07.12.09.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:32:22 -0700 (PDT)
Message-ID: <dc26dd92-c107-bb8d-b40d-71b3568c52e5@linaro.org>
Date:   Tue, 12 Jul 2022 18:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to
 json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com,
        tudor.ambarus@microchip.com
References: <20220712162554.148741-1-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712162554.148741-1-sergiu.moga@microchip.com>
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

On 12/07/2022 18:25, Sergiu Moga wrote:
> Convert SPI DT binding for Atmel/Microchip SoCs to json-schema.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> v1 -> v2:
> - change subject headline prefix from "dt-bindings: spi" to "spi: atmel"
> - change maintainer
> - kept the compatbile as items (instead of switching to enums) and at91rm9200
> as fallback for sam9x60, since the evolution of IP's is incremental.
> - removed unnecessay "cs-gpios" property and descriptions
> - added min/max for fifo-size property.
> 
> 
> v2 -> v3:
> - change subject headline prefix from "spi: atmel" to
> "spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema"
> - use enum instead of a range for "atmel,fifo-size"
> 
> 
>  .../bindings/spi/atmel,at91rm9200-spi.yaml    | 76 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi_atmel.txt     | 36 ---------
>  2 files changed, 76 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> new file mode 100644
> index 000000000000..084897cc8f66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/atmel,spi.yaml#

You need to test the bindings.


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SPI device
> +
> +maintainers:
> +  - Tudor Ambarus <tudor.ambarus@microchip.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

I missed that part - this is one item, so no "items".

Best regards,
Krzysztof
