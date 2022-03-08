Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA24D0D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbiCHBJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbiCHBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:08:47 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5582C139;
        Mon,  7 Mar 2022 17:07:47 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so14358840otl.6;
        Mon, 07 Mar 2022 17:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=12XEWrfJJHySa9ucL9RV1LRbnMaoGn2lDS/BPBwPCdA=;
        b=oyCV5pYIffvCOSztct8FhFe0CtPc8n7o8N+7iUMQclafWzJchwElG2yIkvi7iEMA5I
         M6XodMntztfzMWY9UrBYyOg7hmhI9oZWqic5cmUwwlOmPNXTwSZwJshiyFTgK71NldLO
         XoaGdJFUbBQhTmkd/z+8Cl/OK/5mZnTNOQOjJMJapWzu10O9mHQuQ/KBbaGK4qnjeyiZ
         hl8tidevVlX+X8YjC5BZFriKf3lDfQmgvYjQ2GNDqbU7hcjMAeCG7m0KyOmnzOxCNmPO
         +5ykN4LpiA33Zh1xkvuL3anKpBRzgeZ9HDtrNAsFfXcYnPoSiuwtSHIKnq5iYObNKSRf
         2P0A==
X-Gm-Message-State: AOAM532gJxnW/xqoDW6um5oqJUI9A0+L7rEubYOjoGO74TtFci8bByhh
        9WQjjMforLb6ldkKQfCF2Q==
X-Google-Smtp-Source: ABdhPJxoKDNYYs7TzAhFqVTY+CLyhokQvtKcTTgQtR/V+xGGld1FpDXFhldfCDGd6NVMb+Yz67QBJA==
X-Received: by 2002:a05:6830:2aa7:b0:5b2:2086:d608 with SMTP id s39-20020a0568302aa700b005b22086d608mr6099000otu.159.1646701667031;
        Mon, 07 Mar 2022 17:07:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b63-20020acab242000000b002d9ddf4596fsm1836035oif.49.2022.03.07.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:07:46 -0800 (PST)
Received: (nullmailer pid 3624794 invoked by uid 1000);
        Tue, 08 Mar 2022 01:07:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com,
        lee.jones@linaro.org, krzysztof.kozlowski@canonical.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
In-Reply-To: <20220307153656.177589-2-sergiu.moga@microchip.com>
References: <20220307153656.177589-1-sergiu.moga@microchip.com> <20220307153656.177589-2-sergiu.moga@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: convert atmel pwm to json-schema
Date:   Mon, 07 Mar 2022 19:07:40 -0600
Message-Id: <1646701660.903645.3624793.nullmailer@robh.at.kernel.org>
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

On Mon, 07 Mar 2022 17:36:55 +0200, Sergiu Moga wrote:
> Convert PWM binding for Atmel/Microchip SoCs to Device Tree Schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../bindings/pwm/atmel,at91sam-pwm.yaml       | 42 +++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 43 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1602300


pwm@e1604000: compatible:0: 'microchip,sama7g5-pwm' is not one of ['atmel,at91sam9rl-pwm', 'atmel,sama5d3-pwm', 'atmel,sama5d2-pwm', 'microchip,sam9x60-pwm']
	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml

pwm@e1604000: compatible: ['microchip,sama7g5-pwm', 'atmel,sama5d2-pwm'] is too long
	arch/arm/boot/dts/at91-sama7g5ek.dt.yaml

