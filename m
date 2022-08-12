Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD45909EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiHLBfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHLBfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:35:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572F6B15F;
        Thu, 11 Aug 2022 18:35:43 -0700 (PDT)
X-UUID: b5c82b653aa549a085b2ea9ca5475d72-20220812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PxupfsVphqPVa0RY6efwWYlYVX+cYj7uOfUMBxITsNM=;
        b=rWTs2A2zs1X6D9ljMtdKPRRAK/OqJFBRGd0RzmGfppYyOpY5fTKl2Q8yu1G2Gteqrajwr7Z6JQe9goqXjwjvOgQpok2vZY3Oh7ZwokDdb7L5jl5fV7rjs9VYSWblQpZGUoit7fchwlL+Pl7dWtXQVPcJxwUoozUi//xDo4BI8CQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:e41dc6ea-8ffd-4bc5-aefd-b507316bfd65,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:-5
X-CID-META: VersionHash:3d8acc9,CLOUDID:038394ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b5c82b653aa549a085b2ea9ca5475d72-20220812
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <garmin.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 577985942; Fri, 12 Aug 2022 09:35:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 12 Aug 2022 09:35:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 12 Aug 2022 09:35:37 +0800
Message-ID: <fd8927ad972a0cde4899adf9ccafabdb4c7852d9.camel@mediatek.com>
Subject: Re: [PATCH 01/18] dt-bindings: ARM: MediaTek: Add new document
 bindings of MT8188 clock
From:   Garmin Chang <garmin.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Aug 2022 09:35:37 +0800
In-Reply-To: <e982588a-12bd-7ce6-91f4-e354ac5bec60@linaro.org>
References: <20220729082457.22253-1-Garmin.Chang@mediatek.com>
         <20220729082457.22253-2-Garmin.Chang@mediatek.com>
         <e982588a-12bd-7ce6-91f4-e354ac5bec60@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof


Thank you for your comments, I will revise it in the next edition.


Thanks,
Best regards,
Garmin

