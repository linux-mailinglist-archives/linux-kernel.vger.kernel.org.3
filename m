Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C254CF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349723AbiFORUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbiFORUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:20:08 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67FD23172;
        Wed, 15 Jun 2022 10:20:06 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id r5so13394909iod.5;
        Wed, 15 Jun 2022 10:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sTGa151t/trhczGlfaIhFF1i0SVtoSLocgRhlGdaZgA=;
        b=BLAycBVIcpla2nICRxF5jHexDyuYvqsu2vCm4j8Zh8FASQd6KmTM8OGWVJUiY+P5GA
         c9bigCxuyJGMidGwDExTb6FRccOwXr7LWlf2GuJQnJTsM+LGzX+RWwatzdNgo6ZwmZ60
         DovxVq3fUOeg8kM7bYqAS4PhkpRek09rCcfJ2dcppw//gB7b4Dgw0Q1QPikPcv9Al5nx
         qd0gMBZr6bTFUJwvhssik1tDn/PyFlhaxqRB9hVezgblRaVpf2yyRsL6meVZfk7Gsx68
         CbEF+ifN2pvAkynOe+2Uvmi1SUQsyHGbvkPNuYWaaLgQ8wXJcDJ6FkeczioUChxD0iiD
         zmUQ==
X-Gm-Message-State: AJIora/wW+KypZmun2XIT45B9q9UzWqkzR/6b/HqZ10XsaXJvrA5TsSX
        jTQjwkjO1edV5uuMOha+SQ==
X-Google-Smtp-Source: AGRyM1sTi5PIIcsQSq4HRK5RYwDCF35wSPHxr52ZB9lddA1mfsnKOMGnhVqSy2h9XTYEz+EVUAfR+Q==
X-Received: by 2002:a05:6638:1409:b0:332:221d:1136 with SMTP id k9-20020a056638140900b00332221d1136mr439272jad.3.1655313606060;
        Wed, 15 Jun 2022 10:20:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b127-20020a021985000000b0032e7456da06sm6465171jab.15.2022.06.15.10.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:20:05 -0700 (PDT)
Received: (nullmailer pid 1478916 invoked by uid 1000);
        Wed, 15 Jun 2022 17:20:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     kernel@collabora.com, krisman@collabora.com,
        Zhigang.Shi@liteon.com, jic23@kernel.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, digetx@gmail.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        alvaro.soliverez@collabora.com
In-Reply-To: <20220615135130.227236-2-shreeya.patel@collabora.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com> <20220615135130.227236-2-shreeya.patel@collabora.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: Document ltrf216a light sensor bindings
Date:   Wed, 15 Jun 2022 11:20:03 -0600
Message-Id: <1655313603.936120.1478915.nullmailer@robh.at.kernel.org>
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

On Wed, 15 Jun 2022 19:21:29 +0530, Shreeya Patel wrote:
> Add devicetree bindings for ltrf216a ambient light sensor.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v5
>   - Remove deprecated string 'ltr' from the bindings.
> 
> Changes in v3
>   - Fix indentation in the example section
> 
> Changes in v2
>   - Take over the maintainership for the bindings
>   - Add interrupt and power supply property in DT bindings
> 
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml: properties:compatible:const: ['liteon,ltrf216a'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml: ignoring, error in schema: properties: compatible: const
Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.example.dtb:0:0: /example-0/i2c/light-sensor@53: failed to match any schema with compatible: ['liteon,ltrf216a']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

