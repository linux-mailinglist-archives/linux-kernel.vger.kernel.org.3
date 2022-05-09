Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F251FC66
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiEIMSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiEIMSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:18:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1686C24DC0E;
        Mon,  9 May 2022 05:14:50 -0700 (PDT)
X-UUID: f275fa1f0dca4e9e94cd0b790f38b09c-20220509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1f2ad65d-5bd2-47ba-b63c-923c8f5161d7,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:b315c116-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: f275fa1f0dca4e9e94cd0b790f38b09c-20220509
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1362283811; Mon, 09 May 2022 20:14:46 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 9 May 2022 20:14:45 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 May 2022 20:14:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 9 May 2022 20:14:45 +0800
Message-ID: <a8e5fd9de1feece9051e1624c5cf3b672131a122.camel@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>, <krzk+dt@kernel.org>
CC:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <kyungmin.park@samsung.com>, <khilman@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 9 May 2022 20:14:44 +0800
In-Reply-To: <CAGXv+5HgyN+kp86M2GgFtbruXSAMSLxsh9vf8zVE5TxRMyTyaA@mail.gmail.com>
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
         <20220425125546.4129-2-johnson.wang@mediatek.com>
         <CAGXv+5HgyN+kp86M2GgFtbruXSAMSLxsh9vf8zVE5TxRMyTyaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

On Tue, 2022-04-26 at 11:18 +0800, Chen-Yu Tsai wrote:
> On Mon, Apr 25, 2022 at 8:56 PM Johnson Wang <
> johnson.wang@mediatek.com> wrote:
> > 
> > Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >  .../bindings/interconnect/mediatek,cci.yaml   | 139
> > ++++++++++++++++++
> >  1 file changed, 139 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > new file mode 100644
> > index 000000000000..e5221e17d11b
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > @@ -0,0 +1,139 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/interconnect/mediatek,cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDlQ9pSDO$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDoE9YHyu$
> >  
> > +
> > +title: MediaTek Cache Coherent Interconnect (CCI) frequency and
> > voltage scaling
> > +
> > +maintainers:
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > +
> > +description: |
> > +  MediaTek Cache Coherent Interconnect (CCI) is a hardware engine
> > used by
> > +  MT8183 and MT8186 SoCs to scale the frequency and adjust the
> > voltage in
> > +  hardware. It can also optimize the voltage to reduce the power
> > consumption.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8183-cci
> > +      - mediatek,mt8186-cci
> > +
> > +  clocks:
> > +    items:
> > +      - description:
> > +          The multiplexer for clock input of CPU cluster.
> 
> of the bus, not CPU cluster.

Thanks for your suggestion.
I will correct it in the next version.

> 
> > +      - description:
> > +          A parent of "cpu" clock which is used as an intermediate
> > clock source
> > +          when the original CPU is under transition and not stable
> > yet.
> 
> This really should be handled in the clk controller, and not by every
> device
> that happens to take a clock from a mux with upstream PLLs that can
> change
> in clock rate. The end device hardware only takes one clock input.
> That's it.
> 

To make this intermediate clock works properly, this driver is also
responsible for handling the Vproc voltage and ensures the voltage is
high enough to support intermediate clock rate.

If we move intermediate clock rate control to clock driver, then
intermediate voltage control may be handled by the clock driver itself
as well.

We believe that is not reasonable because clock driver shouldn't handle
voltage control. On the other hand, DVFS driver is more suitable for
doing this job.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: cci
> > +      - const: intermediate
> > +
> > +  operating-points-v2: true
> > +  opp-table: true
> > +
> > +  proc-supply:
> > +    description:
> > +      Phandle of the regulator for CCI that provides the supply
> > voltage.
> > +
> > +  sram-supply:
> > +    description:
> > +      Phandle of the regulator for sram of CCI that provides the
> > supply
> > +      voltage. When it presents, the cci devfreq driver needs to
> > do
> 
> When it is present, the implementation needs to ...
> 
> ChenYu

