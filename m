Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6961B59C921
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiHVTkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiHVTks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:40:48 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F648CAD;
        Mon, 22 Aug 2022 12:40:46 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id o204so5958296oia.12;
        Mon, 22 Aug 2022 12:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=F7N0M14f2U+FDQpQWgJZ3u/jY5t4RVFyRkfLvEHA7mY=;
        b=B5DeLtZurSKGeHdcsiQJwqteKnPcgR+5tKLtlpJcLVF1pJeJ7Z4mxWiGrtDVr9z1+8
         +M7X2Vz1etTgea9Rbeu5UTxZndrFZR6TFyDLy+PAQio2uJ4cds2gAXUdOv0cKGIvTcxv
         puNpOQ42aAaCim6QNKyI3skO+a40q51KGheoY0nmMmG8rOqcWpZ3SBsXzMCIxDQgaPhC
         L/Vm9nBBj7KSb4ZNEb4XC6eO/IbkgoaFRCpSVQ8P7ZggQ5mb4xotJc8dDO0+962oIVuZ
         3tUOWX07Lb89ZOxRff34NmH3GQnMkEzzKjmMYK+K5W4b0vgXlEd7YR8yMZFESGnrG9Zc
         O0aQ==
X-Gm-Message-State: ACgBeo1XQSjnHrgxhVcjAX17HJx8hMZUHdMxhBVZVdvbl3qoBcBJUJL0
        dWN31+Imv2iN7n6ZVnHWDQ==
X-Google-Smtp-Source: AA6agR5XMr5FgVv8vQek4MUAACWDV/kl827jsCrHAB1xrqsqfBvLvnIBX7DvPsTcNbpI/ADfzC+dRw==
X-Received: by 2002:a05:6808:1b2a:b0:344:b633:50f8 with SMTP id bx42-20020a0568081b2a00b00344b63350f8mr12274922oib.42.1661197246089;
        Mon, 22 Aug 2022 12:40:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v134-20020acaac8c000000b00344f28a7a4csm2755758oie.22.2022.08.22.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:40:45 -0700 (PDT)
Received: (nullmailer pid 413613 invoked by uid 1000);
        Mon, 22 Aug 2022 19:40:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
In-Reply-To: <20220822125106.1106798-2-ciprian.regus@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com> <20220822125106.1106798-2-ciprian.regus@analog.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Add docs for LTC2499
Date:   Mon, 22 Aug 2022 14:40:42 -0500
Message-Id: <1661197242.564541.413612.nullmailer@robh.at.kernel.org>
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

On Mon, 22 Aug 2022 15:51:04 +0300, Ciprian Regus wrote:
> Update the bindings documentation for ltc2497 to include the ltc2499.
> 
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 6 +++++-
>  MAINTAINERS                                                 | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml: properties:compatible:enum: 'lltc,ltc2497 lltc,ltc2499' is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml: properties:compatible:enum: 'lltc,ltc2497 lltc,ltc2499' is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml: properties:compatible:enum: 'lltc,ltc2497 lltc,ltc2499' is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml: ignoring, error in schema: properties: compatible: enum
Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.example.dtb:0:0: /example-0/i2c/adc@76: failed to match any schema with compatible: ['lltc,ltc2497']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

