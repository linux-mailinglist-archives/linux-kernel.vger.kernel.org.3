Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959C04C6162
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiB1CpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiB1CpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:45:13 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129C1CB3C;
        Sun, 27 Feb 2022 18:44:36 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso9221674ooi.3;
        Sun, 27 Feb 2022 18:44:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=VfrPv61tJMs17cwzq3IdLBicVTrNBBvHW2vQ3RosnQ8=;
        b=mGdwEPzgg67xmz0CrHfmk2dUDLgKRooqVszg4d5zcgGLA+aH5c85jIkITiEsX+2/JD
         iNk0RMRywoaHs98At54Q9DBOe4aiXx4rCjLCdyPrDsgr5t9y5zVkZKu2Z4lx6gqIRR5L
         T9hex9c2B7u3pntWZ+AjvO13fOGGg2mWeDiyYc54Plv4EnaP1ydza7glYwl0bDh2LmNA
         z2LNUZktIf5FAwa33jb4aKywow6DSwtaGkqCi9WKJyd0u/1E8O6vF+sRreZqMMNwqlQN
         27asiuROD7Xkqoxx6MGk+ze8jhHTaj5WQ2cDTOd2LLNm/9Mh85iHOxNH0tlomAT0k5Sg
         B7UA==
X-Gm-Message-State: AOAM533liNoyq14Abv1a2R1JtdsI/R+tEBi1/g/wUrHviGAQXMl4tdff
        Udj6MHh3S3w1u6cqECLyFxsEU+lqYg==
X-Google-Smtp-Source: ABdhPJyjEdJjOZs+irJb+sLOhRe4AoYqvsKpDtVqAQHQBpJJ4Pn2lzC9wcUA19tmRtUhZ5JPU4peSQ==
X-Received: by 2002:a05:6870:e0d4:b0:d7:2d7a:e942 with SMTP id a20-20020a056870e0d400b000d72d7ae942mr842478oab.148.1646016275498;
        Sun, 27 Feb 2022 18:44:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e25-20020a544f19000000b002d53ce2f979sm5302130oiy.38.2022.02.27.18.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 18:44:34 -0800 (PST)
Received: (nullmailer pid 47200 invoked by uid 1000);
        Mon, 28 Feb 2022 02:44:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        alistair23@gmail.com, andreas@kemnade.info,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-input@vger.kernel.org,
        linus.walleij@linaro.org, rydberg@bitmath.org
In-Reply-To: <20220227123318.313009-3-alistair@alistair23.me>
References: <20220227123318.313009-1-alistair@alistair23.me> <20220227123318.313009-3-alistair@alistair23.me>
Subject: Re: [PATCH v6 2/4] dt-bindings: input: Add Cypress TT2100 touchscreen controller
Date:   Sun, 27 Feb 2022 20:44:30 -0600
Message-Id: <1646016270.948219.47199.nullmailer@robh.at.kernel.org>
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

On Sun, 27 Feb 2022 22:33:16 +1000, Alistair Francis wrote:
> Add the Cypress TrueTouch Generation 5 touchscreen device tree bindings
> documentation. It can use I2C or SPI bus.
> This touchscreen can handle some defined zone that are designed and
> sent as button. To be able to customize the keycode sent, the
> "linux,code" property in a "button" sub-node can be used.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../input/touchscreen/cypress,tt21000.yaml    | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:38.21-31: Warning (reg_format): /example-0/i2c/touchscreen@24/button@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:43.21-31: Warning (reg_format): /example-0/i2c/touchscreen@24/button@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:48.21-31: Warning (reg_format): /example-0/i2c/touchscreen@24/button@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:37.26-40.19: Warning (avoid_default_addr_size): /example-0/i2c/touchscreen@24/button@0: Relying on default #address-cells value
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:37.26-40.19: Warning (avoid_default_addr_size): /example-0/i2c/touchscreen@24/button@0: Relying on default #size-cells value
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:42.26-45.19: Warning (avoid_default_addr_size): /example-0/i2c/touchscreen@24/button@1: Relying on default #address-cells value
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:42.26-45.19: Warning (avoid_default_addr_size): /example-0/i2c/touchscreen@24/button@1: Relying on default #size-cells value
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:47.26-50.19: Warning (avoid_default_addr_size): /example-0/i2c/touchscreen@24/button@2: Relying on default #address-cells value
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dts:47.26-50.19: Warning (avoid_default_addr_size): /example-0/i2c/touchscreen@24/button@2: Relying on default #size-cells value
Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.example.dt.yaml: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1598249

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

