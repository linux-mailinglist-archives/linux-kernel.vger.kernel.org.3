Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CEF5402AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344283AbiFGPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbiFGPoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:44:00 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1EE5F60;
        Tue,  7 Jun 2022 08:43:59 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id q76so10674405iod.8;
        Tue, 07 Jun 2022 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9emrPFpd8ECWdFEtrFErG7pTyWgKbTKd/J5t7zJBtZM=;
        b=jf4taYSEfAoZChJ1lRdb49fAdx0aFttI5dUCOIjdlebS+owQrUsoM67B5bxfhGYk+y
         egsO22Mxh5vqf0vN/PAVFraBtJGEAMiL6Ecpx6WFGnOjfA1xTKmk+W9wDtRK3Odoes14
         qMPlsjMxBsgGn1PdcZv9Pjr962dPsk1KTK6EJi+hDaVgvAuDgofoG5zHtTWpJ0bW60YA
         DSaqvx9kW22erZX0uMsdwcLM37WfrJp6XkZPYHC/RZPsvfaLN6tQZcDmd9PHhsKsLjby
         It8odpbY2bqsS0j/k972xKV7TVaB6C3qDwolgzpCI462RGrZPzC497FNed0M5LWgAwM1
         wYUQ==
X-Gm-Message-State: AOAM533l4wxpk/JxO8SNAiov/wIH9lamfkADSI++MdkOTJ1H4SCO+EFL
        1icfje3tnrEZh3t9Fh0ISg==
X-Google-Smtp-Source: ABdhPJzMlpTTkGHOHDVxZDAQC2uPBC8KMs8m7/yAAkbYaTB8zx5q/+Lj8guskOzy7/ATEbRVs6/SsA==
X-Received: by 2002:a02:b0ca:0:b0:331:92b7:f6a7 with SMTP id w10-20020a02b0ca000000b0033192b7f6a7mr8483213jah.97.1654616639214;
        Tue, 07 Jun 2022 08:43:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g14-20020a92520e000000b002d3ba224e25sm7362246ilb.10.2022.06.07.08.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 08:43:58 -0700 (PDT)
Received: (nullmailer pid 3310493 invoked by uid 1000);
        Tue, 07 Jun 2022 15:43:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220607105951.1821519-2-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com> <20220607105951.1821519-2-abel.vesa@nxp.com>
Subject: Re: [PATCH 01/10] dt-bindings: arm: freescale: Switch fsl,scu to yaml
Date:   Tue, 07 Jun 2022 09:43:57 -0600
Message-Id: <1654616637.643800.3310491.nullmailer@robh.at.kernel.org>
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

On Tue, 07 Jun 2022 13:59:42 +0300, Abel Vesa wrote:
> This patch actually addds the fsl,scu.yaml which is only for the
> main SCU node. The child nodes schemas will be split in different
> yaml files. The old txt file will be removed only after all the
> child nodes have been properly switch to yaml.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu.yaml       | 185 ++++++++++++++++++
>  1 file changed, 185 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/clock-controller: failed to match any schema with compatible: ['fsl,imx8qxp-clk', 'fsl,scu-clk']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/clock-controller: failed to match any schema with compatible: ['fsl,imx8qxp-clk', 'fsl,scu-clk']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/iomuxc: failed to match any schema with compatible: ['fsl,imx8qxp-iomuxc']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/imx8qx-ocotp: failed to match any schema with compatible: ['fsl,imx8qxp-scu-ocotp']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/imx8qx-pd: failed to match any schema with compatible: ['fsl,imx8qxp-scu-pd', 'fsl,scu-pd']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/imx8qx-pd: failed to match any schema with compatible: ['fsl,imx8qxp-scu-pd', 'fsl,scu-pd']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/rtc: failed to match any schema with compatible: ['fsl,imx8qxp-sc-rtc']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/scu-key: failed to match any schema with compatible: ['fsl,imx8qxp-sc-key', 'fsl,imx-sc-key']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/scu-key: failed to match any schema with compatible: ['fsl,imx8qxp-sc-key', 'fsl,imx-sc-key']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/watchdog: failed to match any schema with compatible: ['fsl,imx8qxp-sc-wdt', 'fsl,imx-sc-wdt']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/watchdog: failed to match any schema with compatible: ['fsl,imx8qxp-sc-wdt', 'fsl,imx-sc-wdt']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/thermal-sensor: failed to match any schema with compatible: ['fsl,imx8qxp-sc-thermal', 'fsl,imx-sc-thermal']
Documentation/devicetree/bindings/arm/freescale/fsl,scu.example.dtb:0:0: /example-0/firmware/scu/thermal-sensor: failed to match any schema with compatible: ['fsl,imx8qxp-sc-thermal', 'fsl,imx-sc-thermal']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

