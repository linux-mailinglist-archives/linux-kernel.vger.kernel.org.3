Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42E575024
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiGNN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbiGNN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:56:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CFE6B245;
        Thu, 14 Jul 2022 06:52:57 -0700 (PDT)
X-UUID: 3feda658ac494e09add81f71dcb4d5d9-20220714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:13951805-2a23-42aa-834c-d900c39296e0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:6b52fe32-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 3feda658ac494e09add81f71dcb4d5d9-20220714
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1523591146; Thu, 14 Jul 2022 21:52:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 21:52:53 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 14 Jul 2022 21:52:52 +0800
Message-ID: <4ae9195bd52191ffb816c86cf18a38daf7c66f43.camel@mediatek.com>
Subject: Re: [PATCH 1/1] dt-bindings: uart: update bindings for MT8188 SoC
From:   Kewei Xu <kewei.xu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <caiyu.chen@mediatek.com>, <david-yh.chiu@mediatek.com>
Date:   Thu, 14 Jul 2022 21:52:52 +0800
In-Reply-To: <468507bc-e10d-0d7c-aa77-bab4769efbcf@collabora.com>
References: <20220714104149.23343-1-kewei.xu@mediatek.com>
         <468507bc-e10d-0d7c-aa77-bab4769efbcf@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-14 at 14:30 +0200, AngeloGioacchino Del Regno wrote:
> Il 14/07/22 12:41, kewei.xu@mediatek.com ha scritto:
> > From: Kewei Xu <kewei.xu@mediatek.com>
> > 
> > Add a DT binding documentation for the MT8188 soc.
> > 
> > Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> 
> This file doesn't even exist anymore. I've converted it to json-
> schema, check
> out commit 22b10b33b9c6e76bc08f64e52862e68c4dc76052
> 
> Regards,
> Angelo

Thank you for your reply, I'll confirm the branch version and re-push
the patch based on the latest codebase.

Regards,
Kewei
> > ---
> >   Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > index 113b5d6a2245..e5094e1db7b4 100644
> > --- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
> > @@ -21,6 +21,7 @@ Required properties:
> >     * "mediatek,mt8173-uart" for MT8173 compatible UARTS
> >     * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183
> > compatible UARTS
> >     * "mediatek,mt8186-uart", "mediatek,mt6577-uart" for MT8183
> > compatible UARTS
> > +  * "mediatek,mt8188-uart", "mediatek,mt6577-uart" for MT8188
> > compatible UARTS
> >     * "mediatek,mt8192-uart", "mediatek,mt6577-uart" for MT8192
> > compatible UARTS
> >     * "mediatek,mt8195-uart", "mediatek,mt6577-uart" for MT8195
> > compatible UARTS
> >     * "mediatek,mt8516-uart" for MT8516 compatible UARTS
> > 
> 
> 

