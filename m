Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11855404D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355874AbiFVB5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiFVB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:57:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B431201;
        Tue, 21 Jun 2022 18:57:21 -0700 (PDT)
X-UUID: a6098956ce0e4987891d618e8fd9e30e-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:660ed2cd-09ad-4643-b901-452f7f5f3b84,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:e65b28ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a6098956ce0e4987891d618e8fd9e30e-20220622
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1683346429; Wed, 22 Jun 2022 09:57:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 09:57:16 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 09:57:13 +0800
Message-ID: <ba6cccfa05aed087d14f5adc6db06496547a5094.camel@mediatek.com>
Subject: Re: [PATCH 2/3] dt-bindings: usb: mtk-xhci: Allow middle optional
 clocks to be missing
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <kernel@collabora.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Wed, 22 Jun 2022 09:57:12 +0800
In-Reply-To: <afae6179-3681-f5c6-4615-3228f16f1271@linaro.org>
References: <20220617222916.2435618-1-nfraprado@collabora.com>
         <20220617222916.2435618-3-nfraprado@collabora.com>
         <8639e64d-c659-7090-2d0a-078fd96cfbd4@linaro.org>
         <bb460aa483cc888ffa36709d9e9c1f2e3be0e000.camel@mediatek.com>
         <bc5458fe-083c-d679-9fcb-95810a290da8@linaro.org>
         <af50210b95d0cd8b2e3103b3d4a9702aeeba9452.camel@mediatek.com>
         <a24c24e6-fdee-df79-fd2f-6a71540bd9b3@linaro.org>
         <20220620155057.a6qilnhm7snzhapa@notapiano>
         <afae6179-3681-f5c6-4615-3228f16f1271@linaro.org>
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

On Tue, 2022-06-21 at 09:14 +0200, Krzysztof Kozlowski wrote:
> On 20/06/2022 17:50, Nícolas F. R. A. Prado wrote:
> > On Mon, Jun 20, 2022 at 10:50:57AM +0200, Krzysztof Kozlowski
> > wrote:
> > > On 20/06/2022 08:59, Chunfeng Yun wrote:
> > > > On Sun, 2022-06-19 at 14:05 +0200, Krzysztof Kozlowski wrote:
> > > > > On 19/06/2022 09:46, Chunfeng Yun wrote:
> > > > > > On Fri, 2022-06-17 at 18:25 -0700, Krzysztof Kozlowski
> > > > > > wrote:
> > > > > > > On 17/06/2022 15:29, Nícolas F. R. A. Prado wrote:
> > > > > > > > The current clock list in the binding doesn't allow for
> > > > > > > > one of
> > > > > > > > the
> > > > > > > > optional clocks to be missing and a subsequent clock to
> > > > > > > > be
> > > > > > > > present.
> > > > > > > > An
> > > > > > > > example where this is an issue is in mt8192.dtsi, which
> > > > > > > > has
> > > > > > > > "sys_ck",
> > > > > > > > "ref_ck", "xhci_ck" and would cause dtbs_check
> > > > > > > > warnings.
> > > > > > > > 
> > > > > > > > Change the clock list in a way that allows the middle
> > > > > > > > optional
> > > > > > > > clocks to
> > > > > > > > be missing, while still guaranteeing a fixed order. The
> > > > > > > > "ref_ck" is
> > > > > > > > kept
> > > > > > > > as a const even though it is optional for simplicity,
> > > > > > > > since it
> > > > > > > > is
> > > > > > > > present in all current dts files.
> > > > > > > > 
> > > > > > > > Signed-off-by: Nícolas F. R. A. Prado <
> > > > > > > > nfraprado@collabora.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > >  .../devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > xhci.yaml       | 9
> > > > > > > > +++++++--
> > > > > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git
> > > > > > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > xhci.yaml
> > > > > > > > b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > xhci.yaml
> > > > > > > > index 63cbc2b62d18..99a1b233ec90 100644
> > > > > > > > ---
> > > > > > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > xhci.yaml
> > > > > > > > +++
> > > > > > > > b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > > > xhci.yaml
> > > > > > > > @@ -80,8 +80,13 @@ properties:
> > > > > > > >      items:
> > > > > > > >        - const: sys_ck  # required, the following ones
> > > > > > > > are
> > > > > > > > optional
> > > > > > > >        - const: ref_ck
> > > > > > > > -      - const: mcu_ck
> > > > > > > > -      - const: dma_ck
> > > > > > > > +      - enum:
> > > > > > > > +          - mcu_ck
> > > > > > > > +          - dma_ck
> > > > > > > > +          - xhci_ck
> > > > > > > > +      - enum:
> > > > > > > > +          - dma_ck
> > > > > > > > +          - xhci_ck
> > > > > > > >        - const: xhci_ck
> > > > > > > 
> > > > > > > You allow now almost any order here, including incorrect
> > > > > > > like
> > > > > > > sys,ref,xhci,xhci,xhci.
> > > > > > > 
> > > > > > > The order of clocks has to be fixed and we cannot allow
> > > > > > > flexibility.
> > > > > > > Are
> > > > > > > you sure that these clocks are actually optional (not
> > > > > > > wired to
> > > > > > > the
> > > > > > > device)?
> > > > > > 
> > > > > > In fact, these optional clocks are fixed, due to no gates
> > > > > > are
> > > > > > provided,
> > > > > > SW can't control them by CCF;
> > > > > > In this case, I usually use a fixed clock, or ignore it.
> > > > > 
> > > > > But in some versions these clocks are controllable or not?
> > > > 
> > > > Some SoCs are controllable, some ones are not (fixed clock).
> > > 
> > > Thanks for confirming. Then I would prefer to make these clocks
> > > required
> > > (not optional) and always provide them - via common clock
> > > framework or
> > > fixed-clock.
> > 
> > Hi Krzysztof and Chunfeng,
> > 
> > thank you both for the feedback.
> > 
> > Since the solution I proposed in this patch is not acceptable I see
> > two options:
> > 1. Split the clocks in several if blocks matched by compatibles
> > 2. Make the clocks required and use fixed-clock nodes for the
> > missing clocks in
> >    the DT
> > 
> > My understanding is that 1 is the desirable solution if the clock
> > is really
> > missing in some hardware variants, while 2 is desirable if all
> > hardware variants
> > really receive all the clocks, only that on some variants they're
> > fixed and not
> > controlable by SW.
> > 
> > From what I'm reading of this discussion it seems that the latter
> > is the case
> > here and thus we should go for 2. Is this correct?
> 
> This is how I understood it as well, so correct from my side.
Also right for me.

> 
> > 
> > Also Chunfeng, do you have information on whether the same is true
> > for the MMC
> > HW block? I recently submitted some changes to that binding [1] but
> > I followed
> > approach 1 there instead. However if all the clocks are present in
> > the HW level
> > there as well it would make more sense for me to change it to
> > follow approach 2.

I discussed it with Wenbin, MMC seems a little different with USB,

Hi Wenbin,

   Please give some comments about MMC, thanks

> > 
> > Thanks,
> > Nícolas
> > 
> > [1] 
> > https://lore.kernel.org/all/20220617230114.2438875-1-nfraprado@collabora.com
> 
> 
> Best regards,
> Krzysztof