I will modify it in the next version.

BRs,
Johnson Wang

> 
> > +      "voltage tracking" to step by step scale up/down Vproc and
> > Vsram to fit
> > +      SoC specific needs. When absent, the voltage scaling flow is
> > handled by
> > +      hardware, hence no software "voltage tracking" is needed.
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - operating-points-v2
> > +  - proc-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8183-clk.h>
> > +    cci: cci {
> > +        compatible = "mediatek,mt8183-cci";
> > +        clocks = <&mcucfg CLK_MCU_BUS_SEL>,
> > +                 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
> > +        clock-names = "cci", "intermediate";
> > +        operating-points-v2 = <&cci_opp>;
> > +        proc-supply = <&mt6358_vproc12_reg>;
> > +    };
> > +
> > +    cci_opp: opp-table-cci {
> > +        compatible = "operating-points-v2";
> > +        opp-shared;
> > +        opp2_00: opp-273000000 {
> > +            opp-hz = /bits/ 64 <273000000>;
> > +            opp-microvolt = <650000>;
> > +        };
> > +        opp2_01: opp-338000000 {
> > +            opp-hz = /bits/ 64 <338000000>;
> > +            opp-microvolt = <687500>;
> > +        };
> > +        opp2_02: opp-403000000 {
> > +            opp-hz = /bits/ 64 <403000000>;
> > +            opp-microvolt = <718750>;
> > +        };
> > +        opp2_03: opp-463000000 {
> > +            opp-hz = /bits/ 64 <463000000>;
> > +            opp-microvolt = <756250>;
> > +        };
> > +        opp2_04: opp-546000000 {
> > +            opp-hz = /bits/ 64 <546000000>;
> > +            opp-microvolt = <800000>;
> > +        };
> > +        opp2_05: opp-624000000 {
> > +            opp-hz = /bits/ 64 <624000000>;
> > +            opp-microvolt = <818750>;
> > +        };
> > +        opp2_06: opp-689000000 {
> > +            opp-hz = /bits/ 64 <689000000>;
> > +            opp-microvolt = <850000>;
> > +        };
> > +        opp2_07: opp-767000000 {
> > +            opp-hz = /bits/ 64 <767000000>;
> > +            opp-microvolt = <868750>;
> > +        };
> > +        opp2_08: opp-845000000 {
> > +            opp-hz = /bits/ 64 <845000000>;
> > +            opp-microvolt = <893750>;
> > +        };
> > +        opp2_09: opp-871000000 {
> > +            opp-hz = /bits/ 64 <871000000>;
> > +            opp-microvolt = <906250>;
> > +        };
> > +        opp2_10: opp-923000000 {
> > +            opp-hz = /bits/ 64 <923000000>;
> > +            opp-microvolt = <931250>;
> > +        };
> > +        opp2_11: opp-962000000 {
> > +            opp-hz = /bits/ 64 <962000000>;
> > +            opp-microvolt = <943750>;
> > +        };
> > +        opp2_12: opp-1027000000 {
> > +            opp-hz = /bits/ 64 <1027000000>;
> > +            opp-microvolt = <975000>;
> > +        };
> > +        opp2_13: opp-1092000000 {
> > +            opp-hz = /bits/ 64 <1092000000>;
> > +            opp-microvolt = <1000000>;
> > +        };
> > +        opp2_14: opp-1144000000 {
> > +            opp-hz = /bits/ 64 <1144000000>;
> > +            opp-microvolt = <1025000>;
> > +        };
> > +        opp2_15: opp-1196000000 {
> > +            opp-hz = /bits/ 64 <1196000000>;
> > +            opp-microvolt = <1050000>;
> > +        };
> > +    };
> > --
> > 2.18.0
> > 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!zuufEcqpKbditY3eqLTHpL8P8humMCyh4D4QWsximmw124tJUPE3ZBUyBqBtDvdNpOFZ$
> >  

