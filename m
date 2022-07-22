Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B557EA07
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiGVWpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbiGVWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:45:29 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A58C06F1;
        Fri, 22 Jul 2022 15:45:02 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id w204so7074519oie.7;
        Fri, 22 Jul 2022 15:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=7XwmdpKQBMvYl+pH5ar534iWvJuw8dX5bUNNhw01JC0=;
        b=spELbzAQgfwfjZgkEC9vp8UKDrSRh+SLdskhEdXv1oJ0bUUDkCgXYmf04Efj4AOebm
         R3P4ta/+GI77N3TP5aILoZWJy3hb9MK12trOmLpfr6MnZp+KAGZ7C5Lu87b2F2bPUhyv
         WYB0aP01QZWLPz3QsUqjCXedQ8mbBRfRCgS6ST0TGmOmJ6NqFHT8XMJiux3Eb9150XP4
         rTwY1VWRysFJ3ZHtqvYYTCSAFk/qJEyk2vmph9pF4V3uJdMOlCPh9oFo+g1FjYWG+t9q
         sXbsKxHg/LAM211Osz8shPYTyNxOVrYjifB/BvG/JcjtMc+kme1+QULdvm3p9AiW0cU/
         BXLA==
X-Gm-Message-State: AJIora+iIA2CCnwvCW35kSZ1sh2L+Je0J8PoAe5N1bjW65rmc5ualJIs
        3SM5I+FhMiLD/XRDAMmyew==
X-Google-Smtp-Source: AGRyM1t567gWXFWJV8Z8P3p6+RpUtCKsfkUs/yIOqGV6OA/Un4DLtV0hOWhNYRcnYaQXHgRiApZdsQ==
X-Received: by 2002:a05:6808:1286:b0:33a:9a90:68d2 with SMTP id a6-20020a056808128600b0033a9a9068d2mr861852oiw.235.1658529898372;
        Fri, 22 Jul 2022 15:44:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y7-20020a05683009c700b0061cb7f17ed7sm2466136ott.11.2022.07.22.15.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 15:44:57 -0700 (PDT)
Received: (nullmailer pid 20323 invoked by uid 1000);
        Fri, 22 Jul 2022 22:44:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ryan.Wanner@microchip.com
Cc:     devicetree@vger.kernel.org, alexandre.belloni@bootlin.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        broonie@kernel.org, claudiu.beznea@microchip.com,
        nicolas.ferre@microchip.com
In-Reply-To: <20220722152945.2950807-1-Ryan.Wanner@microchip.com>
References: <20220722152945.2950807-1-Ryan.Wanner@microchip.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Date:   Fri, 22 Jul 2022 16:44:50 -0600
Message-Id: <1658529890.319757.20312.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 08:29:45 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel i2s devicetree binding to json-schema.
> Change file name to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
> Note: running dtbs_check will fail unless updated with this patch,
> https://lore.kernel.org/linux-arm-kernel/20220707215812.193008-1-Ryan.Wanner@microchip.com/
> 
> v1 -> v2:
> - Fix formatting for clock description.
> - Fix formatting for dma description.
> 
>  .../bindings/sound/atmel,sama5d2-i2s.yaml     | 85 +++++++++++++++++++
>  .../devicetree/bindings/sound/atmel-i2s.txt   | 46 ----------
>  2 files changed, 85 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


i2s@fc04c000: 'assigned-parrents' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/at91-kizbox3-hs.dtb
	arch/arm/boot/dts/at91-sama5d27_som1_ek.dtb
	arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_icp.dtb
	arch/arm/boot/dts/at91-sama5d2_ptc_ek.dtb
	arch/arm/boot/dts/at91-sama5d2_xplained.dtb

