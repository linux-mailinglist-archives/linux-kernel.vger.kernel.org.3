Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447AD53B376
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiFBGWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiFBGWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:22:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043A2873F;
        Wed,  1 Jun 2022 23:22:34 -0700 (PDT)
X-UUID: 0b8bf9b9aa0c49ff88bad3bf8e12a3a2-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:193bdc81-635f-4c1e-bc32-7e35d6db20d2,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:2a19b09,CLOUDID:b5a10615-b515-4766-a72d-4514488fe823,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 0b8bf9b9aa0c49ff88bad3bf8e12a3a2-20220602
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 609628221; Thu, 02 Jun 2022 14:22:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 2 Jun 2022 14:22:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 14:22:28 +0800
Message-ID: <6d432025e3f7e96a26d07ad0c779234a246ef4fe.camel@mediatek.com>
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 2 Jun 2022 14:22:28 +0800
In-Reply-To: <177a0be5289045602fdbde295b1bd076bee9e854.camel@mediatek.com>
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
         <177a0be5289045602fdbde295b1bd076bee9e854.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex,

On Fri, 2022-04-22 at 15:59 +0800, Rex-BC Chen wrote:
> On Fri, 2022-04-22 at 15:15 +0800, Tinghan Shen wrote:
> > This patch adds mt8186 dsp document. The dsp is used for Sound Open
> > Firmware driver node. It includes registers, clocks, memory regions,
> > and mailbox for dsp.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> > 
> > This patch depends on MT8186 clock bindings.
> > 
> 
> https://lore.kernel.org/all/20220409132251.31725-2-chun-jie.chen@mediatek.com/
> > 
> > ---
> >  .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 93
> > +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-
> > dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-
> > dsp.yaml
> > new file mode 100644
> > index 000000000000..00a79e880895
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek mt8186 DSP core
> 
> Hello Tinghan,
> 
> Please use MediaTek.

Ok. I'll update it at next version.


Thanks,
TingHan


> Thanks.
> 
> BRs,
> Rex
> 
> > +
> > +maintainers:
> > +  - Tinghan Shen <tinghan.shen@mediatek.com>
> > +
> > +description: |
> > +  MediaTek mt8186 SoC contains a DSP core used for
> > +  advanced pre- and post- audio processing.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt8186-dsp
> > +
> > +  reg:
> > +    items:
> > +      - description: Address and size of the DSP config registers
> > +      - description: Address and size of the DSP SRAM
> > +      - description: Address and size of the DSP secure registers
> > +      - description: Address and size of the DSP bus registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: cfg
> > +      - const: sram
> > +      - const: sec
> > +      - const: bus
> > +
> > +  clocks:
> > +    items:
> > +      - description: mux for audio dsp clock
> > +      - description: mux for audio dsp local bus
> > +
> > +  clock-names:
> > +    items:
> > +      - const: audiodsp_sel
> > +      - const: adsp_bus_sel
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  mboxes:
> > +    items:
> > +      - description: ipc reply between host and audio DSP.
> > +      - description: ipc request between host and audio DSP.
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: mbox0
> > +      - const: mbox1
> > +
> > +  memory-region:
> > +    items:
> > +      - description: dma buffer between host and DSP.
> > +      - description: DSP system memory.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - mbox-names
> > +  - mboxes
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/mt8186-clk.h>
> > +    dsp@10680000 {
> > +        compatible = "mediatek,mt8186-dsp";
> > +        reg = <0x10680000 0x2000>,
> > +              <0x10800000 0x100000>,
> > +              <0x1068b000 0x100>,
> > +              <0x1068f000 0x1000>;
> > +        reg-names = "cfg", "sram", "sec", "bus";
> > +        clocks = <&topckgen CLK_TOP_AUDIODSP>,
> > +                 <&topckgen CLK_TOP_ADSP_BUS>;
> > +        clock-names = "audiodsp_sel",
> > +                      "adsp_bus_sel";
> > +        power-domains = <&spm 6>;
> > +        mbox-names = "mbox0", "mbox1";
> > +        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
> > +    };
> 
> 

