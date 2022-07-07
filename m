Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C755569746
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiGGBLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiGGBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:11:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BCE2D1DA;
        Wed,  6 Jul 2022 18:10:47 -0700 (PDT)
X-UUID: 143a25d7f46e4b69abd2527959728f7d-20220707
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:338708dd-17f2-491d-957d-20cb2abe685c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.8,REQID:338708dd-17f2-491d-957d-20cb2abe685c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:0f94e32,CLOUDID:ada3ced6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:f65fabf43280,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 143a25d7f46e4b69abd2527959728f7d-20220707
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1327031085; Thu, 07 Jul 2022 09:10:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Jul 2022 09:10:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jul 2022 09:10:38 +0800
Message-ID: <ed72abf85a7c167dfd2abd64a79422a19fc53d06.camel@mediatek.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: mtk-xhci: Make all clocks
 required
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <kernel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Thu, 7 Jul 2022 09:10:38 +0800
In-Reply-To: <20220705203621.hunczzwfhiwpcrhy@notapiano>
References: <20220623193702.817996-1-nfraprado@collabora.com>
         <20220623193702.817996-3-nfraprado@collabora.com>
         <93c6b7201533325cf7758637dd194a372f3c00c6.camel@mediatek.com>
         <20220629185546.z6rn7xp3ejpmaupi@notapiano>
         <20220701213702.GA1591697-robh@kernel.org>
         <5f85280ea5fd0d4b445307a13a70c3e3fe552ccf.camel@mediatek.com>
         <20220705203621.hunczzwfhiwpcrhy@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 16:36 -0400, Nícolas F. R. A. Prado wrote:
> On Sat, Jul 02, 2022 at 04:24:12PM +0800, Chunfeng Yun wrote:
> > On Fri, 2022-07-01 at 15:37 -0600, Rob Herring wrote:
> > > On Wed, Jun 29, 2022 at 02:55:46PM -0400, Nícolas F. R. A. Prado
> > > wrote:
> > > > On Tue, Jun 28, 2022 at 08:57:45AM +0800, Chunfeng Yun wrote:
> > > > > Hi Nícolas,
> > > > > 
> > > > > On Thu, 2022-06-23 at 15:37 -0400, Nícolas F. R. A. Prado
> > > > > wrote:
> > > > > > All of the clocks listed in the binding are always wired to
> > > > > > the
> > > > > > XHCI
> > > > > > controller hardware blocks on all SoCs. The reason some
> > > > > > clocks
> > > > > > were
> > > > > > made
> > > > > > optional in the binding was to account for the fact that
> > > > > > depending on
> > > > > > the SoC, some of the clocks might be fixed (ie not
> > > > > > controlled
> > > > > > by
> > > > > > software).
> > > > > > 
> > > > > > Given that the devicetree should represent the hardware,
> > > > > > make
> > > > > > all
> > > > > > clocks
> > > > > > required in the binding. Subsequent patches will make the
> > > > > > DTS
> > > > > > changes
> > > > > > to
> > > > > > specify fixed-clocks for the clocks that aren't
> > > > > > controllable.
> > > > > > 
> > > > > > Signed-off-by: Nícolas F. R. A. Prado <
> > > > > > nfraprado@collabora.com>
> > > > > > 
> > > > > > ---
> > > > > > 
> > > > > > Changes in v2:
> > > > > > - Undid clock list changes that allowed middle clocks to be
> > > > > > missing
> > > > > > from
> > > > > >   v1 and made all clocks required instead
> > > > > > - Rewrote commit message and title
> > > > > > 
> > > > > >  Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > xhci.yaml |
> > > > > > 4 +
> > > > > > ---
> > > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > xhci.yaml
> > > > > > b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > xhci.yaml
> > > > > > index 63cbc2b62d18..1444d18ef9bc 100644
> > > > > > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > xhci.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> > > > > > xhci.yaml
> > > > > > @@ -67,7 +67,6 @@ properties:
> > > > > >      maxItems: 1
> > > > > >  
> > > > > >    clocks:
> > > > > > -    minItems: 1
> > > > > >      items:
> > > > > >        - description: Controller clock used by normal mode
> > > > > >        - description: Reference clock used by low power
> > > > > > mode
> > > > > > etc
> > > > > > @@ -76,9 +75,8 @@ properties:
> > > > > >        - description: controller clock
> > > > > >  
> > > > > >    clock-names:
> > > > > > -    minItems: 1
> > > > > >      items:
> > > > > > -      - const: sys_ck  # required, the following ones are
> > > > > > optional
> > > > > > +      - const: sys_ck
> > > > > >        - const: ref_ck
> > > > > >        - const: mcu_ck
> > > > > >        - const: dma_ck
> > > > > 
> > > > > This patch causes more check warning, I prefer to leave dt-
> > > > > bindings
> > > > > unchanged, but just fix mt8195's dts warning instead, thanks
> > > > > a
> > > > > lot
> > > > 
> > > > Hi Chunfeng,
> > > > 
> > > > the warnings reported by Rob's bot only happen if patches 3 and
> > > > 4
> > > > aren't applied
> > > > to adapt the devicetrees. They are ABI breaking changes, but I
> > > > understood this
> > > > as the desired solution from the discussion we had with
> > > > Krzysztof
> > > > on v1 [1].
> > > 
> > > The warnings have nothing to do with patches 3 and 4 as those are
> > > for 
> > > dts files. It's examples in bindings that are the problem.
> 
> Sorry, you're right, I misread the errors.
> 
> > Yes, I mean almost all existing dts supporting mtk-xhci will also
> > cause
> > similar warnings, as changes in patches 3, 4;
> > 
> > It seems less flexible to make all clock required, not only changes
> > all
> > existing ones but also need more changes if additional clock is
> > added.
> 
> Yes, that's a valid concern. I must have misunderstood the discussion
> in v1
> then.
> 
> So, I'm going to send a revert for this change and send a new patch
> adding fixed
> clocks on the dts for just mt8192 and mt8195 to fix the dtbs_check
> warnings.
> Does that sound good?
Yes, sound good, thanks a lot

> 
> Thanks,
> Nícolas

