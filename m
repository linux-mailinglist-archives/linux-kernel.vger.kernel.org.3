Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100DB57EA06
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbiGVWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiGVWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:45:23 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E2FC06D6;
        Fri, 22 Jul 2022 15:45:00 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id u13-20020a4aa34d000000b00435ac6c3b52so1087715ool.11;
        Fri, 22 Jul 2022 15:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=BcMkbhjHfIjOEjFO5QcCsjIr5qplL7kzWE5vPiVHFT4=;
        b=flFoC8R27iU96U2N2zvRWcA9OIjmG0Vu0oG4NuQriVWtROFN+Ujlu3mBqmcDdHLRjn
         u2Bet7waWeHZqhtNuTLW8FMBeYaFFX2pJljg2X3zBSFsKruW0E+PwCOEBR4aLxjkwgJd
         UzZRbF4DSclhvniTfyH3o8Q8m2DPmLARnlInmRcVpWoH4jj/z8oE4J3bMSZddF4eKMTC
         IC7PzV+J8JrDfFKO+KXdzxASz9luifFTze/jIzF8p9QBjitDb+LjWcIuTzEONzZHY/NH
         MZB85WN49L6avjwB066cNmApzfw/IjZ+bxnraJ80kuNTD1iSvdIVo5eFDXhfp+4WqPvh
         kIFA==
X-Gm-Message-State: AJIora/oXpBiLqpAJLl34XmjOVTVS956UjG5nXtul51f27FFrLrPubMe
        SSxqjVdOufwVANZaJHqsMw==
X-Google-Smtp-Source: AGRyM1u+JlsunW27L1GMybZjJJKJ6kt6UFhFlmt6Cc4c/4bKbT9Sb8d8kFxkxah76TyeHIGHgrEjTw==
X-Received: by 2002:a4a:c015:0:b0:425:6945:8382 with SMTP id v21-20020a4ac015000000b0042569458382mr764258oop.28.1658529895983;
        Fri, 22 Jul 2022 15:44:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 64-20020aca0543000000b0033a63ec17dbsm1117854oif.33.2022.07.22.15.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 15:44:55 -0700 (PDT)
Received: (nullmailer pid 20328 invoked by uid 1000);
        Fri, 22 Jul 2022 22:44:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220722201043.2731570-2-f.fainelli@gmail.com>
References: <20220722201043.2731570-1-f.fainelli@gmail.com> <20220722201043.2731570-2-f.fainelli@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: memory-controller: Document Broadcom STB MEMC
Date:   Fri, 22 Jul 2022 16:44:50 -0600
Message-Id: <1658529890.363700.20325.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 13:10:41 -0700, Florian Fainelli wrote:
> Document the Broadcom STB memory controller which is a trivial binding
> for now with a set of compatible strings and single register.
> 
> Since we introduce this binding, the section in
> Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt is removed
> and this binding is referenced instead.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/arm/bcm/brcm,brcmstb.txt         | 11 +---
>  .../brcm,brcmstb-memc-ddr.yaml                | 53 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,brcmstb-memc-ddr.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


memc-ddr@2000: 'clock-frequency' is a required property
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb

memc-ddr@2000: compatible:0: 'brcm,brcmstb-memc-ddr' is not one of ['brcm,brcmstb-memc-ddr-rev-b.1.x', 'brcm,brcmstb-memc-ddr-rev-b.2.0', 'brcm,brcmstb-memc-ddr-rev-b.2.1', 'brcm,brcmstb-memc-ddr-rev-b.2.2', 'brcm,brcmstb-memc-ddr-rev-b.2.3', 'brcm,brcmstb-memc-ddr-rev-b.2.5', 'brcm,brcmstb-memc-ddr-rev-b.2.6', 'brcm,brcmstb-memc-ddr-rev-b.2.7', 'brcm,brcmstb-memc-ddr-rev-b.2.8', 'brcm,brcmstb-memc-ddr-rev-b.3.0', 'brcm,brcmstb-memc-ddr-rev-b.3.1', 'brcm,brcmstb-memc-ddr-rev-c.1.0', 'brcm,brcmstb-memc-ddr-rev-c.1.1', 'brcm,brcmstb-memc-ddr-rev-c.1.2', 'brcm,brcmstb-memc-ddr-rev-c.1.3', 'brcm,brcmstb-memc-ddr-rev-c.1.4']
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb

memc-ddr@2000: compatible: ['brcm,brcmstb-memc-ddr'] is too short
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dtb

