Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95358520B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 04:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiEJDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbiEJDDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:03:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6325C1C1942;
        Mon,  9 May 2022 19:59:43 -0700 (PDT)
X-UUID: 67b005a93e734020aee11b9840fc7204-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:5edfce57-5e5a-4737-8d9f-d898acc07003,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:33e532b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 67b005a93e734020aee11b9840fc7204-20220510
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2121007293; Tue, 10 May 2022 10:59:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 10:59:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 May 2022 10:59:36 +0800
Message-ID: <e8124721a4ecd591ffea2c4d70853c1f89c83975.camel@mediatek.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>, <cw00.choi@samsung.com>,
        <krzk+dt@kernel.org>, <robh+dt@kernel.org>,
        <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 10 May 2022 10:59:36 +0800
In-Reply-To: <94efefab-918d-2367-4b74-076dd6f23936@gmail.com>
References: <20220425125546.4129-1-johnson.wang@mediatek.com>
         <20220425125546.4129-2-johnson.wang@mediatek.com>
         <94efefab-918d-2367-4b74-076dd6f23936@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Mon, 2022-05-09 at 21:09 +0900, Chanwoo Choi wrote:
> Hi,
> 
> On 22. 4. 25. 21:55, Johnson Wang wrote:
> > Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > ---
> >   .../bindings/interconnect/mediatek,cci.yaml   | 139
> > ++++++++++++++++++
> >   1 file changed, 139 insertions(+)
> >   create mode 100644
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
> > https://urldefense.com/v3/__http://devicetree.org/schemas/interconnect/mediatek,cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!z6ogArqzuIzPR3TYO1aW-Z-scpuZJxIriWMofdfnvrKTXAYBBLZeitAPIKyZayMYZGsR$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!z6ogArqzuIzPR3TYO1aW-Z-scpuZJxIriWMofdfnvrKTXAYBBLZeitAPIKyZa9f2pALd$
> >  
> > +
> > +title: MediaTek Cache Coherent Interconnect (CCI) frequency and
> > voltage scaling
> > +
> > +maintainers:
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> Why did you add your author information?
> Please add your author information.

Sorry, I don't really understand what you mean.
Could you please explain your advice again?

The author of this driver is 'Jia-Wei Chang'.
We have added author information to the driver code and this binding
document as above.

> 
> And add this dt-binding information to MAINTAINERS
> as following: because I cannot catch the later patch
> of modification.
> 
> cwchoi00@chanwoo:~/kernel/linux.chanwoo$ d
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..a11e9c1947b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5698,6 +5698,7 @@ L:        linux-pm@vger.kernel.org
>   S:     Maintained
>   T:     git
> git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
>   F:     Documentation/devicetree/bindings/devfreq/
> +F:     Documentation/devicetree/bindings/interconnect/mediatek,cci.y
> aml
>   F:     drivers/devfreq/
>   F:     include/linux/devfreq.h
>   F:     include/trace/events/devfreq.h
> 

I will add it in the next version.

BRs,
Johnson Wang
> 
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
> > +      - description:
> > +          A parent of "cpu" clock which is used as an intermediate
> > clock source
> > +          when the original CPU is under transition and not stable
> > yet.
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
> 
> 

