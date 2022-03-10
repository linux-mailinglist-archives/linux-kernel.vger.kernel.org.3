Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4AF4D4823
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242457AbiCJNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbiCJNhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:37:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623D14E958;
        Thu, 10 Mar 2022 05:36:34 -0800 (PST)
X-UUID: bea02a7fddde472dbc27cfea5490503d-20220310
X-UUID: bea02a7fddde472dbc27cfea5490503d-20220310
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 265800282; Thu, 10 Mar 2022 21:36:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 10 Mar 2022 21:36:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 21:36:27 +0800
Message-ID: <d80c89fd5fb704ed03244a7e333d59d0ee972e8f.camel@mediatek.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: ARM: Mediatek: Add new document
 bindings of MT8186 clock
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 10 Mar 2022 21:36:27 +0800
In-Reply-To: <YhkmnnIApvU7gRlZ@robh.at.kernel.org>
References: <20220221015258.913-1-chun-jie.chen@mediatek.com>
         <20220221015258.913-2-chun-jie.chen@mediatek.com>
         <YhkmnnIApvU7gRlZ@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-25 at 12:57 -0600, Rob Herring wrote:
> On Mon, Feb 21, 2022 at 09:52:44AM +0800, Chun-Jie Chen wrote:
> > This patch adds the new binding documentation for system clock
> > and functional clock on Mediatek MT8186.
> > 
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > ---
> >  .../arm/mediatek/mediatek,mt8186-clock.yaml   |  56 +++
> >  .../mediatek/mediatek,mt8186-sys-clock.yaml   |  54 +++
> >  include/dt-bindings/clock/mt8186-clk.h        | 445
> > ++++++++++++++++++
> >  3 files changed, 555 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > clock.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-
> > clock.yaml
> >  create mode 100644 include/dt-bindings/clock/mt8186-clk.h
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > clock.yaml
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > clock.yaml
> > new file mode 100644
> > index 000000000000..373e8a100da3
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > clock.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "
> > https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml*__;Iw!!CTRNKA9wMg0ARbw!xKDeg6ddrFWd8p__fZiG7r5F5Py9NVWCmi7zVue5fUzuxKtvqHCSu_pslcpXRWfJmMCT$
> >  "
> > +$schema: "
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xKDeg6ddrFWd8p__fZiG7r5F5Py9NVWCmi7zVue5fUzuxKtvqHCSu_pslcpXRfM3OA21$
> >  "
> > +
> > +title: Mediatek Functional Clock Controller for MT8186
> > +
> > +maintainers:
> > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +description:
> 
> You need a '|' to preserve the formatting.
> 
> > +  The clock architecture in Mediatek like below
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
> > +      - enum:
> > +          - mediatek,mt8186-imp_iic_wrap
> > +          - mediatek,mt8186-mfgsys
> > +          - mediatek,mt8186-wpesys
> > +          - mediatek,mt8186-imgsys1
> > +          - mediatek,mt8186-imgsys2
> > +          - mediatek,mt8186-vdecsys
> > +          - mediatek,mt8186-vencsys
> > +          - mediatek,mt8186-camsys
> > +          - mediatek,mt8186-camsys_rawa
> > +          - mediatek,mt8186-camsys_rawb
> > +          - mediatek,mt8186-mdpsys
> > +          - mediatek,mt8186-ipesys
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    imp_iic_wrap: clock-controller@11017000 {
> > +        compatible = "mediatek,mt8186-imp_iic_wrap";
> > +        reg = <0x11017000 0x1000>;
> > +        #clock-cells = <1>;
> > +    };
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > sys-clock.yaml
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > sys-clock.yaml
> > new file mode 100644
> > index 000000000000..4c071dd66b76
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > sys-clock.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "
> > https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml*__;Iw!!CTRNKA9wMg0ARbw!xKDeg6ddrFWd8p__fZiG7r5F5Py9NVWCmi7zVue5fUzuxKtvqHCSu_pslcpXRRtmGvUx$
> >  "
> > +$schema: "
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xKDeg6ddrFWd8p__fZiG7r5F5Py9NVWCmi7zVue5fUzuxKtvqHCSu_pslcpXRfM3OA21$
> >  "
> > +
> > +title: Mediatek System Clock Controller for MT8186
> > +
> > +maintainers:
> > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +description:
> 
> And here.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Ok, I will fix it in next version.

Thanks!

> > +  The clock architecture in Mediatek like below
> > +  PLLs -->
> > +          dividers -->
> > +                      muxes
> > +                           -->
> > +                              clock gate
> > +
> > +  The apmixedsys provides most of PLLs which generated from SoC
> > 26m.
> > +  The topckgen provides dividers and muxes which provide the clock
> > source to other IP blocks.
> > +  The infracfg_ao provides clock gate in peripheral and
> > infrastructure IP blocks.
> > +  The mcusys provides mux control to select the clock source in AP
> > MCU.
> > +  The device nodes also provide the system control capacity for
> > configuration.

