Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB795A2183
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245053AbiHZHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244863AbiHZHNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:13:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB89D2B13;
        Fri, 26 Aug 2022 00:13:16 -0700 (PDT)
X-UUID: 242eb3be533a430e8b9c4073669c76a0-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=394UNmo0dlilNl7TS7agMGFKl0Cm8pk4mL85CkB70vc=;
        b=k7d9MEro5qgHxCK6h3T9VRe5uxmkEstCEUBOll6HBuRA81sQE7AbKjY30c4klBhWX3GLmhGUbqisMdkeZkdBpp1E0Lk0iS+Jx6j+YwSFnUjXN5VkxRnMN9CVApwKlRppkRWvH7+iGqg66nz+8I4Nkri2B1d0foPK9LlhyCOGaMQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:22bcf2d3-1b49-4beb-aa20-7e6f585b3ec2,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Releas
        e_Ham,ACTION:release,TS:73
X-CID-INFO: VERSION:1.1.10,REQID:22bcf2d3-1b49-4beb-aa20-7e6f585b3ec2,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:73
X-CID-META: VersionHash:84eae18,CLOUDID:134c2f20-1c20-48a5-82a0-25f9c331906d,C
        OID:cf454214b1af,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: 242eb3be533a430e8b9c4073669c76a0-20220826
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 492750950; Fri, 26 Aug 2022 15:13:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 15:13:07 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 15:13:07 +0800
Message-ID: <916bd99bcc4fa77eae5734b22365ce73acd90d58.camel@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: arm: mediatek: mmsys: change compatible
 for MT8195
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?= 
        <Jason-JH.Lin@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?=" 
        <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "hsinyi@google.com" <hsinyi@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 26 Aug 2022 15:13:06 +0800
In-Reply-To: <adcbb2b7-cddd-4546-bdf2-66d056a40c1d@linaro.org>
References: <20220825091448.14008-1-rex-bc.chen@mediatek.com>
         <3ed3d73a-1671-708e-7c42-498cca6aaf1d@gmail.com>
         <8f3dba943170361211d9bb4c8bf1be12bbfdec20.camel@mediatek.com>
         <adcbb2b7-cddd-4546-bdf2-66d056a40c1d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-26 at 15:00 +0800, Krzysztof Kozlowski wrote:
> On 26/08/2022 05:07, Bo-Chen Chen wrote:
> > On Thu, 2022-08-25 at 22:57 +0800, Matthias Brugger wrote:
> > > 
> > > On 25/08/2022 11:14, Bo-Chen Chen wrote:
> > > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > > 
> > > > For previous MediaTek SoCs, such as MT8173, there are 2 display
> > > > HW
> > > > pipelines binding to 1 mmsys with the same power domain, the
> > > > same
> > > > clock driver and the same mediatek-drm driver.
> > > > 
> > > > For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines
> > > > binding
> > > > to
> > > > 2 different power domains, different clock drivers and
> > > > different
> > > > mediatek-drm drivers.
> > > > 
> > > > Moreover, Hardware pipeline of VDOSYS0 has these components:
> > > > COLOR,
> > > > CCORR, AAL, GAMMA, DITHER. They are related to the PQ (Picture
> > > > Quality)
> > > > and they makes VDOSYS0 supports PQ function while they are not
> > > > including in VDOSYS1.
> > > > 
> > > > Hardware pipeline of VDOSYS1 has the component ETHDR (HDR
> > > > related
> > > > component). It makes VDOSYS1 supports the HDR function while
> > > > it's
> > > > not
> > > > including in VDOSYS0.
> > > > 
> > > > To summarize0:
> > > > Only VDOSYS0 can support PQ adjustment.
> > > > Only VDOSYS1 can support HDR adjustment.
> > > > 
> > > > Therefore, we need to separate these two different mmsys
> > > > hardwares
> > > > to
> > > > 2 different compatibles for MT8195.
> > > > 
> > > > Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add
> > > > mt8195
> > > > SoC binding")
> > > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > > ---
> > > > Changes for v2:
> > > > 1. Add hardware difference for VDOSYS0 and VDOSYS1 in commit
> > > > message.
> > > > ---
> > > >  
> > > > .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml       
> > > > |
> > > > 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > index 6ad023eec193..bfbdd30d2092 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > +++
> > > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys
> > > > .yam
> > > > l
> > > > @@ -31,7 +31,8 @@ properties:
> > > >                 - mediatek,mt8183-mmsys
> > > >                 - mediatek,mt8186-mmsys
> > > >                 - mediatek,mt8192-mmsys
> > > > -              - mediatek,mt8195-mmsys
> > > > +              - mediatek,mt8195-vdosys0
> > > 
> > > Thanks for you patch. As I mentioned on v1, I propose to set 
> > > mediatek,mt8195-mmsys as fallback for mediatek,mt8195-vdosys0 to
> > > not
> > > break 
> > > backwards compatibility.
> > > 
> > > Apart from that, the binding change will need some changes to
> > > support
> > > the new 
> > > binding. Please provide these together with this patch.
> > > 
> > > Regards,
> > > Matthias
> > > 
> > 
> > Hello Matthias,
> > 
> > Thanks for your comments.
> > The purpose of this patch is to confirm we can separate mt8195
> > mmsys
> > into two compatibles. I think this modification is accepted.
> 
> No, it is not accepted following Matthias comments. You received my
> ack
> based on assumption that ABI break is perfectly ok for platform
> maintainer, as he has decisive voice. If anyone is not happy with a
> ABI
> break, then his concerns must be addressed.
> 
> So let it be specific:
> NAK.
> 
> > 
> > After this, I think Jason-JH will push another series with this
> > binding
> > patch. 
> 
> I don't know what do you mean here - another series on top of wrong
> patch?
> 

Hello Krzysztof,

For this mt8195 mmsys binding separation, we still need to modify
driver for this. The reason I send this patch is to confirm we can do
this binding modification and I also think we can not pick this patch
here.

We will push another series and it contains modification of binding and
drivers. (The series will push by Jason-JH Lin)

Maybe I should use "RFC" for this series, and I think it's more
correct.

BRs,
Bo-Chen

> > In Jason-JH's series, we will modify mmsys driver based on this.
> > And I think we don't need to keep "mediatek,mt8195-mmsys" if we
> > also
> > modify mmsys drivers in the same series.
> 
> This does not fux ABI break and broken bisectability.
> 
> > 
> > Is it ok that postpones to pick this patch until we finish review
> > follow-up series?
> > 
> 
> No. You got a clear review to fix.
> 
> Best regards,
> Krzysztof

