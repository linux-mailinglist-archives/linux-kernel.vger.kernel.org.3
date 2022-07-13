Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF9573CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiGMTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiGMTIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:08:51 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7512739;
        Wed, 13 Jul 2022 12:08:50 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id u20so11755863iob.8;
        Wed, 13 Jul 2022 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=gPp4fL4X3RNG52iSlBWKs2UeWMn8GTEKPSSMMNjkH1U=;
        b=uv27YH5MpIKsASt8dx6h+RFbi/cLznfNbEYCv/hiokoGcVPzENaXbtP4rmMZ2Axdrp
         LLGVb+M11NQCjW29Kp2gAbBc7PeYEqvS4/SWxA0x9ME1LVERMdZOFOndfQgP6fIjbO09
         zlW9VIfMRXv3TnmWJsTv9v5WXHp7imDr4xJY0deLP7EUD0WF6d1E9APJW0u9E76ozCuK
         l1TzPWSwYQ0FHvhFg8kOBTHcLY5I6JbQRrCdtfBmIy5gegMpL2z+68qsFUr/HZJ+AO7Q
         ApXHPk8bJVRHNod7Z9Fj1OWKFVqkR0Ucsy/fLcEEXmFDXqI3RpWfsR4TQ+OTVT7p5wz9
         4k/g==
X-Gm-Message-State: AJIora/+jhFx3ZFKN+k494NDDVvMlXInz2e3UZm37iOqok2Kzc7G798d
        ZhvxvrRxZAJL5xRa22PAwo/IgyF+vA==
X-Google-Smtp-Source: AGRyM1tgUY0yKG9P+IdNnaJ3ki7q6couzh1ID98oZ135ss6SXwXJQaykZeC8PS/uAXkXV0PG2IJogg==
X-Received: by 2002:a05:6638:4185:b0:33d:c7da:b119 with SMTP id az5-20020a056638418500b0033dc7dab119mr2732685jab.101.1657739329931;
        Wed, 13 Jul 2022 12:08:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h41-20020a022b29000000b0033f0a3a5fbbsm5566358jaa.175.2022.07.13.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 12:08:49 -0700 (PDT)
Received: (nullmailer pid 246144 invoked by uid 1000);
        Wed, 13 Jul 2022 19:08:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ryan.Wanner@microchip.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com
In-Reply-To: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
References: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
Subject: Re: [PATCH] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Date:   Wed, 13 Jul 2022 13:08:47 -0600
Message-Id: <1657739327.994394.246143.nullmailer@robh.at.kernel.org>
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

On Wed, 13 Jul 2022 09:25:38 -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Convert atmel i2s devicetree binding to json-schema.
> Change file name to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../bindings/sound/atmel,sama5d2-i2s.yaml     | 83 +++++++++++++++++++
>  .../devicetree/bindings/sound/atmel-i2s.txt   | 46 ----------
>  2 files changed, 83 insertions(+), 46 deletions(-)
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

