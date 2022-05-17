Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C152AC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbiEQUTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiEQUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:19:09 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E451E6C;
        Tue, 17 May 2022 13:19:05 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id w130so260749oig.0;
        Tue, 17 May 2022 13:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qF0K1DNnjaqSBBuzSNA0jml+7NSOTcoHRSVNExgb0IU=;
        b=hHxYZavkNduQqYTY3Ya4UnZVleO/DbFMEXONXPjmAAt+XPY/9xbaeJI6CBavrtJ1Ro
         KUaLikVyP9Amuk8pUD5Mq9daAYiu6ElJDAZumBFYVqNI0eRwunya7OBD4phZrarnLnNM
         j7Xee9fbkUIVqbt6fdWVGzQH3+vH81O31yPIOpQncQFF3wkRFQE+Q75/9GE+8czZICqh
         bcrwVi09W2R9iIxf+b3EWNwe1hPT7udN1cKM4BPCyWW8sG6twxfBKqGPqYxn3cKRAQID
         AJd7YW2IPQDnSN8J5AAb9q+iZKXdvHfHC/8KhNU9m469EE1KjXMpMSZy9mQZIp3jrnJ8
         XVrA==
X-Gm-Message-State: AOAM530/WMwNEog31+1l9dFzViaBOrvPhsH3HcGGnAeOLO4xMuVXdugI
        +zgxaziJNsOAbIwi09omVA==
X-Google-Smtp-Source: ABdhPJyD6elI9HCVkd6AnLnBYNqOkkIRVTo1++KX2zvPCfJvAtcXP8v/Qto20xBUQ7sIQ4K661TKyg==
X-Received: by 2002:aca:bc57:0:b0:326:b2b6:2535 with SMTP id m84-20020acabc57000000b00326b2b62535mr16655453oif.107.1652818745220;
        Tue, 17 May 2022 13:19:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q19-20020a4a8353000000b00333220959b9sm207184oog.1.2022.05.17.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:19:04 -0700 (PDT)
Received: (nullmailer pid 1561450 invoked by uid 1000);
        Tue, 17 May 2022 20:19:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Smitha T Murthy <smitha.t@samsung.com>
Cc:     ezequiel@vanguardiasur.com.ar, benjamin.gaignard@collabora.com,
        david.plowman@raspberrypi.com, stanimir.varbanov@linaro.org,
        mark.rutland@arm.com, andi@etezian.org, aswani.reddy@samsung.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, dillon.minfei@gmail.com,
        andrzej.hajda@intel.com, linux-arm-kernel@lists.infradead.org,
        pankaj.dubey@samsung.com, jernej.skrabec@gmail.com,
        krzk+dt@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        alim.akhtar@samsung.com, linux-media@vger.kernel.org,
        linux-fsd@tesla.com, hverkuil-cisco@xs4all.nl
In-Reply-To: <20220517125548.14746-3-smitha.t@samsung.com>
References: <20220517125548.14746-1-smitha.t@samsung.com>        <CGME20220517125554epcas5p4e87a71471525056281f1578f4f80f760@epcas5p4.samsung.com> <20220517125548.14746-3-smitha.t@samsung.com>
Subject: Re: [PATCH 02/20] dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt to new DT schema
Date:   Tue, 17 May 2022 15:19:03 -0500
Message-Id: <1652818743.270476.1561449.nullmailer@robh.at.kernel.org>
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

On Tue, 17 May 2022 18:25:30 +0530, Smitha T Murthy wrote:
> Adds DT schema for s5p-mfc in yaml format.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt     | 77 +--------------
>  .../devicetree/bindings/media/s5p-mfc.yaml    | 98 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


codec@11000000: 'iommu-names', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/exynos5250-arndale.dtb
	arch/arm/boot/dts/exynos5250-smdk5250.dtb
	arch/arm/boot/dts/exynos5250-snow.dtb
	arch/arm/boot/dts/exynos5250-snow-rev5.dtb
	arch/arm/boot/dts/exynos5250-spring.dtb
	arch/arm/boot/dts/exynos5420-arndale-octa.dtb
	arch/arm/boot/dts/exynos5420-chagall-wifi.dtb
	arch/arm/boot/dts/exynos5420-klimt-wifi.dtb
	arch/arm/boot/dts/exynos5420-peach-pit.dtb
	arch/arm/boot/dts/exynos5420-smdk5420.dtb
	arch/arm/boot/dts/exynos5422-odroidhc1.dtb
	arch/arm/boot/dts/exynos5422-odroidxu3.dtb
	arch/arm/boot/dts/exynos5422-odroidxu3-lite.dtb
	arch/arm/boot/dts/exynos5422-odroidxu4.dtb
	arch/arm/boot/dts/exynos5800-peach-pi.dtb

codec@13400000: clock-names: ['mfc', 'sclk_mfc'] is too long
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
	arch/arm/boot/dts/exynos3250-monk.dtb
	arch/arm/boot/dts/exynos3250-rinato.dtb
	arch/arm/boot/dts/exynos4210-i9100.dtb
	arch/arm/boot/dts/exynos4210-origen.dtb
	arch/arm/boot/dts/exynos4210-smdkv310.dtb
	arch/arm/boot/dts/exynos4210-trats.dtb
	arch/arm/boot/dts/exynos4210-universal_c210.dtb
	arch/arm/boot/dts/exynos4412-i9300.dtb
	arch/arm/boot/dts/exynos4412-i9305.dtb
	arch/arm/boot/dts/exynos4412-itop-elite.dtb
	arch/arm/boot/dts/exynos4412-n710x.dtb
	arch/arm/boot/dts/exynos4412-odroidu3.dtb
	arch/arm/boot/dts/exynos4412-odroidx2.dtb
	arch/arm/boot/dts/exynos4412-odroidx.dtb
	arch/arm/boot/dts/exynos4412-origen.dtb
	arch/arm/boot/dts/exynos4412-p4note-n8010.dtb
	arch/arm/boot/dts/exynos4412-smdk4412.dtb
	arch/arm/boot/dts/exynos4412-tiny4412.dtb
	arch/arm/boot/dts/exynos4412-trats2.dtb

