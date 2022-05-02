Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAED5172AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385852AbiEBPhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355963AbiEBPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:37:05 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABDCBC22;
        Mon,  2 May 2022 08:33:35 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso4020345fac.1;
        Mon, 02 May 2022 08:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dD2Y3vOMl2tr/XEHZTE9aVU35/4IL1e3I9wJvGZpl2M=;
        b=M7pYKdd2uedkmcrcRbthb/xGW+RthwBl0cryFQvRKbCrZVC8lWrGfvRsEha25wDRC3
         4Lmqt9fJ9ahiPAmdnuX/x1Dyj/KLEE1O+dOXqJH4ru8imIVMBi/M9FTIfWbc4uX5JqAh
         WOvSoNQgGAFlS2ljWLI+5yQnR7iwe2rEuXnrhD4AHe9iuU2HKnsYF/s6dm5J/EmUwF3f
         /sAzN53emB7lfQl0Al5U2uR3IhNZFSEX9iZ0OabC58cez+z4CMS0RfdFRQROeq8ynptl
         MJh/4h0ni+niJ7772p3blsHidKhzwjjpoaRZyG+16m0MoBOJ0D5SGmG4B5KNLRgGJFr5
         CY9A==
X-Gm-Message-State: AOAM531jqHDFcJYG+qJRW8Y3H7nXjJukhF0hC/bt8BmxXDe9oEId7KC6
        WkWMvg+QYDNl4YxEmtOiJhVqbGCBJw==
X-Google-Smtp-Source: ABdhPJwlvrfdTgjaRkOgo9CjTot/4UQsJOPWIqMwz3jzRpOIldIk7cbmsTcBnhJhaUqFMsfxE8sRng==
X-Received: by 2002:a05:6870:e9a0:b0:e6:9d2:ff42 with SMTP id r32-20020a056870e9a000b000e609d2ff42mr5126607oao.7.1651505614677;
        Mon, 02 May 2022 08:33:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a056830120400b0060603221240sm2950294otp.16.2022.05.02.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:33:34 -0700 (PDT)
Received: (nullmailer pid 1161773 invoked by uid 1000);
        Mon, 02 May 2022 15:33:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@collabora.com, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
In-Reply-To: <20220429211111.2214119-2-nfraprado@collabora.com>
References: <20220429211111.2214119-1-nfraprado@collabora.com> <20220429211111.2214119-2-nfraprado@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Fix optional reg-names for mtk,scp
Date:   Mon, 02 May 2022 10:33:29 -0500
Message-Id: <1651505609.475123.1161772.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 17:11:09 -0400, Nícolas F. R. A. Prado wrote:
> The SCP has three memory regions: sram, l1tcm and cfg. Only sram is
> required, the other two are optional. Fix the dt-binding so that the
> optional regions can be omitted and passed in any order.
> 
> Also add the missing minItems to the reg property and update the
> description.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


scp@10500000: interrupts: [[0, 174, 4]] is not of type 'object'
	arch/arm64/boot/dts/mediatek/mt8183-evb.dtb
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
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb

scp@10500000: memory-region: [[25]] is not of type 'object'
	arch/arm64/boot/dts/mediatek/mt8183-evb.dtb

scp@10500000: memory-region: [[27]] is not of type 'object'
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb

scp@10500000: memory-region: [[28]] is not of type 'object'
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

