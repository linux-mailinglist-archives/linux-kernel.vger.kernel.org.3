Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0845AA823
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiIBGkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiIBGjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:39:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47750D56;
        Thu,  1 Sep 2022 23:39:46 -0700 (PDT)
X-UUID: c05eac422097471c872056318a83e103-20220902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GMxt2oT0D3MCbD0Lp6mcCwpaeEOxm0ZIUUd82Rv5VG0=;
        b=TmeP9WsgGG0Tk0phqDb/xcB8YDQKXSe1Gm8bRtynzIcy+dAGAclXjX6rOKjA2hWGIFa5YnBcJNOIn2ZIjbhjHEXrXnq4/6cfLU0sTvH6dbPdCkVADVQAQ8Has/gR8zhVHpyg6D7HFxf1qNaod4FPTVX8BknQCPjs1BZNc08ccAw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:52633523-0b9a-473a-a1a0-9f0e7bfb7947,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Releas
        e_Ham,ACTION:release,TS:73
X-CID-INFO: VERSION:1.1.10,REQID:52633523-0b9a-473a-a1a0-9f0e7bfb7947,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:73
X-CID-META: VersionHash:84eae18,CLOUDID:4726eb20-1c20-48a5-82a0-25f9c331906d,C
        OID:1003028753b3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: c05eac422097471c872056318a83e103-20220902
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 97495843; Fri, 02 Sep 2022 14:39:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 2 Sep 2022 14:39:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Sep 2022 14:39:37 +0800
Message-ID: <67237f85d1c4bc72906848d811988209d0112c06.camel@mediatek.com>
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Date:   Fri, 2 Sep 2022 14:39:38 +0800
In-Reply-To: <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
         <20220831124850.7748-3-johnson.wang@mediatek.com>
         <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 16:19 +0300, Krzysztof Kozlowski wrote:
> On 31/08/2022 15:48, Johnson Wang wrote:
> > Add the new binding documentation for MediaTek frequency hopping
> > and spread spectrum clocking control.
> > 
> > Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,fhctl.yaml | 49
> > +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
> > l
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
> > l
> > new file mode 100644
> > index 000000000000..c5d76410538b
> > --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yam
> > l
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml*__;Iw!!CTRNKA9wMg0ARbw!ysl-bMp7yP9Ym70o6EVB8A36MBxcXGap8doEKR_SbaAQSy8-_RU5jvrWTjzETut_6eXNGut4j-3dY0q7xJdpQbmaOw$
> >  
> > +$schema: 
> > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!ysl-bMp7yP9Ym70o6EVB8A36MBxcXGap8doEKR_SbaAQSy8-_RU5jvrWTjzETut_6eXNGut4j-3dY0q7xJezt7_RBw$
> >  
> > +
> > +title: MediaTek frequency hopping and spread spectrum clocking
> > control
> > +
> > +maintainers:
> > +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
> > +
> > +description: |
> > +  Frequency hopping control (FHCTL) is a piece of hardware that
> > control
> > +  some PLLs to adopt "hopping" mechanism to adjust their
> > frequency.
> > +  Spread spectrum clocking (SSC) is another function provided by
> > this hardware.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,fhctl
> 
> You need SoC/device specific compatibles. Preferably only SoC
> specific,
> without generic fallback, unless you can guarantee (while
> representing
> MediaTek), that generic fallback will cover all of their SoCs?
> 

Hi Krzysztof,

At this moment, we plan to support FHCTL feature for MT8186 only.

If you prefer SoC-specific compatble, we will improve that in the next
version.

Thanks for your suggestion.

BRs,
Johnson Wang
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  mediatek,hopping-ssc-percents:
> > +    description: |
> > +      Determine the enablement of frequency hopping feature and
> > the percentage
> > +      of spread spectrum clocking for PLLs.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    items:
> > +      items:
> > +        - description: PLL id that is expected to enable frequency
> > hopping.
> 
> So the clocks are indices from some specific, yet unnamed
> clock-controller? This feels hacky. You should rather take here clock
> phandles (1) or integrate it into specific clock controller (2). The
> reason is that either your device does something on top of existing
> clocks (option 1, thus it takes clock as inputs) or it modifies
> existing
> clocks (option 2, thus it is integral part of clock-controller).
> 
> 
> Best regards,
> Krzysztof

