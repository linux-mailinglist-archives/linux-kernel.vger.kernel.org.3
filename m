Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CBD5B283F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIHVQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiIHVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:16:20 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D7C0BEA;
        Thu,  8 Sep 2022 14:16:19 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1279948d93dso28004418fac.10;
        Thu, 08 Sep 2022 14:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rNfS6MnyHN11CpGaQWsFrP3IeC5VsdT1Q8lOQ8f0+8c=;
        b=wzjJI3ShqsGqhIVUQD4/29zqnC8DH9Ak9hzakwq5JKpYVIojHRwUmg7i6h/Z78djDt
         CktB191ZhChF5ymezadtlAe78wlLPtU0lo7BoQkIBDUhH1JtCxuQbVM0DwSt5vLOWuhX
         PyKKuxM0Cd0qv7zagPrBcG2nZxWa7n9QZOQLMa+BZND7WbAjgQOdxG7zA3sC7TuJ4UDq
         b4i19BMs3mAZJ7pzxIKVTTEQPpHCtwg2pQQzpY+qgaXgWsx9zwTVNISm2Pc058tBNDHZ
         Qk3ehWZvwhy1ROon7Qq1VHIG83/1zhbDnn4+BM5iTamwPr8BcgFzfV47lymiMPLUfrdn
         22Ww==
X-Gm-Message-State: ACgBeo3EQs7RODeFhKVbFajkq3FOr974vkfi18pRJLkv32FAQoE2Z5hk
        X7M4enlc8BFyKaangLYXiw==
X-Google-Smtp-Source: AA6agR7yzkSOR7+iMoDWr2pkLqwGpPal2DQtXpIUDxMa3JnvtAGmKhFXcgETaGCBLNHgBQ0C5HVX3Q==
X-Received: by 2002:a05:6808:2103:b0:343:2b03:959b with SMTP id r3-20020a056808210300b003432b03959bmr2412843oiw.229.1662671778768;
        Thu, 08 Sep 2022 14:16:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m16-20020a056808025000b00344851ea0ddsm7860871oie.56.2022.09.08.14.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 14:16:18 -0700 (PDT)
Received: (nullmailer pid 3355401 invoked by uid 1000);
        Thu, 08 Sep 2022 21:16:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, lee@kernel.org, robh+dt@kernel.org
In-Reply-To: <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
References: <20220908150658.1839520-1-kavyasree.kotagiri@microchip.com> <20220908150658.1839520-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [RESEND PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to json-schema
Date:   Thu, 08 Sep 2022 16:16:16 -0500
Message-Id: <1662671776.565921.3355400.nullmailer@robh.at.kernel.org>
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

On Thu, 08 Sep 2022 13:06:56 -0200, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v8 -> v9:
>  - Changed reference provided for spi bindings to atmel,at91rm9200-spi.yaml
> 
> v7 -> v8:
>  - Added back patternProperties for child nodes.
> 
> v6 -> v7:
>  - Change filename to atmel,sama5d2-flexcom.yaml
>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> 
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is under review).
>    Once that is accepted, I will add back spi example through new patch.
> 
> v4 -> v5:
>  - Fixed indentations.
> 
> v3 -> v4:
>  - Corrected format of enum used for compatible string.
> 
> v2 -> v3:
>  - used enum for compatible string.
>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>  - fixed dtschema errors.
> 
> v1 -> v2:
>  - Fix title.
> 
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 91 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
>  2 files changed, 91 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


flexcom@e0040000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

flexcom@e0044000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

flexcom@e0060000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

flexcom@e0064000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

flexcom@e0070000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb
	arch/arm/boot/dts/lan966x-pcb8309.dtb

flexcom@e2824000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@f8034000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@f8038000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@fc010000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@fc014000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@fc018000: spi@400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

