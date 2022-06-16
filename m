Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36DD54DBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359303AbiFPHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359478AbiFPHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:34:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F525F75;
        Thu, 16 Jun 2022 00:34:24 -0700 (PDT)
X-UUID: 8d913bc540484203ac33d2b2bc4efc2e-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:cc6d52a1-2bd3-443a-885a-1c3d93f54167,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:c56874f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 8d913bc540484203ac33d2b2bc4efc2e-20220616
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 495931524; Thu, 16 Jun 2022 15:34:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 15:34:19 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 15:34:19 +0800
Message-ID: <29fd9902d02654fa5098000732f92d6dc89defc4.camel@mediatek.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: dsp: mediatek: add mt8186 dsp
 document
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        "Allen-KH Cheng" <allen-kh.cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 16 Jun 2022 15:34:19 +0800
In-Reply-To: <acac2ec1-759a-dee0-8f08-df83b63b96f5@linaro.org>
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
         <20220609083101.24195-4-tinghan.shen@mediatek.com>
         <acac2ec1-759a-dee0-8f08-df83b63b96f5@linaro.org>
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

Hi Krzysztof,

On Wed, 2022-06-15 at 10:32 -0700, Krzysztof Kozlowski wrote:
> On 09/06/2022 01:31, Tinghan Shen wrote:
> > This patch adds mt8186 dsp document. The dsp is used for Sound Open
> > Firmware driver node. It includes registers, clocks, memory regions,
> > and mailbox for dsp.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../bindings/dsp/mediatek,mt8186-dsp.yaml     | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > new file mode 100644
> > index 000000000000..33c78f89d296
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8186-dsp.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/dsp/mediatek,mt8186-dsp.yaml*__;Iw!!CTRNKA9wMg0ARbw!0iJc3XTOVoKM_s-soALULRxog7f0GZLppKL0FCcIrYfh91fW2HmlpzSUZjVmoUR5PrasY2BmVGvmvv_IwZtlmOdXYw$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!0iJc3XTOVoKM_s-soALULRxog7f0GZLppKL0FCcIrYfh91fW2HmlpzSUZjVmoUR5PrasY2BmVGvmvv_IwZujnl7wMw$
> >  
> > +
> > +title: MediaTek mt8186 DSP core
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
> > +      - const: audiodsp
> > +      - const: adsp_bus
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  mboxes:
> > +    items:
> > +      - description: ipc reply between host and audio DSP.
> > +      - description: ipc request between host and audio DSP.
> 
> "IPC request between" does not specify who sends the request. Host or DSP?
> 
> See existing bindings for some better examples, e.g.:
> Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.yaml
> which clearly states who receives from who.
> 
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: rep
> > +      - const: req
> 
> tx/rx
> 
> 
> 
> 
> Best regards,
> Krzysztof

OK. I'll update in the next version.

Thanks,
TingHan