codec@13400000: clocks: [[5, 273], [5, 170]] is too long
	arch/arm/boot/dts/exynos4210-i9100.dtb
	arch/arm/boot/dts/exynos4210-origen.dtb
	arch/arm/boot/dts/exynos4210-smdkv310.dtb
	arch/arm/boot/dts/exynos4210-trats.dtb
	arch/arm/boot/dts/exynos4210-universal_c210.dtb

codec@13400000: clocks: [[7, 178], [7, 228]] is too long
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
	arch/arm/boot/dts/exynos3250-monk.dtb
	arch/arm/boot/dts/exynos3250-rinato.dtb

codec@13400000: clocks: [[7, 273], [7, 170]] is too long
	arch/arm/boot/dts/exynos4412-i9300.dtb
	arch/arm/boot/dts/exynos4412-i9305.dtb
	arch/arm/boot/dts/exynos4412-itop-elite.dtb
	arch/arm/boot/dts/exynos4412-n710x.dtb
	arch/arm/boot/dts/exynos4412-odroidu3.dtb
	arch/arm/boot/dts/exynos4412-odroidx2.dtb
	arch/arm/boot/dts/exynos4412-odroidx.dtb
	arch/arm/boot/dts/exynos4412-origen.dtb
	arch/arm/boot/dts/exynos4412-p4note-n8010.dtb
	arch/arm/boot/dts/exynos4412-smdk4412.dtb
	arch/arm/boot/dts/exynos4412-tiny4412.dtb
	arch/arm/boot/dts/exynos4412-trats2.dtb

codec@13400000: 'iommu-names', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/exynos4210-i9100.dtb
	arch/arm/boot/dts/exynos4210-origen.dtb
	arch/arm/boot/dts/exynos4210-smdkv310.dtb
	arch/arm/boot/dts/exynos4210-trats.dtb
	arch/arm/boot/dts/exynos4210-universal_c210.dtb
	arch/arm/boot/dts/exynos4412-i9300.dtb
	arch/arm/boot/dts/exynos4412-i9305.dtb
	arch/arm/boot/dts/exynos4412-itop-elite.dtb
	arch/arm/boot/dts/exynos4412-n710x.dtb
	arch/arm/boot/dts/exynos4412-odroidu3.dtb
	arch/arm/boot/dts/exynos4412-odroidx2.dtb
	arch/arm/boot/dts/exynos4412-odroidx.dtb
	arch/arm/boot/dts/exynos4412-origen.dtb
	arch/arm/boot/dts/exynos4412-p4note-n8010.dtb
	arch/arm/boot/dts/exynos4412-smdk4412.dtb
	arch/arm/boot/dts/exynos4412-tiny4412.dtb
	arch/arm/boot/dts/exynos4412-trats2.dtb

codec@13400000: iommus: [[36]] is too short
	arch/arm/boot/dts/exynos3250-monk.dtb

codec@13400000: iommus: [[40]] is too short
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb

codec@13400000: iommus: [[47]] is too short
	arch/arm/boot/dts/exynos3250-rinato.dtb

codec@13400000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
	arch/arm/boot/dts/exynos3250-monk.dtb
	arch/arm/boot/dts/exynos3250-rinato.dtb

codec@152e0000: clock-names: ['pclk', 'aclk', 'aclk_xiu'] is too long
	arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb
	arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb

codec@152e0000: clocks: [[34, 16], [34, 9], [34, 6]] is too long
	arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb
	arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb

codec@152e0000: 'iommu-names', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb
	arch/arm64/boot/dts/exynos/exynos5433-tm2e.dtb

codec@f1700000: clock-names: ['sclk_mfc', 'mfc'] is too long
	arch/arm/boot/dts/s5pv210-aquila.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb
	arch/arm/boot/dts/s5pv210-goni.dtb
	arch/arm/boot/dts/s5pv210-smdkc110.dtb
	arch/arm/boot/dts/s5pv210-smdkv210.dtb
	arch/arm/boot/dts/s5pv210-torbreck.dtb

codec@f1700000: clocks: [[2, 60], [2, 92]] is too long
	arch/arm/boot/dts/s5pv210-aquila.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb
	arch/arm/boot/dts/s5pv210-goni.dtb
	arch/arm/boot/dts/s5pv210-smdkc110.dtb
	arch/arm/boot/dts/s5pv210-smdkv210.dtb
	arch/arm/boot/dts/s5pv210-torbreck.dtb

codec@f1700000: 'iommus' is a required property
	arch/arm/boot/dts/s5pv210-aquila.dtb
	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
	arch/arm/boot/dts/s5pv210-galaxys.dtb
	arch/arm/boot/dts/s5pv210-goni.dtb
	arch/arm/boot/dts/s5pv210-smdkc110.dtb
	arch/arm/boot/dts/s5pv210-smdkv210.dtb
	arch/arm/boot/dts/s5pv210-torbreck.dtb

