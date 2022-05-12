Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9FD52424C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiELCEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiELCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:04:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F15E6007D;
        Wed, 11 May 2022 19:04:51 -0700 (PDT)
X-UUID: 61fc5763feac462a8af6bb2d313d6388-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0f9ca906-966c-4812-ad43-9cf00fa93e7f,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:79
X-CID-INFO: VERSION:1.1.4,REQID:0f9ca906-966c-4812-ad43-9cf00fa93e7f,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:54,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:79
X-CID-META: VersionHash:faefae9,CLOUDID:c8838727-a01c-4223-8f5a-12d972216e7b,C
        OID:03949d916c65,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 61fc5763feac462a8af6bb2d313d6388-20220512
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1840925719; Thu, 12 May 2022 10:04:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 10:04:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 12 May 2022 10:04:43 +0800
Message-ID: <b9c49e8e8ccbd01a51db63dfe545744d6160886f.camel@mediatek.com>
Subject: Re: [PATCH v4] dt-bindings: nvmem: convert mtk-efuse.txt to YAML
 schema
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Date:   Thu, 12 May 2022 10:04:42 +0800
In-Reply-To: <5847417d-921c-7fca-f5de-00e8a550dcb8@linaro.org>
References: <20220509014521.10248-1-chunfeng.yun@mediatek.com>
         <5847417d-921c-7fca-f5de-00e8a550dcb8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 17:39 +0200, Krzysztof Kozlowski wrote:
> On 09/05/2022 03:45, Chunfeng Yun wrote:
> > Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v4: fix duplicated unit-address in example;
> >     drop reviewed-by Rob, due to changes;
> 
> That's a small change, you should keep his review tag.
Ok.
> 
> > 
> > v3: add reviewed-by Rob
> > 
> > v2:
> >    1. remove description of subnodes which is covered by nvmem.yaml
> > suggested by Rob
> >    2. change the example which is commoner than mt8173's
> > 
> > ---
> >  .../bindings/nvmem/mediatek,efuse.yaml        | 86
> > +++++++++++++++++++
> >  .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ----------
> >  2 files changed, 86 insertions(+), 43 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-
> > efuse.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > new file mode 100644
> > index 000000000000..abb8b85655fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek efuse device tree bindings
> 
> s/device tree bindings//
Will remove it, thanks

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Best regards,
> Krzysztof

