Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27425510D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiFTHAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiFTHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:00:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C666268;
        Mon, 20 Jun 2022 00:00:27 -0700 (PDT)
X-UUID: 95dd7d9fe54a4c7d82f127ef3f1d1088-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b5da8170-25f4-4b65-a470-33a9e479aa30,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:b5da8170-25f4-4b65-a470-33a9e479aa30,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:d703fbe9-f7af-4e69-92ee-0fd74a0c286c,C
        OID:91dce0d6509b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 95dd7d9fe54a4c7d82f127ef3f1d1088-20220620
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1784945762; Mon, 20 Jun 2022 15:00:00 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 20 Jun 2022 14:59:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 20 Jun 2022 14:59:58 +0800
Message-ID: <af50210b95d0cd8b2e3103b3d4a9702aeeba9452.camel@mediatek.com>
Subject: Re: [PATCH 2/3] dt-bindings: usb: mtk-xhci: Allow middle optional
 clocks to be missing
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <kernel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Mon, 20 Jun 2022 14:59:58 +0800
In-Reply-To: <bc5458fe-083c-d679-9fcb-95810a290da8@linaro.org>
References: <20220617222916.2435618-1-nfraprado@collabora.com>
         <20220617222916.2435618-3-nfraprado@collabora.com>
         <8639e64d-c659-7090-2d0a-078fd96cfbd4@linaro.org>
         <bb460aa483cc888ffa36709d9e9c1f2e3be0e000.camel@mediatek.com>
         <bc5458fe-083c-d679-9fcb-95810a290da8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-06-19 at 14:05 +0200, Krzysztof Kozlowski wrote:
> On 19/06/2022 09:46, Chunfeng Yun wrote:
> > On Fri, 2022-06-17 at 18:25 -0700, Krzysztof Kozlowski wrote:
> > > On 17/06/2022 15:29, Nícolas F. R. A. Prado wrote:
> > > > The current clock list in the binding doesn't allow for one of
> > > > the
> > > > optional clocks to be missing and a subsequent clock to be
> > > > present.
> > > > An
> > > > example where this is an issue is in mt8192.dtsi, which has
> > > > "sys_ck",
> > > > "ref_ck", "xhci_ck" and would cause dtbs_check warnings.
> > > > 
> > > > Change the clock list in a way that allows the middle optional
> > > > clocks to
> > > > be missing, while still guaranteeing a fixed order. The
> > > > "ref_ck" is
> > > > kept
> > > > as a const even though it is optional for simplicity, since it
> > > > is
> > > > present in all current dts files.
> > > > 
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > > 
> > > >  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml       | 9
> > > > +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > xhci.yaml
> > > > index 63cbc2b62d18..99a1b233ec90 100644
> > > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > xhci.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > xhci.yaml
> > > > @@ -80,8 +80,13 @@ properties:
> > > >      items:
> > > >        - const: sys_ck  # required, the following ones are
> > > > optional
> > > >        - const: ref_ck
> > > > -      - const: mcu_ck
> > > > -      - const: dma_ck
> > > > +      - enum:
> > > > +          - mcu_ck
> > > > +          - dma_ck
> > > > +          - xhci_ck
> > > > +      - enum:
> > > > +          - dma_ck
> > > > +          - xhci_ck
> > > >        - const: xhci_ck
> > > 
> > > You allow now almost any order here, including incorrect like
> > > sys,ref,xhci,xhci,xhci.
> > > 
> > > The order of clocks has to be fixed and we cannot allow
> > > flexibility.
> > > Are
> > > you sure that these clocks are actually optional (not wired to
> > > the
> > > device)?
> > 
> > In fact, these optional clocks are fixed, due to no gates are
> > provided,
> > SW can't control them by CCF;
> > In this case, I usually use a fixed clock, or ignore it.
> 
> But in some versions these clocks are controllable or not?
Some SoCs are controllable, some ones are not (fixed clock).

> 
> Best regards,
> Krzysztof

