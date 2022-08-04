Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6195899CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiHDJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiHDJRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:17:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD9CCCD;
        Thu,  4 Aug 2022 02:17:01 -0700 (PDT)
X-UUID: 798942ea4ada4b59b2af815de34d7b48-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hn3C1DbmbSBxgcXhYKQ0b8hhfjiQV9f02TA0yA5GXLk=;
        b=OPosYza4sZNTzeuuRCyZPW6B6sDTaZY7i6n4yUKMVgd8HTiXajnQ3G81jNRv4FWRuiUtigA6gpt2uDowHc8LM5UmAZyyLpXwMtHcfSs19qpFb0aI4YiUt2RhZnRPdVoa7Yh4sU81qx+3RSlCS6Gb0bp9jqUbYk0iG3LFtCbIvO4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:ca628cc1-1086-48a5-927d-98829d52fed3,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:ca628cc1-1086-48a5-927d-98829d52fed3,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:543338d1-841b-4e95-ad42-8f86e18f54fc,C
        OID:2780e0fbad96,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 798942ea4ada4b59b2af815de34d7b48-20220804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 385525212; Thu, 04 Aug 2022 17:16:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 4 Aug 2022 17:16:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Aug 2022 17:16:55 +0800
Message-ID: <e4ae167cc5f2436097b98c7c26484e9f782797eb.camel@mediatek.com>
Subject: Re: [PATCH v4 05/20] dt-bindings: power: mediatek: Update
 maintainer list
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "MandyJH Liu" <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 4 Aug 2022 17:16:55 +0800
In-Reply-To: <11c7b04e-9837-440c-fa5b-3074a706e0ba@gmail.com>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
         <20220729063208.16799-6-tinghan.shen@mediatek.com>
         <11c7b04e-9837-440c-fa5b-3074a706e0ba@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, 2022-08-04 at 10:43 +0200, Matthias Brugger wrote:
> Weiyi Lu,
> 
> On 29/07/2022 08:31, Tinghan Shen wrote:
> > Update the maintainer list of power controller binding.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git
 a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > index 2d6afc0909473..03b7f6aa591d4 100644
> > ---
 a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > +++
 b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > @@ -7,7 +7,7 @@ $schema: 
> >
 https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!0Fm9t0VaOL6Sa_hC5KnVSsSa8A9LD3giZsk9UmSm2U8BkqwKo7-YhZtAaMoqHF2RYvhf1NG1qAc-je5tb-bE03wdVA$
> >  
> >   title: Mediatek Power Domains Controller
> >   
> >   maintainers:
> > -  - Weiyi Lu <weiyi.lu@mediatek.com>
> > +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> 
> Are you ok with this change. Can you provide a Acked-by tag for that?
> 
> Regards,
> Matthias
> 
> >     - Matthias Brugger <mbrugger@suse.com>
> >   
> >   description: |


Weiyi has resigned from MediaTek, and MandyJH has taken his place.
Maybe he still keep an eye on this list, but MandyJH should take over as
 MediaTek's maintainer.


Best regards,
TingHan



