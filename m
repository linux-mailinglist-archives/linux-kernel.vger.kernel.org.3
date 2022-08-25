Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF75A191D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbiHYSvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbiHYSve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:51:34 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6273BD14F;
        Thu, 25 Aug 2022 11:51:26 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-11c59785966so26045016fac.11;
        Thu, 25 Aug 2022 11:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=/mQxvQUe1gZvztnNOjvvy0GAYtv4p8n82bdrYuXSJNc=;
        b=SmxtThvt0xullVIzo+tu58M3kfxDoeNbYY3oomu4YexB98wxnj+U11QlSSavL+gpnq
         qVgR7UoiqMwzENeVO4p3TW+H7NefI9L0PhfNGhkdSrW7+D4D+ic3xhNtP4tHzE0ekB9R
         YJmxOEjEeebX4OuyfQElNtV5YYbRAoa5tKCyMEJLCMeaJZo1m0JHsIt4aW1uVLBz3WSL
         YsPBLCU2y7Bt/tE9uZ5OS5iRqjZwAJv6iYAWL8Af+FauW365zPrPX4FePzJ14vLmdKSD
         t72jaJZsxK8dvkVfSnJATRhI1SBnxT9v0sDdELOJ961BWsEKX+wubMDT3tPxRLj0lEL2
         POOw==
X-Gm-Message-State: ACgBeo2foa7Cx8BHXBOjvLfxv23ooDAcliJppRIIdySI2QOZ570aU99L
        1x1yIB+HKTba3NjRt6yMQA==
X-Google-Smtp-Source: AA6agR7VmIvwrjdERFhI9ibJJis5Ad/n5EP/mLtA9FAraPED+0yZNGZaOa0d6weoNURMUb/qtIHNOA==
X-Received: by 2002:a05:6871:96:b0:11d:ca1b:db19 with SMTP id u22-20020a056871009600b0011dca1bdb19mr259813oaa.74.1661453485513;
        Thu, 25 Aug 2022 11:51:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n16-20020a056870971000b0011d2ec94fcasm3737802oaq.36.2022.08.25.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:51:24 -0700 (PDT)
Received: (nullmailer pid 1486944 invoked by uid 1000);
        Thu, 25 Aug 2022 18:51:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Andreas_B=C3=B6hler?= <dev@aboehler.at>
Cc:     linux-hwmon@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220825143737.77732-1-dev@aboehler.at>
References: <20220825143737.77732-1-dev@aboehler.at>
Subject: Re: [PATCH v3 1/2] Documentation: devicetree: update bindings for tps23861
Date:   Thu, 25 Aug 2022 13:51:19 -0500
Message-Id: <1661453480.004870.1486943.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022 16:37:36 +0200, Andreas Böhler wrote:
> The tps23861 driver does not initialize the chip and relies on it being
> in auto-mode by default. On some devices, these controllers default to
> OFF-Mode and hence cannot be used at all.
> 
> This brings minimal support for initializing the controller in a user-
> defined mode.
> 
> Signed-off-by: Andreas Böhler <dev@aboehler.at>
> ---
>  .../bindings/hwmon/ti,tps23861.yaml           | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:28.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:36.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:44.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:52.23-33: Warning (reg_format): /example-0/i2c/tps23861@30/port@3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:27.26-33.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@0: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:27.26-33.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@0: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:35.26-41.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@1: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:35.26-41.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@1: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:43.26-49.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@2: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:43.26-49.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@2: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:51.26-57.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@3: Relying on default #address-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dts:51.26-57.21: Warning (avoid_default_addr_size): /example-0/i2c/tps23861@30/port@3: Relying on default #size-cells value
Documentation/devicetree/bindings/hwmon/ti,tps23861.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

