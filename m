Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6384E559FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiFXR1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiFXR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:44 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D77911A16;
        Fri, 24 Jun 2022 10:26:41 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id w10so1925409ilj.4;
        Fri, 24 Jun 2022 10:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=B5w8YwmvaMvgaa+XdQ9K9wrK3DoeF6dUpZwQeNncYzU=;
        b=5S7jZ2DwxYsqIR3F3tWMPBX8DGfNIddNGlGBHhoqeKJpFE3T6hwbSs5XOQqDDW56Cz
         03jhUSUFO39oM6HFQYCNh69dIckGooiN/NdiywpXmlH0XkBt3t8UCU1UjZUv2qlmITLb
         2RakjGSEGXWQ9CoMkXDsWmXO4XWuuIjV+m/GtbNXSAznV7+VYjIJNh70zfWTu96fmUQf
         VGjAxBvNPCGOsj2Nr4PcLi+YRqvfYSKypR/Lv2zBj4xaI+HmH3ZjAsJMdVCywVMIS7wS
         9JzQGz9zEJiS+a42yZVvYh59pmsJUMp4vaBG2p5x/MZccLIX0JXBHpj/xV4SChopvZDu
         w3fQ==
X-Gm-Message-State: AJIora90fsaort/i9rOCMZCyLofP95JBXe+zxdeByaXa5WAgDiCmLG8n
        6w3/X2ouort14KNNgJ2L2+kgHB+7tg==
X-Google-Smtp-Source: AGRyM1v4lwCvNUsULQiN1Fb/2fRNm5hCntJ8GiYUQcFu8to/stf++2gRR+lEsPmEbGiKxezIqCr1NQ==
X-Received: by 2002:a92:7c06:0:b0:2d6:605d:8164 with SMTP id x6-20020a927c06000000b002d6605d8164mr29024ilc.179.1656091600683;
        Fri, 24 Jun 2022 10:26:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c10-20020a92940a000000b002d90c9077a2sm1338850ili.57.2022.06.24.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:40 -0700 (PDT)
Received: (nullmailer pid 146340 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kent Gustavsson <kent@minoris.se>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20220623170844.2189814-5-marcus.folkesson@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com> <20220623170844.2189814-5-marcus.folkesson@gmail.com>
Subject: Re: [PATCH 05/10] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.379237.146339.nullmailer@robh.at.kernel.org>
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

On Thu, 23 Jun 2022 19:08:39 +0200, Marcus Folkesson wrote:
> The Data Ready Output Pin is either hard wired to work as high
> impedance or push-pull. Make it configurable.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml    | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml: properties:microchip,data-ready-hiz: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml: properties:microchip,data-ready-hiz: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('default', 'type' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml: properties:microchip,data-ready-hiz: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml: ignoring, error in schema: properties: microchip,data-ready-hiz
Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.example.dtb:0:0: /example-0/spi/adc@0: failed to match any schema with compatible: ['microchip,mcp3911']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

