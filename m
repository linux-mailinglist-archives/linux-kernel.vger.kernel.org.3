Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4BD4E62F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349950AbiCXMM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349954AbiCXMMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:12:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15DA8891;
        Thu, 24 Mar 2022 05:11:15 -0700 (PDT)
X-UUID: 207443c495114ac884bd24a5c9e6cbfc-20220324
X-UUID: 207443c495114ac884bd24a5c9e6cbfc-20220324
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 88857433; Thu, 24 Mar 2022 20:11:09 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 20:11:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Mar
 2022 20:11:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 20:11:08 +0800
Message-ID: <13482b1b4244df5c0c0a4d6a60cdb2a7ba88500a.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: devfreq: mediatek: add mtk cci devfreq
 dt-bindings
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Thu, 24 Mar 2022 20:11:08 +0800
In-Reply-To: <bf418e08-2e32-5e61-abd8-abb0d8f5c080@canonical.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
         <20220307122513.11822-2-jia-wei.chang@mediatek.com>
         <bf418e08-2e32-5e61-abd8-abb0d8f5c080@canonical.com>
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

Dear Krzysztof,

Thanks for your comments.
Pardon me for my late reply.

On Mon, 2022-03-07 at 22:42 +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 13:25, Tim Chang wrote:
> > add devicetree binding of mtk cci devfreq on MediaTek SoC.
> 
> Start with capital letter.

Sure, I will update it for the whole series in next version.

> 
> > 
> > Signed-off-by: Jia-Wei Chang <
> > jia-wei.chang@mediatek.corp-partner.google.com>
> 
> This does not match your From. Please fix this in all your
> submissions.

Sure, I will update it for the whole series in next version.

> 
> > ---
> >  .../devicetree/bindings/devfreq/mtk-cci.yaml  | 73
> > +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/devfreq/mtk-
> > cci.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml 
> > b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> > new file mode 100644
> > index 000000000000..e64ac4c56758
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/mtk-cci.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/devfreq/mtk-cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!2apx_16V_XMrl28ae1aDO3-2WFga3xJiACU_40mgGydrumBmFuHcQFpW_LnX6DHny5Zpig$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!2apx_16V_XMrl28ae1aDO3-2WFga3xJiACU_40mgGydrumBmFuHcQFpW_LnX6DEPqkDN4g$
> >  
> > +
> > +title: Mediatek Cache Coherent Interconnect (CCI) Devfreq driver
> > Device Tree Bindings
> 
> Similarly to your other patches - the title describes hardware.
> Please
> fix it in all your submissions of all your series.

Sure, I will fix them in the next version.

> 
> Remove "driver Device Tree Bindings". "Devfreq" is Linuxism, so this
> maybe "bus frequency scaling"? Although later you call the device
> node
> as cci.

Should I use "Binding for MediaTek's Cache Coherent Interconnect (CCI)
frequency and voltage scaling" as new title?

> 
> > +
> > +maintainers:
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > +
> > +description: |
> > +  This module is used to create CCI DEVFREQ.
> > +  The performance will depend on both CCI frequency and CPU
> > frequency.
> > +  For MT8186, CCI co-buck with Little core.
> > +  Contain CCI opp table for voltage and frequency scaling.
> 
> Half of this description (first and last sentence) does not describe
> the
> actual hardware. Please describe hardware, not driver.

Sure, I will fix it in the next version.

> 
> > +
> > +properties:
> > +  compatible:
> > +    const: "mediatek,mt8186-cci"
> 
> No need for quotes.

Sure, I will fix it in the next version.

> 
> > +
> > +  clocks:
> > +    items:
> > +      - description:
> > +          The first one is the multiplexer for clock input of CPU
> > cluster.
> > +      - description:
> > +          The other is used as an intermediate clock source when
> > the original
> > +          CPU is under transition and not stable yet.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: "cci"
> > +      - const: "intermediate"
> 
> No need for quotes.

Sure, I will fix it in the next version.

> 
> > +
> > +  operating-points-v2:
> > +    description:
> > +      For details, please refer to
> > +      Documentation/devicetree/bindings/opp/opp-v2.yaml
> > +
> > +  opp-table: true
> 
> Same comments as your CPU freq bindings apply.

mtk-cci-devfreq is a new driver and its arch is same as mediatek-
cpufreq so that the properties of mtk-cci are refer to mediatek-cpufreq 
bindings.
operating-point-v2 is used to determine the voltage and frequency of
dvfs which is further utilized by mtk-cci-devfreq.

> 
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
> > +      voltage. When present, the cci devfreq driver needs to do
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
> > +    #include <dt-bindings/clock/mt8186-clk.h>
> > +    cci: cci {
> 
> Node names should be generic and describe type of device. Are you
> sure
> this is a CCI? Maybe "interconnect" suits it better?

Yes, this is a CCI and it is generic type of device like CPU in my
opinion.
If my understanding is correct, CCI is more suitable.

> 
> > +      compatible = "mediatek,mt8186-cci";
> > +      clocks = <&mcusys CLK_MCU_ARMPLL_BUS_SEL>, <&apmixedsys
> > CLK_APMIXED_MAINPLL>;
> > +      clock-names = "cci", "intermediate";
> > +      operating-points-v2 = <&cci_opp>;
> > +      proc-supply = <&mt6358_vproc12_reg>;
> > +      sram-supply = <&mt6358_vsram_proc12_reg>;
> > +    };
> 
> 
> Best regards,
> Krzysztof

