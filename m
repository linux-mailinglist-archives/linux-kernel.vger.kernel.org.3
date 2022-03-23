Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8D14E4D09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiCWHHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiCWHHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:07:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E371710D7;
        Wed, 23 Mar 2022 00:05:27 -0700 (PDT)
X-UUID: 844e671226874cdcbf84e5a8f1db266e-20220323
X-UUID: 844e671226874cdcbf84e5a8f1db266e-20220323
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1418472178; Wed, 23 Mar 2022 15:05:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 23 Mar 2022 15:05:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 15:05:22 +0800
Message-ID: <d2b36a358651e60b3d64efc6479a182d027066cb.camel@mediatek.com>
Subject: Re: [PATCH V9 1/5] dt-bindings: display: mediatek: add aal binding
 for MT8183
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jassisinghbrar@gmail.com>, <fparent@baylibre.com>,
        <yongqiang.niu@mediatek.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 23 Mar 2022 15:05:22 +0800
In-Reply-To: <e4c85b2d-8546-1740-9f83-d4cf985949d1@canonical.com>
References: <20220317051831.7107-1-rex-bc.chen@mediatek.com>
         <20220317051831.7107-2-rex-bc.chen@mediatek.com>
         <e4c85b2d-8546-1740-9f83-d4cf985949d1@canonical.com>
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

On Thu, 2022-03-17 at 08:20 +0100, Krzysztof Kozlowski wrote:
> On 17/03/2022 06:18, Rex-BC Chen wrote:
> > Add aal binding for MT8183.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml   | 5
> > +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for your review.

Because this patch is not related to MT8186 display, I will drop this
patch in this series and resend v10.

I will send another series to add the disp_aal dt-binding for 8192 with
this patch.

I will mail to you in another series.

Thanks!

BRs,
Rex

