Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672674FF6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiDMM2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiDMM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:28:31 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835651E4E;
        Wed, 13 Apr 2022 05:26:10 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id v19-20020a056820101300b0032488bb70f5so314708oor.5;
        Wed, 13 Apr 2022 05:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=S0aRwqpDS6rngBma2Gi2fYH+8a0XLfJUHOogpLlyjvo=;
        b=WPhDIfyP9Y4CXIhZi4w4xrd09ygGj4PJBZUCAMkuzibI7un6T2XKKt5GLEHsHAB9Kv
         ngn/bT1KgJemi74HbjWhelw/ZDO58+3N4SAKR9bfLp5N6Xia+KcyfsiRhkOrFrfS3Ys6
         ickxABNBkLMPlHBIiJInKEreG1x83K6PFK7xWXhgU2e3HXZkvKmt9NO0I9VOolokPSlr
         gDepAATlH5VJEzakrjQoOhrx/TcBjWqsJ0gp7eood2Ya9/svK0UcnMIgubUu8e8Mjpfn
         dk5fcGTgKKcIH/0eP7uLw/x26PEHLhJqdUIGx413bUHVP7wzisOin0FZAliiKwvQ23Ux
         0oyg==
X-Gm-Message-State: AOAM530wT9pSDcd2BNbm91ixwvnGO1G9PyQNSDvUo4fxcEHMWR/yt348
        iYJnTtI8Q2dEw8v9VoBuOQ==
X-Google-Smtp-Source: ABdhPJwjTGH/YI3AnbUmwp0jGCq97XHBV6V+VIGoHJBjqXE2giohj0FVKXscDDlXZZA+hK5t+vWQqQ==
X-Received: by 2002:a4a:de16:0:b0:321:3be1:803e with SMTP id y22-20020a4ade16000000b003213be1803emr13102003oot.71.1649852769255;
        Wed, 13 Apr 2022 05:26:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r6-20020a0568301ac600b005cdbc6e62a9sm14257731otc.39.2022.04.13.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:26:08 -0700 (PDT)
Received: (nullmailer pid 2930031 invoked by uid 1000);
        Wed, 13 Apr 2022 12:26:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20220413094011.185269-1-cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: add AD4130
Date:   Wed, 13 Apr 2022 07:26:08 -0500
Message-Id: <1649852768.314703.2930030.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:40:09 +0300, Cosmin Tanislav wrote:
> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
> 
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4130.yaml          | 255 ++++++++++++++++++
>  1 file changed, 255 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9]|1[0-5])$:properties:adi,excitation-pin-0: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('minimum', 'maximum', 'default' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9]|1[0-5])$:properties:adi,excitation-pin-0: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: patternProperties:^channel@([0-9]|1[0-5])$:properties:adi,excitation-pin-0: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:interrupts: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,int-ref-en: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,int-ref-en: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('type', 'default' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,int-ref-en: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,vbias-pins: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('items' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,vbias-pins: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,vbias-pins: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,bipolar: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('default' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,bipolar: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('type', 'default' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: properties:adi,bipolar: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml: ignoring, error in schema: patternProperties: ^channel@([0-9]|1[0-5])$: properties: adi,excitation-pin-0
Error: Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dts:35.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/iio/adc/adi,ad4130.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

