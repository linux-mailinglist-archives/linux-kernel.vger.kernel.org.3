Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564214C64B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiB1IST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiB1ISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:18:12 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1401DA59;
        Mon, 28 Feb 2022 00:17:28 -0800 (PST)
X-UUID: 98a9ea68394b4c7599ef0f49829a9e45-20220228
X-UUID: 98a9ea68394b4c7599ef0f49829a9e45-20220228
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1588900933; Mon, 28 Feb 2022 16:17:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 28 Feb 2022 16:17:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Feb 2022 16:17:21 +0800
Message-ID: <087a41fd768eb9fcac7e475c1e8c84590ad0b6b4.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: usb: mtk-xhci: add compatible for mt8186
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Min Guo <Min.Guo@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@google.com>
Date:   Mon, 28 Feb 2022 16:17:21 +0800
In-Reply-To: <20220216120025.29860-1-allen-kh.cheng@mediatek.com>
References: <20220216120025.29860-1-allen-kh.cheng@mediatek.com>
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

On Wed, 2022-02-16 at 20:00 +0800, Allen-KH Cheng wrote:
> Add compatible for mt8186
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-
> xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
> xhci.yaml
> index 11f7bacd4e2b..6d9c3bad1d10 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -30,6 +30,7 @@ properties:
>            - mediatek,mt7629-xhci
>            - mediatek,mt8173-xhci
>            - mediatek,mt8183-xhci
> +          - mediatek,mt8186-xhci
>            - mediatek,mt8192-xhci
>            - mediatek,mt8195-xhci
>        - const: mediatek,mtk-xhci

Acked-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks


