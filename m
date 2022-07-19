Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0A57951B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiGSIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiGSIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:17:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F2724F18;
        Tue, 19 Jul 2022 01:17:25 -0700 (PDT)
X-UUID: d21d494d581d44cd925db6dcf01ec486-20220719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:4fd9f2e5-67de-4d5d-8288-37defb56e580,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:768fae64-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d21d494d581d44cd925db6dcf01ec486-20220719
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1610973080; Tue, 19 Jul 2022 16:17:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 19 Jul 2022 16:17:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 19 Jul 2022 16:17:16 +0800
Message-ID: <c4480c9ea0822ae693ff6a501c073c365e983b83.camel@mediatek.com>
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 19 Jul 2022 16:17:16 +0800
In-Reply-To: <46df4ad5-5102-b5fe-95b7-5b157fb28f01@linaro.org>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
         <20220714122837.20094-4-tinghan.shen@mediatek.com>
         <46df4ad5-5102-b5fe-95b7-5b157fb28f01@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, 2022-07-15 at 09:57 +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 14:28, Tinghan Shen wrote:
> > The System Control Processor System (SCPSYS) has several power
> > management related tasks in the system. Add the bindings for it.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../bindings/mfd/mediatek,scpsys.yaml         | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> > b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> > new file mode 100644
> > index 000000000000..a8b9220f2f27
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml*__;Iw!!CTRNKA9wMg0ARbw!1TUl-dhD0p8qh3rYVk8RtfoKEP88jg8OADMd19qP6siBCQHhFnHWCgsyUqiETyBzxw8$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!1TUl-dhD0p8qh3rYVk8RtfoKEP88jg8OADMd19qP6siBCQHhFnHWCgsyUqiEJQmakAI$
> >  
> > +
> > +title: MediaTek System Control Processor System
> > +
> > +maintainers:
> > +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> > +
> > +description:
> > +  MediaTek System Control Processor System (SCPSYS) has several
> > +  power management tasks. The tasks include MTCMOS power
> > +  domain control, thermal measurement, DVFS, etc.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mediatek,scpsys
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  power-controller:
> > +    $ref: /schemas/power/mediatek,power-controller.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/mt8195-clk.h>
> > +    #include <dt-bindings/power/mt8195-power.h>
> > +
> > +    syscon@10006000 {
> > +        compatible = "mediatek,scpsys", "syscon", "simple-mfd";
> 
> This should be a SoC-specific compatible (and filename).

Ok. I think that you mean "mediatek,mt8195-scpsys".
I'll update it in next version.

> 
> > +        reg = <0x10006000 0x100>;
> > +
> > +        spm: power-controller {
> 
> I think you created before less-portable, quite constrained bindings for
> power controller. You now require that mt8195-power-controller is always
> a child of some parent device which will share its regmap/MMIO with it.
> 
> And what if in your next block there is no scpsys block and power
> controller is the scpsys alone? It's not possible with your bindings.

Do you mean a power controller node that looks like this?

scpsys: power-controller@10006000 {
	compatible = "mediatek,mt6797-scpsys";
	#power-domain-cells = <1>;

	// ...
};

> 
> Wouldn't it be better to assign some address space to the
> power-controller (now as an offset from scpsys)?

Is this mean adding an offset after the node name?

spm: power-controller@0 {
                     ^^

> 
> This is just wondering (Rockchip did the same...) and not a blocker as
> power-controller bindings are done.
> 
> Best regards,
> Krzysztof


Thanks,
TingHan


