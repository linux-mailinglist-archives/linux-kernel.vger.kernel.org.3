Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9744E560C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiF2WjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiF2WhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:37:05 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303091CB22;
        Wed, 29 Jun 2022 15:37:03 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id h85so17474437iof.4;
        Wed, 29 Jun 2022 15:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=MbblukbV9eQzp63XhSRYjJT2TIAxXCGnXWe6sKmekNs=;
        b=UqGhvEQqE1PrluqRf8Q1gF8LRRuScYBKgwcWBakKj/csNNI8TXXWPk/AG0zutPErG3
         uEGgyHFX+7bN+LPMoZj1WPB44GhlaoMRQLea+2oTRc2UVtzfjtAWBLFbPr9gnRgjgYy+
         HPSw/+E4f9AugpXEq2uy4q6+ceemU8Jn+VNtz50e/MQ7yowUqArBAPMdUDb566QUz2EU
         Z7WX4Jb7FJpl9Znjm9YdTdRGZHGP4jXL7N5O4z4IHsdmHQfRQiDCx/tKAjTRx/SKGAiW
         sbeQfj8kHZTsB0wapmaCxjsWgANHvDwKnBNbmIv3sFbA1/k+++dH1luvn5SkLSV/eqEy
         JTrw==
X-Gm-Message-State: AJIora9+Som/QihFe2mqvZJkESyzYlgKeuCbeOQYRqyq3rn11XUgHi60
        vYAiF0OINTivkcElrLDdAQ==
X-Google-Smtp-Source: AGRyM1vrXWjHdWf9HlFUjhNb24cmSnmvE4y5H7JjWeXZScDf9UZJmyrsPsQRRLt4UWsbRPUP4u698g==
X-Received: by 2002:a6b:4019:0:b0:669:3314:ebcb with SMTP id k25-20020a6b4019000000b006693314ebcbmr2869577ioa.197.1656542222341;
        Wed, 29 Jun 2022 15:37:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o126-20020a022284000000b00339f193b8ddsm7936816jao.130.2022.06.29.15.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 15:37:02 -0700 (PDT)
Received: (nullmailer pid 1042477 invoked by uid 1000);
        Wed, 29 Jun 2022 22:36:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        UNGLinuxDriver@microchip.com, linux-spi@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, Kavyasree.Kotagiri@microchip.com,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org
In-Reply-To: <20220629125804.137099-1-sergiu.moga@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Date:   Wed, 29 Jun 2022 16:36:59 -0600
Message-Id: <1656542219.625404.1042476.nullmailer@robh.at.kernel.org>
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

On Wed, 29 Jun 2022 15:58:04 +0300, Sergiu Moga wrote:
> Convert SPI binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../devicetree/bindings/spi/atmel,spi.yaml    | 82 +++++++++++++++++++
>  .../devicetree/bindings/spi/spi_atmel.txt     | 36 --------
>  2 files changed, 82 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/atmel,spi.example.dtb:0:0: /example-0/spi@fffcc000/mmc@0: failed to match any schema with compatible: ['mmc-spi-slot']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

