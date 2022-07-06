Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FA656896F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGFN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiGFN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:29:11 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7153D22536;
        Wed,  6 Jul 2022 06:29:09 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id v185so13950660ioe.11;
        Wed, 06 Jul 2022 06:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=aH9lY+PqiINzwORzIiO0qDw6/f8iZmksmBw46FQhWpk=;
        b=ZU4k9EwsJe71bEPuMPK0lbyWmxGQAMOcEW+n3oeNXf+dG44xu97oBkS7Qcg6vlxvOc
         aXozB4uMFAkOWHj2TzaGsjgpnN+swxtskIn8I+ysyolbCTOgK9jDeqb91SYyTxX8YG3T
         2+q3siFL/rNhs9SQ3H54jemXv3/oK0P37qq+Y39mFhMd2plJ/yElZNBspE94HPMvPhw/
         g/opXiWUgdG+lrH0NVUqpemNI8gmTttsanaKSHA6uiXxEb1oQK0uY/vZRvDTI12bnzYU
         yvOcebMTJIn41/iIG9X8vwtanjzMSb6s7ptHtPGZ989APzrEwUGUoSa55AUxM6rxX6MR
         gACA==
X-Gm-Message-State: AJIora89V2XVJ6gqO1jGsw3L+/KfyoDjZWRSCTmsrI5atb4Q4jGBB1ZU
        61TNpKgGObrf6PsVzzsO/A==
X-Google-Smtp-Source: AGRyM1siwmsKZBGMzZqo+DCW0UuVyEgykE4URqCkd6D2y8wK9hzr/wCXAIdebsXRMO5/8F/INeU8rg==
X-Received: by 2002:a05:6602:29d1:b0:669:428e:8c59 with SMTP id z17-20020a05660229d100b00669428e8c59mr21345697ioq.85.1657114148656;
        Wed, 06 Jul 2022 06:29:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 19-20020a056e0211b300b002dc0d743570sm3817592ilj.43.2022.07.06.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 06:29:08 -0700 (PDT)
Received: (nullmailer pid 4099937 invoked by uid 1000);
        Wed, 06 Jul 2022 13:29:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     nicolas.ferre@microchip.com, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        Kavyasree.Kotagiri@microchip.com, UNGLinuxDriver@microchip.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com> <20220706110619.71729-2-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: Convert atmel-flexcom to json-schema
Date:   Wed, 06 Jul 2022 07:29:04 -0600
Message-Id: <1657114144.966195.4099936.nullmailer@robh.at.kernel.org>
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

On Wed, 06 Jul 2022 09:06:17 -0200, Kavyasree Kotagiri wrote:
> Convert the Atmel flexcom device tree bindings to json schema.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
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
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 74 +++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 ----------------
>  2 files changed, 74 insertions(+), 63 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


flexcom@e0040000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb

flexcom@e0044000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb

flexcom@e0060000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb

flexcom@e0064000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb

flexcom@e0070000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
	arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
	arch/arm/boot/dts/lan966x-pcb8291.dtb

flexcom@e1818000: 'serial@200' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e181c000: 'i2c@600' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e1824000: 'serial@200' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e2018000: 'serial@200' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e2024000: 'serial@200' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e2818000: 'i2c@600' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e281c000: 'i2c@600' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@e2824000: 'spi@400' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sama7g5ek.dtb

flexcom@f0000000: 'spi@400' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sam9x60ek.dtb

flexcom@f0004000: 'serial@200' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sam9x60ek.dtb

flexcom@f8010000: 'i2c@600' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sam9x60ek.dtb

flexcom@f801c000: 'i2c@600' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-sam9x60ek.dtb

flexcom@f8034000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@f8038000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@fc010000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@fc014000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

flexcom@fc018000: 'i2c@600', 'serial@200', 'spi@400' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

