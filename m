Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC9592602
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiHNSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNSfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:35:09 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893E186DF;
        Sun, 14 Aug 2022 11:35:06 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id f18so1147297ilj.11;
        Sun, 14 Aug 2022 11:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=gVW85/KDaANkBY2qCn0Fjp04/BEeNokQszStw+tvDH0=;
        b=Hgug6en0aQBzDWOrSc3r8/mFR0PuRcjHata3McUZyq+my9XubakKloyelf+0BNcUhH
         kbzI+uNjGjAGL9Qu7QCDc4i1zrcTX4Gr+5z2t6Dzh1P+ViWrR8YhaWSwr1ZSANTehoyM
         rd4lGYa3CSyNIPa9iuor5XX35DukKcS0Q2Eog4z+t0uLIDyihuOL0JTm3a+ztvwB4UHp
         V3UyhKhAb9VejTKHmTgPGbqWBI4/2hyXozPN4eg9ONdGGpZH7/msFFIT04hMiO4gfMeT
         aRAMTSD7I+uqCvJaS4drBo5RHcXZKKwasLdX/+0hVK2zpgZF3HzU6Goltl/W1SVEHJSx
         QQ+A==
X-Gm-Message-State: ACgBeo2Lo4jlDkU6gAvVFYmIKEJolKK3xCL8MgVDHcF+vs1e3kpHj18f
        8cw9qjvudPHk/WJJXtoqLg==
X-Google-Smtp-Source: AA6agR7Y1di0eWxnpj0zfbAvLFxAvmjIxcBDVB44qAyLxZqqOTVzWXub5XeNFypIKZNsMxAYflc0sA==
X-Received: by 2002:a92:c26a:0:b0:2e5:b7e4:7e52 with SMTP id h10-20020a92c26a000000b002e5b7e47e52mr775729ild.299.1660502105860;
        Sun, 14 Aug 2022 11:35:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h12-20020a056e021d8c00b002e127d59f63sm3063758ila.74.2022.08.14.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 11:35:04 -0700 (PDT)
Received: (nullmailer pid 546325 invoked by uid 1000);
        Sun, 14 Aug 2022 18:35:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, festevam@gmail.com,
        krzysztof.kozlowski@linaro.org, saravanak@google.com,
        geert+renesas@glider.be, robh+dt@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20220814074338.453608-3-victor.liu@nxp.com>
References: <20220814074338.453608-1-victor.liu@nxp.com> <20220814074338.453608-3-victor.liu@nxp.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Sun, 14 Aug 2022 12:35:02 -0600
Message-Id: <1660502102.287520.546324.nullmailer@robh.at.kernel.org>
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

On Sun, 14 Aug 2022 15:43:38 +0800, Liu Ying wrote:
> Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
> It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
> DSI and HDMI TX subsystems, like I2C controller, PWM controller,
> MIPI DSI controller and Control and Status Registers (CSR) module.
> 
> Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
> link MSI bus specific bindings.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3->v4:
> * Add child nodes in the example MSI bus node of the MSI bus dt-binding. (Krzysztof)
> 
> v2->v3:
> * Add a pattern property to allow child nodes. (Rob)
> 
> v1->v2:
> Address Krzysztof's comments:
> * Add a select to explicitly select the MSI bus dt-binding.
> * List 'simple-pm-bus' explicitly as one item of compatible strings.
> * Require compatible and reg properties.
> * Put reg property just after compatible property in example.
> 
>  .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 232 ++++++++++++++++++
>  1 file changed, 232 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.example.dtb:0:0: /example-0/bus@56200000/syscon@56221000: failed to match any schema with compatible: ['fsl,imx8qxp-mipi-lvds-csr', 'syscon', 'simple-mfd']
Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.example.dtb:0:0: /example-0/bus@56200000/syscon@56221000/pxl2dpi: failed to match any schema with compatible: ['fsl,imx8qxp-pxl2dpi']
Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.example.dtb:0:0: /example-0/bus@56200000/syscon@56221000/ldb: failed to match any schema with compatible: ['fsl,imx8qxp-ldb']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

