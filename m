Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665B64F5CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiDFLyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiDFLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:53:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD11F1605;
        Wed,  6 Apr 2022 00:09:04 -0700 (PDT)
X-UUID: c835b0a0749d4d8195d7d630a6eceb4f-20220406
X-UUID: c835b0a0749d4d8195d7d630a6eceb4f-20220406
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1601077540; Wed, 06 Apr 2022 15:08:59 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 6 Apr 2022 15:08:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Apr
 2022 15:08:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 15:08:58 +0800
Message-ID: <ae8ba0030d42d078580233f1710c592992e7d778.camel@mediatek.com>
Subject: Re: [PATCH v2,1/2] dt-bindings: display: mediatek: dpi: Add
 compatible for MediaTek MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, <xinlei.lee@mediatek.com>,
        <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>
Date:   Wed, 6 Apr 2022 15:08:58 +0800
In-Reply-To: <4940e2e4ecb5f9f6857dc960ea5dbe43c551df77.camel@mediatek.com>
References: <1648727917-3099-1-git-send-email-xinlei.lee@mediatek.com>
         <1648727917-3099-2-git-send-email-xinlei.lee@mediatek.com>
         <e0d5a344c8ec1f92357bd9d5b8782dded862c549.camel@mediatek.com>
         <4940e2e4ecb5f9f6857dc960ea5dbe43c551df77.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 14:38 +0800, CK Hu wrote:
> Hi,
> 
> On Fri, 2022-04-01 at 09:38 +0800, Rex-BC Chen wrote:
> > On Thu, 2022-03-31 at 19:58 +0800, xinlei.lee@mediatek.com wrote:
> > > From: Xinlei Lee <xinlei.lee@mediatek.com>
> > > 
> > > Add dt-binding documentation of dpi for MediaTek MT8186 SoC.
> > > 
> > > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml      
> > >  |
> > > 1
> > > +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > index dd2896a40ff0..a73044c50b5f 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > +++
> > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi
> > > .y
> > > am
> > > l
> > > @@ -22,6 +22,7 @@ properties:
> > >        - mediatek,mt7623-dpi
> > >        - mediatek,mt8173-dpi
> > >        - mediatek,mt8183-dpi
> > > +      - mediatek,mt8186-dpi
> > >        - mediatek,mt8192-dpi
> > >  
> > >    reg:
> > 
> > Hello Xinlei,
> > 
> > From the dts we use, the dpi node needs other properties for
> > MT8186.
> > Please send another patch and add these properties to binding.
> > 
> > assigned-clocks = <&topckgen CLK_TOP_DPI>;
> > assigned-clock-parents = <&topckgen CLK_TOP_TVDPLL_D2>;
> 
> According to [1], the assigned-clocks is initial value. Without this
> initial value, I think driver would set this clock again, wouldn't
> it?
> 
> [1] 
> 
https://www.kernel.org/doc/Documentation/devicetree/bindings/clock/clock-bindings.txt
> 
> Regards,
> CK
> 

Hello CK,

OK, Thanks for your explanation.


Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

BRs,
Rex
> > 
> > Thanks
> > 
> > BRs,
> > Rex
> > 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > 
> 
> 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!wtF15QZZTCzWfRpxNLjZ1VQQ54i40D8STuOo0h18dtz3es-ksLfYQGTEFlb7lg$
> >  
> 
> 

