Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A05003FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiDNCIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiDNCIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:08:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB973CA5F;
        Wed, 13 Apr 2022 19:06:28 -0700 (PDT)
X-UUID: 357038ec81ab4413802d677d5e90ae1a-20220414
X-UUID: 357038ec81ab4413802d677d5e90ae1a-20220414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 109818928; Thu, 14 Apr 2022 10:06:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Apr 2022 10:06:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 10:06:18 +0800
Message-ID: <a3ac398a3a0b815c5404af783ef62363664d15d0.camel@mediatek.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: Add DT schema for Arm Mali Valhall
 GPU
From:   Nick Fan <nick.fan@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Nick Fan =?UTF-8?Q?=28=E8=8C=83=E5=93=B2=E7=B6=AD=29?= 
        <Nick.Fan@mediatek.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 14 Apr 2022 10:06:17 +0800
In-Reply-To: <20210205220402.GA3824042@robh.at.kernel.org>
References: <20210128022342.6445-1-Nick.Fan@mediatek.com>
         <20210205220402.GA3824042@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-02-06 at 06:04 +0800, Rob Herring wrote:
> On Thu, Jan 28, 2021 at 10:23:41AM +0800, Nick Fan wrote:
> > Add devicetree schema for Arm Mali Valhall GPU
> > 
> > Define a compatible string for the Mali Valhall GPU
> > for Mediatek's SoC platform.
> > 
> > Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
> > ---
> >  .../bindings/gpu/arm,mali-valhall.yaml        | 217
> > ++++++++++++++++++
> >  1 file changed, 217 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-
> > valhall.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-
> > valhall.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-
> > valhall.yaml
> > new file mode 100644
> > index 000000000000..275c14ad173a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall.yaml
> > @@ -0,0 +1,217 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2020 MediaTek Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpu/arm,mali-valhall.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM Mali Valhall GPU
> > +
> > +maintainers:
> > +  - Rob Herring <robh@kernel.org>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^gpu@[a-f0-9]+$'
> > +
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mediatek,mt8192-mali
> > +      - const: arm,mali-valhall
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: GPU interrupt
> > +      - description: MMU interrupt
> > +      - description: Job interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: gpu
> > +      - const: mmu
> > +      - const: job
> 
> Please use the same order as midgard and bifrost.
This will fix in the next version v6.
With the same order as midgard and bifrost.
> 
> > +
> > +  clocks:
> > +    minItems: 1
> > +
> > +  power-domains:
> > +    minItems: 1
> > +    maxItems: 5
> > +
> > +  mali-supply: true
> > +  sram-supply: true
> > +
> > +  operating-points-v2: true
> > +  opp_table: true
> 
> opp-table
This will fix in the next version v6.
> 
> > +
> > +  "#cooling-cells":
> > +    const: 2
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: mediatek,mt8192-mali
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          minItems: 5
> > +          maxItems: 5
> > +
> > +        power-domain-names:
> > +          items:
> > +            - const: core0
> > +            - const: core1
> > +            - const: core2
> > +            - const: core3
> > +            - const: core4
> > +
> > +      required:
> > +        - sram-supply
> > +        - power-domains
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    gpu@13000000 {
> > +           compatible = "mediatek,mt8192-mali", "arm,mali-
> > valhall";
> 
> Do 4 space indent.
This will fix in the next version v6.
> 
> > +           reg = <0x13000000 0x4000>;
> > +           interrupts =
> > +                   <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
> > +                   <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
> > +                   <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>;
> > +           interrupt-names =
> > +                   "gpu",
> > +                   "mmu",
> > +                   "job";
> > +
> > +           clocks = <&mfgcfg 0>;
> > +
> > +           power-domains =
> > +                   <&spm 4>,
> > +                   <&spm 5>,
> > +                   <&spm 6>,
> > +                   <&spm 7>,
> > +                   <&spm 8>;
> > +
> > +           operating-points-v2 = <&gpu_opp_table>;
> > +           mali-supply = <&mt6315_7_vbuck1>;
> > +           sram-supply = <&mt6359_vsram_others_ldo_reg>;
> > +           gpu_opp_table: opp_table {
> > +             compatible = "operating-points-v2";
> 
> And then the same here.
This will fix in the next version v6.
> 
> > +             opp-shared;
> > +
> > +             opp-358000000 {
> > +                   opp-hz = /bits/ 64 <358000000>;
> > +                   opp-microvolt = <606250>,
> > +                                   <750000>;
> 
> Isn't this supposed to be either a single value or <min max nominal>?
I use single value.
It required two regulators for this platform.
So I separate them by angular brackets <>.
> 
> > +             };
> > +
> > +             opp-399000000 {
> > +                   opp-hz = /bits/ 64 <399000000>;
> > +                   opp-microvolt = <618750>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-440000000 {
> > +                   opp-hz = /bits/ 64 <440000000>;
> > +                   opp-microvolt = <631250>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-482000000 {
> > +                   opp-hz = /bits/ 64 <482000000>;
> > +                   opp-microvolt = <643750>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-523000000 {
> > +                   opp-hz = /bits/ 64 <523000000>;
> > +                   opp-microvolt = <656250>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-564000000 {
> > +                   opp-hz = /bits/ 64 <564000000>;
> > +                   opp-microvolt = <668750>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-605000000 {
> > +                   opp-hz = /bits/ 64 <605000000>;
> > +                   opp-microvolt = <681250>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-647000000 {
> > +                   opp-hz = /bits/ 64 <647000000>;
> > +                   opp-microvolt = <693750>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-688000000 {
> > +                   opp-hz = /bits/ 64 <688000000>;
> > +                   opp-microvolt = <706250>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-724000000 {
> > +                   opp-hz = /bits/ 64 <724000000>;
> > +                   opp-microvolt = <725000>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-760000000 {
> > +                   opp-hz = /bits/ 64 <760000000>;
> > +                   opp-microvolt = <743750>,
> > +                                   <750000>;
> > +             };
> > +
> > +             opp-795000000 {
> > +                   opp-hz = /bits/ 64 <795000000>;
> > +                   opp-microvolt = <762500>,
> > +                                   <762500>;
> > +             };
> > +
> > +             opp-831000000 {
> > +                   opp-hz = /bits/ 64 <831000000>;
> > +                   opp-microvolt = <781250>,
> > +                                   <781250>;
> > +             };
> > +
> > +             opp-855000000 {
> > +                   opp-hz = /bits/ 64 <855000000>;
> > +                   opp-microvolt = <793750>,
> > +                                   <793750>;
> > +             };
> > +
> > +             opp-902000000 {
> > +                   opp-hz = /bits/ 64 <902000000>;
> > +                   opp-microvolt = <818750>,
> > +                                   <818750>;
> > +             };
> > +
> > +             opp-950000000 {
> > +                   opp-hz = /bits/ 64 <950000000>;
> > +                   opp-microvolt = <843750>,
> > +                                   <843750>;
> > +             };
> > +          };
> > +    };
> > +...
> > --
> > 2.18.0
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

