Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D2D4B66F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiBOJHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:07:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBOJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:07:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C9B5FF6;
        Tue, 15 Feb 2022 01:07:20 -0800 (PST)
X-UUID: cf75595ca2d841329b55b4771b8ac7e0-20220215
X-UUID: cf75595ca2d841329b55b4771b8ac7e0-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1528053680; Tue, 15 Feb 2022 17:07:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 17:07:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 17:07:16 +0800
Message-ID: <f7de15857fe110dcd9e3a6fc342bf253fd201f7b.camel@mediatek.com>
Subject: Re: [v2,2/6] dt-bindings: display: mediatek: update supported SoC
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, <chunkuang.hu@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <airlied@linux.ie>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <yongqiang.niu@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fparent@baylibre.com>, <linux-mediatek@lists.infradead.org>,
        <hsinyi@chromium.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 15 Feb 2022 17:07:16 +0800
In-Reply-To: <0de5fc29ed65eb5c6e9f227ec5e77cd4312718f4.camel@mediatek.com>
References: <20220215075953.3310-1-rex-bc.chen@mediatek.com>
         <20220215075953.3310-3-rex-bc.chen@mediatek.com>
         <0de5fc29ed65eb5c6e9f227ec5e77cd4312718f4.camel@mediatek.com>
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

On Tue, 2022-02-15 at 16:48 +0800, CK Hu wrote:
> Hi, Rex:
> 
> On Tue, 2022-02-15 at 15:59 +0800, Rex-BC Chen wrote:
> > Add decriptions about supported SoC: MT8186.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,disp.txt      |
> > 2
> > +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.
> > tx
> > t
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.
> > tx
> > t
> > index 78044c340e20..f22b3d90d45a 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.
> > tx
> > t
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.
> > tx
> > t
> > @@ -44,7 +44,7 @@ Required properties (all function blocks):
> >  	"mediatek,<chip>-dpi"        		- DPI controller,
> > see
> > mediatek,dpi.txt
> >  	"mediatek,<chip>-disp-mutex" 		- display mutex
> >  	"mediatek,<chip>-disp-od"    		- overdrive
> > -  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173,
> > mt8183 and mt8192.
> > +  the supported chips are mt2701, mt7623, mt2712, mt8167, mt8173,
> > mt8183, mt8186 and mt8192.
> 
> I've applied [1], so please depend on [1] to send this patch.
> 
> [1] 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-drm-next&id=4ed545e7d10049b5492afc184e61a67e478a2cfd
> 
> Regards,
> CK
> 
Hello CK,

Thanks for your review.
I will modify display binding based on [1] for next version.

BRs,
Rex-BC Chen
> >  - reg: Physical base address and length of the function block
> > register space
> >  - interrupts: The interrupt signal from the function block
> > (required, except for
> >    merge and split function blocks).
> 
> 

