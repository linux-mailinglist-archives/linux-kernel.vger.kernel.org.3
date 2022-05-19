Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442252D389
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbiESNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238401AbiESNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:05:49 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFC8C03;
        Thu, 19 May 2022 06:05:44 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so3488203otr.9;
        Thu, 19 May 2022 06:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Q/j+6fWgTqD415mSRX9AX0OXoNhg/oIoVCv39xRaqdo=;
        b=gYQQI0cKb6ZC+EVtZ433tLxSNNolxHSfxLXLsGwMV1k4TsOzH5v2MFajvFAybTiFVC
         QOFbDUx1orTzKAcJBWKbJXlaQfA9ef1Iaj8TP3K0KGlXVXjRU4rpgLd3KACORlXTZKMq
         +HB0cHt+Tp1hw9Q+MEG8E7rf8dgku7plZMCHHsrNUfcVYFlto2h68CbM2lWrA9QxIYdU
         oCI8hlFSF9KKcSr2d0sz3H8bOrgkLlymIUBSpOBvUoVumScULH3ITKwebrwZUpXIGUvi
         1VjfWiHzNo1MBhk8kqXZLiJLQmnxSCcfNeCVLOVItYbxT2C2wJhVYbJuS93OnuydtPy4
         T3lQ==
X-Gm-Message-State: AOAM530+I5d95mQxpg9crDSEWyHR0F3QkkHrZZe30F4qXj4YBl6qPDxO
        aIeFKQLAA82n9LL/DhE6x4FFakPZyQ==
X-Google-Smtp-Source: ABdhPJyPEkqet1JAMCaueSPlwvRkHmeO55aWygzOBFDEVMu07vwehIQomdtoatme15/VpZ1w6QwVQw==
X-Received: by 2002:a05:6830:1e13:b0:605:f05e:d413 with SMTP id s19-20020a0568301e1300b00605f05ed413mr1876449otr.296.1652965543699;
        Thu, 19 May 2022 06:05:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r206-20020aca5dd7000000b00325cda1ffbbsm1752423oib.58.2022.05.19.06.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:05:42 -0700 (PDT)
Received: (nullmailer pid 1359569 invoked by uid 1000);
        Thu, 19 May 2022 13:05:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220519105928.22826-1-angelogioacchino.delregno@collabora.com>
References: <20220519105928.22826-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] dt-bindings: serial: mtk-uart: Convert txt to json-schema
Date:   Thu, 19 May 2022 08:05:39 -0500
Message-Id: <1652965539.994674.1359568.nullmailer@robh.at.kernel.org>
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

On Thu, 19 May 2022 12:59:28 +0200, AngeloGioacchino Del Regno wrote:
> Convert the mtk-uart documentation from freeform text to a json-schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/serial/mediatek,uart.yaml        | 118 ++++++++++++++++++
>  .../devicetree/bindings/serial/mtk-uart.txt   |  59 ---------
>  2 files changed, 118 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/mediatek,uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


serial@11002000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11002000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11003000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11003000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11003000: More than one condition true in oneOf schema:
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu-sku22.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dtb
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dtb

serial@11004000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11004000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11005000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11005000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6592-evb.dtb

serial@11006000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11006000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11007000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11007000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11008000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11008000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11009000: compatible:0: 'mediatek,mt6577-uart' is not one of ['mediatek,mt2701-uart', 'mediatek,mt2712-uart', 'mediatek,mt6580-uart', 'mediatek,mt6582-uart', 'mediatek,mt6589-uart', 'mediatek,mt6755-uart', 'mediatek,mt6765-uart', 'mediatek,mt6779-uart', 'mediatek,mt6795-uart', 'mediatek,mt6797-uart', 'mediatek,mt7622-uart', 'mediatek,mt7623-uart', 'mediatek,mt7629-uart', 'mediatek,mt7986-uart', 'mediatek,mt8127-uart', 'mediatek,mt8135-uart', 'mediatek,mt8173-uart', 'mediatek,mt8183-uart', 'mediatek,mt8186-uart', 'mediatek,mt8192-uart', 'mediatek,mt8195-uart', 'mediatek,mt8516-uart']
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

serial@11009000: compatible: ['mediatek,mt6577-uart'] is too short
	arch/arm/boot/dts/mt6589-aquaris5.dtb
	arch/arm/boot/dts/mt6589-fairphone-fp1.dtb

