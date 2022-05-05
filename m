Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9EC51B77D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbiEEFfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243694AbiEEFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:34:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD282528B;
        Wed,  4 May 2022 22:31:16 -0700 (PDT)
X-UUID: 81fd9384cec64eecb3f6899df0bc59be-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fb04e849-50f9-4aaf-8683-ae13266ff6c2,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:fb04e849-50f9-4aaf-8683-ae13266ff6c2,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:4d7a4216-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 81fd9384cec64eecb3f6899df0bc59be-20220505
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 919015993; Thu, 05 May 2022 13:31:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 13:31:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 13:31:11 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <robh@kernel.org>
CC:     <allen-kh.cheng@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <ikjn@chromium.org>, <krzk+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <matthias.bgg@kernel.org>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of mt8192 clock
Date:   Thu, 5 May 2022 13:31:11 +0800
Message-ID: <20220505053111.13924-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YnGjScfQA9axBYBO@robh.at.kernel.org>
References: <YnGjScfQA9axBYBO@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

>> From: Matthias Brugger <matthias.bgg@gmail.com>
>> 
>> The msdc gate is part of the MMC driver. Delete the binding description
>> of this node.
> 
>An ABI break is okay because ...?

Sorry for that, 

If the mediatek,mt8192-msdc part is removed from the driver, 
Is it ok to keep "mediatek,mt8192-msdc" in the binding document? or 
we should add '# deprecated' to "mediatek,mt8192-msdc" and keep the example.

e.g.,
          - mediatek,mt8192-msdc # deprecated


thanks,
Miles

> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> ---
> 
> Changes in v2:
> - Delete compatible in binding descprition as well
> 
>  .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml      | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> index c8c67c033f8c..b57cc2e69efb 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> @@ -24,7 +24,6 @@ properties:
>            - mediatek,mt8192-imp_iic_wrap_w
>            - mediatek,mt8192-imp_iic_wrap_n
>            - mediatek,mt8192-msdc_top
> -          - mediatek,mt8192-msdc
>            - mediatek,mt8192-mfgcfg
>            - mediatek,mt8192-imgsys
>            - mediatek,mt8192-imgsys2
> @@ -107,13 +106,6 @@ examples:
>          #clock-cells = <1>;
>      };
>  
> -  - |
> -    msdc: clock-controller@11f60000 {
> -        compatible = "mediatek,mt8192-msdc";
> -        reg = <0x11f60000 0x1000>;
> -        #clock-cells = <1>;
> -    };
> -
>    - |
>      mfgcfg: clock-controller@13fbf000 {
>          compatible = "mediatek,mt8192-mfgcfg";
> -- 
> 2.34.1
> 
> 

