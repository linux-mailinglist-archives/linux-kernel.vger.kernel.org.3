Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72340568976
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiGFN3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiGFN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:29:10 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD1A22BE2;
        Wed,  6 Jul 2022 06:29:07 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id h5so9170019ili.3;
        Wed, 06 Jul 2022 06:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bL71fy7BLG4i0HSqgZRBo3aR1jRlA0eAtGzp+APcptI=;
        b=y9bkXaWy1jzrEnjmY+jHTnni2nrJNudGT8uQYkoApzxv0E2DtmfVAbn3I2Qm6nhgFk
         Z8MsymzKR3pIg+sU7ojRT74lak0Khs9ZSWrm85E0yZMZYVR+5xHRAl/UGcZgqPJn9Ria
         893Xrhf4fxxsDK/GWrL8fQX5UW/hJsFqsgp6/ZK9XJHYnfK1NmKi3EYcc3NxEmPiRKz1
         yS+gBC/Ym3JSwHp9sV0mJF/2GI2bxcs59z0cXrpk351/M8Ev/utSF0r1FBMWD38WvZxM
         V0eif+dFFi2bqAqDmrVMVEi2ghXuJnbtd8ZdJO9F+zhkmv9FQfdpmRu1bCVoPtlmwToW
         ABxA==
X-Gm-Message-State: AJIora/Gp7P6wdttzoyf6ktO6UicaBs99DZnvBNvIkl65D/r0twMG/Vg
        4Ed0eZQ7BPKK2zXnGTIBnA==
X-Google-Smtp-Source: AGRyM1tJGJIVlx7VpB8IkYCckD9b2GDYj12b9uIMBx8AyD4cJrWgClMUDYkNKE6zsrsxzt8Q5IB69w==
X-Received: by 2002:a05:6e02:1848:b0:2da:af35:e7c3 with SMTP id b8-20020a056e02184800b002daaf35e7c3mr23641658ilv.265.1657114146897;
        Wed, 06 Jul 2022 06:29:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z10-20020a92650a000000b002dc100ab6fdsm3675172ilb.35.2022.07.06.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:29:06 -0700 (PDT)
Received: (nullmailer pid 4099934 invoked by uid 1000);
        Wed, 06 Jul 2022 13:29:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     john@metanate.com, heiko@sntech.de, p.zabel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, didi.debian@cknow.org,
        herbert@gondor.apana.org.au, sboyd@kernel.org,
        mturquette@baylibre.com, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220706090412.806101-26-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com> <20220706090412.806101-26-clabbe@baylibre.com>
Subject: Re: [PATCH v8 25/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Wed, 06 Jul 2022 07:29:04 -0600
Message-Id: <1657114144.957232.4099933.nullmailer@robh.at.kernel.org>
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

On Wed, 06 Jul 2022 09:04:04 +0000, Corentin Labbe wrote:
> The latest addition to the rockchip crypto driver need to update the
> driver bindings.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
>  1 file changed, 77 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:0:then:properties:clock-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too long
	[{'const': 'aclk'}, {'const': 'hclk'}, {'const': 'sclk'}, {'const': 'apb_pclk'}] is too short
	False schema does not allow 4
	1 was expected
	4 is greater than the maximum of 2
	4 is greater than the maximum of 3
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:0:then:properties:reset-names: {'items': [{'const': 'crypto-rst'}], 'maxItems': 1} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:1:then:properties:clock-names: {'items': [{'const': 'hclk_master'}, {'const': 'hclk_slave'}, {'const': 'sclk'}], 'maxItems': 3} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:1:then:properties:reset-names: {'items': [{'const': 'crypto-rst'}], 'maxItems': 1} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:2:then:properties:clock-names: {'items': [{'const': 'hclk_master'}, {'const': 'hclk_slave'}, {'const': 'sclk'}], 'maxItems': 3} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: allOf:2:then:properties:reset-names: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'rst_master'}, {'const': 'rst_slave'}, {'const': 'crypto-rst'}] is too long
	[{'const': 'rst_master'}, {'const': 'rst_slave'}, {'const': 'crypto-rst'}] is too short
	False schema does not allow 3
	1 was expected
	3 is greater than the maximum of 2
	hint: "minItems" is only needed if less than the "items" list length
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml: ignoring, error in schema: allOf: 0: then: properties: reset-names
Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.example.dtb:0:0: /example-0/crypto@ff8a0000: failed to match any schema with compatible: ['rockchip,rk3288-crypto']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

