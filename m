Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42952E902
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347758AbiETJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343582AbiETJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:41:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624752DD5D;
        Fri, 20 May 2022 02:41:00 -0700 (PDT)
X-UUID: 4b1d1c2740b841b4a2762fc0400074f7-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ab825165-707d-46ca-bd20-42a6777e6e33,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:59
X-CID-INFO: VERSION:1.1.5,REQID:ab825165-707d-46ca-bd20-42a6777e6e33,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_HamU,ACTI
        ON:release,TS:59
X-CID-META: VersionHash:2a19b09,CLOUDID:3689007a-5ef6-470b-96c9-bdb8ced32786,C
        OID:0ea0a549b8f2,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 4b1d1c2740b841b4a2762fc0400074f7-20220520
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1710984426; Fri, 20 May 2022 17:40:55 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 17:40:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 17:40:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 17:40:54 +0800
Message-ID: <9b6e304e69e0d6064893534831d70df58f932843.camel@mediatek.com>
Subject: Re: [RESEND v4 1/2] dt-bindings: interconnect: Add MediaTek CCI
 dt-bindings
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>,
        <djakov@kernel.org>, <khilman@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 20 May 2022 17:40:54 +0800
In-Reply-To: <CAGXv+5FqjDX7y_bR0Y=2xCnCqwtAB2S+3Fn==adxJJqanv8=YQ@mail.gmail.com>
References: <20220513032832.17645-1-johnson.wang@mediatek.com>
         <20220513032832.17645-2-johnson.wang@mediatek.com>
         <CAGXv+5FqjDX7y_bR0Y=2xCnCqwtAB2S+3Fn==adxJJqanv8=YQ@mail.gmail.com>
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

On Fri, 2022-05-13 at 11:35 +0800, Chen-Yu Tsai wrote:
> On Fri, May 13, 2022 at 11:31 AM Johnson Wang <
> johnson.wang@mediatek.com> wrote:
> > 
> > Add devicetree binding of MediaTek CCI on MT8183 and MT8186.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  .../bindings/interconnect/mediatek,cci.yaml   | 140
> > ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 141 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > new file mode 100644
> > index 000000000000..034c3b38ca3d
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/interconnect/mediatek,cci.yaml*__;Iw!!CTRNKA9wMg0ARbw!0vYE2yw5meNp-VKz6-Xp4C_qT8rz0tpzc0iPAGI__dVczbtBVpOcQfxdrQADjIdqtgDrrni0ZKWuBFP1QcwD0mHhOw$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!0vYE2yw5meNp-VKz6-Xp4C_qT8rz0tpzc0iPAGI__dVczbtBVpOcQfxdrQADjIdqtgDrrni0ZKWuBFP1QcxLQ8hn_A$
> >  
> > +
> > +title: MediaTek Cache Coherent Interconnect (CCI) frequency and
> > voltage scaling
> > +
> > +maintainers:
> > +  - Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > +  - Johnson Wang <johnson.wang@mediatek.com>
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
> > +          The multiplexer for clock input of the bus.
> > +      - description:
> > +          A parent of "cpu" clock which is used as an intermediate
> > clock source
> 
> Replace "cpu" with "bus"?
> 
> > +          when the original CPU is under transition and not stable
> > yet.
> 
> 
> And also, "when the original clock source (PLL) is under transition
> ..."
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Hi Chen-Yu,

I will modify them in the next version.

BRs,
Johnson Wang

