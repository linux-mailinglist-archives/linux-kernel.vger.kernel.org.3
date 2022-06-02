Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C197853B3C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiFBGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiFBGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:44:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD89A988;
        Wed,  1 Jun 2022 23:44:34 -0700 (PDT)
X-UUID: f3e7fe5f7e3548a5b655106bafce5478-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ace17e4b-e989-4f5b-ad01-201b48944afc,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:ec2adc37-9855-4915-a138-f5705f1f3d02,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: f3e7fe5f7e3548a5b655106bafce5478-20220602
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1851618249; Thu, 02 Jun 2022 14:44:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 2 Jun 2022 14:44:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 2 Jun 2022 14:44:31 +0800
Message-ID: <eb4deff1a01c09783518bbaff8fe4e4c4ca6fa5b.camel@mediatek.com>
Subject: Re: [PATCH v1] dt-bindings: dsp: mediatek: add mt8186 dsp document
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 2 Jun 2022 14:44:31 +0800
In-Reply-To: <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
References: <20220422071534.15653-1-tinghan.shen@mediatek.com>
         <c0a188e5-8a8c-d4a3-5a3d-9b9dd85d8f44@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your review and sorry for late response.

On Fri, 2022-04-22 at 17:49 +0200, Krzysztof Kozlowski wrote:
> On 22/04/2022 09:15, Tinghan Shen wrote:
> > This patch adds mt8186 dsp document. The dsp is used for Sound Open
> > Firmware driver node. It includes registers, clocks, memory regions,
> > and mailbox for dsp.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> > 
> > This patch depends on MT8186 clock bindings.
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20220409132251.31725-2-chun-jie.chen@mediatek.com/__;!!CTRNKA9wMg0ARbw!xNJkwM9Z-raJLjgIoriOnjolphzSHqpnATbd3XC7wU7iaUns8gqGB2omSOkliuoDf3g$
> >  
> > 
> > ---
> >  .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > new file mode 100644
> > index 000000000000..00a79e880895
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml*__;Iw!!CTRNKA9wMg0ARbw!xNJkwM9Z-raJLjgIoriOnjolphzSHqpnATbd3XC7wU7iaUns8gqGB2omSOklA_t3nMM$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!xNJkwM9Z-raJLjgIoriOnjolphzSHqpnATbd3XC7wU7iaUns8gqGB2omSOkl3OXmT2U$
> >  
> > +
> > +title: Mediatek mt8186 DSP core
> > +

(...snip...)

> > +
> > +  clock-names:
> > +    items:
> > +      - const: audiodsp_sel
> > +      - const: adsp_bus_sel
> 
> What does the "sel" stands for? Maybe just skip the "_sel" suffixes?

No problem. I'll remove '_sel' in next version.

> 
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
> 
> These should be rather some meaningful names, e.g. "rx" and "tx".

The mbox name has to align with the adsp ipc driver.
The adsp ipc driver is using 'mbox%d' for mailbox channels.


https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=9db69df4bdd37eb1f65b6931ee067fb15b9a4d5c

	chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);

	/* ...snip... */

	adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);

Is it ok to continue using these names?
> 
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
> 
> You do not use these headers.

Ok. I'll remove them at next version.

Thanks,
TingHan

> 
> > +    #include <dt-bindings/clock/mt8186-clk.h>
> > +    dsp@10680000 {
> 
> 
> 
> Best regards,
> Krzysztof

