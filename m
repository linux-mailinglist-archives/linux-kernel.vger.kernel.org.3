Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301D8504B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiDRD46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiDRD4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:56:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF718B11;
        Sun, 17 Apr 2022 20:54:14 -0700 (PDT)
X-UUID: b2b48544fd5a4912a59083dde5eec71e-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a0d2538d-3199-4538-9d13-39c5f8326794,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:1bc832ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: b2b48544fd5a4912a59083dde5eec71e-20220418
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1044070103; Mon, 18 Apr 2022 11:54:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 18 Apr 2022 11:54:09 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 11:54:09 +0800
Message-ID: <7fd1afd02a488e1973fbe4c19ebf7a5c28a482e9.camel@mediatek.com>
Subject: Re: [PATCH v19 09/10] drm/mediatek: add postfix 0 to
 DDP_COMPONENT_DITHER for mt8195 vdosys0
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        "Singo Chang" <singo.chang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 18 Apr 2022 11:54:09 +0800
In-Reply-To: <7f5a4307-b28d-1072-ee1d-752b3761bc30@collabora.com>
References: <20220415083911.5186-1-jason-jh.lin@mediatek.com>
         <20220415083911.5186-10-jason-jh.lin@mediatek.com>
         <7f5a4307-b28d-1072-ee1d-752b3761bc30@collabora.com>
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

Hi Angelo,

Thanks for the reviews.

On Fri, 2022-04-15 at 12:32 +0200, AngeloGioacchino Del Regno wrote:
> Il 15/04/22 10:39, jason-jh.lin ha scritto:
> > Because mt8195 vdosys0 has 2 DITHER components,
> > so the postfix 0 need to be added to DDP_COMPONENT_DITHER.
> > 
> > Then DITHER enum will become:
> > DDP_COMPONENT_DITHER0 and DDP_COMPONENT_DITHER1.
> > 
> > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> 
> I think that "postfix" should be "suffix" instead :)))
> 
OK, I'll fix it.
Thanks.

Regards,
Jason-JH.Lin

> In any case:
> 
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!0VHqcu_Bx0oyxup8Fj2rgqHuGYhj6UYv4YNNbEr3K8CBkZNPEQxjbrjcw6OccXWGif6P$
>  
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

