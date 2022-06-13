Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FC549A66
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiFMRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiFMRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:50:12 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728CB3CFE7;
        Mon, 13 Jun 2022 06:33:27 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id q11so6047703iod.8;
        Mon, 13 Jun 2022 06:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vdZfN90YQu4hf8Uqw177MbmjixkJ2AAcNrLx6oY9MCU=;
        b=0vEUpAa5zAKQ89i46hqzZ+3hHeTnn+DY1/X0kJqYTFueZ/FwBOmrWDjFsa9Z9odXwA
         XIjIzf/6hM5JcDlSSzkHeMObN075lc2pXL6MO4JLhob4Y18jDKdvfTMrMv1IxFRWemqi
         IekeaKiCXsLUYOKPMWwtBHZjYPlOQvFTiyS51PcrCX7Y2C+stDxntVkUIN7XsOBy43dA
         u0xReuMw2mjoYysPsGqAcxIds4wIewSkd74UcCePomD/b6c7wQVujeaosljM/+6Uqey0
         Vz3gXVjv0A4PGzhbEY+B87oYpb5ay9ATjp/elrD4yzI4Z4jFyKQQZLIpI8E7aucJg0pz
         Ii2w==
X-Gm-Message-State: AOAM532oZpiFlDl4z/q02iRfmE4Sw1UP9tpECriUzZLcRbTTDmksN14b
        oYoyJUfpE5+LEyTXxGcKpg==
X-Google-Smtp-Source: ABdhPJwxl/8h496O951i+ofEnsI3E+yQOwKm/ujxZmtouDcCZ56WJ1Frq7wX9lahXWnDMzS3ZoRpNQ==
X-Received: by 2002:a6b:bf46:0:b0:669:c998:6b48 with SMTP id p67-20020a6bbf46000000b00669c9986b48mr6141923iof.67.1655127206555;
        Mon, 13 Jun 2022 06:33:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l16-20020a056e020e5000b002d1a16ef24dsm3870641ilk.82.2022.06.13.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 06:33:26 -0700 (PDT)
Received: (nullmailer pid 3564137 invoked by uid 1000);
        Mon, 13 Jun 2022 13:33:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org, szunichen@gmail.com,
        lars@metafoo.de, matthias.bgg@gmail.com,
        daniel.thompson@linaro.org, lee.jones@linaro.org,
        ChiYuan Huang <cy_huang@richtek.com>,
        linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org,
        jingoohan1@gmail.com, devicetree@vger.kernel.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
In-Reply-To: <20220613111146.25221-7-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-7-peterwu.pub@gmail.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: mfd: Add Mediatek MT6370
Date:   Mon, 13 Jun 2022 07:33:17 -0600
Message-Id: <1655127197.567546.3564136.nullmailer@robh.at.kernel.org>
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

On Mon, 13 Jun 2022 19:11:37 +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek MT6370 binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/mfd/mediatek,mt6370.yaml         | 279 ++++++++++++++++++
>  .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |  18 ++
>  2 files changed, 297 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/leds/backlight/mediatek,mt6370-backlight.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: backlight: False schema does not allow {'compatible': ['mediatek,mt6370-backlight'], 'mediatek,bled-channel-use': b'\x0f'}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: charger: False schema does not allow {'compatible': ['mediatek,mt6370-charger'], 'interrupts': [[48], [68], [6]], 'interrupt-names': ['attach_i', 'uvp_d_evt', 'mivr'], 'io-channels': [[1, 5]], 'usb-otg-vbus-regulator': {'regulator-name': ['mt6370-usb-otg-vbus'], 'regulator-min-microvolt': [[4350000]], 'regulator-max-microvolt': [[5800000]], 'regulator-min-microamp': [[500000]], 'regulator-max-microamp': [[3000000]], 'phandle': [[2]]}}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: tcpc: False schema does not allow {'compatible': ['mediatek,mt6370-tcpc'], 'interrupts-extended': [[4294967295, 4, 8]], 'connector': {'compatible': ['usb-c-connector'], 'label': ['USB-C'], 'vbus-supply': [[2]], 'data-role': ['dual'], 'power-role': ['dual'], 'try-power-role': ['sink'], 'source-pdos': [[570527844]], 'sink-pdos': [[570527944]], 'op-sink-microwatt': [[10000000]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@2': {'reg': [[2]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}}}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: indicator: False schema does not allow {'compatible': ['mediatek,mt6370-indicator'], '#address-cells': [[1]], '#size-cells': [[0]], 'multi-led@0': {'reg': [[0]], 'function': ['indicator'], 'color': [[9]], 'led-max-microamp': [[24000]], '#address-cells': [[1]], '#size-cells': [[0]], 'led@0': {'reg': [[0]], 'color': [[1]]}, 'led@1': {'reg': [[1]], 'color': [[2]]}, 'led@2': {'reg': [[2]], 'color': [[3]]}}, 'led@3': {'reg': [[3]], 'function': ['indicator'], 'color': [[0]], 'led-max-microamp': [[6000]]}}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: pmic@34: flashlight: False schema does not allow {'compatible': ['mediatek,mt6370-flashlight'], '#address-cells': [[1]], '#size-cells': [[0]], 'led@0': {'reg': [[0]], 'led-sources': [[0]], 'function': ['flash'], 'color': [[0]], 'function-enumerator': [[1]], 'led-max-microamp': [[200000]], 'flash-max-microamp': [[500000]], 'flash-max-timeout-us': [[1248000]]}, 'led@1': {'reg': [[1]], 'led-sources': [[1]], 'function': ['flash'], 'color': [[0]], 'function-enumerator': [[2]], 'led-max-microamp': [[200000]], 'flash-max-microamp': [[500000]], 'flash-max-timeout-us': [[1248000]]}}
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb: backlight: mediatek,bled-channel-use: b'\x0f' is not of type 'object', 'array', 'boolean', 'null'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/dt-core.yaml
Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/backlight: failed to match any schema with compatible: ['mediatek,mt6370-backlight']
Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/charger: failed to match any schema with compatible: ['mediatek,mt6370-charger']
Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/indicator: failed to match any schema with compatible: ['mediatek,mt6370-indicator']
Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/flashlight: failed to match any schema with compatible: ['mediatek,mt6370-flashlight']
Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /example-0/i2c/pmic@34/tcpc: failed to match any schema with compatible: ['mediatek,mt6370-tcpc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

