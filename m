Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D54BA638
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiBQQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:40:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiBQQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:23 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9A2B31B4;
        Thu, 17 Feb 2022 08:40:08 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id 9so1960816ily.11;
        Thu, 17 Feb 2022 08:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FG2H7omY9RofxBYIWqf/AqADQ+9egAxBNOFJHSTjFn8=;
        b=iG8UAruKRt/C616UqTuXelswnPyQjtP0UYSrcCWKkoaB8IQg8xnDv7icJjjTLtEUAO
         9FX/gwGLupEhZ1wKheb6b1/cyucJyUw00mgTzst1P2Dpce5YoAqM9M9Sr7HQ+5qlR3Ha
         iy0nr1scdC7kmp7yH8Wk9IsurdcUfyplWV2su+geLru4GNlzKmOAd+3dpmYV2SmTfYq4
         /THCobs75i58lhJuhB3CyWP6HpbXPiKHQTZ8uvMUmIIgLtqYKaNkVOdONAGFtRgtkBAG
         gTYyCd0OzUtfniKhm6+1QROJU5KjSm6rLVA6wDOna8MrTHX2WutyMXEnSU0O0gvqYbh0
         berQ==
X-Gm-Message-State: AOAM532goEkcB4e1tEuRACz3qzJyaqJNSSTsKt+NC9E4LZMueMDfQdOh
        KtADBtEZOuUtDVUA8q/GoK+O0y3T/g==
X-Google-Smtp-Source: ABdhPJwmuv4Ou8IkxQmMGckJPm80zD2OBF0ztUKoJ0WK/FADyqFbwkpG2ZcG1QBGYVRNdpq4k6OzJw==
X-Received: by 2002:a05:6e02:692:b0:2be:a3a4:8f0 with SMTP id o18-20020a056e02069200b002bea3a408f0mr2562966ils.134.1645116008024;
        Thu, 17 Feb 2022 08:40:08 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x11sm2300132iow.8.2022.02.17.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:40:07 -0800 (PST)
Received: (nullmailer pid 3365325 invoked by uid 1000);
        Thu, 17 Feb 2022 16:39:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jic23@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220217101241.71702-1-cristian.pop@analog.com>
References: <20220217101241.71702-1-cristian.pop@analog.com>
Subject: Re: [PATCH v3 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Date:   Thu, 17 Feb 2022 10:39:55 -0600
Message-Id: <1645115995.366904.3365324.nullmailer@robh.at.kernel.org>
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

On Thu, 17 Feb 2022 12:12:40 +0200, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> changes in v3:
>  - Fix indentation
>  - Rename property 'adi,lo-freq-hz' to 'adi,lo-freq-khz'
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: properties:adi,lo-freq-khz: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: properties:adi,lo-freq-khz: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: properties:adi,lo-freq-khz: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml: ignoring, error in schema: properties: adi,lo-freq-khz
Documentation/devicetree/bindings/iio/frequency/adi,admv4420.example.dt.yaml:0:0: /example-0/spi/admv4420@0: failed to match any schema with compatible: ['adi,admv4420']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1594130

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

