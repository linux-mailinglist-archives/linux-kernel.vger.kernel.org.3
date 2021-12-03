Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002414680A0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383538AbhLCXiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:38:02 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44628 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383526AbhLCXhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:55 -0500
Received: by mail-ot1-f48.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso5349828otj.11;
        Fri, 03 Dec 2021 15:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=YiLKOo6UjENxJNlcLLad7PuFG7LasjEMP8sQf/vfoCY=;
        b=RIm2ePknVIf1XAh+8D4XHk9aGTYINpU/YF/fPjDjkmQ1Z837Ee2tKGOKbSNKkpX0Ht
         b4d9PEgE8ZwThwvLySugGDJtmk/crjw7AXedqjLrCdeSJV16wBjjGq7/syezm78mIpOD
         D9pv9xIQkf0gWz4nta9DaShER8rLSgvzZTEM80kepNqycRLSc1JUhn1fzVgwccV+H22/
         qcuPmOwP9nGl9+2UOKxVBjit/n8UzQc0TAZF4kkhysbqQHcS2GC81dFRmlQbL0zCsSRP
         0ZcYrQ7J/VL88SrSyCdTyn4IJqMAAZ7lJoYkAWp2JxWf7Ue6X8BgQKOwaOHgcmVggGh/
         M9MQ==
X-Gm-Message-State: AOAM531/06tbmDUVahgXHAadLK7AX7Ff7pAwLs9amnhezv6wiozKLTHW
        //WEUO9NWHVMtPM99cbdFJ7J8twdaQ==
X-Google-Smtp-Source: ABdhPJzaChXSNEtZQrVDuuBqE4OOoH38CUdgHcZapsCQUiGSTfOcqkFwFK52oIJ1fUrqoQYuBMT/Hw==
X-Received: by 2002:a9d:7a5a:: with SMTP id z26mr19045138otm.297.1638574470251;
        Fri, 03 Dec 2021 15:34:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o19sm1051377oiw.22.2021.12.03.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:29 -0800 (PST)
Received: (nullmailer pid 1043013 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Tomasz Figa <tfiga@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joerg Roedel <joro@8bytes.org>, yi.kuo@mediatek.com,
        anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        anthony.huang@mediatek.com, lc.kan@mediatek.com,
        srv_heupstream@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, youlin.pei@mediatek.com
In-Reply-To: <20211203064027.14993-2-yong.wu@mediatek.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com> <20211203064027.14993-2-yong.wu@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Correct the minItems of clk for larbs
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.281202.1043012.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 14:40:24 +0800, Yong Wu wrote:
> If a platform's larb support gals, there will be some larbs have a one
> more "gals" clock while the others still only need "apb"/"smi" clocks.
> then the minItems is 2 and the maxItems is 3.
> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1563127


larb@14016000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

larb@14017000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

larb@15001000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

larb@16010000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

larb@16010000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

larb@17010000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

