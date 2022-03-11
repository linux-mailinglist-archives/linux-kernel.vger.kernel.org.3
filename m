Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF14D59B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiCKEjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiCKEjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:39:01 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3260CF1;
        Thu, 10 Mar 2022 20:37:55 -0800 (PST)
X-UUID: 7dd93f70c660491cbc92193446535ada-20220311
X-UUID: 7dd93f70c660491cbc92193446535ada-20220311
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1357477453; Fri, 11 Mar 2022 12:37:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Mar 2022 12:37:49 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 12:37:49 +0800
Message-ID: <f2b9e3ab13351af601253d8e8a7160a06b609760.camel@mediatek.com>
Subject: Re: [PATCH v2 01/15] dt-bindings: ARM: Mediatek: Add new document
 bindings of MT8186 clock
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Fri, 11 Mar 2022 12:37:49 +0800
In-Reply-To: <20220310234509.32636-1-miles.chen@mediatek.com>
References: <20220221015258.913-2-chun-jie.chen@mediatek.com>
         <20220310234509.32636-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 07:45 +0800, Miles Chen wrote:
> Hi Chun-Jie,
> 
> > [PATCH v2 01/15] dt-bindings: ARM: Mediatek: Add new document
> > bindings of MT8186 clock
> 
> s/Mediatek/MediaTek/
> 
> > This patch adds the new binding documentation for system clock
> > and functional clock on Mediatek MT8186.
> 
> s/Mediatek/MediaTek/
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
> > http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#
> > "
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Mediatek Functional Clock Controller for MT8186
> 
> s/Mediatek/MediaTek/
> 
> > +
> > +maintainers:
> > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +description:
> > +  The clock architecture in Mediatek like below
> 
> s/Mediatek/MediaTek/
> 
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
> > http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#
> > "
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Mediatek System Clock Controller for MT8186
> > 
> 
> s/Mediatek/MediaTek/
> 
> > +
> > +maintainers:
> > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > +
> > +description:
> > +  The clock architecture in Mediatek like below
> 
> s/Mediatek/MediaTek/
> 
> Thanks,
> Miles

Ok, I will check binding document and all patch messages in this
series.

Thanks!

