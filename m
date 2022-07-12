Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203D5572952
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiGLW3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiGLW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:29:40 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905CBB7C5;
        Tue, 12 Jul 2022 15:29:38 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id a12so5702141ilp.13;
        Tue, 12 Jul 2022 15:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=U+O3UQuvrvrntFqlfRAKrW204ra9jF/x0VyVbWf6pwM=;
        b=yAimlVxHZaeqM/dbODsnvK2a6RH3oEYVyu+ZwQqNUPn0FMz9WLvX1vhV5ODgUlSA8A
         uyJdX5MXlk8E+m1TlOLjoqBJzFwR0htJ3CtW4tD2uFOLr52NIc1fhCupMQbGk7X0zU9v
         R5gZPQnrswl0NhzlqxaoilKrNnJwGP0Vp76il+0p9tN4WbprSC86i+I1wpT8vxsx17W9
         jEGKUCq1Iub0s3L8/eKv15IXG1gqhUqSVf9UP9JakQM3epMRgNz6/3Ktc91TSaC9D4xZ
         sH90Rzq11/Fzn8mS5AE85Hh1UefDJpmeMxP7JRxCyeUKC0q+q9tn+rFCupKeuFFOWT95
         8+8Q==
X-Gm-Message-State: AJIora8UtsyYX8SBv/kL0urzikwVvaw72EkjmCLru3CSySmWkxquniM/
        dr3wncNXguv6V3ZE1Hcgzw==
X-Google-Smtp-Source: AGRyM1vzqJULwIdhRWBsK+4KRBHFMl1w3TlwQ3/TXmQ1gQ8Clp03fp2vjiMRSHmdvjYLtdm5y+Gj/w==
X-Received: by 2002:a05:6e02:1291:b0:2dc:2936:8da0 with SMTP id y17-20020a056e02129100b002dc29368da0mr223462ilq.283.1657664978022;
        Tue, 12 Jul 2022 15:29:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m15-20020a924b0f000000b002dc7bfe144dsm2767995ilg.84.2022.07.12.15.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 15:29:37 -0700 (PDT)
Received: (nullmailer pid 2476653 invoked by uid 1000);
        Tue, 12 Jul 2022 22:29:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, tudor.ambarus@microchip.com,
        devicetree@vger.kernel.org, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        UNGLinuxDriver@microchip.com, Kavyasree.Kotagiri@microchip.com,
        alexandre.belloni@bootlin.com, broonie@kernel.org
In-Reply-To: <20220712162554.148741-1-sergiu.moga@microchip.com>
References: <20220712162554.148741-1-sergiu.moga@microchip.com>
Subject: Re: [PATCH v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to json-schema
Date:   Tue, 12 Jul 2022 16:29:35 -0600
Message-Id: <1657664975.846030.2476652.nullmailer@robh.at.kernel.org>
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

On Tue, 12 Jul 2022 19:25:55 +0300, Sergiu Moga wrote:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml: properties:enum: [16, 32] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
./Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/spi/atmel,at91rm9200-spi.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml: ignoring, error in schema: properties: enum
Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.example.dtb:0:0: /example-0/spi@fffcc000: failed to match any schema with compatible: ['atmel,at91rm9200-spi']
Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.example.dtb:0:0: /example-0/spi@fffcc000/mmc@0: failed to match any schema with compatible: ['mmc-spi-slot']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

