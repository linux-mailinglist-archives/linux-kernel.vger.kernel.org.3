Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18854F8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382586AbiFQN6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382599AbiFQN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:58:36 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494C3701C;
        Fri, 17 Jun 2022 06:58:35 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i16so4607102ioa.6;
        Fri, 17 Jun 2022 06:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lbcreYN4VPYy/7BTtnrYijE6k2/8OFKvf2b09R9U1rM=;
        b=Upr96FBmxLEFb6NvmJk5S9is+NOJM4KdG9v5z3MvWky6p0yxlA+7ta80p+nJAn0fJK
         QyujpS/heOzQbJZJVTdkOmsuV7Gw0AFTsyQznbpI4nnjiSqLVMuzkQKU6IGlLo2Ry9hD
         CjZMG2WcaSyInE8M8Tbzya8tlnQUk7vTxymN74CMfsvBhKLU3msirDSHmlGpiZeW2dJU
         xmYEbdlp3E3iW98Vz2Fc5Ha/6YAfmSKYCW2bBAW2K1uxki4GP4zO9vuxCkQTuqY2BW5h
         zcQBGGJC+EN57wnUArAHNc/pZkiWLIwEePojX/NA8htpueEGkw7VVqsPgvPdhrmJY1nS
         6wwQ==
X-Gm-Message-State: AJIora+0gP1MBo/oLRjQB49A4RrK3r+V99JxT1yfskq0B6hr28vDQL6F
        nf+HptAodoIC2AQ0cOwImg==
X-Google-Smtp-Source: AGRyM1sZImmgKGvXl9lNZCtvIonUpMe2eH9SdATYtuai25d6h0SGbbNKAcwmJhGbh3nw4UVIq+uLiA==
X-Received: by 2002:a05:6638:160f:b0:332:6ac:ed93 with SMTP id x15-20020a056638160f00b0033206aced93mr5660462jas.222.1655474314922;
        Fri, 17 Jun 2022 06:58:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i186-20020a6bb8c3000000b0065a47e16f44sm2556059iof.22.2022.06.17.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:58:34 -0700 (PDT)
Received: (nullmailer pid 1508987 invoked by uid 1000);
        Fri, 17 Jun 2022 13:58:32 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     UNGLinuxDriver@microchip.com, Nicolas.Ferre@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Claudiu.Beznea@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
In-Reply-To: <20220617130729.12072-3-kavyasree.kotagiri@microchip.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com> <20220617130729.12072-3-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: mfd: atmel,flexcom: Add new compatible string for lan966x
Date:   Fri, 17 Jun 2022 07:58:32 -0600
Message-Id: <1655474312.871814.1508986.nullmailer@robh.at.kernel.org>
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

On Fri, 17 Jun 2022 18:37:28 +0530, Kavyasree Kotagiri wrote:
> LAN966x SoC flexcoms has two optional I/O lines. Namely, CS0 and CS1
> in flexcom SPI mode. CTS and RTS in flexcom USART mode. These pins
> can be mapped to lan966x FLEXCOM_SHARED[0-20] pins and usage depends on
> functions being configured.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v3 -> v4:
>  - Added else condition to allOf:if:then.
> 
> v2 -> v3:
>  - Add reg property of lan966x missed in v2.
> 
> v1 -> v2:
>  - Use allOf:if:then for lan966x dt properties
> 
>  .../bindings/mfd/atmel,flexcom.yaml           | 80 ++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: allOf:0:else:properties:reg: {'maxItems': 1, 'items': [{'description': 'Flexcom base regsiters map'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: allOf:0:then:properties:reg: 'oneOf' conditional failed, one must be fixed:
	[{'description': 'Flexcom base regsiters map'}, {'description': 'Flexcom shared registers map'}] is too long
	[{'description': 'Flexcom base regsiters map'}, {'description': 'Flexcom shared registers map'}] is too short
	False schema does not allow 2
	1 was expected
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml: ignoring, error in schema: allOf: 0: else: properties: reg
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-0/flexcom@f8034000: failed to match any schema with compatible: ['atmel,sama5d2-flexcom']
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-0/flexcom@f8034000/spi@400: failed to match any schema with compatible: ['atmel,at91rm9200-spi']
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-1/flexcom@e0064000: failed to match any schema with compatible: ['microchip,lan966x-flexcom']
Documentation/devicetree/bindings/mfd/atmel,flexcom.example.dtb:0:0: /example-1/flexcom@e0064000/spi@400: failed to match any schema with compatible: ['atmel,at91rm9200-spi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

