Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC82508961
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiDTNc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379096AbiDTNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:32:44 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C110FFC;
        Wed, 20 Apr 2022 06:29:57 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e604f712ecso1910306fac.9;
        Wed, 20 Apr 2022 06:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sTuVq0s9OtPDutsc1Wu98n4D94RYOqx86fIxGxCByOw=;
        b=brNeDICG7Q79eG+S+OnLRVtZafoehPuLkbGFf/MFusbHC6evcvtg/9YPbMvGNH6MOd
         /kESfMiXPdt7koP3N+B7/dDPZyN4qja1v5xl7iEM4yaB6gdEPyEP+rYNpoxidxs0WMp5
         /DOxAhJ5g7VdsVQloOEg9ySgqoUYL7IagrL+RjRN51wo/XvmpElEVWIVcG4teeeCcfcs
         dI3za+o0A61L/Iq/oK2euKGkLoHaEcAwnBt47hXT63B2UznSRQU4nAoapmu9MlHchpgz
         PXfRxeBtjPSkxvpCcyKUuabeFLHxQXn/uwtxxLqnDLW70hibPxnzkZ/A0d2TuCliN/cW
         ZdMw==
X-Gm-Message-State: AOAM530uJbliHqW0jArigk0B76vFjHEiVE+lxqiUDJvGyCatpPuPXd+7
        Zov0QQRuVqnk6k6BndbQXG1gjS42HQ==
X-Google-Smtp-Source: ABdhPJypu6fAb/Ix1HcbjShAF/0D/wrocyPLP/X4IvjoEm4gGT2fBwDtznF7vSwT1Q3Y0gSuwcgGDA==
X-Received: by 2002:a05:6870:b68e:b0:e5:c836:882b with SMTP id cy14-20020a056870b68e00b000e5c836882bmr1541641oab.177.1650461397291;
        Wed, 20 Apr 2022 06:29:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m65-20020acabc44000000b002ed13d0fe6fsm6197382oif.23.2022.04.20.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:29:56 -0700 (PDT)
Received: (nullmailer pid 1168371 invoked by uid 1000);
        Wed, 20 Apr 2022 13:29:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        allen-kh.cheng@mediatek.com, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Longfei Wang <longfei.wang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        srv_heupstream@mediatek.com,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220420073440.31649-1-irui.wang@mediatek.com>
References: <20220420073440.31649-1-irui.wang@mediatek.com>
Subject: Re: [PATCH] dt-bindings: media: mtk-vcodec: Adds encoder power domain property
Date:   Wed, 20 Apr 2022 08:29:53 -0500
Message-Id: <1650461393.995094.1168370.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 15:34:39 +0800, Irui Wang wrote:
> Adds encoder power domain property
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


vcodec@18002000: 'mediatek,larb' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

vcodec@18002000: 'power-domains' is a required property
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

vcodec@19002000: 'mediatek,larb' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

vcodec@19002000: 'power-domains' is a required property
	arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
	arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
	arch/arm64/boot/dts/mediatek/mt8173-evb.dtb

