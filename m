Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D7552345D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbiEKNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiEKNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:37:00 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1219663FB;
        Wed, 11 May 2022 06:36:57 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-e656032735so2891523fac.0;
        Wed, 11 May 2022 06:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BESNWVMVzlpAR343foZqZ3D2dxIXgbt3nrEPEet5hPU=;
        b=FnJ2dSrNizbwhV3xWRDuX8PXBOvkXMrcHh16XM5dBv1Y5lK4s+dn+RXP+LssiXUHSQ
         IKBAhi8zcLMeMRViLLrJS+W69mZlrilS69EBR3RIf/2/PzMhJQxUJnRKuE0E7feQLXcT
         gYw5CSdVFl+Ekf7E51LiNuEuD7ZzRZkFW058EFj+eu0+Bb/QQQTXDks0BZ42CGUufNPt
         nxdv+4JQfSqZm9h0OvWR9E2bbFxRP6W3Q4FsNq1FoUSZcdJs7Ds6JfVgBOdkYfYzLUW8
         Yitz6cciDat0YSRDRlhrHUDvuWjSvnMRVYCyCWNv32ngRccL9892950VnosJ5Wubv1LF
         LToQ==
X-Gm-Message-State: AOAM531zmTXPsew9N7HVXxj5kGkvXvK1OiClZsPSIzU1i8x2V92KpQBR
        k0YSZ562E5x1vzvjvajrTssUi15vbA==
X-Google-Smtp-Source: ABdhPJypjFI4l+Lms9fP4E6yGMirxQU8rgih54mxtA/iH+7Km5JEKremvPW8Rkvj9kndQb/uXX7XQQ==
X-Received: by 2002:a05:6870:8985:b0:da:b3f:3253 with SMTP id f5-20020a056870898500b000da0b3f3253mr2684208oaq.259.1652276217077;
        Wed, 11 May 2022 06:36:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t142-20020acaaa94000000b0032647f4e437sm734905oie.45.2022.05.11.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:36:56 -0700 (PDT)
Received: (nullmailer pid 182487 invoked by uid 1000);
        Wed, 11 May 2022 13:36:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-gpio@vger.kernel.org
In-Reply-To: <20220511013737.1194344-1-chris.packham@alliedtelesis.co.nz>
References: <20220511013737.1194344-1-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v2] dt-bindings: gpio: gpio-mvebu: convert txt binding to YAML
Date:   Wed, 11 May 2022 08:36:55 -0500
Message-Id: <1652276215.699297.182486.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 13:37:37 +1200, Chris Packham wrote:
> Convert the existing device tree binding to YAML format.
> 
> The old binding listed the interrupt-controller and related properties
> as required but there are sufficiently many existing usages without it
> that the YAML binding does not make the interrupt properties required.
> 
> The offset and marvell,pwm-offset properties weren't in the old binding
> and are added to the YAML binding. The offset property is required when
> the marvell,armada-8k-gpio compatible is used.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Notes:
>     Changes in v2:
>     - Collect review from Andrew
>     - Remove unnecessary/obvious property descriptions
>     - Clarify reg property requirements for armadaxp vs the rest. Enforce
>       these with a variant specific constraint.
>     - Update compatible property requirements. marvell,orion-gpio and
>       marvell,armada-8k-gpio can be used on their own. Everything else needs
>       marvell,orion-gpio as a fallback.
>     - Correct example to include marvell,orion-gpio fallback
> 
>  .../devicetree/bindings/gpio/gpio-mvebu.txt   |  93 -----------
>  .../devicetree/bindings/gpio/gpio-mvebu.yaml  | 151 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 152 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt: Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt: Documentation/devicetree/bindings/gpio/gpio-mvebu.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

