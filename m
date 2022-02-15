Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F504B6AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiBOLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:31:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbiBOLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:31:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4013CFB;
        Tue, 15 Feb 2022 03:31:29 -0800 (PST)
X-UUID: 39c9a947dafe4ffb826bdea49c2bf5e9-20220215
X-UUID: 39c9a947dafe4ffb826bdea49c2bf5e9-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1084979076; Tue, 15 Feb 2022 19:31:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 19:31:24 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 19:31:23 +0800
Message-ID: <f2bce3870b3eacce0c9bcdf5a022e11371a9ace4.camel@mediatek.com>
Subject: Re: [PATCH v2, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>, <linux-media@vger.kernel.org>,
        <angelogioacchino.delregno@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Tue, 15 Feb 2022 19:31:23 +0800
In-Reply-To: <1642433742.919482.3923083.nullmailer@robh.at.kernel.org>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
         <20220117120615.21687-4-irui.wang@mediatek.com>
         <1642433742.919482.3923083.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rob,

Many thanks for your comments.

On Mon, 2022-01-17 at 09:35 -0600, Rob Herring wrote:
> On Mon, 17 Jan 2022 20:06:08 +0800, Irui Wang wrote:
> > Adds encoder cores dt-bindings for mt8195
> > 
> > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > ---
> >  .../media/mediatek,vcodec-encoder-core.yaml   | 214
> > ++++++++++++++++++
> >  1 file changed, 214 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> > core.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> core.example.dts:20:18: fatal error: dt-bindings/memory/mt8195-
> memory-port.h: No such file or directory
>    20 |         #include <dt-bindings/memory/mt8195-memory-port.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:373:
> Documentation/devicetree/bindings/media/mediatek,vcodec-encoder-
> core.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1413: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1580741
> 
> This check can fail if there are any dependencies. The base for a
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

This new encoder yaml includes mt8195 iommu and power&clock node, so it
depends on patches:
iommu:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=551641
power:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579

which are not accept yet. 

But IOMMU and power already send new version series patches, I will
rebase this series in next version.

Thanks
BRs
> 