On Tue, 2022-08-02 at 09:31 +0200, Krzysztof Kozlowski wrote:
> On 29/07/2022 10:24, Garmin.Chang wrote:
> > Add the new binding documentation for system clock
> > and functional clock on MediaTek MT8188.
> > 
> > Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> > ---
> >  .../arm/mediatek/mediatek,mt8188-clock.yaml   | 230 ++++++
> >  .../mediatek/mediatek,mt8188-sys-clock.yaml   |  75 ++
> >  include/dt-bindings/clock/mt8188-clk.h        | 759
> > ++++++++++++++++++
> >  3 files changed, 1064 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > clock.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-sys-
> > clock.yaml
> >  create mode 100644 include/dt-bindings/clock/mt8188-clk.h
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > clock.yaml
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > clock.yaml
> > new file mode 100644
> > index 000000000000..b03745fe971a
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > clock.yaml
> > @@ -0,0 +1,230 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "
> > https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8188-clock.yaml*__;Iw!!CTRNKA9wMg0ARbw!ydPMfABiSHOE2O88pjxcZhMrkJ-Scd1BPzPWaC6BmRz3-mjqJZxOOr8G8cl2alHGbUg$
> >  "
> > +$schema: "
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!ydPMfABiSHOE2O88pjxcZhMrkJ-Scd1BPzPWaC6BmRz3-mjqJZxOOr8G8cl2tjHoC30$
> >  "
> 
> No need for quotes.
> 
> > +
> > +title: MediaTek Functional Clock Controller for MT8188
> > +
> > +maintainers:
> > +  - Garmin Chang <garmin.chang@mediatek.com>
> > +
> > +description: |
> > +  The clock architecture in MediaTek like below
> > +  PLLs -->
> > +          dividers -->
> > +                      muxes
> > +                           -->
> > +                              clock gate
> > +
> > +  The devices provide clock gate control in different IP blocks.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> 
> You have just one item, so no "items".
> 
> > +      - enum:
> > +          - mediatek,mt8188-imp_iic_wrap_c
> > +          - mediatek,mt8188-imp_iic_wrap_en
> > +          - mediatek,mt8188-imp_iic_wrap_w
> > +          - mediatek,mt8188-mfgcfg
> > +          - mediatek,mt8188-vppsys0
> > +          - mediatek,mt8188-wpesys
> > +          - mediatek,mt8188-wpesys_vpp0
> > +          - mediatek,mt8188-vppsys1
> > +          - mediatek,mt8188-imgsys
> > +          - mediatek,mt8188-imgsys_wpe1
> > +          - mediatek,mt8188-imgsys_wpe2
> > +          - mediatek,mt8188-imgsys_wpe3
> > +          - mediatek,mt8188-imgsys1_dip_top
> > +          - mediatek,mt8188-imgsys1_dip_nr
> > +          - mediatek,mt8188-ipesys
> > +          - mediatek,mt8188-camsys
> > +          - mediatek,mt8188-camsys_rawa
> > +          - mediatek,mt8188-camsys_yuva
> > +          - mediatek,mt8188-camsys_rawb
> > +          - mediatek,mt8188-camsys_yuvb
> > +          - mediatek,mt8188-ccusys
> > +          - mediatek,mt8188-vdecsys_soc
> > +          - mediatek,mt8188-vdecsys
> > +          - mediatek,mt8188-vencsys
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> 
> clock-cells should be required as well.
> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    imp_iic_wrap_c: clock-controller@11283000 {
> > +        compatible = "mediatek,mt8188-imp_iic_wrap_c";
> > +        reg = <0x11283000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> 
> 
> Only one example is enough. All others are exactly the same.
> 
> > +
> > +  - |
> > +    imp_iic_wrap_en: clock-controller@11ec2000 {
> > +        compatible = "mediatek,mt8188-imp_iic_wrap_en";
> > +        reg = <0x11ec2000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> 
> 
> > +
> > +  - |
> > +    imp_iic_wrap_w: clock-controller@11e02000 {
> > +        compatible = "mediatek,mt8188-imp_iic_wrap_w";
> > +        reg = <0x11e02000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    mfgcfg: clock-controller@13fbf000 {
> > +        compatible = "mediatek,mt8188-mfgcfg";
> > +        reg = <0x13fbf000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    vppsys0: clock-controller@14000000 {
> > +        compatible = "mediatek,mt8188-vppsys0";
> > +        reg = <0x14000000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    wpesys: clock-controller@14e00000 {
> > +        compatible = "mediatek,mt8188-wpesys";
> > +        reg = <0x14e00000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    wpesys_vpp0: clock-controller@14e02000 {
> > +        compatible = "mediatek,mt8188-wpesys_vpp0";
> > +        reg = <0x14e02000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    vppsys1: clock-controller@14f00000 {
> > +        compatible = "mediatek,mt8188-vppsys1";
> > +        reg = <0x14f00000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    imgsys: clock-controller@15000000 {
> > +        compatible = "mediatek,mt8188-imgsys";
> > +        reg = <0x15000000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    imgsys_wpe1: clock-controller@15220000 {
> > +        compatible = "mediatek,mt8188-imgsys_wpe1";
> > +        reg = <0x15220000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    imgsys_wpe2: clock-controller@15520000 {
> > +        compatible = "mediatek,mt8188-imgsys_wpe2";
> > +        reg = <0x15520000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    imgsys_wpe3: clock-controller@15620000 {
> > +        compatible = "mediatek,mt8188-imgsys_wpe3";
> > +        reg = <0x15620000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    imgsys1_dip_top: clock-controller@15110000 {
> > +        compatible = "mediatek,mt8188-imgsys1_dip_top";
> > +        reg = <0x15110000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    imgsys1_dip_nr: clock-controller@15130000 {
> > +        compatible = "mediatek,mt8188-imgsys1_dip_nr";
> > +        reg = <0x15130000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    ipesys: clock-controller@15330000 {
> > +        compatible = "mediatek,mt8188-ipesys";
> > +        reg = <0x15330000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    camsys: clock-controller@16000000 {
> > +        compatible = "mediatek,mt8188-camsys";
> > +        reg = <0x16000000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    camsys_rawa: clock-controller@1604f000 {
> > +        compatible = "mediatek,mt8188-camsys_rawa";
> > +        reg = <0x1604f000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    camsys_yuva: clock-controller@1606f000 {
> > +        compatible = "mediatek,mt8188-camsys_yuva";
> > +        reg = <0x1606f000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    camsys_rawb: clock-controller@1608f000 {
> > +        compatible = "mediatek,mt8188-camsys_rawb";
> > +        reg = <0x1608f000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    camsys_yuvb: clock-controller@160af000 {
> > +        compatible = "mediatek,mt8188-camsys_yuvb";
> > +        reg = <0x160af000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    ccusys: clock-controller@17200000 {
> > +        compatible = "mediatek,mt8188-ccusys";
> > +        reg = <0x17200000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    vdecsys_soc: clock-controller@1800f000 {
> > +        compatible = "mediatek,mt8188-vdecsys_soc";
> > +        reg = <0x1800f000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    vdecsys: clock-controller@1802f000 {
> > +        compatible = "mediatek,mt8188-vdecsys";
> > +        reg = <0x1802f000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    vencsys: clock-controller@1a000000 {
> > +        compatible = "mediatek,mt8188-vencsys";
> > +        reg = <0x1a000000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > +
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > sys-clock.yaml
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > sys-clock.yaml
> > new file mode 100644
> > index 000000000000..b97cad03241c
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8188-
> > sys-clock.yaml
> > @@ -0,0 +1,75 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "
> > https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8188-sys-clock.yaml*__;Iw!!CTRNKA9wMg0ARbw!ydPMfABiSHOE2O88pjxcZhMrkJ-Scd1BPzPWaC6BmRz3-mjqJZxOOr8G8cl21roH3SU$
> >  "
> > +$schema: "
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!ydPMfABiSHOE2O88pjxcZhMrkJ-Scd1BPzPWaC6BmRz3-mjqJZxOOr8G8cl2tjHoC30$
> >  "
> 
> All previous comments apply here and further as well.
> 
> (...)
> 
> > diff --git a/include/dt-bindings/clock/mt8188-clk.h b/include/dt-
> > bindings/clock/mt8188-clk.h
> > new file mode 100644
> > index 000000000000..bd1f21bd6584
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/mt8188-clk.h
> 
> Filename with vendor prefix, so "mediatek,mt8188-clk.h"
> 
> 
> Best regards,
> Krzysztof

