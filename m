Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA54B6929
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiBOKYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:24:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiBOKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:24:18 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEA22B3D;
        Tue, 15 Feb 2022 02:24:03 -0800 (PST)
X-UUID: 516bda6b62b445118af49fcb6b8d6d3d-20220215
X-UUID: 516bda6b62b445118af49fcb6b8d6d3d-20220215
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2077768483; Tue, 15 Feb 2022 18:23:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 18:23:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 18:23:57 +0800
Message-ID: <52212d3177dd6609129388f95c0c5b415b9918a8.camel@mediatek.com>
Subject: Re: [v1 01/16] dt-bindings: ARM: Mediatek: Add new document
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
Date:   Tue, 15 Feb 2022 18:23:57 +0800
In-Reply-To: <0900d6de780557023c676431173bfc4493fe03b0.camel@mediatek.com>
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
         <20220110134416.5191-2-chun-jie.chen@mediatek.com>
         <YetPCgSSRiWpDtcc@robh.at.kernel.org>
         <0900d6de780557023c676431173bfc4493fe03b0.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-09 at 09:40 +0800, Chun-Jie Chen wrote:
> On Fri, 2022-01-21 at 18:25 -0600, Rob Herring wrote:
> > On Mon, Jan 10, 2022 at 09:44:01PM +0800, Chun-Jie Chen wrote:
> > > This patch adds the new binding documentation for system clock
> > > and functional clock on Mediatek MT8186.
> > > 
> > > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > ---
> > >  .../arm/mediatek/mediatek,mt8186-clock.yaml   | 133
> > > ++++++++++++++++++
> > >  .../mediatek/mediatek,mt8186-sys-clock.yaml   |  74 ++++++++++
> > >  2 files changed, 207 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > clock.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > sys-
> > > clock.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > clock.yaml
> > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > clock.yaml
> > > new file mode 100644
> > > index 000000000000..fc39101bc9b0
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > clock.yaml
> > > @@ -0,0 +1,133 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "
> > > 
https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml*__;Iw!!CTRNKA9wMg0ARbw!3pIyNVU0grMb7zKVQZoRO2z-eKrg6FnGcieEON8cCw84G6_W7Tt4GEFwytcYEXyrcj6e$
> > >  "
> > > +$schema: "
> > > 
https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3pIyNVU0grMb7zKVQZoRO2z-eKrg6FnGcieEON8cCw84G6_W7Tt4GEFwytcYEUOCCW1i$
> > >  "
> > > +
> > > +title: Mediatek Functional Clock Controller for MT8186
> > > +
> > > +maintainers:
> > > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > +
> > > +description:
> > > +  The clock architecture in Mediatek like below
> > > +  PLLs -->
> > > +          dividers -->
> > > +                      muxes
> > > +                           -->
> > > +                              clock gate
> > > +
> > > +  The devices provide clock gate control in different IP blocks.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - mediatek,mt8186-imp_iic_wrap
> > > +          - mediatek,mt8186-mfgsys
> > > +          - mediatek,mt8186-wpesys
> > > +          - mediatek,mt8186-imgsys1
> > > +          - mediatek,mt8186-imgsys2
> > > +          - mediatek,mt8186-vdecsys
> > > +          - mediatek,mt8186-vencsys
> > > +          - mediatek,mt8186-camsys
> > > +          - mediatek,mt8186-camsys_rawa
> > > +          - mediatek,mt8186-camsys_rawb
> > > +          - mediatek,mt8186-mdpsys
> > > +          - mediatek,mt8186-ipesys
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    imp_iic_wrap: clock-controller@11017000 {
> > > +        compatible = "mediatek,mt8186-imp_iic_wrap";
> > > +        reg = <0x11017000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    mfgsys: clock-controller@13000000 {
> > > +        compatible = "mediatek,mt8186-mfgsys";
> > > +        reg = <0x13000000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    wpesys: clock-controller@14020000 {
> > > +        compatible = "mediatek,mt8186-wpesys";
> > > +        reg = <0x14020000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    imgsys1: clock-controller@15020000 {
> > > +        compatible = "mediatek,mt8186-imgsys1";
> > > +        reg = <0x15020000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    imgsys2: clock-controller@15820000 {
> > > +        compatible = "mediatek,mt8186-imgsys2";
> > > +        reg = <0x15820000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    vdecsys: clock-controller@1602f000 {
> > > +        compatible = "mediatek,mt8186-vdecsys";
> > > +        reg = <0x1602f000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    vencsys: clock-controller@17000000 {
> > > +        compatible = "mediatek,mt8186-vencsys";
> > > +        reg = <0x17000000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    camsys: clock-controller@1a000000 {
> > > +        compatible = "mediatek,mt8186-camsys";
> > > +        reg = <0x1a000000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    camsys_rawa: clock-controller@1a04f000 {
> > > +        compatible = "mediatek,mt8186-camsys_rawa";
> > > +        reg = <0x1a04f000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    camsys_rawb: clock-controller@1a06f000 {
> > > +        compatible = "mediatek,mt8186-camsys_rawb";
> > > +        reg = <0x1a06f000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    mdpsys: clock-controller@1b000000 {
> > > +        compatible = "mediatek,mt8186-mdpsys";
> > > +        reg = <0x1b000000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    ipesys: clock-controller@1c000000 {
> > > +        compatible = "mediatek,mt8186-ipesys";
> > > +        reg = <0x1c000000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > 
> > There's little point in enumerating every possible compatible. 1
> > example 
> > is more than enough.
> > 
> > 
> 
> Ok, I will fix it in next patch.
> 
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > sys-clock.yaml
> > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > sys-clock.yaml
> > > new file mode 100644
> > > index 000000000000..11473971a165
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-
> > > sys-clock.yaml
> > > @@ -0,0 +1,74 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "
> > > 
https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml*__;Iw!!CTRNKA9wMg0ARbw!3pIyNVU0grMb7zKVQZoRO2z-eKrg6FnGcieEON8cCw84G6_W7Tt4GEFwytcYERailYtq$
> > >  "
> > > +$schema: "
> > > 
https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3pIyNVU0grMb7zKVQZoRO2z-eKrg6FnGcieEON8cCw84G6_W7Tt4GEFwytcYEUOCCW1i$
> > >  "
> > > +
> > > +title: Mediatek System Clock Controller for MT8186
> > > +
> > > +maintainers:
> > > +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > > +
> > > +description:
> > > +  The clock architecture in Mediatek like below
> > > +  PLLs -->
> > > +          dividers -->
> > > +                      muxes
> > > +                           -->
> > > +                              clock gate
> > > +
> > > +  The apmixedsys provides most of PLLs which generated from SoC
> > > 26m.
> > > +  The topckgen provides dividers and muxes which provide the
> > > clock
> > > source to other IP blocks.
> > > +  The infracfg_ao provides clock gate in peripheral and
> > > infrastructure IP blocks.
> > > +  The mcusys provides mux control to select the clock source in
> > > AP
> > > MCU.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - mediatek,mt8186-mcusys
> > > +          - mediatek,mt8186-topckgen
> > > +          - mediatek,mt8186-infracfg_ao
> > > +          - mediatek,mt8186-apmixedsys
> > > +      - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    mcusys: syscon@c53a000 {
> > 
> > clock-controller@...
> > 
> > Drop unused labels.
> > 
> 
> Ok, I will change to pure clock-controller
> 
> Thanks!
> Best Regards,
> Chun-Jie
> 

Please skip the reply above.

The devices in this binding document also support system configuration
not only pure clock provider, so make them as "syscon".

Thanks!
Best Regards,
Chun-Jie

> > > +        compatible = "mediatek,mt8186-mcusys", "syscon";
> > > +        reg = <0xc53a000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    topckgen: syscon@10000000 {
> > > +        compatible = "mediatek,mt8186-topckgen", "syscon";
> > > +        reg = <0x10000000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    infracfg_ao: syscon@10001000 {
> > > +        compatible = "mediatek,mt8186-infracfg_ao", "syscon";
> > > +        reg = <0x10001000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    apmixedsys: syscon@1000c000 {
> > > +        compatible = "mediatek,mt8186-apmixedsys", "syscon";
> > > +        reg = <0x1000c000 0x1000>;
> > > +        #clock-cells = <1>;
> > > +    };
> > 
> > Again, 1 example is enough.

