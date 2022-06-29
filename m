Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD055F32A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 04:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiF2CJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 22:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiF2CJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 22:09:43 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C438B27B1D;
        Tue, 28 Jun 2022 19:09:42 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id l24so14627708ion.13;
        Tue, 28 Jun 2022 19:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3ww8IIJdv7f/OVWj83PtK7d2cH+9S36RhpLx7LDKL0k=;
        b=rtAJnYongbcAVFY7m7g+oZvYQUCvd22g3O+oN+dfmDxarTCbSiUA96W42P5LCVQoX+
         qNeKMxvDsxKBY3uB9yr31xl61+U2i765YVXGofAtxk5lb1XoHGlhXcjPbQTldLf4Gqd9
         QkA8OWpd5way5fLXjhlTeeHF5cVwJ3tBfIY/OStMy8/iyUAcl519o0HLFIgLhnph+awI
         OLA4vkxma+kHEV+phFfFHCxIyn1m2dAlH2dRJ+OtGwS7AUpvHKmQfoHnpv7Cb3JlU5Dc
         86IEX1Tj5C5XNHC2BjYlfSxV5Hkn1nB99gOQCPBAJdMQ/gZZeQO1kt2IAwuNZ/hsXaYT
         2gTQ==
X-Gm-Message-State: AJIora/DimjXwk2kwxejUO0d/mwll84SF/7TC2x5mFFuNvAZ2O3q56bf
        QLdvV3XCU+eFgNxyybTsiHRWVKwWnA==
X-Google-Smtp-Source: AGRyM1uM6/M+XyyVT1BybyL1G5laT7fSjqJ92A94OIl6gk5IP9M1r72nNINaMr9MSibjz24mPvGRyQ==
X-Received: by 2002:a05:6638:2494:b0:33c:cfb8:1e3c with SMTP id x20-20020a056638249400b0033ccfb81e3cmr299603jat.139.1656468581975;
        Tue, 28 Jun 2022 19:09:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u16-20020a6b4910000000b00669384fcf88sm7377409iob.1.2022.06.28.19.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 19:09:41 -0700 (PDT)
Received: (nullmailer pid 1403669 invoked by uid 1000);
        Wed, 29 Jun 2022 02:09:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20220628144649.3957286-2-cosmin.tanislav@analog.com>
References: <20220628144649.3957286-1-cosmin.tanislav@analog.com> <20220628144649.3957286-2-cosmin.tanislav@analog.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: add AD4130
Date:   Tue, 28 Jun 2022 20:09:39 -0600
Message-Id: <1656468579.876540.1403668.nullmailer@robh.at.kernel.org>
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

On Tue, 28 Jun 2022 17:46:48 +0300, Cosmin Tanislav wrote:
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 256 ++++++++++++++++++
>  1 file changed, 256 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9a-f])$:properties:adi,excitation-current-1-nanoamp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9a-f])$:properties:adi,excitation-current-1-nanoamp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	100 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	10000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	20000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	50000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	100000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	150000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	200000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9a-f])$:properties:adi,burnout-current-nanoamp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9a-f])$:properties:adi,burnout-current-nanoamp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	500 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	4000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9a-f])$:properties:adi,excitation-current-0-nanoamp: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default', 'enum' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9a-f])$:properties:adi,excitation-current-0-nanoamp: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	100 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	10000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	20000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	50000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	100000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	150000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	200000 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: ignoring, error in schema: patternProperties: ^channel@([0-9a-f])$: properties: adi,excitation-current-1-nanoamp
Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb:0:0: /example-0/spi/adc@0: failed to match any schema with compatible: ['adi,ad4130']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

